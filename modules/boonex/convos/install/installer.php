<?php defined('BX_DOL') or die('hack attempt');
/**
 * Copyright (c) BoonEx Pty Limited - http://www.boonex.com/
 * CC-BY License - http://creativecommons.org/licenses/by/3.0/
 *
 * @defgroup    Convos Convos
 * @ingroup     DolphinModules
 *
 * @{
 */

bx_import('BxBaseModTextInstaller');

class BxCnvInstaller extends BxBaseModTextInstaller
{
    function __construct($aConfig)
    {
        parent::__construct($aConfig);
        $this->_aTranscoders = array ('bx_convos_preview');
        $this->_aStorages = array ('bx_convos_files');
        $this->_aMenuTriggers = array ('trigger_profile_view_actions');
    }
}

/** @} */
