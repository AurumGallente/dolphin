<?php
/**
 * Copyright (c) BoonEx Pty Limited - http://www.boonex.com/
 * CC-BY License - http://creativecommons.org/licenses/by/3.0/
 *
 * @defgroup    DolphinStudio Dolphin Studio
 * @{
 */
defined('BX_DOL') or die('hack attempt');

require_once(BX_DIRECTORY_PATH_INC . 'design.inc.php');

bx_import('BxTemplGrid');
bx_import('BxDolForm');
bx_import('BxDolPermalinks');

class BxSitesGridOverview extends BxTemplGrid {
	protected $_oModule;
	protected $_aAccount;

	public function __construct ($aOptions, $oTemplate = false) {
        parent::__construct ($aOptions, $oTemplate);

        bx_import('BxDolModule');
        $this->_oModule = BxDolModule::getInstance('bx_sites');
    }

    public function setAccount(&$aAccount)
    {
    	$this->_aAccount = $aAccount;
    	$this->_aQueryAppend['account'] = $aAccount['id'];
    }

	public function performActionUnconfirmed()
    {
		$sAction = 'unconfirmed';

        $oForm = BxDolForm::getObjectInstance('bx_sites', 'bx_sites_site_confirm'); 
        if(!$oForm) {
        	$this->_echoResultJson(array('msg' => _t('_sys_txt_error_occured')), true);
            return;
        }

        $oForm->aFormAttrs['action'] = BX_DOL_URL_ROOT . 'grid.php?o=' . $this->_sObject . '&a=' . $sAction . '&_r=' . mktime(); 
		$oForm->aParams['db']['submit_name'] = 'do_confirm';

        $iAccountId = (int)bx_get('account');
        if($iAccountId !== false)
			$oForm->aInputs['id']['value'] = $iAccountId;

		$oForm->aInputs['info']['content'] = _t('_bx_sites_form_site_input_info_unconfirmed');

		$oPermalinks = BxDolPermalinks::getInstance();
		$sUrl = BX_DOL_URL_ROOT . $oPermalinks->permalink('page.php?i=site-delete&id=' . $iAccountId);
		foreach($oForm->aInputs['confirm_block'] as $iKey => $aInput)
			if(is_int($iKey) && !empty($aInput) && $aInput['name'] == 'do_delete')
				$oForm->aInputs['confirm_block'][$iKey]['attrs']['onclick'] = 'javascript:window.open(\'' . $sUrl . '\',\'_self\');';

		$oForm->initChecker();
        if(!$oForm->isSubmittedAndValid()) {
	    	bx_import('BxTemplFunctions');
			$sContent = BxTemplFunctions::getInstance()->popupBox('bx-sites-site-unconfirmed-popup', _t('_bx_sites_grid_overview_popup_unconfirmed'), $this->_oModule->_oTemplate->parseHtmlByName('block_unconfirmed.html', array(
				'form_id' => $oForm->aFormAttrs['id'],
				'form' => $oForm->getCode(true),
				'object' => $this->_sObject,
				'action' => $sAction
			)));

			$this->_echoResultJson(array('popup' => array('html' => $sContent, 'options' => array('closeOnOuterClick' => false))), true);
			return;
		}

		$iAccount = $oForm->getCleanValue('id');
		$aAccount = $this->_oModule->_oDb->getAccount(array('type' => 'id', 'value' => $iAccount));
		if(empty($aAccount) || !is_array($aAccount)) {
			$this->_echoResultJson(array('msg' => _t('_bx_sites_txt_err_site_is_not_defined')), true);
			return;
		}

		$sUrl = $this->_oModule->startSubscription($iAccount);
		if(empty($sUrl)) {
			$this->_echoResultJson(array('msg' => _t('_bx_sites_txt_err_cannot_perform')), true);
			return;
		}

		$this->_echoResultJson(array('eval' => 'window.open(\'' . $sUrl . '\', \'_self\');', 'popup_not_hide' => 1), true);
    }

	public function performActionPending()
    {
		$sAction = 'pending';

        $oForm = BxDolForm::getObjectInstance('bx_sites', 'bx_sites_site_pending'); 
        if(!$oForm) {
        	$this->_echoResultJson(array('msg' => _t('_sys_txt_error_occured')), true);
            return;
        }

        $oForm->aFormAttrs['action'] = BX_DOL_URL_ROOT . 'grid.php?o=' . $this->_sObject . '&a=' . $sAction . '&_r=' . mktime(); 

        $iAccountId = (int)bx_get('account');
        if($iAccountId !== false)
			$oForm->aInputs['id']['value'] = $iAccountId;

		$oForm->aInputs['info']['content'] = _t('_bx_sites_form_site_input_info_pending');

		$oForm->initChecker();
        if(!$oForm->isSubmittedAndValid()) {
	    	bx_import('BxTemplFunctions');
			$sContent = BxTemplFunctions::getInstance()->popupBox('bx-sites-site-pending-popup', _t('_bx_sites_grid_overview_popup_pending'), $this->_oModule->_oTemplate->parseHtmlByName('block_pending.html', array(
				'form_id' => $oForm->aFormAttrs['id'],
				'form' => $oForm->getCode(true),
				'object' => $this->_sObject,
				'action' => $sAction
			)));

			$this->_echoResultJson(array('popup' => array('html' => $sContent, 'options' => array('closeOnOuterClick' => false))), true);
			return;
		}

		//Note: Place onSubmit code here if it's needed. 
    }

	public function performActionActive()
    {
		$sAction = 'active';

		bx_import('BxDolForm');
        $oForm = BxDolForm::getObjectInstance('bx_sites', 'bx_sites_site_cancel'); 
        if(!$oForm) {
        	$this->_echoResultJson(array('msg' => _t('_sys_txt_error_occured')), true);
            return;
        }

        $oForm->aFormAttrs['action'] = BX_DOL_URL_ROOT . 'grid.php?o=' . $this->_sObject . '&a=' . $sAction . '&_r=' . mktime();
        $oForm->aFormAttrs['onsubmit'] = 'return ' . $this->_oModule->_oConfig->getJsObject() . '.onCancelSubscription(this);'; 
		$oForm->aParams['db']['submit_name'] = 'do_cancel';

        $iAccountId = (int)bx_get('account');
        if($iAccountId !== false)
			$oForm->aInputs['id']['value'] = $iAccountId;

		$oForm->aInputs['info']['content'] = _t('_bx_sites_form_site_input_info_active');

		$oForm->initChecker();
        if(!$oForm->isSubmittedAndValid()) {
	    	bx_import('BxTemplFunctions');
			$sContent = BxTemplFunctions::getInstance()->popupBox('bx-sites-site-active-popup', _t('_bx_sites_grid_overview_popup_active'), $this->_oModule->_oTemplate->parseHtmlByName('block_active.html', array(
				'form_id' => $oForm->aFormAttrs['id'],
				'form' => $oForm->getCode(true),
				'object' => $this->_sObject,
				'action' => $sAction
			)));

			$this->_echoResultJson(array('popup' => array('html' => $sContent, 'options' => array('closeOnOuterClick' => false))), true);
			return;
		} 

		$iAccount = $oForm->getCleanValue('id');
		$aAccount = $this->_oModule->_oDb->getAccount(array('type' => 'id', 'value' => $iAccount));
		if(empty($aAccount) || !is_array($aAccount)) {
			$this->_echoResultJson(array('msg' => _t('_bx_sites_txt_err_site_is_not_defined')), true);
			return;
		}

		$bResult = $this->_oModule->cancelSubscription($aAccount['pd_profile_id']);
		if(!$bResult) {
			$this->_echoResultJson(array('msg' => _t('_bx_sites_txt_err_cannot_perform')), true);
			return;
		}

		bx_import('BxDolPermalinks');
		$oPermalinks = BxDolPermalinks::getInstance();

		$sUrl = BX_DOL_URL_ROOT . $oPermalinks->permalink('page.php?i=site-view&id=' . $aAccount['id']);
		$this->_echoResultJson(array('eval' => 'window.open(\'' . $sUrl . '\',\'_self\');'), true); 
    }

	public function performActionCanceled()
    {
		$sAction = 'canceled';

		bx_import('BxDolForm');
        $oForm = BxDolForm::getObjectInstance('bx_sites', 'bx_sites_site_reactivate'); 
        if(!$oForm) {
        	$this->_echoResultJson(array('msg' => _t('_sys_txt_error_occured')), true);
            return;
        }

        $oForm->aFormAttrs['action'] = BX_DOL_URL_ROOT . 'grid.php?o=' . $this->_sObject . '&a=' . $sAction . '&_r=' . mktime(); 
		$oForm->aParams['db']['submit_name'] = 'do_reactivate';

        $iAccountId = (int)bx_get('account');
        if($iAccountId !== false)
			$oForm->aInputs['id']['value'] = $iAccountId;

		$oForm->aInputs['info']['content'] = _t('_bx_sites_form_site_input_info_canceled');

		$oForm->initChecker();
        if(!$oForm->isSubmittedAndValid()) {
	    	bx_import('BxTemplFunctions');
			$sContent = BxTemplFunctions::getInstance()->popupBox('bx-sites-site-canceled-popup', _t('_bx_sites_grid_overview_popup_canceled'), $this->_oModule->_oTemplate->parseHtmlByName('block_canceled.html', array(
				'form_id' => $oForm->aFormAttrs['id'],
				'form' => $oForm->getCode(true),
				'object' => $this->_sObject,
				'action' => $sAction
			)));

			$this->_echoResultJson(array('popup' => array('html' => $sContent, 'options' => array('closeOnOuterClick' => false))), true);
			return;
		} 

    	$iAccount = $oForm->getCleanValue('id');
		$aAccount = $this->_oModule->_oDb->getAccount(array('type' => 'id', 'value' => $iAccount));
		if(empty($aAccount) || !is_array($aAccount)) {
			$this->_echoResultJson(array('msg' => _t('_bx_sites_txt_err_site_is_not_defined')), true);
			return;
		}

		$sUrl = $this->_oModule->startSubscription($iAccount);
	    if(empty($sUrl)) {
			$this->_echoResultJson(array('msg' => _t('_bx_sites_txt_err_cannot_perform')), true);
			return;
		}

		$this->_echoResultJson(array('eval' => 'window.open(\'' . $sUrl . '\', \'_self\');', 'popup_not_hide' => 1), true);
    }

	public function performActionSuspended()
    {
		$sAction = 'suspended';

        $oForm = BxDolForm::getObjectInstance('bx_sites', 'bx_sites_site_suspended'); 
        if(!$oForm) {
        	$this->_echoResultJson(array('msg' => _t('_sys_txt_error_occured')), true);
            return;
        }

        $oForm->aFormAttrs['action'] = BX_DOL_URL_ROOT . 'grid.php?o=' . $this->_sObject . '&a=' . $sAction . '&_r=' . mktime(); 

        $iAccountId = (int)bx_get('account');
        if($iAccountId !== false)
			$oForm->aInputs['id']['value'] = $iAccountId;

		$oForm->aInputs['info']['content'] = _t('_bx_sites_form_site_input_info_suspended');

		$oForm->initChecker();
        if(!$oForm->isSubmittedAndValid()) {
	    	bx_import('BxTemplFunctions');
			$sContent = BxTemplFunctions::getInstance()->popupBox('bx-sites-site-suspended-popup', _t('_bx_sites_grid_overview_popup_suspended'), $this->_oModule->_oTemplate->parseHtmlByName('block_suspended.html', array(
				'form_id' => $oForm->aFormAttrs['id'],
				'form' => $oForm->getCode(true),
				'object' => $this->_sObject,
				'action' => $sAction
			)));

			$this->_echoResultJson(array('popup' => array('html' => $sContent, 'options' => array('closeOnOuterClick' => false))), true);
			return;
		}

		//Note: Place onSubmit code here if it's needed. 
    }

    public function getCode($isDisplayHeader = true)
    {
    	if(in_array($this->_aAccount['status'], array(BX_SITES_ACCOUNT_STATUS_UNCONFIRMED, BX_SITES_ACCOUNT_STATUS_PENDING, BX_SITES_ACCOUNT_STATUS_CANCELED, BX_SITES_ACCOUNT_STATUS_SUSPENDED)))
    		$this->_oTemplate = $this->_oModule->_oTemplate;

    	return parent::getCode($isDisplayHeader);
    }

	protected function _addJsCss() {
        parent::_addJsCss();
        $this->_oTemplate->addJs(array('jquery.form.js'));
        $this->_oTemplate->addJsTranslation(array('_bx_sites_form_site_input_do_cancel_confirm'));

        bx_import('BxTemplFormView');
        $oForm = new BxTemplFormView(array());
        $oForm->addCssJs();
    }

    protected function _getDataArray($sFilter, $sOrderField, $sOrderDir, $iStart, $iPerPage)
    {
    	$this->_aOptions['source'] = array();
    	$sCurrency = $this->_oModule->_oConfig->getCurrencyCode();
    	$iNextPayment = $this->_aAccount['paid'];

    	$aPayment = $this->_oModule->_oDb->getPaymentHistory(array('type' => 'account_id_last', 'value' => $this->_aAccount['id']));
    	if(!empty($aPayment) && is_array($aPayment))
    		$this->_aOptions['source'][] = array(
    			'id' => 'last', 
    			'title' => '_bx_sites_grid_overview_txt_payment_last',
    			'type' => '_bx_sites_txt_payment_type_' . $aPayment['type'],
    			'transaction' => $aPayment['transaction'], 
    			'when' => getLocaleDate($aPayment['when']),
    			'amount' => number_format($aPayment['amount'], 2) . ' ' .$sCurrency
    		);

    	if(!empty($iNextPayment)) {
    		$aAmount = 0;
    		$fAmountTrial = $this->_oModule->_oConfig->getPaymentPrice(BX_SITES_PP_PERIOD_TRIAL);
    		$fAmountRegular = $this->_oModule->_oConfig->getPaymentPrice(BX_SITES_PP_PERIOD_REGULAR);
    		switch($this->_aAccount['status']) {
    			case BX_SITES_ACCOUNT_STATUS_PENDING:
    				$aAmount = $fAmountTrial != 0 ? $fAmountTrial : $fAmountRegular;
    				break;
    			case BX_SITES_ACCOUNT_STATUS_TRIAL:
    				$aAmount = $fAmountRegular;
    				break;
    			case BX_SITES_ACCOUNT_STATUS_ACTIVE:
    				$aAmount = $fAmountRegular;
    				break;
    		}

	    	$this->_aOptions['source'][] = array(
	    		'id' => 'next',
	    		'title' => '_bx_sites_grid_overview_txt_payment_next',
	    		'type' => '',
	    		'transaction' => '', 
	    		'when' => getLocaleDate($iNextPayment),
	    		'amount' => number_format($aAmount, 2) . ' ' .$sCurrency
	    	);
    	}

        return parent::_getDataArray($sFilter, $sOrderField, $sOrderDir, $iStart, $iPerPage);
    }

    protected function _getFilterControls ()
    {
		$sAction = $this->_aAccount['status'];
		if($sAction == BX_SITES_ACCOUNT_STATUS_TRIAL)
			$sAction = BX_SITES_ACCOUNT_STATUS_ACTIVE;

		$sStatus = _t('_bx_sites_txt_status_' . $this->_aAccount['status']);
		if(in_array($sAction, array(BX_SITES_ACCOUNT_STATUS_UNCONFIRMED, BX_SITES_ACCOUNT_STATUS_PENDING, BX_SITES_ACCOUNT_STATUS_ACTIVE, BX_SITES_ACCOUNT_STATUS_CANCELED, BX_SITES_ACCOUNT_STATUS_SUSPENDED))) {
			$sStatus = $this->_oModule->_oTemplate->parseHtmlByName('bx_a.html', array(
	            'href' => 'javascript:void(0)',
	            'title' => _t('_bx_sites_grid_overview_btn_' . $sAction),
	            'bx_repeat:attrs' => array(
					array('key' => 'bx_grid_action_independent', 'value' => $sAction),
					array('key' => 'bx_grid_action_data', 'value' => $this->_aAccount['id'])
				),
	            'content' => $sStatus,
	        ));
		}

		return $this->_oModule->_oTemplate->parseHtmlByName('block_overview_status.html', array(
        	'status' => $sStatus,
			'bx_if:show_reactivate' => array(
				'condition' => false,
				'content' => array()
			)
        ));
    }

	protected function _getActionUnconfirmed($sType, $sKey, $a, $isSmall = false, $isDisabled = false, $aRow = array()) {
		return '';
    }

	protected function _getActionPending($sType, $sKey, $a, $isSmall = false, $isDisabled = false, $aRow = array()) {
		return '';
    }

	protected function _getActionActive($sType, $sKey, $a, $isSmall = false, $isDisabled = false, $aRow = array()) {
		return '';
    }

	protected function _getActionCanceled($sType, $sKey, $a, $isSmall = false, $isDisabled = false, $aRow = array()) {
		return '';
    }

	protected function _getActionSuspended($sType, $sKey, $a, $isSmall = false, $isDisabled = false, $aRow = array()) {
		return '';
    }
}
/** @} */