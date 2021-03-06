<?php defined('BX_DOL') or die('hack attempt');
/**
 * Copyright (c) BoonEx Pty Limited - http://www.boonex.com/
 * CC-BY License - http://creativecommons.org/licenses/by/3.0/
 *
 * @defgroup    BaseNotifications Base classes for Notifications like modules
 * @ingroup     DolphinModules
 *
 * @{
 */

bx_import('BxDolModuleTemplate');

class BxBaseModNotificationsTemplate extends BxDolModuleTemplate
{
	function __construct(&$oConfig, &$oDb)
    {
        parent::__construct($oConfig, $oDb);
    }

	public function getCssJs()
    {
        $this->addCss(array(
            'view.css',
            'view-media-tablet.css',
            'view-media-desktop.css',
        ));
        $this->addJs(array(
        	'jquery.anim.js',
            'main.js',
            'view.js',
        ));
    }

	public function getJsCode($sType, $aRequestParams = array(), $bWrap = true)
    {
        $oModule = $this->getModule();

        $sBaseUri = $this->_oConfig->getBaseUri();
        $sJsClass = $this->_oConfig->getJsClass($sType);
        $sJsObject = $this->_oConfig->getJsObject($sType);

        $aParams = array(
            'sActionUri' => $sBaseUri,
            'sActionUrl' => BX_DOL_URL_ROOT . $sBaseUri,
            'sObjName' => $sJsObject,
            'iOwnerId' => $oModule->_iOwnerId,
            'sAnimationEffect' => $this->_oConfig->getAnimationEffect(),
            'iAnimationSpeed' => $this->_oConfig->getAnimationSpeed(),
            'aHtmlIds' => $this->_oConfig->getHtmlIds($sType),
            'oRequestParams' => !empty($aRequestParams) ? $aRequestParams : array()
        );

        $sContent = "var " . $sJsObject . " = new " . $sJsClass . "(" . json_encode($aParams) . ");";

        $this->getCssJs();
        return !$bWrap ? $sContent : $this->_wrapInTagJsCode($sContent);
    }

	protected function getModule()
    {
        $sName = $this->_oConfig->getName();
        return BxDolModule::getInstance($sName);
    }

}

/** @} */
