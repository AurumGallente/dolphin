<?php defined('BX_DOL') or die('hack attempt');
/**
 * Copyright (c) BoonEx Pty Limited - http://www.boonex.com/
 * CC-BY License - http://creativecommons.org/licenses/by/3.0/
 *
 * @defgroup    Organizations Organizations
 * @ingroup     DolphinModules
 *
 * @{
 */

bx_import('BxBaseModProfilePageBrowse');

/**
 * Browse entries pages.
 */
class BxOrgsPageBrowse extends BxBaseModProfilePageBrowse
{
    public function __construct($aObject, $oTemplate = false)
    {
        $this->MODULE = 'bx_organizations';
        parent::__construct($aObject, $oTemplate);
    }
}

/** @} */
