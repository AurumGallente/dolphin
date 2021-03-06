<?php
/**
 * Copyright (c) BoonEx Pty Limited - http://www.boonex.com/
 * CC-BY License - http://creativecommons.org/licenses/by/3.0/
 *
 * @defgroup    DolphinCore Samples
 * @{
 */

/**
 * @page samples
 * @section grid Grid
 */

/**
 * Please refer to the following file for custom class and SQL dump data for this example:
 * @see BxGridMy.php
 */

$aPathInfo = pathinfo(__FILE__);
require_once ($aPathInfo['dirname'] . '/../inc/header.inc.php');
require_once(BX_DIRECTORY_PATH_INC . "design.inc.php");

bx_import('BxDolLanguages');
bx_import('BxDolTemplate');

$oTemplate = BxDolTemplate::getInstance();
$oTemplate->setPageNameIndex (BX_PAGE_DEFAULT);
$oTemplate->setPageHeader ("Sample grid");
$oTemplate->setPageContent ('page_main_code', PageCompMainCode());
$oTemplate->getPageCode();

/**
 * page code function
 */
function PageCompMainCode()
{
    ob_start();

    bx_import('BxDolGrid');
    $oGrid = BxDolGrid::getObjectInstance('sample'); // it automatically creates instance of default or custom class by object name
    if ($oGrid)
        echo $oGrid->getCode(); // print grid object

    return DesignBoxContent("Sample grid", ob_get_clean(), BX_DB_PADDING_DEF);
}

/** @} */
