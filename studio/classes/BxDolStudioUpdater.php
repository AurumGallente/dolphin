<?php defined('BX_DOL') or die('hack attempt');
/**
 * Copyright (c) BoonEx Pty Limited - http://www.boonex.com/
 * CC-BY License - http://creativecommons.org/licenses/by/3.0/
 *
 * @defgroup    DolphinStudio Dolphin Studio
 * @{
 */

bx_import('BxDolStudioInstaller');

class BxDolStudioUpdater extends BxDolStudioInstaller
{
    public function __construct($aConfig)
    {
        parent::__construct($aConfig);
        $this->_sModulePath = $this->_sBasePath . $aConfig['module_dir'];

        $this->_aActions = array_merge($this->_aActions, array(
            'check_module_exists' => array(
                'title' => _t('_adm_txt_modules_check_module_exists'),
            ),
            'check_module_version' => array(
                'title' => _t('_adm_txt_modules_check_module_version'),
            ),
            'check_module_hash' => array(
                'title' => _t('_adm_txt_modules_check_module_hash'),
            ),
            'update_files' => array(
                'title' => _t('_adm_txt_modules_update_files'),
            ),
            'restore_languages' => array(
                'title' => _t('_adm_txt_modules_restore_languages'),
            ),
        ));
    }

    public function update($aParams)
    {
        $oDb = bx_instance('BxDolStudioInstallerQuery');

        $aResult = array(
            'operation_title' => _t('_adm_txt_modules_operation_update', $this->_aConfig['title'], $this->_aConfig['version_from'], $this->_aConfig['version_to'])
        );

        //--- Check for module to update ---//
        $sQuery = $oDb->prepare("SELECT `id`, `version` FROM `sys_modules` WHERE `path`=? AND `uri`=? LIMIT 1", $this->_aConfig['module_dir'], $this->_aConfig['module_uri']);
        $aModuleInfo = $oDb->getRow($sQuery);
        if(!$aModuleInfo)
            return array_merge($aResult, array(
                'message' => $this->_displayResult('check_module_exists', false, '_adm_err_modules_module_not_found'),
                'result' => false
            ));

        //--- Check version ---//
        if($aModuleInfo['version'] != $this->_aConfig['version_from'])
            return array_merge($aResult, array(
                'message' => $this->_displayResult('check_module_version', false, '_adm_err_modules_wrong_version'),
                'result' => false
            ));

        //--- Check hash ---//
        $aFiles = array();
        $this->hashFiles(BX_DIRECTORY_PATH_ROOT . 'modules/' . $this->_aConfig['module_dir'], $aFiles);

        list($aFilesChanged, $fChangedPercent) = $this->hashCheck($aFiles, $aModuleInfo['id']);
        $bAutoupdateForceModifiedFiles = getParam('sys_autoupdate_force_modified_files') == 'on';

    	if(!empty($aFilesChanged) && !$bAutoupdateForceModifiedFiles) 
    		return array_merge($aResult, array(
                'message' => $this->_displayResult('check_module_hash', false, '_adm_err_modules_module_was_modified'),
                'result' => false
            ));
		else if($fChangedPercent > BX_FORCE_AUTOUPDATE_MAX_CHANGED_FILES_PERCENT && $bAutoupdateForceModifiedFiles) 
			return array_merge($aResult, array(
                'message' => $this->_displayResult('check_module_hash', false, _t('_sys_upgrade_files_checksum_failed_too_many', round($fChangedPercent * 100))),
                'result' => false
            ));

        //--- Perform action and check results ---//
        $aResult = array_merge($aResult, $this->_perform('install', 'Update'));
        if($aResult['result']) {
            $sQuery = $oDb->prepare("UPDATE `sys_modules` SET `version`=? WHERE `id`=?", $this->_aConfig['version_to'], $aModuleInfo['id']);
            $oDb->query($sQuery);

            $oDb->deleteModuleTrackFiles($aModuleInfo['id']);

            $aFiles = array();
            $this->hashFiles(BX_DIRECTORY_PATH_ROOT . 'modules/' . $this->_aConfig['module_dir'], $aFiles);
            foreach($aFiles as $aFile)
                $oDb->insertModuleTrack($aModuleInfo['id'], $aFile);

            //--- Remove update pckage ---//
            $this->delete();
        }

        return $aResult;
    }

    //--- Action Methods ---//
    public function actionUpdateFiles($bInstall = true)
    {
        $sPath = $this->_sHomePath . 'source/';
        if(!file_exists($sPath))
            return BX_DOL_STUDIO_INSTALLER_FAILED;

		$oFile = $this->_getFileManager();
		if(empty($oFile))
			return BX_DOL_STUDIO_INSTALLER_FAILED;

		if(!$oFile->copy($sPath . '*', 'modules/' . $this->_aConfig['module_dir']))
			return BX_DOL_STUDIO_INSTALLER_FAILED;

		if(!empty($this->_aConfig['delete_files']) && is_array($this->_aConfig['delete_files']))
			foreach($this->_aConfig['delete_files'] as $sFile)
				if(!$oFile->delete('modules/' . $this->_aConfig['module_dir'] . $sFile))
					return BX_DOL_STUDIO_INSTALLER_FAILED;

        return BX_DOL_STUDIO_INSTALLER_SUCCESS;
    }

    public function actionUpdateLanguages($bInstall = true)
    {
        $aConfig = self::getModuleConfig($this->_sHomePath . 'install/config.php');
        if(empty($aConfig) || !is_array($aConfig))
            return BX_DOL_STUDIO_INSTALLER_FAILED;

    	bx_import('BxDolStudioLanguagesUtils');
        $oLanguages = BxDolStudioLanguagesUtils::getInstance();
        $aLanguages = $oLanguages->getLanguages();

        $iCategoryId = !empty($aConfig['language_category']) ? $oLanguages->getLanguageCategory($aConfig['language_category']) : 0;

        foreach($aLanguages as $sName => $sTitle)
            $this->_updateLanguage($bInstall, $sName, $iCategoryId);

        return $oLanguages->compileLanguage(0, true) ? BX_DOL_STUDIO_INSTALLER_SUCCESS : BX_DOL_STUDIO_INSTALLER_FAILED;
    }

    /*
     * Restore module's language files.
     * 
     * Note. Mainly the action is needed for Updates in 'language' type modules. 
     * It should be used after 'update_files' action if some changes were done in module's language files. 
     */
    public function actionRestoreLanguages($bInstall = true)
    {
    	$aConfig = self::getModuleConfig($this->_sHomePath . 'install/config.php');
        if(empty($aConfig) || !is_array($aConfig) || empty($aConfig['module_uri']))
            return BX_DOL_STUDIO_INSTALLER_FAILED;

		bx_import('BxDolStudioLanguagesUtils');
        $oLanguages = BxDolStudioLanguagesUtils::getInstance();
        $aLanguages = $oLanguages->getLanguages();

        $bResult = true;
        foreach($aLanguages as $sName => $sTitle)
        	$bResult &= $oLanguages->restoreLanguage($sName, $aConfig['module_uri']);

        return $bResult ? BX_DOL_STUDIO_INSTALLER_SUCCESS : BX_DOL_STUDIO_INSTALLER_FAILED;
    }

    protected function _updateLanguage($bInstall, $sLanguage, $iCategory = 0)
    {
        $oDb = BxDolDb::getInstance();
        $oLanguages = BxDolStudioLanguagesUtils::getInstance();

        $sPath = $this->_sHomePath . 'install/langs/' . $sLanguage . '.xml';
        $aLanguageInfo = $oLanguages->readLanguage($sPath, 'update');
        if(empty($aLanguageInfo))
            return false;

        $iLanguage = $oLanguages->getLangId($sLanguage);

        if(!empty($aLanguageInfo['category']))
        	$iCategory = $oLanguages->getLanguageCategory($aLanguageInfo['category']);

        //--- Process delete. Note. Deletion is performed for all languages. ---//
        if(isset($aLanguageInfo['strings_del']))
        	foreach($aLanguageInfo['strings_del'] as $sKey => $sValue)
        		$oLanguages->deleteLanguageString($sKey, 0, false);

        //--- Process add. Note. Key's category will be updated if it doesn't match. ---//
        if(isset($aLanguageInfo['strings_add']))
        	foreach($aLanguageInfo['strings_add'] as $sKey => $sValue)
        		$oLanguages->addLanguageString($sKey, $sValue, $iLanguage, $iCategory, false);

        //--- Process update. Note. Key's category will be updated if it doesn't match. ---//
        if(isset($aLanguageInfo['strings_upd']))
        	foreach($aLanguageInfo['strings_upd'] as $sKey => $sValue)
        		$oLanguages->updateLanguageString($sKey, $sValue, $iLanguage, $iCategory, false);

        return true;
    }
}

/** @} */
