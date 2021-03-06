<?php defined('BX_DOL') or die('hack attempt');
/**
 * Copyright (c) BoonEx Pty Limited - http://www.boonex.com/
 * CC-BY License - http://creativecommons.org/licenses/by/3.0/
 *
 * @defgroup    DolphinStudio Dolphin Studio
 * @{
 */

bx_import('BxTemplStudioGrid');
bx_import('BxDolStudioTemplate');
bx_import('BxDolStudioFormsQuery');

class BxDolStudioFormsDisplays extends BxTemplStudioGrid
{
    protected $sModule = '';
    protected $sObject = '';

    public function __construct ($aOptions, $oTemplate = false)
    {
        parent::__construct ($aOptions, $oTemplate);

        $this->oDb = new BxDolStudioFormsQuery();

        $sModule = bx_get('module');
        if(!empty($sModule)) {
            $this->sModule = bx_process_input($sModule);
            $this->_aQueryAppend['module'] = $this->sModule;
        }

        $sObject = bx_get('object');
        if(!empty($sObject)) {
            $this->sObject = bx_process_input($sObject);
            $this->_aQueryAppend['object'] = $this->sObject;
        }
    }

    protected function _getDataSql($sFilter, $sOrderField, $sOrderDir, $iStart, $iPerPage)
    {
        if(empty($this->sObject))
            return array();

        $this->_aOptions['source'] .= $this->oDb->prepare(" AND `td`.`object`=?", $this->sObject);
        return parent::_getDataSql($sFilter, $sOrderField, $sOrderDir, $iStart, $iPerPage);
    }
}

/** @} */
