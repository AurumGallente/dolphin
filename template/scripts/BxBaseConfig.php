<?php defined('BX_DOL') or defined('BX_DOL_INSTALL') or die('hack attempt');
/**
 * Copyright (c) BoonEx Pty Limited - http://www.boonex.com/
 * CC-BY License - http://creativecommons.org/licenses/by/3.0/
 *
 * @defgroup    DolphinCore Dolphin Core
 * @{
 */

class BxBaseConfig extends BxDol implements iBxDolSingleton
{
    protected $_aConfig = array (
        'bAllowUnicodeInPreg' => false, ///< allow unicode in regular expressions
        'aLessConfig' => array (
            'bx-page-width' => '1000px',

            'bx-margin' => '20px',
            'bx-margin-sec' => '10px',
            'bx-margin-thd' => '5px',

            'bx-padding' => '20px',
            'bx-padding-sec' => '10px',
            'bx-padding-thd' => '5px',

            'bx-font-family' => '"Helvetica Neue", Helvetica, Arial, "Lucida Grande", sans-serif',

            'bx-size-avatar' => '96px',
            'bx-size-thumb' => '48px',
            'bx-size-icon' => '32px',

            'bx-size-gallery-img-width' => '300px',
            'bx-size-gallery-img-height' => '200px',
            'bx-size-gallery-unit-width' => '300px',
            'bx-size-gallery-unit-height' => '320px',

            'bx-color-page' => '#fff',
            'bx-color-block' => '#fff',
            'bx-color-box' => '#fff',
            'bx-color-sec' => '#f2f2f2',
            'bx-color-hl' => 'rgba(196, 248, 156, 0.2)',
            'bx-color-active' => 'rgba(196, 248, 156, 0.4)',

            'bx-border-width' => '1px',
            'bx-border-type' => 'solid',
            'bx-border-color' => '#d0d0d0',

            'bx-font-size-default' => '16px',
            'bx-font-size-small' => '12px',
            'bx-font-size-middle' => '14px',
            'bx-font-size-large' => '18px',
            'bx-font-size-h1' => '24px',
            'bx-font-size-h2' => '20px',
            'bx-font-size-h3' => '16px',

            'bx-font-color-default' => '#333',
            'bx-font-color-grayed' => '#999',
            'bx-font-color-contrasted' => '#fff',

            'bx-round-corners-radius' => '3px',
        ),
    );

    function __construct()
    {
        parent::__construct();

        if (class_exists('BxDolDb') && BxDolDb::getInstance())
            $this->_aConfig['aLessConfig']['bx-page-width'] = getParam('main_div_width');
    }

    public static function getInstance()
    {
        if(!isset($GLOBALS['bxDolClasses'][__CLASS__]))
            $GLOBALS['bxDolClasses'][__CLASS__] = new BxTemplConfig();

        return $GLOBALS['bxDolClasses'][__CLASS__];
    }

    public function __get($sName)
    {
        if (array_key_exists($sName, $this->_aConfig))
            return $this->_aConfig[$sName];

        trigger_error('Undefined property "' . $sName . '" in ' . get_class($this), E_USER_ERROR);

        return null;
    }

    public function __isset($sName)
    {
        return isset($this->_aConfig[$sName]);
    }

}

/** @} */
