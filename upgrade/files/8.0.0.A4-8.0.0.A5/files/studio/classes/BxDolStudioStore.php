<?php defined('BX_DOL') or die('hack attempt');
/**
 * Copyright (c) BoonEx Pty Limited - http://www.boonex.com/
 * CC-BY License - http://creativecommons.org/licenses/by/3.0/
 *
 * @defgroup    DolphinStudio Dolphin Studio
 * @{
 */

bx_import('BxTemplStudioPage');
bx_import('BxDolStudioStoreQuery');
bx_import('BxDolStudioInstallerUtils');

define('BX_DOL_STUDIO_STR_TYPE_DEFAULT', 'downloaded');

class BxDolStudioStore extends BxTemplStudioPage
{
    protected $sPage;
    protected $aContent;

    protected $iClient;

    protected $aAlias;
    protected $bAuthAccessUpdates;

    function __construct($sPage = "")
    {
        parent::__construct('store');

        $this->oDb = new BxDolStudioStoreQuery();

        $this->aAlias = array(
            'tag' => array(
                'modules' => 'extensions',
                'languages' => 'translations'
            ),
            'category' => array()
        );
        $this->bAuthAccessUpdates = false;

        $this->sPage = BX_DOL_STUDIO_STR_TYPE_DEFAULT;
        if(is_string($sPage) && !empty($sPage))
            $this->sPage = $sPage;

		bx_import('BxDolStudioOAuth');
        $this->iClient = BxDolStudioOAuth::getAuthorizedClient();

        //--- Check actions ---//
        if(($sAction = bx_get('str_action')) !== false) {
            $sAction = bx_process_input($sAction);

            $aResult = array('code' => 1, 'message' => _t('_adm_mod_err_cannot_process_action'));
            switch($sAction) {
                /*
                 * NOTE. Is needed for download popup selector. Isn't used for now.
                 */
                case 'get-files':
                    $iId = (int)bx_get('str_id');
                    $sType = bx_process_input(bx_get('str_type'));
                    $aResult = $this->getFiles($iId, $sType);
                    break;

                case 'get-file':
                    $iFileId = (int)bx_get('str_id');
                    $aResult = $this->getFile($iFileId);
                    break;

                case 'get-product':
                    $sModuleName = bx_process_input(bx_get('str_id'));
                    $aResult = $this->getProduct($sModuleName);
                    break;

                case 'get-update':
                    $sModuleName = bx_process_input(bx_get('str_id'));
                    $aResult = $this->getUpdate($sModuleName);
                    break;

                case 'get-products-by-type':
                    $this->sPage = bx_process_input(bx_get('str_value'));

                    $sContent = $this->getPageCode();
                    if(!empty($sContent))
                        $aResult = array('code' => 0, 'content' => $sContent);
                    else
                        $aResult = array('code' => 1, 'message' => _t('_adm_act_err_failed_page_loading'));
                    break;

                case 'get-products-by-page':
                    $this->sPage = bx_process_input(bx_get('str_type'));

                    $sContent = $this->getPageContent();
                    if(!empty($sContent))
                        $aResult = array('code' => 0, 'content' => $sContent);
                    else
                        $aResult = array('code' => 1, 'message' => _t('_adm_act_err_failed_page_loading'));
                    break;

                case 'add-to-cart':
                    $sVendor = bx_process_input(bx_get('str_vendor'));
                    $iItem = (int)bx_get('str_item');
                    $iItemCount = 1;

                    if(empty($sVendor) || empty($iItem)) {
                        $aResult = array('code' => 1, 'message' => _t('_adm_err_modules_cannot_add_to_cart'));
                        break;
                    }

                    bx_import('BxDolStudioCart');
                    BxDolStudioCart::getInstance()->add($sVendor, $iItem, $iItemCount);
                    $aResult = array('code' => 0, 'message' => _t('_adm_msg_modules_success_added_to_cart'));
                    break;

                case 'delete-from-cart':
                    $sVendor = bx_process_input(bx_get('str_vendor'));
                    $iItem = (int)bx_get('str_item');

                    if(empty($sVendor)) {
                        $aResult = array('code' => 1, 'message' => _t('_adm_err_modules_cannot_delete_from_cart'));
                        break;
                    }

                    bx_import('BxDolStudioCart');
                    BxDolStudioCart::getInstance()->delete($sVendor, $iItem);
                    $aResult = array('code' => 0, 'message' => '');
                    break;

                case 'checkout-cart':
                    $sVendor = bx_process_input(bx_get('str_vendor'));
                    if(empty($sVendor)) {
                        $aResult = array('code' => 1, 'message' => _t('_adm_err_modules_cannot_checkout_empty_vendor'));
                        break;
                    }

                    $sLocation = $this->checkoutCart($sVendor);
                    $aResult = array('code' => 0, 'message' => '', 'redirect' => $sLocation);
                    break;

                case 'install':
                    $sValue = bx_process_input(bx_get('str_value'));
                    if(empty($sValue))
                        break;

                    bx_import('BxDolStudioInstallerUtils');
                    $aResult = BxDolStudioInstallerUtils::getInstance()->perform($sValue, 'install', array('auto_enable' => true));
                    break;

                case 'update':
                    $sValue = bx_process_input(bx_get('str_value'));
                    if(empty($sValue))
                        break;

                    bx_import('BxDolStudioInstallerUtils');
                    $aResult = BxDolStudioInstallerUtils::getInstance()->perform($sValue, 'update');
                    break;

                case 'delete':
                    $sValue = bx_process_input(bx_get('str_value'));
                    if(empty($sValue))
                        break;

                    bx_import('BxDolStudioInstallerUtils');
                    $aResult = BxDolStudioInstallerUtils::getInstance()->perform($sValue, 'delete');
                    break;
            }

            if(!empty($aResult['message'])) {
                bx_import('BxDolStudioTemplate');
                $aResult['message'] = BxDolStudioTemplate::getInstance()->parseHtmlByName('mod_action_result.html', array('content' => $aResult['message']));

                bx_import('BxTemplStudioFunctions');
                $aResult['message'] = BxTemplStudioFunctions::getInstance()->transBox('', $aResult['message']);
            }

            echo json_encode($aResult);
            exit;
        }
    }

    protected function loadGoodies()
    {
        $iPerPage = 5;
        $aProducts = array();
        $sJsObject = $this->getPageJsObject();

        bx_import('BxDolStudioJson');
        $oJson = BxDolStudioJson::getInstance();

        // Load featured
        $aProducts[] = array(
            'caption' => '_adm_block_cpt_last_featured',
            'actions' => array(
                array('name' => 'featured', 'caption' => '_adm_action_cpt_see_all_featured', 'url' => 'javascript:void(0)', 'onclick' => $sJsObject . ".changePage('featured', this)")
            ),
            'items' => $oJson->load(BX_DOL_UNITY_URL_MARKET . 'json_browse_featured', array('start' => 0, 'per_page' => $iPerPage, 'client' => $this->iClient))
        );


        // Load modules
        $aProducts[] = array(
            'caption' => '_adm_block_cpt_last_modules',
            'actions' => array(
                array('name' => 'modules', 'caption' => '_adm_action_cpt_see_all_modules', 'url' => 'javascript:void(0)', 'onclick' => $sJsObject . ".changePage('modules', this)")
            ),
            'items' => $oJson->load(BX_DOL_UNITY_URL_MARKET . 'json_browse_by_tag', array('value' => 'extensions', 'start' => 0, 'per_page' => $iPerPage, 'client' => $this->iClient))
        );

        // Load templates
        $aProducts[] = array(
            'caption' => '_adm_block_cpt_last_templates',
            'actions' => array(
                array('name' => 'templates', 'caption' => '_adm_action_cpt_see_all_templates', 'url' => 'javascript:void(0)', 'onclick' => $sJsObject . ".changePage('templates', this)")
            ),
            'items' => $oJson->load(BX_DOL_UNITY_URL_MARKET . 'json_browse_by_tag', array('value' => 'templates', 'start' => 0, 'per_page' => $iPerPage, 'client' => $this->iClient))
        );

        // Load languages
        $aProducts[] = array(
            'caption' => '_adm_block_cpt_last_languages',
            'actions' => array(
                array('name' => 'languages', 'caption' => '_adm_action_cpt_see_all_languages', 'url' => 'javascript:void(0)', 'onclick' => $sJsObject . ".changePage('languages', this)")
            ),
            'items' => $oJson->load(BX_DOL_UNITY_URL_MARKET . 'json_browse_by_tag', array('value' => 'translations', 'start' => 0, 'per_page' => $iPerPage, 'client' => $this->iClient))
        );

        return $aProducts;
    }

    protected function loadFeatured($iStart, $iPerPage)
    {
        bx_import('BxDolStudioJson');
        return BxDolStudioJson::getInstance()->load(BX_DOL_UNITY_URL_MARKET . 'json_browse_featured', array('start' => $iStart, 'per_page' => $iPerPage, 'client' => $this->iClient));
    }

    protected function loadTag($sTag, $iStart, $iPerPage)
    {
        bx_import('BxDolStudioJson');
        return BxDolStudioJson::getInstance()->load(BX_DOL_UNITY_URL_MARKET . 'json_browse_by_tag', array('value' => $this->aliasToNameTag($sTag), 'start' => $iStart, 'per_page' => $iPerPage, 'client' => $this->iClient));
    }

    protected function loadPurchases()
    {
        bx_import('BxDolStudioOAuth');
        $aProducts = BxDolStudioOAuth::getInstance()->loadItems(array('dol_type' => 'purchased_products', 'dol_domain' => BX_DOL_URL_ROOT));

        $this->oDb->updateModule(array('hash' => ''));
        if(!empty($aProducts) && is_array($aProducts))
	        foreach ($aProducts as $aProduct)
	        	$this->oDb->updateModule(array('hash' => $aProduct['hash']), array('name' => $aProduct['name']));

        return $aProducts;
    }

    protected function loadUpdates()
    {
    	bx_import('BxDolStudioInstallerUtils');
        return BxDolStudioInstallerUtils::getInstance()->checkUpdates($this->bAuthAccessUpdates);
    }

    protected function loadCheckout()
    {
        bx_import('BxDolStudioJson');
        $oJson = BxDolStudioJson::getInstance();

        bx_import('BxDolStudioCart');
        $aVendors = BxDolStudioCart::getInstance()->parseByVendor();

        $aResult = array();
        foreach($aVendors as $sVendor => $aItems) {
            $aIds = $aCounts = array();
            foreach($aItems as $aItem) {
                $aIds[] = $aItem['item_id'];
                $aCounts[$aItem['item_id']] = $aItem['item_count'];
            }

            $aProducts = $oJson->load(BX_DOL_UNITY_URL_MARKET . 'json_browse_selected', array('products' => base64_encode(serialize($aIds))));
            if(!empty($aProducts))
                $aResult[$sVendor] = array(
                    'ids' => $aIds,
                    'counts' => $aCounts,
                    'products' => $aProducts
                );
        }

        return $aResult;
    }

    protected function loadDownloaded()
    {
        bx_import('BxDolStudioInstallerUtils');
        $oInstallerUtils = BxDolStudioInstallerUtils::getInstance();

        return array(
            'modules' => $oInstallerUtils->getModules(),
            'updates' => $oInstallerUtils->getUpdates()
        );
    }

    protected function loadProduct($sModuleName)
    {
        bx_import('BxDolStudioJson');
        $oJson = BxDolStudioJson::getInstance();

        return $oJson->load(BX_DOL_UNITY_URL_MARKET . 'json_get_product_by_name', array('value' => $sModuleName, 'client' => $this->iClient));
    }

    /*
     * NOTE. Is needed for download popup selector. Isn't used for now.
     */
    protected function loadFiles($iId, $sType)
    {
        bx_import('BxDolStudioOAuth');
        return BxDolStudioOAuth::getInstance()->loadItems(array('dol_type' => 'product_files', 'dol_product_id' => $iId, 'dol_file_type' => $sType));
    }

    /*
     * Load package (module, update) using OAuth authorization.
     */
    protected function loadFile($iFileId)
    {
        bx_import('BxDolStudioInstallerUtils');
        return BxDolStudioInstallerUtils::getInstance()->downloadFileAuthorized($iFileId);
    }

    /*
     * Load update's package publicly.
     */
	protected function loadUpdate($sModuleName)
    {
        bx_import('BxDolStudioInstallerUtils');
        return BxDolStudioInstallerUtils::getInstance()->downloadUpdatePublic($sModuleName);
    }

    private function checkoutCart($sVendor)
    {
        bx_import('BxDolStudioCart');
        $oCart = BxDolStudioCart::getInstance();

        $aItems = $oCart->getByVendor($sVendor);
        if(empty($aItems) || !is_array($aItems))
            return false;

        $aIds = array();
        foreach($aItems as $aItem)
            $aIds[] = $aItem['item_id'];

        $sSid = bx_site_hash();
        return BX_DOL_UNITY_URL_MARKET . 'purchase/' . $sVendor . '?sid=' . $sSid . '&products=' . base64_encode(implode(',', $aIds));
    }

    private function aliasToNameTag($sAlias)
    {
        return $this->aliasToName('tag', $sAlias);
    }

    private function aliasToNameCategory($sAlias)
    {
        return $this->aliasToName('category', $sAlias);
    }

    private function aliasToName($sType, $sAlias)
    {
        return isset($this->aAlias[$sType][$sAlias]) ? $this->aAlias[$sType][$sAlias] : $sAlias;
    }
}

/** @} */
