<?php
/**
 * Copyright (c) BoonEx Pty Limited - http://www.boonex.com/
 * CC-BY License - http://creativecommons.org/licenses/by/3.0/
 *
 * @defgroup    DolphinEndAdmin Dolphin Studio End Admin Pages
 * @ingroup     DolphinStudio
 * @{
 */

require_once('./../inc/header.inc.php');
require_once(BX_DIRECTORY_PATH_INC . 'design.inc.php');

bx_import('BxDolLanguages');

bx_require_authentication(true);

bx_import('BxTemplStudioMenuTop');
$oTopMenu = BxTemplStudioMenuTop::getInstance();
$oTopMenu->setVisibleAll();

bx_import('BxTemplStudioLauncher');
$oPage = new BxTemplStudioLauncher();

bx_import('BxDolStudioTemplate');
$oTemplate = BxDolStudioTemplate::getInstance();
$oTemplate->setPageNameIndex($oPage->getPageIndex());
$oTemplate->setPageHeader($oPage->getPageHeader());
$oTemplate->setPageContent('page_main_code', $oPage->getPageCode());
$oTemplate->addCss($oPage->getPageCss());
$oTemplate->addJs($oPage->getPageJs());
$oTemplate->getPageCode();
/** @} */
