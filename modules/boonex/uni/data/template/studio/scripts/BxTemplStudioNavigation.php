<?php
/**
 * Copyright (c) BoonEx Pty Limited - http://www.boonex.com/
 * CC-BY License - http://creativecommons.org/licenses/by/3.0/
 *
 * @defgroup    DolphinView Dolphin Studio Representation classes
 * @ingroup     DolphinStudio
 * @{
 */
defined('BX_DOL') or die('hack attempt');

bx_import('BxBaseStudioNavigation');

class BxTemplStudioNavigation extends BxBaseStudioNavigation
{
    function __construct($sPage = '')
    {
        parent::__construct($sPage);
    }
}
/** @} */
