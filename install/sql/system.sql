--
-- Database: v 8.0
--

SET @sSysVersion = '8.0.0';

-- --------------------------------------------------------

SET NAMES 'utf8';
DROP TABLE IF EXISTS `sys_categories`, `sys_keys`, `sys_objects_editor`, `sys_objects_captcha`, `sys_objects_social_sharing`, `sys_objects_categories`, `sys_objects_cmts`, `sys_cmts_images`, `sys_cmts_images_preview`, `sys_cmts_images2entries`, `sys_email_templates`, `sys_options`, sys_options_types, `sys_options_categories`, `sys_ip_list`, `sys_ip_members_visits`, `sys_localization_categories`, `sys_localization_keys`, `sys_localization_languages`, `sys_localization_string_params`, `sys_localization_strings`, `sys_acl_actions`, `sys_acl_actions_track`, `sys_acl_matrix`, `sys_acl_level_prices`, `sys_acl_levels`, `sys_sessions`, `sys_acl_levels_members`, `sys_objects_search`, `sys_stat_site`, `sys_alerts`, `sys_alerts_handlers`, `sys_injections`, `sys_injections_admin`, `sys_modules`, `sys_modules_file_tracks`, `sys_permalinks`, `sys_objects_privacy`, `sys_privacy_defaults`, `sys_privacy_groups`, `sys_tags`, `sys_objects_tag`, `sys_transactions`, `sys_objects_auths`, `sys_objects_vote`, `sys_objects_view`, `sys_cron_jobs`, `sys_dnsbl_rules`, `sys_menu_mobile`, `sys_menu_mobile_pages`, `sys_objects_storage`, `sys_objects_uploader`, `sys_storage_user_quotas`, `sys_storage_tokens`, `sys_storage_ghosts`, `sys_storage_mime_types`, `sys_objects_transcoder_images`, `sys_transcoder_images_files`, `sys_transcoder_images_filters`, `sys_accounts`, `sys_profiles`, `sys_antispam_block_log`, `sys_objects_form`, `sys_form_displays`, `sys_form_inputs`, `sys_form_display_inputs`, `sys_form_pre_lists`, `sys_form_pre_values`, `sys_menu_templates`, `sys_objects_menu`, `sys_menu_sets`, `sys_menu_items`, `sys_objects_grid`, `sys_grid_fields`, `sys_grid_actions`, `sys_objects_connection`, `sys_profiles_conn_subscriptions`, `sys_profiles_conn_friends`, `sys_objects_page`, `sys_pages_layouts`, `sys_pages_design_boxes`, `sys_pages_blocks`, `sys_images`, `sys_std_pages`, `sys_std_widgets`, `sys_std_pages_widgets`;
ALTER DATABASE DEFAULT CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci';


-- --------------------------------------------------------


CREATE TABLE `sys_categories` (
  `Category` varchar(32) NOT NULL default '',
  `ID` int(10) unsigned NOT NULL default '0',
  `Type` varchar(20) NOT NULL default 'photo',
  `Owner` int(10) unsigned NOT NULL,
  `Status` enum('active', 'passive') NOT NULL default 'active',
  `Date` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`Category`, `ID`, `Type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- --------------------------------------------------------


CREATE TABLE `sys_keys` (
  `key` varchar(32) NOT NULL,
  `data` text NOT NULL,
  `expire` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- --------------------------------------------------------


CREATE TABLE `sys_objects_editor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object` varchar(32) NOT NULL,
  `title` varchar(255) NOT NULL,
  `skin` varchar(255) NOT NULL,
  `override_class_name` varchar(255) NOT NULL,
  `override_class_file` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `object` (`object`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;


INSERT INTO `sys_objects_editor` (`object`, `title`, `skin`, `override_class_name`, `override_class_file`) VALUES
('sys_tinymce', 'TinyMCE', 'default', 'BxTemplEditorTinyMCE', ''),
('sys_cleditor', 'CLEditor', '', 'BxTemplEditorCLEditor', '');


-- --------------------------------------------------------


CREATE TABLE IF NOT EXISTS `sys_objects_social_sharing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object` varchar(32) NOT NULL,
  `type` enum('html','service') NOT NULL,
  `content` text NOT NULL,
  `order` int(11) NOT NULL,
  `active` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


INSERT INTO `sys_objects_social_sharing` (`object`, `type`, `content`, `order`, `active`) VALUES
('facebook', 'html', '<a class="bx-btn" target="_blank" href="https://www.facebook.com/sharer/sharer.php?u={url_encoded}"><i class="sys-icon facebook"></i><span>32</span></a>', 1, 1),
('googleplus', 'html', '<a class="bx-btn" target="_blank" href="https://plus.google.com/share?url={url_encoded}"><i class="sys-icon google-plus"></i></a>', 2, 1),
('twitter', 'html', '<a class="bx-btn" target="_blank" href="https://twitter.com/share?url={url_encoded}"><i class="sys-icon twitter"></i></a>', 3, 1),
('pinterest', 'html', '<a class="bx-btn" target="_blank" href="http://pinterest.com/pin/create/button/?url={url_encoded}&media={img_url_encoded}&description={title_encoded}" class="pin-it-button" count-layout="horizontal"><i class="sys-icon pinterest"></i></a>', 4, 1);


-- --------------------------------------------------------


CREATE TABLE `sys_objects_captcha` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object` varchar(32) NOT NULL,
  `title` varchar(255) NOT NULL,
  `override_class_name` varchar(255) NOT NULL,
  `override_class_file` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

INSERT INTO `sys_objects_captcha` (`object`, `title`, `override_class_name`, `override_class_file`) VALUES
('sys_recaptcha', 'reCAPTCHA', 'BxTemplCaptchaReCAPTCHA', '');


-- --------------------------------------------------------


CREATE TABLE `sys_objects_auths` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `Title` varchar(128) NOT NULL,
  `Link` varchar(255) NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Table structure for table `sys_objects_categories`
--

CREATE TABLE `sys_objects_categories` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `ObjectName` varchar(50) NOT NULL,
  `Query` text  NOT NULL,
  `PermalinkParam` varchar(50) NOT NULL default '',
  `EnabledPermalink` varchar(100) NOT NULL default '',
  `DisabledPermalink` varchar(100) NOT NULL default '',
  `LangKey` varchar(100) NOT NULL default '',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sys_objects_cmts`
--

CREATE TABLE `sys_objects_cmts` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `Name` varchar(50) NOT NULL,
  `Table` varchar(50) NOT NULL,
  `CharsPostMin` int(10) NOT NULL,
  `CharsPostMax` int(10) NOT NULL,
  `CharsDisplayMax` int(10) NOT NULL,
  `Nl2br` smallint(1) NOT NULL,
  `PerView` smallint(6) NOT NULL,
  `PerViewReplies` smallint(6) NOT NULL,
  `BrowseType` varchar(50) NOT NULL,
  `IsBrowseSwitch` smallint(1) NOT NULL,
  `PostFormPosition` varchar(50) NOT NULL,
  `NumberOfLevels` smallint(6) NOT NULL,
  `IsDisplaySwitch` smallint(1) NOT NULL,
  `IsRatable` smallint(1) NOT NULL,
  `ViewingThreshold` smallint(6) NOT NULL,
  `IsOn` smallint(1) NOT NULL,
  `RootStylePrefix` varchar(16) NOT NULL default 'cmt',
  `BaseUrl` varchar(256) NOT NULL,
  `ObjectVote` varchar(32) NOT NULL,
  `TriggerTable` varchar(32) NOT NULL,
  `TriggerFieldId` varchar(32) NOT NULL,
  `TriggerFieldTitle` varchar(32) NOT NULL,
  `TriggerFieldComments` varchar(32) NOT NULL,
  `ClassName` varchar(32) NOT NULL,
  `ClassFile` varchar(256) NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sys_email_templates`
--

CREATE TABLE IF NOT EXISTS `sys_email_templates` (
  `ID` int(11) unsigned NOT NULL auto_increment,
  `Module` varchar(32) NOT NULL,
  `NameSystem` varchar(255) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Subject` varchar(255) NOT NULL,
  `Body` varchar(255) NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ;

INSERT INTO `sys_email_templates` (`Module`, `NameSystem`, `Name`, `Subject`, `Body`) VALUES
('system', '_sys_et_txt_name_system_activation', 't_Activation', '_sys_et_txt_subject_activation', '_sys_et_txt_body_activation'),
('system', '_sys_et_txt_name_system_admin_email', 't_AdminEmail', '_sys_et_txt_subject_admin_email', '_sys_et_txt_body_admin_email'),
('system', '_sys_et_txt_name_system_confirmation', 't_Confirmation', '_sys_et_txt_subject_confirmation', '_sys_et_txt_body_confirmation'),
('system', '_sys_et_txt_name_system_forgot', 't_Forgot', '_sys_et_txt_subject_forgot', '_sys_et_txt_body_forgot'),
('system', '_sys_et_txt_name_system_password_reset', 't_PasswordReset', '_sys_et_txt_subject_password_reset', '_sys_et_txt_body_password_reset'),
('system', '_sys_et_txt_name_system_mem_expiration', 't_MemExpiration', '_sys_et_txt_subject_mem_expiration', '_sys_et_txt_body_mem_expiration'),
('system', '_sys_et_txt_name_system_mem_changed', 't_MemChanged', '_sys_et_txt_subject_mem_changed', '_sys_et_txt_body_mem_changed'),
('system', '_sys_et_txt_name_system_comment_replied', 't_CommentReplied', '_sys_et_txt_subject_comment_replied', '_sys_et_txt_body_comment_replied');

-- --------------------------------------------------------

--
-- Table structure for table `sys_options`
--
CREATE TABLE `sys_options` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `category_id` int(11) unsigned NOT NULL default '0',
  `name` varchar(64) NOT NULL default '',
  `caption` varchar(255) NOT NULL default '',
  `value` mediumtext NOT NULL,
  `type` enum('digit','text','checkbox','select','combobox','file','list') NOT NULL default 'digit',
  `extra` text NOT NULL default '',
  `check` text NOT NULL,
  `check_error` varchar(255) NOT NULL default '',
  `order` int(11) default '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name`(`name`),
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Table structure for table `sys_options_categories`
--
CREATE TABLE `sys_options_categories` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `type_id` int(11) unsigned NOT NULL default '0',
  `name` varchar(64) NOT NULL default '',
  `caption` varchar(64) NOT NULL default '',
  `hidden` tinyint(1) NOT NULL default '0',
  `order` int(11) default '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name`(`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

--
-- Table structure for table `sys_options_types`
--
CREATE TABLE `sys_options_types` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `group` varchar(64) NOT NULL default '',
  `name` varchar(64) NOT NULL default '',
  `caption` varchar(64) NOT NULL default '',
  `icon` varchar(64) NOT NULL default '',
  `order` int(11) default '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name`(`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

--
-- Dumping data for tables `sys_options_types`
--
INSERT INTO `sys_options_types`(`group`, `name`, `caption`, `icon`, `order`) VALUES ('system', 'system', '_adm_stg_cpt_type_system', 'mi-stg-system.png', 1);
SET @iTypeId = LAST_INSERT_ID();

--
-- CATEGORY (HIDDEN): System
--
INSERT INTO `sys_options_categories`(`type_id`, `name`, `caption`, `hidden`, `order`) VALUES (@iTypeId, 'system', '_adm_stg_cpt_category_system', 1, 1);
SET @iCategoryId = LAST_INSERT_ID();

INSERT INTO `sys_options`(`category_id`, `name`, `caption`, `value`, `type`, `extra`, `check`, `check_error`, `order`) VALUES
(@iCategoryId, 'cmdDay', '', '10', 'digit', '', '', '', 1),
(@iCategoryId, 'sys_version', '', @sSysVersion, 'digit', '', '', '', 2),
(@iCategoryId, 'sys_install_time', '', '0', 'digit', '', '', '', 3),

(@iCategoryId, 'sys_html_fields', '', 'a:1:{s:6:"system";a:4:{i:0;s:12:"POST.message";i:1;s:15:"REQUEST.message";i:2;s:12:"POST.CmtText";i:3;s:15:"REQUEST.CmtText";}}', 'text', '', '', '', 10),
(@iCategoryId, 'sys_json_fields', '', '', 'text', '', '', '', 11),
(@iCategoryId, 'sys_exceptions_fields', '', '', 'text', '', '', '', 12),

(@iCategoryId, 'sys_site_logo', '', '0', 'digit', '', '', '', 20),
(@iCategoryId, 'sys_site_logo_alt', '_adm_dsg_txt_alt_text', '0', 'text', '', '', '', 21),
(@iCategoryId, 'sys_site_icon', '', '0', 'digit', '', '', '', 22),
(@iCategoryId, 'main_div_width', '', '998px', 'digit', '', '', '', 25),

(@iCategoryId, 'sys_template_cache_image_enable', '', '', 'checkbox', '', '', '', 30),
(@iCategoryId, 'sys_template_cache_image_max_size', '', '5', 'digit', '', '', '', 31),

(@iCategoryId, 'sys_email_confirmation', '', 'on', 'checkbox', '', '', '', 40),

(@iCategoryId, 'sys_redirect_after_account_added', '', 'page.php?i=create-persons-profile', 'digit', '', '', '', 50),

(@iCategoryId, 'sys_editor_default', '', 'sys_tinymce', 'digit', '', '', '', 60),
(@iCategoryId, 'sys_captcha_default', '', 'sys_recaptcha', 'digit', '', '', '', 61);


--
-- CATEGORY (HIDDEN): Languages
--
INSERT INTO `sys_options_categories`(`type_id`, `name`, `caption`, `hidden`, `order`) VALUES (@iTypeId, 'languages', '_adm_stg_cpt_category_languages', 1, 2);
SET @iCategoryId = LAST_INSERT_ID();

INSERT INTO `sys_options`(`category_id`, `name`, `caption`, `value`, `type`, `extra`, `check`, `check_error`, `order`) VALUES
(@iCategoryId, 'lang_default', '_adm_stg_cpt_option_lang_default', '', 'select', 'PHP:bx_import(''BxDolLanguages''); $aValues = BxDolLanguages::getInstance()->getLanguages(false, true); $aResult = array(); foreach($aValues as $sKey => $sValue) $aResult[] = array(\'key\' => $sKey, \'value\' => $sValue); return $aResult;', '', '', 1),

(@iCategoryId, 'sys_calendar_starts_sunday', '_adm_stg_cpt_option_sys_calendar_starts_sunday', '', 'checkbox', '', '', '', 2),

(@iCategoryId, 'sys_format_date', '_adm_stg_cpt_option_sys_format_date', 'D MMM YYYY', 'digit', '', '', '', 3),
(@iCategoryId, 'sys_format_time', '_adm_stg_cpt_option_sys_format_time', 'HH:mm', 'digit', '', '', '', 4),
(@iCategoryId, 'sys_format_datetime', '_adm_stg_cpt_option_sys_format_datetime', 'D MMM YYYY h:mm:ss a', 'digit', '', '', '', 5),
(@iCategoryId, 'sys_format_timeago', '_adm_stg_cpt_option_sys_format_timeago', 432000, 'digit', '', '', '', 6);


--
-- CATEGORY (HIDDEN): Templates
--
INSERT INTO `sys_options_categories`(`type_id`, `name`, `caption`, `hidden`, `order`) VALUES (@iTypeId, 'templates', '_adm_stg_cpt_category_templates', 1, 3);
SET @iCategoryId = LAST_INSERT_ID();

INSERT INTO `sys_options`(`category_id`, `name`, `caption`, `value`, `type`, `extra`, `check`, `check_error`, `order`) VALUES
(@iCategoryId, 'template', '_adm_stg_cpt_option_template', '', 'select', 'PHP:$aValues = get_templates_array(); $aResult = array(); foreach($aValues as $sKey => $sValue) $aResult[] = array(\'key\' => $sKey, \'value\' => $sValue); return $aResult;', 'bx_import(\'BxDolModuleQuery\'); return (strlen($arg0) > 0 && BxDolModuleQuery::getInstance()->isEnabled($arg0)) ? true : false;', 'Template cannot be empty and must have a valid name.', 1),
(@iCategoryId, 'enable_template', '_adm_stg_cpt_option_enable_template', 'on', 'checkbox', '', '', '', 2),

(@iCategoryId, 'sys_template_page_width_min', '_adm_stg_cpt_option_sys_template_page_width_min', '774', 'digit', '', '', '', 3),
(@iCategoryId, 'sys_template_page_width_max', '_adm_stg_cpt_option_sys_template_page_width_max', '1600', 'digit', '', '', '', 4);


--
-- CATEGORY: Cache
--
INSERT INTO `sys_options_categories`(`type_id`, `name`, `caption`, `hidden`, `order`) VALUES (@iTypeId, 'cache', '_adm_stg_cpt_category_cache', 0, 4);
SET @iCategoryId = LAST_INSERT_ID();

INSERT INTO `sys_options`(`category_id`, `name`, `caption`, `value`, `type`, `extra`, `check`, `check_error`, `order`) VALUES
(@iCategoryId, 'sys_db_cache_enable', '_adm_stg_cpt_option_sys_db_cache_enable', '', 'checkbox', '', '', '', 1),
(@iCategoryId, 'sys_db_cache_engine', '_adm_stg_cpt_option_sys_db_cache_engine', 'File', 'select', 'File,EAccelerator,Memcache,APC,XCache', '', '', 2),

(@iCategoryId, 'sys_cache_memcache_host', '_adm_stg_cpt_option_sys_cache_memcache_host', '', 'digit', '', '', '', 3),
(@iCategoryId, 'sys_cache_memcache_port', '_adm_stg_cpt_option_sys_cache_memcache_port', '11211', 'digit', '', '', '', 4),

(@iCategoryId, 'sys_page_cache_enable', '_adm_stg_cpt_option_sys_page_cache_enable', '', 'checkbox', '', '', '', 5),
(@iCategoryId, 'sys_page_cache_engine', '_adm_stg_cpt_option_sys_page_cache_engine', 'File', 'select', 'File,EAccelerator,Memcache,APC,XCache', '', '', 6),

(@iCategoryId, 'sys_pb_cache_enable', '_adm_stg_cpt_option_sys_pb_cache_enable', '', 'checkbox', '', '', '', 7),
(@iCategoryId, 'sys_pb_cache_engine', '_adm_stg_cpt_option_sys_pb_cache_engine', 'File', 'select', 'File,EAccelerator,Memcache,APC,XCache', '', '', 8),
(@iCategoryId, 'sys_mm_cache_engine', '_adm_stg_cpt_option_sys_mm_cache_engine', 'File', 'select', 'File,EAccelerator,Memcache,APC,XCache', '', '', 9),

(@iCategoryId, 'sys_template_cache_enable', '_adm_stg_cpt_option_sys_template_cache_enable', '', 'checkbox', '', '', '', 10),
(@iCategoryId, 'sys_template_cache_engine', '_adm_stg_cpt_option_sys_template_cache_engine', 'FileHtml', 'select', 'FileHtml,EAccelerator,Memcache,APC,XCache', '', '', 11),
(@iCategoryId, 'sys_template_cache_css_enable', '_adm_stg_cpt_option_sys_template_cache_css_enable', '', 'checkbox', '', '', '', 12),
(@iCategoryId, 'sys_template_cache_js_enable', '_adm_stg_cpt_option_sys_template_cache_js_enable', '', 'checkbox', '', '', '', 13),
(@iCategoryId, 'sys_template_cache_compress_enable', '_adm_stg_cpt_option_sys_template_cache_compress_enable', 'on', 'checkbox', '', '', '', 14);


--
-- CATEGORY: Categories
--
INSERT INTO `sys_options_categories`(`type_id`, `name`, `caption`, `hidden`, `order`) VALUES (@iTypeId, 'categories', '_adm_stg_cpt_category_categories', 0, 5);
SET @iCategoryId = LAST_INSERT_ID();

INSERT INTO `sys_options`(`category_id`, `name`, `caption`, `value`, `type`, `extra`, `check`, `check_error`, `order`) VALUES
(@iCategoryId, 'categ_perpage_browse', '_adm_stg_cpt_option_categ_perpage_browse', '30', 'digit', '', '', '', 1),
(@iCategoryId, 'categ_show_columns', '_adm_stg_cpt_option_categ_show_columns', '5', 'digit', '', '', '', 2);


--
-- CATEGORY: General
--
INSERT INTO `sys_options_categories`(`type_id`, `name`, `caption`, `hidden`, `order`) VALUES (@iTypeId, 'general', '_adm_stg_cpt_category_general', 0, 6);
SET @iCategoryId = LAST_INSERT_ID();

INSERT INTO `sys_options`(`category_id`, `name`, `caption`, `value`, `type`, `extra`, `check`, `check_error`, `order`) VALUES
(@iCategoryId, 'sys_ftp_login', '_adm_stg_cpt_option_sys_ftp_login', '', 'digit', '', '', '', 1),
(@iCategoryId, 'sys_ftp_password', '_adm_stg_cpt_option_sys_ftp_password', '', 'digit', '', '', '', 2),
(@iCategoryId, 'sys_ftp_dir', '_adm_stg_cpt_option_sys_ftp_dir', '', 'digit', '', '', '', 3),

(@iCategoryId, 'sys_oauth_key', '_adm_stg_cpt_option_sys_oauth_key', '', 'digit', '', '', '', 4),
(@iCategoryId, 'sys_oauth_secret', '_adm_stg_cpt_option_sys_oauth_secret', '', 'digit', '', '', '', 5),
(@iCategoryId, 'boonexAffID', '_adm_stg_cpt_option_boonex_aff_id', '', 'digit', '', '', '', 6),

(@iCategoryId, 'currency_code', '_adm_stg_cpt_option_currency_code', 'USD', 'select', 'USD,EURO', 'return strlen($arg0) > 0;', 'Cannot be empty.', 7),
(@iCategoryId, 'currency_sign', '_adm_stg_cpt_option_currency_sign', '&#36;', 'digit', '', 'return strlen($arg0) > 0;', 'Cannot be empty.', 8),

(@iCategoryId, 'enable_gd', '_adm_stg_cpt_option_enable_gd', 'on', 'checkbox', '', '', '', 9),
(@iCategoryId, 'useLikeOperator', '_adm_stg_cpt_option_use_like_operator', 'on', 'checkbox', '', '', '', 10);


--
-- CATEGORY: Massmailer
--
INSERT INTO `sys_options_categories`(`type_id`, `name`, `caption`, `hidden`, `order`) VALUES (@iTypeId, 'massmailer', '_adm_stg_cpt_category_massmailer', 0, 7);
SET @iCategoryId = LAST_INSERT_ID();

INSERT INTO `sys_options`(`category_id`, `name`, `caption`, `value`, `type`, `extra`, `check`, `check_error`, `order`) VALUES
(@iCategoryId, 'msgs_per_start', '_adm_stg_cpt_option_msgs_per_start', '20', 'digit', '', '', '', 1);


--
-- CATEGORY: Memberships
--
INSERT INTO `sys_options_categories`(`type_id`, `name`, `caption`, `hidden`, `order`) VALUES (@iTypeId, 'memberships', '_adm_stg_cpt_category_memberships', 0, 8);
SET @iCategoryId = LAST_INSERT_ID();

INSERT INTO `sys_options`(`category_id`, `name`, `caption`, `value`, `type`, `extra`, `check`, `check_error`, `order`) VALUES
(@iCategoryId, 'expire_notification_days', '_adm_stg_cpt_option_expire_notification_days', '1', 'digit', '', '', '', 1),
(@iCategoryId, 'expire_notify_once', '_adm_stg_cpt_option_expire_notify_once', 'on', 'checkbox', '', '', '', 2);


--
-- CATEGORY: Permalinks
--
INSERT INTO `sys_options_categories`(`type_id`, `name`, `caption`, `hidden`, `order`) VALUES (@iTypeId, 'permalinks', '_adm_stg_cpt_category_permalinks', 0, 9);
SET @iCategoryId = LAST_INSERT_ID();

INSERT INTO `sys_options` (`category_id`, `name`, `caption`, `value`, `type`, `extra`, `check`, `check_error`, `order`) VALUES
(@iCategoryId, 'permalinks_pages', '_adm_stg_cpt_option_permalinks_pages', 'on', 'checkbox', '', '', '', 1),
(@iCategoryId, 'permalinks_modules', '_adm_stg_cpt_option_permalinks_modules', 'on', 'checkbox', '', '', '', 2);


--
-- CATEGORY: Pruning
--
INSERT INTO `sys_options_categories`(`type_id`, `name`, `caption`, `hidden`, `order`) VALUES (@iTypeId, 'pruning', '_adm_stg_cpt_category_pruning', 0, 10);
SET @iCategoryId = LAST_INSERT_ID();

INSERT INTO `sys_options`(`category_id`, `name`, `caption`, `value`, `type`, `extra`, `check`, `check_error`, `order`) VALUES
(@iCategoryId, 'db_clean_members_visits', 'Delete stored members IPs older than (days)', '90', 'digit', '', '', '', 1),
(@iCategoryId, 'db_clean_mem_levels', 'Delete membership levels expired for (days)', '30', 'digit', '', '', '', 2);


--
-- CATEGORY: Security
--
INSERT INTO `sys_options_categories`(`type_id`, `name`, `caption`, `hidden`, `order`) VALUES (@iTypeId, 'security', '_adm_stg_cpt_category_security', 0, 11);
SET @iCategoryId = LAST_INSERT_ID();

INSERT INTO `sys_options`(`category_id`, `name`, `caption`, `value`, `type`, `extra`, `check`, `check_error`, `order`) VALUES
(@iCategoryId, 'enable_member_store_ip', '_adm_stg_cpt_option_enable_member_store_ip', 'on', 'checkbox', '', '', '', 1),
(@iCategoryId, 'ipBlacklistMode', '_adm_stg_cpt_option_ip_blacklist_mode', '2', 'digit', '', '', '', 2),
(@iCategoryId, 'ipListGlobalType', '_adm_stg_cpt_option_ip_list_global_type', '0', 'digit', '', '', '', 3),
(@iCategoryId, 'sys_security_impact_threshold_log', '_adm_stg_cpt_option_sys_security_impact_threshold_log', '-1', 'digit', '', '', '', 4),
(@iCategoryId, 'sys_security_impact_threshold_block', '_adm_stg_cpt_option_sys_security_impact_threshold_block', '-1', 'digit', '', '', '', 5),
(@iCategoryId, 'sys_security_form_token_enable', '_adm_stg_cpt_option_sys_security_form_token_enable', 'on', 'checkbox', '', '', '', 6),
(@iCategoryId, 'sys_security_form_token_lifetime', '_adm_stg_cpt_option_sys_security_form_token_lifetime', '86400', 'digit', '', '', '', 7),
(@iCategoryId, 'sys_dnsbl_enable', '_adm_stg_cpt_option_sys_dnsbl_enable', '', 'checkbox', '', '', '', 8),
(@iCategoryId, 'sys_uridnsbl_enable', '_adm_stg_cpt_option_sys_uridnsbl_enable', '', 'checkbox', '', '', '', 9),
(@iCategoryId, 'sys_akismet_enable', '_adm_stg_cpt_option_sys_akismet_enable', '', 'checkbox', '', '', '', 10),
(@iCategoryId, 'sys_akismet_api_key', '_adm_stg_cpt_option_sys_akismet_api_key', '', 'digit', '', '', '', 11),
(@iCategoryId, 'sys_antispam_block', '_adm_stg_cpt_option_sys_antispam_block', '', 'checkbox', '', '', '', 12),
(@iCategoryId, 'sys_antispam_report', '_adm_stg_cpt_option_sys_antispam_report', 'on', 'checkbox', '', '', '', 13),
(@iCategoryId, 'sys_recaptcha_key_public', '_adm_stg_cpt_option_sys_recaptcha_key_public', '', 'digit', '', '', '', 14),
(@iCategoryId, 'sys_recaptcha_key_private', '_adm_stg_cpt_option_sys_recaptcha_key_private', '', 'digit', '', '', '', 15);


--
-- CATEGORY: Site Settings
--
INSERT INTO `sys_options_categories`(`type_id`, `name`, `caption`, `hidden`, `order`) VALUES (@iTypeId, 'site_settings','_adm_stg_cpt_category_site_settings', 0, 12);
SET @iCategoryId = LAST_INSERT_ID();

INSERT INTO `sys_options`(`category_id`, `name`, `caption`, `value`, `type`, `extra`, `check`, `check_error`, `order`) VALUES
(@iCategoryId, 'site_title', '_adm_stg_cpt_option_site_title', 'Community', 'digit', '', '', '', 1),
(@iCategoryId, 'site_email', '_adm_stg_cpt_option_site_email', 'xxx@gmail.com', 'digit', '', '', '', 2),
(@iCategoryId, 'site_email_notify', '_adm_stg_cpt_option_site_email_notify', 'xxx2@gmail.com', 'digit', '', '', '', 3),
(@iCategoryId, 'site_email_bug_report', '_adm_stg_cpt_option_site_email_bug_report', 'xxx3@gmail.com', 'digit', '', '', '', 4);


--
-- CATEGORY: Storage
--
INSERT INTO `sys_options_categories`(`type_id`, `name`, `caption`, `hidden`, `order`) VALUES (@iTypeId, 'storage', '_adm_stg_cpt_category_storage', 0, 13);
SET @iCategoryId = LAST_INSERT_ID();

INSERT INTO `sys_options`(`category_id`, `name`, `caption`, `value`, `type`, `extra`, `check`, `check_error`, `order`) VALUES
(@iCategoryId, 'sys_storage_default', '_adm_stg_cpt_option_sys_storage_default', 'Local', 'select', 'Local,S3', '', '', 1),
(@iCategoryId, 'sys_storage_s3_access_key', '_adm_stg_cpt_option_sys_storage_s3_access_key', '', 'digit', '', '', '', 2),
(@iCategoryId, 'sys_storage_s3_secret_key', '_adm_stg_cpt_option_sys_storage_s3_secret_key', '', 'digit', '', '', '', 3),
(@iCategoryId, 'sys_storage_s3_bucket', '_adm_stg_cpt_option_sys_storage_s3_bucket', '', 'digit', '', '', '', 4),
(@iCategoryId, 'sys_storage_s3_domain', '_adm_stg_cpt_option_sys_storage_s3_domain', '', 'digit', '', '', '', 5);


--
-- CATEGORY: Tags
--
INSERT INTO `sys_options_categories`(`type_id`, `name`, `caption`, `hidden`, `order`) VALUES (@iTypeId, 'tags', '_adm_stg_cpt_category_tags', 0, 14);
SET @iCategoryId = LAST_INSERT_ID();

INSERT INTO `sys_options`(`category_id`, `name`, `caption`, `value`, `type`, `extra`, `check`, `check_error`, `order`) VALUES
(@iCategoryId, 'tags_non_parsable', '_adm_stg_cpt_option_tags_non_parsable', 'hi, hey, hello, all, i, i''m, i''d, am, for, in, to, a, the, on, it''s, is, my, of, are, from, i''m, me, you, and, we, not, will, at, where, there', 'text', '', '', '', 1),
(@iCategoryId, 'tags_perpage_browse', '_adm_stg_cpt_option_tags_perpage_browse', '30', 'digit', '', '', '', 2),
(@iCategoryId, 'tags_show_limit', '_adm_stg_cpt_option_tags_show_limit', '50', 'digit', '', '', '', 3);

-- --------------------------------------------------------

--
-- Table structure for table `sys_ip_list`
--

CREATE TABLE `sys_ip_list` (
  `ID` int(11) NOT NULL auto_increment,
  `From` int(10) unsigned NOT NULL,
  `To` int(10) unsigned NOT NULL,
  `Type` enum('allow','deny') NOT NULL default 'deny',
  `LastDT` int(11) unsigned NOT NULL,
  `Desc` varchar(128) NOT NULL,
  PRIMARY KEY  (`ID`),
  KEY `From` (`From`),
  KEY `To` (`To`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------


--
-- Table structure for table `sys_ip_members_visits`
--

CREATE TABLE `sys_ip_members_visits` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `MemberID` int(10) unsigned NOT NULL,
  `From` int(10) unsigned NOT NULL,
  `DateTime` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `From` (`From`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sys_localization_categories`
--

CREATE TABLE `sys_localization_categories` (
  `ID` int(6) unsigned NOT NULL auto_increment,
  `Name` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`ID`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sys_localization_categories`
--

INSERT INTO `sys_localization_categories` VALUES
(1, 'System'),
(2, 'Custom');

-- --------------------------------------------------------

--
-- Table structure for table `sys_localization_keys`
--

CREATE TABLE `sys_localization_keys` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `IDCategory` int(6) unsigned NOT NULL default '0',
  `Key` varchar(255) character set utf8 collate utf8_bin NOT NULL default '',
  PRIMARY KEY  (`ID`),
  UNIQUE KEY `Key` (`Key`),
  FULLTEXT KEY `KeyFilter` (`Key`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sys_localization_languages`
--

CREATE TABLE `sys_localization_languages` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `Name` varchar(5) NOT NULL default '',
  `Flag` varchar(2) NOT NULL default '',
  `Title` varchar(255) NOT NULL default '',
  `Enabled` tinyint(1) unsigned NOT NULL default '0',
  PRIMARY KEY  (`ID`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Table structure for table `sys_localization_string_params`
--

CREATE TABLE `sys_localization_string_params` (
  `IDKey` int(10) unsigned NOT NULL default '0',
  `IDParam` tinyint(3) unsigned NOT NULL default '0',
  `Description` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`IDKey`,`IDParam`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sys_localization_strings`
--

CREATE TABLE `sys_localization_strings` (
  `IDKey` int(10) unsigned NOT NULL default '0',
  `IDLanguage` int(10) unsigned NOT NULL default '0',
  `String` mediumtext NOT NULL,
  PRIMARY KEY  (`IDKey`,`IDLanguage`),
  FULLTEXT KEY `String` (`String`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- --------------------------------------------------------


CREATE TABLE `sys_acl_actions` (  
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Module` varchar(32) NOT NULL,
  `Name` varchar(255) NOT NULL default '',
  `AdditionalParamName` varchar(80) default NULL,
  `Title` varchar(255) NOT NULL,
  `Desc` varchar(255) NOT NULL,
  `Countable` tinyint(4) NOT NULL DEFAULT '0',
  `DisabledForLevels` int(10) unsigned NOT NULL DEFAULT '3',
  PRIMARY KEY  (`ID`),
  FULLTEXT KEY `ModuleAndName` (`Module`, `Name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

INSERT INTO `sys_acl_actions` (`ID`, `Module`, `Name`, `AdditionalParamName`, `Title`, `Desc`, `Countable`, `DisabledForLevels`) VALUES
(3, 'system', 'vote', NULL, '_sys_acl_action_vote', '', 0, 0),
(6, 'system', 'comments post', NULL, '_sys_acl_action_comments_post', '', 0, 1),
(8, 'system', 'comments edit own', NULL, '_sys_acl_action_comments_edit_own', '', 0, 1),
(9, 'system', 'comments remove own', NULL, '_sys_acl_action_comments_remove_own', '', 0, 1),
(10, 'system', 'comments edit all', NULL, '_sys_acl_action_comments_edit_all', '', 0, 1),
(11, 'system', 'comments remove all', NULL, '_sys_acl_action_comments_remove_all', '', 0, 1),
(12, 'system', 'create account', NULL, '_sys_acl_action_create_account', '_sys_acl_action_create_account_desc', 0, 2147483646),
(13, 'system', 'delete account', NULL, '_sys_acl_action_delete_account', '_sys_acl_action_delete_account_desc', 0, 2147483646);


CREATE TABLE `sys_acl_actions_track` (
  `IDAction` int(10) unsigned NOT NULL DEFAULT '0',
  `IDMember` int(10) unsigned NOT NULL default '0',
  `ActionsLeft` int(10) unsigned NOT NULL DEFAULT '0',
  `ValidSince` datetime default NULL,
  PRIMARY KEY  (`IDAction`,`IDMember`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



CREATE TABLE `sys_acl_matrix` (
  `IDLevel` int(10) unsigned NOT NULL DEFAULT '0',
  `IDAction` int(10) unsigned NOT NULL DEFAULT '0',
  `AllowedCount` int(10) unsigned DEFAULT NULL,
  `AllowedPeriodLen` int(10) unsigned DEFAULT NULL,
  `AllowedPeriodStart` datetime default NULL,
  `AllowedPeriodEnd` datetime default NULL,
  `AdditionalParamValue` varchar(255) default NULL,
  PRIMARY KEY  (`IDLevel`,`IDAction`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

SET @iUnauthenticated = 1;
SET @iStandard = 2;
SET @iUnconfirmed = 3;
SET @iPending = 4;
SET @iSuspended = 5;
SET @iModerator = 6;
SET @iAdministrator = 7;
SET @iPremium = 8;

INSERT INTO `sys_acl_matrix` (`IDLevel`, `IDAction`) VALUES

-- vote 
(@iStandard, 3),
(@iModerator, 3),
(@iAdministrator, 3),
(@iPremium, 3),

-- commets post
(@iStandard, 6),
(@iModerator, 6),
(@iAdministrator, 6),
(@iPremium, 6),

-- commets vote
(@iStandard, 7),
(@iModerator, 7),
(@iAdministrator, 7),
(@iPremium, 7),

-- commets edit own
(@iStandard, 8),
(@iModerator, 8),
(@iAdministrator, 8),
(@iPremium, 8),

-- commets remove own
(@iStandard, 9),
(@iModerator, 9),
(@iAdministrator, 9),
(@iPremium, 9),

-- commets edit all
(@iModerator, 10),
(@iAdministrator, 10),

-- commets remove all
(@iModerator, 11),
(@iAdministrator, 11),

-- account create
(@iUnauthenticated, 12),

-- account delete
(@iStandard, 13),
(@iUnconfirmed, 13),
(@iPending, 13),
(@iModerator, 13),
(@iAdministrator, 13),
(@iPremium, 13);



CREATE TABLE `sys_acl_level_prices` (
  `id` int(11) NOT NULL auto_increment,
  `IDLevel` int(10) unsigned NOT NULL DEFAULT '0',
  `Days` int(10) unsigned NOT NULL default '1',
  `Price` float unsigned NOT NULL default '1',
  `Order` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`IDLevel`,`Days`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



CREATE TABLE `sys_acl_levels` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL default '',
  `Icon` varchar(255) NOT NULL default '',
  `Description` varchar(255) NOT NULL default '',
  `Active` enum('yes','no') NOT NULL default 'no',
  `Purchasable` enum('yes','no') NOT NULL default 'yes',
  `Removable` enum('yes','no') NOT NULL default 'yes',
  `QuotaSize` int(11) NOT NULL,
  `QuotaNumber` int(11) NOT NULL,
  `QuotaMaxFileSize` int(11) NOT NULL,
  `Order` int(11) NOT NULL default '0',
  PRIMARY KEY  (`ID`),
  UNIQUE KEY `Name` (`Name`),
  FULLTEXT KEY `Description` (`Description`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

INSERT INTO `sys_acl_levels` (`ID`, `Name`, `Icon`, `Description`, `Active`, `Purchasable`, `Removable`, `QuotaSize`, `QuotaNumber`, `QuotaMaxFileSize`, `Order`) VALUES
(1, '_adm_prm_txt_level_unauthenticated', 'acl-non-member.png', '', 'yes', 'no', 'no', 0, 0, 0, 1),
(2, '_adm_prm_txt_level_standard', 'acl-standard.png', '', 'yes', 'no', 'no', 0, 0, 0, 2),
(3, '_adm_prm_txt_level_unconfirmed', 'acl-unconfirmed.png', '', 'yes', 'no', 'no', 0, 0, 0, 3),
(4, '_adm_prm_txt_level_pending', 'acl-pending.png', '', 'yes', 'no', 'no', 0, 0, 0, 4),
(5, '_adm_prm_txt_level_suspended', 'acl-suspended.png', '', 'yes', 'no', 'no', 0, 0, 0, 5),
(6, '_adm_prm_txt_level_moderator', 'acl-moderator.png', '', 'yes', 'no', 'no', 0, 0, 0, 6),
(7, '_adm_prm_txt_level_administrator', 'acl-administrator.png', '', 'yes', 'no', 'no', 0, 0, 0, 7),
(8, '_adm_prm_txt_level_premium', 'acl-premium.png', '', 'yes', 'yes', 'no', 0, 0, 0, 8);


-- --------------------------------------------------------

--
-- Table structure for table `boon_sys_sessions`
--

CREATE TABLE IF NOT EXISTS `sys_sessions` (
  `id` varchar(32) NOT NULL default '',
  `user_id` int(10) unsigned NOT NULL default '0',
  `data` text collate utf8_unicode_ci,
  `date` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `date` (`date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ;

-- --------------------------------------------------------

--
-- Table structure for table `sys_acl_levels_members`
--

CREATE TABLE `sys_acl_levels_members` (
  `IDMember` int(10) unsigned NOT NULL default '0',
  `IDLevel` int(10) unsigned NOT NULL DEFAULT '0',
  `DateStarts` datetime NOT NULL default '0000-00-00 00:00:00',
  `DateExpires` datetime default NULL,
  `TransactionID` varchar(16) NOT NULL default '',
  PRIMARY KEY  (`IDMember`,`IDLevel`,`DateStarts`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- --------------------------------------------------------


CREATE TABLE `sys_accounts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `profile_id` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_confirmed` tinyint(4) NOT NULL DEFAULT '0',
  `receive_updates` tinyint(4) NOT NULL DEFAULT '1',
  `receive_news` tinyint(4) NOT NULL DEFAULT '0',
  `password` varchar(40) NOT NULL,
  `salt` varchar(10) NOT NULL,
  `role` tinyint(4) NOT NULL DEFAULT '1',
  `lang_id` int(10) unsigned NOT NULL DEFAULT '0',
  `added` int(11) NOT NULL DEFAULT '0',
  `changed` int(11) NOT NULL DEFAULT '0',
  `logged` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `added` (`added`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;



CREATE TABLE IF NOT EXISTS `sys_profiles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `type` varchar(32) NOT NULL,
  `content_id` int(10) unsigned NOT NULL,
  `status` enum('active','pending','suspended') NOT NULL DEFAULT 'active',
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_type_content` (`account_id`,`type`,`content_id`),
  KEY `content_type` (`content_id`,`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- --------------------------------------------------------


CREATE TABLE `sys_stat_site` (
  `ID` tinyint(4) unsigned NOT NULL auto_increment,
  `Name` varchar(20) NOT NULL default '',
  `Title` varchar(50) NOT NULL default '',
  `UserLink` varchar(255) NOT NULL default '',
  `UserQuery` varchar(255) NOT NULL default '',
  `AdminLink` varchar(255) NOT NULL default '',
  `AdminQuery` varchar(255) NOT NULL default '',
  `IconName` varchar(50) NOT NULL default '',
  `StatOrder` int(4) unsigned NOT NULL default '0',
  PRIMARY KEY  (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Table structure for table 'sys_objects_search'
--

CREATE TABLE `sys_objects_search` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `ObjectName` varchar(50) NOT NULL  default '',
  `Title` varchar(50) NOT NULL default '',
  `ClassName` varchar(50) NOT NULL  default '',
  `ClassPath` varchar(100) NOT NULL  default '',
  PRIMARY KEY  (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ;


-- --------------------------------------------------------

--
-- Table structure for table `sys_tags`
--

CREATE TABLE `sys_tags` (
  `Tag` varchar(32) NOT NULL default '',
  `ObjID` int(10) unsigned NOT NULL default '0',
  `Type` varchar(20) NOT NULL default 'profile',
  `Date` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`Tag`,`ObjID`,`Type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sys_tags`
--

-- --------------------------------------------------------

--
-- Table structure for table `sys_objects_tag`
--

CREATE TABLE `sys_objects_tag` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `ObjectName` varchar(50) NOT NULL,
  `Query` text NOT NULL,
  `PermalinkParam` varchar(50) NOT NULL default '',
  `EnabledPermalink` varchar(100) NOT NULL default '',
  `DisabledPermalink` varchar(100) NOT NULL default '',
  `LangKey` varchar(100) NOT NULL default '',
  PRIMARY KEY  (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sys_transactions`
--

CREATE TABLE `sys_transactions` (
  `ID` bigint(20) unsigned NOT NULL auto_increment,
  `IDMember` int(10) unsigned NOT NULL default '0',
  `IDProvider` smallint(6) unsigned NOT NULL default '0',
  `gtwTransactionID` varchar(32) NOT NULL default '',
  `Date` datetime NOT NULL default '0000-00-00 00:00:00',
  `Amount` float unsigned NOT NULL default '0',
  `Currency` varchar(3) NOT NULL default 'USD',
  `Status` enum('pending','approved','declined') NOT NULL default 'pending',
  `Data` text NOT NULL,
  `Description` tinytext,
  `Note` tinytext,
  PRIMARY KEY  (`ID`),
  KEY `IDMember` (`IDMember`),
  KEY `IDProvider` (`IDProvider`),
  KEY `gtwTransactionID` (`gtwTransactionID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sys_objects_vote`
--

CREATE TABLE `sys_objects_vote` (
  `ID` int(11) unsigned NOT NULL auto_increment,
  `Name` varchar(50) NOT NULL default '',
  `TableMain` varchar(50) NOT NULL default '',
  `TableTrack` varchar(50) NOT NULL default '',
  `PostTimeout` int(11) NOT NULL default '0',
  `MinValue` tinyint(4) NOT NULL default '1',
  `MaxValue` tinyint(4) NOT NULL default '5',
  `IsUndo` tinyint(1) NOT NULL default '0',
  `IsOn` tinyint(1) NOT NULL default '1',
  `TriggerTable` varchar(32) NOT NULL default '',
  `TriggerFieldId` varchar(32) NOT NULL default '',
  `TriggerFieldRate` varchar(32) NOT NULL default '',
  `TriggerFieldRateCount` varchar(32) NOT NULL default '',
  `ClassName` varchar(32) NOT NULL default '',
  `ClassFile` varchar(256) NOT NULL default '',
  PRIMARY KEY  (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;


-- -------------------------------------------------------


CREATE TABLE `sys_modules` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `type` varchar(16) NOT NULL default 'module',
  `name` varchar(32) NOT NULL default '',
  `title` varchar(255) NOT NULL default '',
  `vendor` varchar(64) NOT NULL default '',
  `version` varchar(32) NOT NULL default '',
  `product_url` varchar(128) NOT NULL default '',
  `update_url` varchar(128) NOT NULL default '',
  `path` varchar(255) NOT NULL default '',  
  `uri` varchar(32) NOT NULL default '',
  `class_prefix` varchar(32) NOT NULL default '',
  `db_prefix` varchar(32) NOT NULL default '',
  `lang_category` varchar(64) NOT NULL default '',
  `dependencies` varchar(255) NOT NULL default '',
  `date` int(11) unsigned NOT NULL default '0',
  `enabled` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `path` (`path`),
  UNIQUE KEY `uri` (`uri`),
  UNIQUE KEY `class_prefix` (`class_prefix`),
  UNIQUE KEY `db_prefix` (`db_prefix`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

INSERT INTO `sys_modules` (`type`, `name`, `title`, `vendor`, `version`, `product_url`, `update_url`, `path`, `uri`, `class_prefix`, `db_prefix`, `lang_category`, `dependencies`, `date`, `enabled`) VALUES
('module', 'system', 'System', 'BoonEx', @sSysVersion, '', '', '', 'system', 'Bx', 'sys_', 'System', '', 0, 1);


CREATE TABLE `sys_modules_file_tracks` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `module_id` int(11) unsigned NOT NULL default '0',
  `file` varchar(255) NOT NULL default '',
  `hash` varchar(64) NOT NULL default '',  
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Table structure for table `sys_images`
--
CREATE TABLE `sys_images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_id` int(10) unsigned NOT NULL,
  `remote_id` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `mime_type` varchar(128) NOT NULL,
  `ext` varchar(32) NOT NULL,
  `size` int(11) NOT NULL,
  `added` int(11) NOT NULL,
  `modified` int(11) NOT NULL,
  `private` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `remote_id` (`remote_id`)
);

-- --------------------------------------------------------

--
-- Table structure for table `sys_cmts_images`
--
CREATE TABLE IF NOT EXISTS `sys_cmts_images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_id` int(10) unsigned NOT NULL,
  `remote_id` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `mime_type` varchar(128) NOT NULL,
  `ext` varchar(32) NOT NULL,
  `size` int(11) NOT NULL,
  `added` int(11) NOT NULL,
  `modified` int(11) NOT NULL,
  `private` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `remote_id` (`remote_id`)
);

-- --------------------------------------------------------

--
-- Table structure for table `sys_cmts_images_preview`
--
CREATE TABLE IF NOT EXISTS `sys_cmts_images_preview` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_id` int(10) unsigned NOT NULL,
  `remote_id` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `mime_type` varchar(128) NOT NULL,
  `ext` varchar(32) NOT NULL,
  `size` int(11) NOT NULL,
  `added` int(11) NOT NULL,
  `modified` int(11) NOT NULL,
  `private` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `remote_id` (`remote_id`)
);

-- --------------------------------------------------------

--
-- Table structure for table `sys_cmts_images2entries`
--
CREATE TABLE IF NOT EXISTS `sys_cmts_images2entries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `system_id` int(11) NOT NULL DEFAULT '0',
  `cmt_id` int(11) NOT NULL DEFAULT '0',
  `image_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `image` (`system_id`,`cmt_id`,`image_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

CREATE TABLE `sys_injections` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `name` varchar(128) NOT NULL default '',
  `page_index` int(11) NOT NULL default '0',
  `key` varchar(128) NOT NULL default '',
  `type` enum('text', 'php') NOT NULL default 'text',
  `data` text NOT NULL default '',
  `replace` TINYINT NOT NULL DEFAULT '0',
  `active` TINYINT NOT NULL DEFAULT '1',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

CREATE TABLE `sys_injections_admin` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `name` varchar(128) NOT NULL default '',
  `page_index` int(11) NOT NULL default '0',
  `key` varchar(128) NOT NULL default '',
  `type` enum('text','php') NOT NULL default 'text',
  `data` text NOT NULL,
  `replace` tinyint(4) NOT NULL default '0',
  `active` tinyint(4) NOT NULL default '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;


-- --------------------------------------------------------


CREATE TABLE `sys_permalinks` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `standard` varchar(128) NOT NULL DEFAULT '',
  `permalink` varchar(128) NOT NULL DEFAULT '',
  `check` varchar(64) NOT NULL DEFAULT '',
  `compare_by_prefix` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `check` (`standard`,`permalink`,`check`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

INSERT INTO `sys_permalinks` (`standard`, `permalink`, `check`, `compare_by_prefix`) VALUES
('page.php?i=', 'page/', 'permalinks_pages', 1),
('modules/?r=', 'm/', 'permalinks_modules', 1);


-- --------------------------------------------------------


CREATE TABLE `sys_alerts_handlers` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `name` varchar(128) NOT NULL default '',
  `class` varchar(128) NOT NULL default '',
  `file` varchar(255) NOT NULL default '',
  `eval` text NOT NULL default '', 
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;



CREATE TABLE `sys_alerts` (
  `id` int(11) unsigned NOT NULL auto_increment,  
  `unit` varchar(128) NOT NULL default '',
  `action` varchar(32) NOT NULL default 'none',
  `handler_id` int(11) NOT NULL default '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `alert_handler` (`unit`, `action`, `handler_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;


-- --------------------------------------------------------


CREATE TABLE `sys_objects_view` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(32) NOT NULL,
  `table_track` varchar(32) NOT NULL,
  `period` int(11) NOT NULL default '86400',
  `is_on` tinyint(4) NOT NULL default '1',
  `trigger_table` varchar(32) NOT NULL,
  `trigger_field_id` varchar(32) NOT NULL,
  `trigger_field_count` varchar(32) NOT NULL,
  `class_name` varchar(32) NOT NULL default '',
  `class_file` varchar(256) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;


-- --------------------------------------------------------


CREATE TABLE `sys_objects_privacy` (
  `id` int(11) NOT NULL auto_increment,
  `object` varchar(64) NOT NULL default '',
  `module` varchar(64) NOT NULL default '',
  `action` varchar(255) NOT NULL default '',
  `title` varchar(255) NOT NULL default '',
  `default_group` varchar(255) NOT NULL default '1',
  `table` varchar(255) NOT NULL default '',
  `table_field_id` varchar(255) NOT NULL default '',
  `table_field_author` varchar(255) NOT NULL default '',
  `override_class_name` varchar(255) NOT NULL default '',
  `override_class_file` varchar(255) NOT NULL default '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `object` (`object`),
  UNIQUE KEY `action` (`module`, `action`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

CREATE TABLE `sys_privacy_defaults` (  
  `owner_id` int(11) NOT NULL default '0',
  `action_id` int(11) NOT NULL default '0',
  `group_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`owner_id`, `action_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

CREATE TABLE `sys_privacy_groups` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL default '',
  `check` text NOT NULL default '',
  `active` tinyint(4) NOT NULL default '1',
  `visible` tinyint(4) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

INSERT INTO `sys_privacy_groups`(`id`, `title`, `check`, `active`, `visible`) VALUES
('1', '', '', 1, 0),
('2', '_sys_ps_group_title_me_only', '@me_only', 1, 1),
('3', '_sys_ps_group_title_public', '@public', 1, 1),
('4', '_sys_ps_group_title_members', '@members', 0, 0),
('5', '_sys_ps_group_title_friends', '@friends', 1, 1);


-- --------------------------------------------------------


--
-- Table structure for table `sys_cron_jobs`
--

CREATE TABLE `sys_cron_jobs` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `name` varchar(128) NOT NULL default '',
  `time` varchar(128) NOT NULL default '*',
  `class` varchar(128) NOT NULL default '',
  `file` varchar(255) NOT NULL default '',
  `eval` text NOT NULL default '', 
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sys_cron_jobs`
--

INSERT INTO `sys_cron_jobs` (`name`, `time`, `class`, `file`, `eval`) VALUES
('cmd', '0 0 * * *', 'BxDolCronCmd', 'inc/classes/BxDolCronCmd.php', ''),
('notifies', '*/10 * * * *', 'BxDolCronNotifies', 'inc/classes/BxDolCronNotifies.php', ''),
('video_comments', '* * * * *', 'BxDolCronVideoComments', 'flash/modules/video_comments/inc/classes/BxDolCronVideoComments.php', '');


-- --------------------------------------------------------


CREATE TABLE IF NOT EXISTS `sys_dnsbl_rules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `chain` enum('spammers','whitelist','uridns') NOT NULL,
  `zonedomain` varchar(255) NOT NULL,
  `postvresp` varchar(32) NOT NULL,
  `url` varchar(255) NOT NULL,
  `recheck` varchar(255) NOT NULL,
  `comment` varchar(255) NOT NULL,
  `added` int(11) NOT NULL,
  `active` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

INSERT INTO `sys_dnsbl_rules` (`id`, `chain`, `zonedomain`, `postvresp`, `url`, `recheck`, `comment`, `added`, `active`) VALUES
(1, 'whitelist', 'au.countries.nerd.dk.', '127.0.0.2', 'http://countries.nerd.dk/', '', 'Country based zone, any ip from Australia is whitelisted', 1287642420, 0),
(2, 'spammers', 'sbl.spamhaus.org.', 'any', 'http://www.spamhaus.org/sbl/', 'http://www.spamhaus.org/query/bl?ip=%s', 'Any non-failure result from sbl.spamhaus.org is a positive match', 1287642420, 1),
(3, 'spammers', 'zomgbl.spameatingmonkey.net.', 'any', 'http://spameatingmonkey.com/index.html', '', 'This zone is guaranteed to block 100% of all IPs because it lists everything (0.0.0.0/0). This list should never be used in production but exists to verify overall functionality of the blacklist servers.', 1287642420, 0),
(4, 'spammers', 'cn.countries.nerd.dk.', '127.0.0.2', 'http://countries.nerd.dk/', '', 'Country based zone, any ip from China is blocked', 1287642420, 0),
(5, 'uridns', 'multi.surbl.org.', 'any', 'http://www.surbl.org/', 'http://george.surbl.org/lookup.html', 'SURBLs are lists of web sites that have appeared in unsolicited messages. Unlike most lists, SURBLs are not lists of message senders.', 1287642420, 1);

CREATE TABLE IF NOT EXISTS `sys_antispam_block_log` (
  `ip` int(10) unsigned NOT NULL,
  `member_id` int(10) unsigned NOT NULL,
  `type` varchar(32) NOT NULL,
  `extra` text NOT NULL,
  `added` int(11) NOT NULL,
  KEY `ip` (`ip`),
  KEY `member_id` (`member_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `sys_dnsbluri_zones` (
  `level` tinyint(4) NOT NULL,
  `zone` varchar(64) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `sys_menu_mobile_pages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page` varchar(32) NOT NULL,
  `title` varchar(255) NOT NULL,
  `order` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `page` (`page`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

INSERT INTO `sys_menu_mobile_pages` (`id`, `page`, `title`, `order`) VALUES
(1, 'homepage', '_adm_mobile_page_homepage', 1),
(2, 'profile', '_adm_mobile_page_profile', 2);

CREATE TABLE IF NOT EXISTS `sys_menu_mobile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(32) NOT NULL,
  `page` varchar(32) NOT NULL,
  `title` varchar(255) NOT NULL,
  `icon` varchar(255) NOT NULL,
  `action` int(11) NOT NULL,
  `action_data` varchar(255) NOT NULL,
  `eval_bubble` text NOT NULL,
  `eval_hidden` text NOT NULL,
  `order` int(11) NOT NULL,
  `active` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

INSERT INTO `sys_menu_mobile` (`type`, `page`, `title`, `icon`, `action`, `action_data`, `eval_bubble`, `eval_hidden`, `order`, `active`) VALUES
('system', 'homepage', '_sys_mobile_status', 'home_status.png', 1, '', '', '', 1, 1),
('system', 'homepage', '_sys_mobile_mail', 'home_messages.png', 3, '', 'return getNewLettersNum({member_id});', '', 2, 1),
('system', 'homepage', '_sys_mobile_friends', 'home_friends.png', 4, '', 'return getFriendRequests({member_id});', '', 3, 1),
('system', 'homepage', '_sys_mobile_info', 'home_info.png', 5, '', '', '', 4, 1),
('system', 'homepage', '_sys_mobile_search', 'home_search.png', 6, '', '', '', 5, 1),
('system', 'profile', '_sys_mobile_profile_info', '', 5, '', '', '', 1, 1),
('system', 'profile', '_sys_mobile_profile_contact', '', 3, '', '', '', 2, 1),
('system', 'profile', '_sys_mobile_profile_friends', '', 4, '', 'return getFriendNumber(''{profile_id}'');', '', 3, 1);

-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `sys_objects_storage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object` varchar(32) NOT NULL,
  `engine` varchar(32) NOT NULL,
  `params` text NOT NULL,
  `token_life` int(11) NOT NULL,
  `cache_control` int(11) NOT NULL,
  `levels` tinyint(4) NOT NULL,
  `table_files` varchar(64) NOT NULL,
  `ext_mode` enum('allow-deny','deny-allow') NOT NULL,
  `ext_allow` text NOT NULL,
  `ext_deny` text NOT NULL,
  `quota_size` int(11) NOT NULL,
  `current_size` int(11) NOT NULL,
  `quota_number` int(11) NOT NULL,
  `current_number` int(11) NOT NULL,
  `max_file_size` int(11) NOT NULL,
  `ts` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `object` (`object`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `sys_objects_storage` (`object`, `engine`, `params`, `token_life`, `cache_control`, `levels`, `table_files`, `ext_mode`, `ext_allow`, `ext_deny`, `quota_size`, `current_size`, `quota_number`, `current_number`, `max_file_size`, `ts`) VALUES
('sys_images', 'Local', '', 360, 2592000, 0, 'sys_images', 'allow-deny', 'jpg,jpeg,jpe,gif,png', '', 0, 0, 0, 0, 0, 0),
('sys_cmts_images', 'Local', '', 360, 2592000, 3, 'sys_cmts_images', 'allow-deny', 'jpg,jpeg,jpe,gif,png', '', 0, 0, 0, 0, 0, 0),
('sys_cmts_images_preview', 'Local', '', 360, 2592000, 3, 'sys_cmts_images_preview', 'allow-deny', 'jpg,jpeg,jpe,gif,png', '', 0, 0, 0, 0, 0, 0);

CREATE TABLE IF NOT EXISTS `sys_storage_user_quotas` (
  `profile_id` int(11) NOT NULL,
  `current_size` int(11) NOT NULL,
  `current_number` int(11) NOT NULL,
  `ts` int(11) NOT NULL,
  PRIMARY KEY (`profile_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `sys_storage_tokens` (
  `id` int(11) NOT NULL,
  `object` varchar(32) NOT NULL,
  `hash` varchar(32) NOT NULL,
  `created` int(10) unsigned NOT NULL,
  UNIQUE KEY `id` (`id`,`object`,`hash`),
  KEY `created` (`created`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `sys_storage_ghosts` (
  `id` int(11) NOT NULL,
  `profile_id` int(10) unsigned NOT NULL,
  `object` varchar(32) NOT NULL,
  `content_id` int(11) NOT NULL,
  `created` int(10) unsigned NOT NULL,
  UNIQUE KEY `id` (`id`,`object`),
  KEY `created` (`created`),
  KEY `profile_object_content` (`profile_id`,`object`,`content_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `sys_storage_mime_types` (
  `ext` varchar(32) NOT NULL,
  `mime_type` varchar(128) NOT NULL,
  `icon` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`ext`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


INSERT INTO `sys_storage_mime_types` (`ext`, `mime_type`, `icon`) VALUES
('ez', 'application/andrew-inset', ''),
('aw', 'application/applixware', ''),
('atom', 'application/atom+xml', ''),
('atomcat', 'application/atomcat+xml', ''),
('atomsvc', 'application/atomsvc+xml', ''),
('ccxml', 'application/ccxml+xml', ''),
('cdmia', 'application/cdmi-capability', ''),
('cdmic', 'application/cdmi-container', ''),
('cdmid', 'application/cdmi-domain', ''),
('cdmio', 'application/cdmi-object', ''),
('cdmiq', 'application/cdmi-queue', ''),
('cu', 'application/cu-seeme', ''),
('davmount', 'application/davmount+xml', ''),
('dssc', 'application/dssc+der', ''),
('xdssc', 'application/dssc+xml', ''),
('ecma', 'application/ecmascript', ''),
('emma', 'application/emma+xml', ''),
('epub', 'application/epub+zip', ''),
('exi', 'application/exi', ''),
('pfr', 'application/font-tdpfr', ''),
('stk', 'application/hyperstudio', ''),
('ipfix', 'application/ipfix', ''),
('jar', 'application/java-archive', ''),
('ser', 'application/java-serialized-object', ''),
('class', 'application/java-vm', ''),
('js', 'application/javascript', ''),
('json', 'application/json', ''),
('lostxml', 'application/lost+xml', ''),
('hqx', 'application/mac-binhex40', ''),
('cpt', 'application/mac-compactpro', ''),
('mads', 'application/mads+xml', ''),
('mrc', 'application/marc', ''),
('mrcx', 'application/marcxml+xml', ''),
('ma', 'application/mathematica', ''),
('nb', 'application/mathematica', ''),
('mb', 'application/mathematica', ''),
('mathml', 'application/mathml+xml', ''),
('mbox', 'application/mbox', ''),
('mscml', 'application/mediaservercontrol+xml', ''),
('meta4', 'application/metalink4+xml', ''),
('mets', 'application/mets+xml', ''),
('mods', 'application/mods+xml', ''),
('m21', 'application/mp21', ''),
('mp21', 'application/mp21', ''),
('mp4s', 'application/mp4', ''),
('doc', 'application/msword', 'mime-type-document.png'),
('dot', 'application/msword', ''),
('mxf', 'application/mxf', ''),
('bin', 'application/octet-stream', ''),
('dms', 'application/octet-stream', ''),
('lha', 'application/octet-stream', ''),
('lrf', 'application/octet-stream', ''),
('lzh', 'application/octet-stream', ''),
('so', 'application/octet-stream', ''),
('iso', 'application/octet-stream', ''),
('dmg', 'application/octet-stream', ''),
('dist', 'application/octet-stream', ''),
('distz', 'application/octet-stream', ''),
('pkg', 'application/octet-stream', ''),
('bpk', 'application/octet-stream', ''),
('dump', 'application/octet-stream', ''),
('elc', 'application/octet-stream', ''),
('deploy', 'application/octet-stream', ''),
('mobipocket-ebook', 'application/octet-stream', ''),
('oda', 'application/oda', ''),
('opf', 'application/oebps-package+xml', ''),
('ogx', 'application/ogg', ''),
('onetoc', 'application/onenote', ''),
('onetoc2', 'application/onenote', ''),
('onetmp', 'application/onenote', ''),
('onepkg', 'application/onenote', ''),
('xer', 'application/patch-ops-error+xml', ''),
('pdf', 'application/pdf', 'mime-type-document.png'),
('pgp', 'application/pgp-encrypted', ''),
('asc', 'application/pgp-signature', ''),
('sig', 'application/pgp-signature', ''),
('prf', 'application/pics-rules', ''),
('p10', 'application/pkcs10', 'mime-type-vector.png'),
('p7m', 'application/pkcs7-mime', ''),
('p7c', 'application/pkcs7-mime', ''),
('p7s', 'application/pkcs7-signature', ''),
('p8', 'application/pkcs8', ''),
('ac', 'application/pkix-attr-cert', ''),
('cer', 'application/pkix-cert', ''),
('crl', 'application/pkix-crl', ''),
('pkipath', 'application/pkix-pkipath', ''),
('pki', 'application/pkixcmp', ''),
('pls', 'application/pls+xml', ''),
('ai', 'application/postscript', 'mime-type-vector.png'),
('eps', 'application/postscript', ''),
('ps', 'application/postscript', 'mime-type-vector.png'),
('cww', 'application/prs.cww', ''),
('pskcxml', 'application/pskc+xml', ''),
('rdf', 'application/rdf+xml', ''),
('rif', 'application/reginfo+xml', ''),
('rnc', 'application/relax-ng-compact-syntax', ''),
('rl', 'application/resource-lists+xml', ''),
('rld', 'application/resource-lists-diff+xml', ''),
('rs', 'application/rls-services+xml', ''),
('rsd', 'application/rsd+xml', ''),
('rss', 'application/rss+xml', ''),
('rtf', 'application/rtf', 'mime-type-document.png'),
('sbml', 'application/sbml+xml', ''),
('scq', 'application/scvp-cv-request', ''),
('scs', 'application/scvp-cv-response', ''),
('spq', 'application/scvp-vp-request', ''),
('spp', 'application/scvp-vp-response', ''),
('sdp', 'application/sdp', 'mime-type-presentation.png'),
('setpay', 'application/set-payment-initiation', ''),
('setreg', 'application/set-registration-initiation', ''),
('shf', 'application/shf+xml', ''),
('smi', 'application/smil+xml', ''),
('smil', 'application/smil+xml', ''),
('rq', 'application/sparql-query', ''),
('srx', 'application/sparql-results+xml', ''),
('gram', 'application/srgs', ''),
('grxml', 'application/srgs+xml', ''),
('sru', 'application/sru+xml', ''),
('ssml', 'application/ssml+xml', ''),
('tei', 'application/tei+xml', ''),
('teicorpus', 'application/tei+xml', ''),
('tfi', 'application/thraud+xml', ''),
('tsd', 'application/timestamped-data', ''),
('plb', 'application/vnd.3gpp.pic-bw-large', ''),
('psb', 'application/vnd.3gpp.pic-bw-small', ''),
('pvb', 'application/vnd.3gpp.pic-bw-var', ''),
('tcap', 'application/vnd.3gpp2.tcap', ''),
('pwn', 'application/vnd.3m.post-it-notes', ''),
('aso', 'application/vnd.accpac.simply.aso', ''),
('imp', 'application/vnd.accpac.simply.imp', ''),
('acu', 'application/vnd.acucobol', ''),
('atc', 'application/vnd.acucorp', ''),
('acutc', 'application/vnd.acucorp', ''),
('air', 'application/vnd.adobe.air-application-installer-package+zip', ''),
('fxp', 'application/vnd.adobe.fxp', ''),
('fxpl', 'application/vnd.adobe.fxp', ''),
('xdp', 'application/vnd.adobe.xdp+xml', ''),
('xfdf', 'application/vnd.adobe.xfdf', ''),
('ahead', 'application/vnd.ahead.space', ''),
('azf', 'application/vnd.airzip.filesecure.azf', ''),
('azs', 'application/vnd.airzip.filesecure.azs', ''),
('azw', 'application/vnd.amazon.ebook', ''),
('acc', 'application/vnd.americandynamics.acc', ''),
('ami', 'application/vnd.amiga.ami', ''),
('apk', 'application/vnd.android.package-archive', ''),
('cii', 'application/vnd.anser-web-certificate-issue-initiation', ''),
('fti', 'application/vnd.anser-web-funds-transfer-initiation', ''),
('atx', 'application/vnd.antix.game-component', ''),
('mpkg', 'application/vnd.apple.installer+xml', ''),
('m3u8', 'application/vnd.apple.mpegurl', ''),
('swi', 'application/vnd.aristanetworks.swi', ''),
('aep', 'application/vnd.audiograph', ''),
('mpm', 'application/vnd.blueice.multipass', ''),
('bmi', 'application/vnd.bmi', ''),
('rep', 'application/vnd.businessobjects', ''),
('cdxml', 'application/vnd.chemdraw+xml', ''),
('mmd', 'application/vnd.chipnuts.karaoke-mmd', ''),
('cdy', 'application/vnd.cinderella', ''),
('cla', 'application/vnd.claymore', ''),
('rp9', 'application/vnd.cloanto.rp9', ''),
('c4g', 'application/vnd.clonk.c4group', ''),
('c4d', 'application/vnd.clonk.c4group', ''),
('c4f', 'application/vnd.clonk.c4group', ''),
('c4p', 'application/vnd.clonk.c4group', ''),
('c4u', 'application/vnd.clonk.c4group', ''),
('c11amc', 'application/vnd.cluetrust.cartomobile-config', ''),
('c11amz', 'application/vnd.cluetrust.cartomobile-config-pkg', ''),
('csp', 'application/vnd.commonspace', ''),
('cdbcmsg', 'application/vnd.contact.cmsg', ''),
('cmc', 'application/vnd.cosmocaller', ''),
('clkx', 'application/vnd.crick.clicker', ''),
('clkk', 'application/vnd.crick.clicker.keyboard', ''),
('clkp', 'application/vnd.crick.clicker.palette', ''),
('clkt', 'application/vnd.crick.clicker.template', ''),
('clkw', 'application/vnd.crick.clicker.wordbank', ''),
('wbs', 'application/vnd.criticaltools.wbs+xml', ''),
('pml', 'application/vnd.ctc-posml', ''),
('ppd', 'application/vnd.cups-ppd', ''),
('car', 'application/vnd.curl.car', ''),
('pcurl', 'application/vnd.curl.pcurl', ''),
('rdz', 'application/vnd.data-vision.rdz', ''),
('uvf', 'application/vnd.dece.data', ''),
('uvvf', 'application/vnd.dece.data', ''),
('uvd', 'application/vnd.dece.data', ''),
('uvvd', 'application/vnd.dece.data', ''),
('uvt', 'application/vnd.dece.ttml+xml', ''),
('uvvt', 'application/vnd.dece.ttml+xml', ''),
('uvx', 'application/vnd.dece.unspecified', ''),
('uvvx', 'application/vnd.dece.unspecified', ''),
('fe_launch', 'application/vnd.denovo.fcselayout-link', ''),
('dna', 'application/vnd.dna', ''),
('mlp', 'application/vnd.dolby.mlp', ''),
('dpg', 'application/vnd.dpgraph', ''),
('dfac', 'application/vnd.dreamfactory', ''),
('ait', 'application/vnd.dvb.ait', 'mime-type-vector.png'),
('svc', 'application/vnd.dvb.service', ''),
('geo', 'application/vnd.dynageo', ''),
('mag', 'application/vnd.ecowin.chart', ''),
('nml', 'application/vnd.enliven', ''),
('esf', 'application/vnd.epson.esf', ''),
('msf', 'application/vnd.epson.msf', ''),
('qam', 'application/vnd.epson.quickanime', ''),
('slt', 'application/vnd.epson.salt', ''),
('ssf', 'application/vnd.epson.ssf', ''),
('es3', 'application/vnd.eszigno3+xml', ''),
('et3', 'application/vnd.eszigno3+xml', ''),
('ez2', 'application/vnd.ezpix-album', ''),
('ez3', 'application/vnd.ezpix-package', ''),
('fdf', 'application/vnd.fdf', ''),
('mseed', 'application/vnd.fdsn.mseed', ''),
('seed', 'application/vnd.fdsn.seed', ''),
('dataless', 'application/vnd.fdsn.seed', ''),
('gph', 'application/vnd.flographit', ''),
('ftc', 'application/vnd.fluxtime.clip', ''),
('fm', 'application/vnd.framemaker', ''),
('frame', 'application/vnd.framemaker', ''),
('maker', 'application/vnd.framemaker', ''),
('book', 'application/vnd.framemaker', ''),
('fnc', 'application/vnd.frogans.fnc', ''),
('ltf', 'application/vnd.frogans.ltf', ''),
('fsc', 'application/vnd.fsc.weblaunch', ''),
('oas', 'application/vnd.fujitsu.oasys', ''),
('oa2', 'application/vnd.fujitsu.oasys2', ''),
('oa3', 'application/vnd.fujitsu.oasys3', ''),
('fg5', 'application/vnd.fujitsu.oasysgp', ''),
('bh2', 'application/vnd.fujitsu.oasysprs', ''),
('ddd', 'application/vnd.fujixerox.ddd', ''),
('xdw', 'application/vnd.fujixerox.docuworks', ''),
('xbd', 'application/vnd.fujixerox.docuworks.binder', ''),
('fzs', 'application/vnd.fuzzysheet', ''),
('txd', 'application/vnd.genomatix.tuxedo', ''),
('ggb', 'application/vnd.geogebra.file', ''),
('ggt', 'application/vnd.geogebra.tool', ''),
('gex', 'application/vnd.geometry-explorer', ''),
('gre', 'application/vnd.geometry-explorer', ''),
('gxt', 'application/vnd.geonext', ''),
('g2w', 'application/vnd.geoplan', ''),
('g3w', 'application/vnd.geospace', ''),
('gmx', 'application/vnd.gmx', ''),
('kml', 'application/vnd.google-earth.kml+xml', ''),
('kmz', 'application/vnd.google-earth.kmz', ''),
('gqf', 'application/vnd.grafeq', ''),
('gqs', 'application/vnd.grafeq', ''),
('gac', 'application/vnd.groove-account', ''),
('ghf', 'application/vnd.groove-help', ''),
('gim', 'application/vnd.groove-identity-message', ''),
('grv', 'application/vnd.groove-injector', ''),
('gtm', 'application/vnd.groove-tool-message', ''),
('tpl', 'application/vnd.groove-tool-template', ''),
('vcg', 'application/vnd.groove-vcard', ''),
('hal', 'application/vnd.hal+xml', ''),
('zmm', 'application/vnd.handheld-entertainment+xml', ''),
('hbci', 'application/vnd.hbci', ''),
('les', 'application/vnd.hhe.lesson-player', ''),
('hpgl', 'application/vnd.hp-hpgl', 'mime-type-vector.png'),
('hpid', 'application/vnd.hp-hpid', ''),
('hps', 'application/vnd.hp-hps', ''),
('jlt', 'application/vnd.hp-jlyt', ''),
('pcl', 'application/vnd.hp-pcl', ''),
('pclxl', 'application/vnd.hp-pclxl', ''),
('sfd-hdstx', 'application/vnd.hydrostatix.sof-data', ''),
('x3d', 'application/vnd.hzn-3d-crossword', ''),
('mpy', 'application/vnd.ibm.minipay', ''),
('afp', 'application/vnd.ibm.modcap', ''),
('listafp', 'application/vnd.ibm.modcap', ''),
('list3820', 'application/vnd.ibm.modcap', ''),
('irm', 'application/vnd.ibm.rights-management', ''),
('sc', 'application/vnd.ibm.secure-container', ''),
('icc', 'application/vnd.iccprofile', ''),
('icm', 'application/vnd.iccprofile', ''),
('igl', 'application/vnd.igloader', ''),
('ivp', 'application/vnd.immervision-ivp', ''),
('ivu', 'application/vnd.immervision-ivu', ''),
('igm', 'application/vnd.insors.igm', ''),
('xpw', 'application/vnd.intercon.formnet', ''),
('xpx', 'application/vnd.intercon.formnet', ''),
('i2g', 'application/vnd.intergeo', ''),
('qbo', 'application/vnd.intu.qbo', ''),
('qfx', 'application/vnd.intu.qfx', ''),
('rcprofile', 'application/vnd.ipunplugged.rcprofile', ''),
('irp', 'application/vnd.irepository.package+xml', ''),
('xpr', 'application/vnd.is-xpr', ''),
('fcs', 'application/vnd.isac.fcs', ''),
('jam', 'application/vnd.jam', ''),
('rms', 'application/vnd.jcp.javame.midlet-rms', ''),
('jisp', 'application/vnd.jisp', ''),
('joda', 'application/vnd.joost.joda-archive', ''),
('ktz', 'application/vnd.kahootz', ''),
('ktr', 'application/vnd.kahootz', ''),
('karbon', 'application/vnd.kde.karbon', ''),
('chrt', 'application/vnd.kde.kchart', ''),
('kfo', 'application/vnd.kde.kformula', ''),
('flw', 'application/vnd.kde.kivio', ''),
('kon', 'application/vnd.kde.kontour', ''),
('kpr', 'application/vnd.kde.kpresenter', ''),
('kpt', 'application/vnd.kde.kpresenter', ''),
('ksp', 'application/vnd.kde.kspread', ''),
('kwd', 'application/vnd.kde.kword', ''),
('kwt', 'application/vnd.kde.kword', ''),
('htke', 'application/vnd.kenameaapp', ''),
('kia', 'application/vnd.kidspiration', ''),
('kne', 'application/vnd.kinar', ''),
('knp', 'application/vnd.kinar', ''),
('skp', 'application/vnd.koan', ''),
('skd', 'application/vnd.koan', ''),
('skt', 'application/vnd.koan', ''),
('skm', 'application/vnd.koan', ''),
('sse', 'application/vnd.kodak-descriptor', ''),
('lasxml', 'application/vnd.las.las+xml', ''),
('lbd', 'application/vnd.llamagraphics.life-balance.desktop', ''),
('lbe', 'application/vnd.llamagraphics.life-balance.exchange+xml', ''),
('123', 'application/vnd.lotus-1-2-3', ''),
('apr', 'application/vnd.lotus-approach', ''),
('pre', 'application/vnd.lotus-freelance', ''),
('nsf', 'application/vnd.lotus-notes', ''),
('org', 'application/vnd.lotus-organizer', ''),
('scm', 'application/vnd.lotus-screencam', ''),
('lwp', 'application/vnd.lotus-wordpro', ''),
('portpkg', 'application/vnd.macports.portpkg', ''),
('mcd', 'application/vnd.mcd', ''),
('mc1', 'application/vnd.medcalcdata', ''),
('cdkey', 'application/vnd.mediastation.cdkey', ''),
('mwf', 'application/vnd.mfer', ''),
('mfm', 'application/vnd.mfmp', ''),
('flo', 'application/vnd.micrografx.flo', ''),
('igx', 'application/vnd.micrografx.igx', ''),
('mif', 'application/vnd.mif', ''),
('daf', 'application/vnd.mobius.daf', ''),
('dis', 'application/vnd.mobius.dis', ''),
('mbk', 'application/vnd.mobius.mbk', ''),
('mqy', 'application/vnd.mobius.mqy', ''),
('msl', 'application/vnd.mobius.msl', ''),
('plc', 'application/vnd.mobius.plc', ''),
('txf', 'application/vnd.mobius.txf', ''),
('mpn', 'application/vnd.mophun.application', ''),
('mpc', 'application/vnd.mophun.certificate', ''),
('xul', 'application/vnd.mozilla.xul+xml', ''),
('cil', 'application/vnd.ms-artgalry', 'mime-type-vector.png'),
('cab', 'application/vnd.ms-cab-compressed', 'mime-type-archive.png'),
('xls', 'application/vnd.ms-excel', 'mime-type-spreadsheet.png'),
('xlm', 'application/vnd.ms-excel', ''),
('xla', 'application/vnd.ms-excel', ''),
('xlc', 'application/vnd.ms-excel', ''),
('xlt', 'application/vnd.ms-excel', 'mime-type-spreadsheet.png'),
('xlw', 'application/vnd.ms-excel', ''),
('xlam', 'application/vnd.ms-excel.addin.macroenabled.12', ''),
('xlsb', 'application/vnd.ms-excel.sheet.binary.macroenabled.12', ''),
('xlsm', 'application/vnd.ms-excel.sheet.macroenabled.12', ''),
('xltm', 'application/vnd.ms-excel.template.macroenabled.12', ''),
('eot', 'application/vnd.ms-fontobject', ''),
('chm', 'application/vnd.ms-htmlhelp', ''),
('ims', 'application/vnd.ms-ims', ''),
('lrm', 'application/vnd.ms-lrm', ''),
('thmx', 'application/vnd.ms-officetheme', ''),
('cat', 'application/vnd.ms-pki.seccat', ''),
('stl', 'application/vnd.ms-pki.stl', ''),
('ppt', 'application/vnd.ms-powerpoint', 'mime-type-presentation.png'),
('pps', 'application/vnd.ms-powerpoint', ''),
('pot', 'application/vnd.ms-powerpoint', ''),
('ppam', 'application/vnd.ms-powerpoint.addin.macroenabled.12', ''),
('pptm', 'application/vnd.ms-powerpoint.presentation.macroenabled.12', ''),
('sldm', 'application/vnd.ms-powerpoint.slide.macroenabled.12', ''),
('ppsm', 'application/vnd.ms-powerpoint.slideshow.macroenabled.12', ''),
('potm', 'application/vnd.ms-powerpoint.template.macroenabled.12', ''),
('mpp', 'application/vnd.ms-project', ''),
('mpt', 'application/vnd.ms-project', ''),
('docm', 'application/vnd.ms-word.document.macroenabled.12', ''),
('dotm', 'application/vnd.ms-word.template.macroenabled.12', ''),
('wps', 'application/vnd.ms-works', ''),
('wks', 'application/vnd.ms-works', ''),
('wcm', 'application/vnd.ms-works', ''),
('wdb', 'application/vnd.ms-works', ''),
('wpl', 'application/vnd.ms-wpl', ''),
('xps', 'application/vnd.ms-xpsdocument', ''),
('mseq', 'application/vnd.mseq', ''),
('mus', 'application/vnd.musician', ''),
('msty', 'application/vnd.muvee.style', ''),
('nlu', 'application/vnd.neurolanguage.nlu', ''),
('nnd', 'application/vnd.noblenet-directory', ''),
('nns', 'application/vnd.noblenet-sealer', ''),
('nnw', 'application/vnd.noblenet-web', ''),
('ngdat', 'application/vnd.nokia.n-gage.data', ''),
('n-gage', 'application/vnd.nokia.n-gage.symbian.install', ''),
('rpst', 'application/vnd.nokia.radio-preset', ''),
('rpss', 'application/vnd.nokia.radio-presets', ''),
('edm', 'application/vnd.novadigm.edm', ''),
('edx', 'application/vnd.novadigm.edx', ''),
('ext', 'application/vnd.novadigm.ext', ''),
('odc', 'application/vnd.oasis.opendocument.chart', ''),
('otc', 'application/vnd.oasis.opendocument.chart-template', ''),
('odb', 'application/vnd.oasis.opendocument.database', ''),
('odf', 'application/vnd.oasis.opendocument.formula', ''),
('odft', 'application/vnd.oasis.opendocument.formula-template', ''),
('odg', 'application/vnd.oasis.opendocument.graphics', 'mime-type-vector.png'),
('otg', 'application/vnd.oasis.opendocument.graphics-template', ''),
('odi', 'application/vnd.oasis.opendocument.image', ''),
('oti', 'application/vnd.oasis.opendocument.image-template', ''),
('odp', 'application/vnd.oasis.opendocument.presentation', 'mime-type-presentation.png'),
('otp', 'application/vnd.oasis.opendocument.presentation-template', ''),
('ods', 'application/vnd.oasis.opendocument.spreadsheet', 'mime-type-spreadsheet.png'),
('ots', 'application/vnd.oasis.opendocument.spreadsheet-template', 'mime-type-spreadsheet.png'),
('odt', 'application/vnd.oasis.opendocument.text', 'mime-type-document.png'),
('odm', 'application/vnd.oasis.opendocument.text-master', ''),
('ott', 'application/vnd.oasis.opendocument.text-template', 'mime-type-document.png'),
('oth', 'application/vnd.oasis.opendocument.text-web', ''),
('xo', 'application/vnd.olpc-sugar', ''),
('dd2', 'application/vnd.oma.dd2+xml', ''),
('oxt', 'application/vnd.openofficeorg.extension', ''),
('pptx', 'application/vnd.openxmlformats-officedocument.presentationml.presentation', 'mime-type-presentation.png'),
('sldx', 'application/vnd.openxmlformats-officedocument.presentationml.slide', ''),
('ppsx', 'application/vnd.openxmlformats-officedocument.presentationml.slideshow', ''),
('potx', 'application/vnd.openxmlformats-officedocument.presentationml.template', ''),
('xlsx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 'mime-type-spreadsheet.png'),
('xltx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.template', ''),
('docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'mime-type-document.png'),
('dotx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.template', ''),
('mgp', 'application/vnd.osgeo.mapguide.package', ''),
('dp', 'application/vnd.osgi.dp', ''),
('pdb', 'application/vnd.palm', 'mime-type-document.png'),
('pqa', 'application/vnd.palm', ''),
('oprc', 'application/vnd.palm', ''),
('paw', 'application/vnd.pawaafile', ''),
('str', 'application/vnd.pg.format', ''),
('ei6', 'application/vnd.pg.osasli', ''),
('efif', 'application/vnd.picsel', ''),
('wg', 'application/vnd.pmi.widget', ''),
('plf', 'application/vnd.pocketlearn', ''),
('pbd', 'application/vnd.powerbuilder6', ''),
('box', 'application/vnd.previewsystems.box', ''),
('mgz', 'application/vnd.proteus.magazine', ''),
('qps', 'application/vnd.publishare-delta-tree', ''),
('ptid', 'application/vnd.pvi.ptid1', ''),
('qxd', 'application/vnd.quark.quarkxpress', ''),
('qxt', 'application/vnd.quark.quarkxpress', ''),
('qwd', 'application/vnd.quark.quarkxpress', ''),
('qwt', 'application/vnd.quark.quarkxpress', ''),
('qxl', 'application/vnd.quark.quarkxpress', ''),
('qxb', 'application/vnd.quark.quarkxpress', ''),
('bed', 'application/vnd.realvnc.bed', ''),
('mxl', 'application/vnd.recordare.musicxml', ''),
('musicxml', 'application/vnd.recordare.musicxml+xml', ''),
('cryptonote', 'application/vnd.rig.cryptonote', ''),
('cod', 'application/vnd.rim.cod', ''),
('rm', 'application/vnd.rn-realmedia', ''),
('link66', 'application/vnd.route66.link66+xml', ''),
('st', 'application/vnd.sailingtracker.track', ''),
('see', 'application/vnd.seemail', ''),
('sema', 'application/vnd.sema', ''),
('semd', 'application/vnd.semd', ''),
('semf', 'application/vnd.semf', ''),
('ifm', 'application/vnd.shana.informed.formdata', ''),
('itp', 'application/vnd.shana.informed.formtemplate', ''),
('iif', 'application/vnd.shana.informed.interchange', ''),
('ipk', 'application/vnd.shana.informed.package', ''),
('twd', 'application/vnd.simtech-mindmapper', ''),
('twds', 'application/vnd.simtech-mindmapper', ''),
('mmf', 'application/vnd.smaf', ''),
('teacher', 'application/vnd.smart.teacher', ''),
('sdkm', 'application/vnd.solent.sdkm+xml', ''),
('sdkd', 'application/vnd.solent.sdkm+xml', ''),
('dxp', 'application/vnd.spotfire.dxp', ''),
('sfs', 'application/vnd.spotfire.sfs', ''),
('sdc', 'application/vnd.stardivision.calc', 'mime-type-spreadsheet.png'),
('sda', 'application/vnd.stardivision.draw', ''),
('sdd', 'application/vnd.stardivision.impress', 'mime-type-presentation.png'),
('smf', 'application/vnd.stardivision.math', ''),
('sdw', 'application/vnd.stardivision.writer', 'mime-type-document.png'),
('vor', 'application/vnd.stardivision.writer', ''),
('sgl', 'application/vnd.stardivision.writer-global', ''),
('sm', 'application/vnd.stepmania.stepchart', ''),
('sxc', 'application/vnd.sun.xml.calc', 'mime-type-spreadsheet.png'),
('stc', 'application/vnd.sun.xml.calc.template', 'mime-type-spreadsheet.png'),
('sxd', 'application/vnd.sun.xml.draw', 'mime-type-vector.png'),
('std', 'application/vnd.sun.xml.draw.template', ''),
('sxi', 'application/vnd.sun.xml.impress', 'mime-type-presentation.png'),
('sti', 'application/vnd.sun.xml.impress.template', 'mime-type-presentation.png'),
('sxm', 'application/vnd.sun.xml.math', ''),
('sxw', 'application/vnd.sun.xml.writer', 'mime-type-document.png'),
('sxg', 'application/vnd.sun.xml.writer.global', ''),
('stw', 'application/vnd.sun.xml.writer.template', 'mime-type-document.png'),
('sus', 'application/vnd.sus-calendar', ''),
('susp', 'application/vnd.sus-calendar', ''),
('svd', 'application/vnd.svd', ''),
('sis', 'application/vnd.symbian.install', ''),
('sisx', 'application/vnd.symbian.install', ''),
('xsm', 'application/vnd.syncml+xml', ''),
('bdm', 'application/vnd.syncml.dm+wbxml', ''),
('xdm', 'application/vnd.syncml.dm+xml', ''),
('tao', 'application/vnd.tao.intent-module-archive', ''),
('tmo', 'application/vnd.tmobile-livetv', ''),
('tpt', 'application/vnd.trid.tpt', ''),
('mxs', 'application/vnd.triscape.mxs', ''),
('tra', 'application/vnd.trueapp', ''),
('ufd', 'application/vnd.ufdl', ''),
('ufdl', 'application/vnd.ufdl', ''),
('utz', 'application/vnd.uiq.theme', ''),
('umj', 'application/vnd.umajin', ''),
('unityweb', 'application/vnd.unity', ''),
('uoml', 'application/vnd.uoml+xml', ''),
('vcx', 'application/vnd.vcx', ''),
('vsd', 'application/vnd.visio', ''),
('vst', 'application/vnd.visio', ''),
('vss', 'application/vnd.visio', 'mime-type-vector.png'),
('vsw', 'application/vnd.visio', ''),
('vis', 'application/vnd.visionary', ''),
('vsf', 'application/vnd.vsf', ''),
('wbxml', 'application/vnd.wap.wbxml', ''),
('wmlc', 'application/vnd.wap.wmlc', ''),
('wmlsc', 'application/vnd.wap.wmlscriptc', ''),
('wtb', 'application/vnd.webturbo', ''),
('nbp', 'application/vnd.wolfram.player', ''),
('wpd', 'application/vnd.wordperfect', ''),
('wqd', 'application/vnd.wqd', ''),
('stf', 'application/vnd.wt.stf', ''),
('xar', 'application/vnd.xara', ''),
('xfdl', 'application/vnd.xfdl', ''),
('hvd', 'application/vnd.yamaha.hv-dic', ''),
('hvs', 'application/vnd.yamaha.hv-script', ''),
('hvp', 'application/vnd.yamaha.hv-voice', ''),
('osf', 'application/vnd.yamaha.openscoreformat', ''),
('osfpvg', 'application/vnd.yamaha.openscoreformat.osfpvg+xml', ''),
('saf', 'application/vnd.yamaha.smaf-audio', ''),
('spf', 'application/vnd.yamaha.smaf-phrase', ''),
('cmp', 'application/vnd.yellowriver-custom-menu', ''),
('zir', 'application/vnd.zul', ''),
('zirz', 'application/vnd.zul', ''),
('zaz', 'application/vnd.zzazz.deck+xml', ''),
('vxml', 'application/voicexml+xml', ''),
('wgt', 'application/widget', ''),
('hlp', 'application/winhlp', ''),
('wsdl', 'application/wsdl+xml', ''),
('wspolicy', 'application/wspolicy+xml', ''),
('7z', 'application/x-7z-compressed', 'mime-type-archive.png'),
('abw', 'application/x-abiword', ''),
('ace', 'application/x-ace-compressed', 'mime-type-archive.png'),
('aab', 'application/x-authorware-bin', ''),
('x32', 'application/x-authorware-bin', ''),
('u32', 'application/x-authorware-bin', ''),
('vox', 'application/x-authorware-bin', ''),
('aam', 'application/x-authorware-map', ''),
('aas', 'application/x-authorware-seg', ''),
('bcpio', 'application/x-bcpio', ''),
('torrent', 'application/x-bittorrent', ''),
('bz', 'application/x-bzip', ''),
('bz2', 'application/x-bzip2', 'mime-type-archive.png'),
('boz', 'application/x-bzip2', ''),
('vcd', 'application/x-cdlink', ''),
('chat', 'application/x-chat', ''),
('pgn', 'application/x-chess-pgn', ''),
('cpio', 'application/x-cpio', ''),
('csh', 'application/x-csh', ''),
('deb', 'application/x-debian-package', ''),
('udeb', 'application/x-debian-package', ''),
('dir', 'application/x-director', ''),
('dcr', 'application/x-director', ''),
('dxr', 'application/x-director', ''),
('cst', 'application/x-director', ''),
('cct', 'application/x-director', ''),
('cxt', 'application/x-director', ''),
('w3d', 'application/x-director', ''),
('fgd', 'application/x-director', ''),
('swa', 'application/x-director', ''),
('wad', 'application/x-doom', ''),
('ncx', 'application/x-dtbncx+xml', ''),
('dtb', 'application/x-dtbook+xml', ''),
('res', 'application/x-dtbresource+xml', ''),
('dvi', 'application/x-dvi', ''),
('bdf', 'application/x-font-bdf', ''),
('gsf', 'application/x-font-ghostscript', ''),
('psf', 'application/x-font-linux-psf', ''),
('otf', 'application/x-font-otf', ''),
('pcf', 'application/x-font-pcf', ''),
('snf', 'application/x-font-snf', ''),
('ttf', 'application/x-font-ttf', ''),
('ttc', 'application/x-font-ttf', ''),
('pfa', 'application/x-font-type1', ''),
('pfb', 'application/x-font-type1', ''),
('pfm', 'application/x-font-type1', ''),
('afm', 'application/x-font-type1', ''),
('woff', 'application/x-font-woff', ''),
('spl', 'application/x-futuresplash', ''),
('gnumeric', 'application/x-gnumeric', ''),
('gtar', 'application/x-gtar', ''),
('hdf', 'application/x-hdf', ''),
('jnlp', 'application/x-java-jnlp-file', ''),
('latex', 'application/x-latex', ''),
('prc', 'application/x-mobipocket-ebook', ''),
('mobi', 'application/x-mobipocket-ebook', ''),
('application', 'application/x-ms-application', ''),
('wmd', 'application/x-ms-wmd', ''),
('wmz', 'application/x-ms-wmz', ''),
('xbap', 'application/x-ms-xbap', ''),
('mdb', 'application/x-msaccess', ''),
('obd', 'application/x-msbinder', ''),
('crd', 'application/x-mscardfile', ''),
('clp', 'application/x-msclip', ''),
('exe', 'application/x-msdownload', ''),
('dll', 'application/x-msdownload', ''),
('com', 'application/x-msdownload', ''),
('bat', 'application/x-msdownload', ''),
('msi', 'application/x-msdownload', ''),
('mvb', 'application/x-msmediaview', ''),
('m13', 'application/x-msmediaview', ''),
('m14', 'application/x-msmediaview', ''),
('wmf', 'application/x-msmetafile', ''),
('mny', 'application/x-msmoney', ''),
('pub', 'application/x-mspublisher', ''),
('scd', 'application/x-msschedule', ''),
('trm', 'application/x-msterminal', ''),
('wri', 'application/x-mswrite', ''),
('nc', 'application/x-netcdf', ''),
('cdf', 'application/x-netcdf', ''),
('p12', 'application/x-pkcs12', ''),
('pfx', 'application/x-pkcs12', ''),
('p7b', 'application/x-pkcs7-certificates', ''),
('spc', 'application/x-pkcs7-certificates', ''),
('p7r', 'application/x-pkcs7-certreqresp', ''),
('rar', 'application/x-rar-compressed', 'mime-type-archive.png'),
('sh', 'application/x-sh', ''),
('shar', 'application/x-shar', ''),
('swf', 'application/x-shockwave-flash', ''),
('xap', 'application/x-silverlight-app', ''),
('sit', 'application/x-stuffit', ''),
('sitx', 'application/x-stuffitx', ''),
('sv4cpio', 'application/x-sv4cpio', ''),
('sv4crc', 'application/x-sv4crc', ''),
('tar', 'application/x-tar', 'mime-type-archive.png'),
('tcl', 'application/x-tcl', ''),
('tex', 'application/x-tex', ''),
('tfm', 'application/x-tex-tfm', ''),
('texinfo', 'application/x-texinfo', ''),
('texi', 'application/x-texinfo', ''),
('ustar', 'application/x-ustar', ''),
('src', 'application/x-wais-source', ''),
('der', 'application/x-x509-ca-cert', ''),
('crt', 'application/x-x509-ca-cert', ''),
('fig', 'application/x-xfig', ''),
('xpi', 'application/x-xpinstall', ''),
('xdf', 'application/xcap-diff+xml', ''),
('xenc', 'application/xenc+xml', ''),
('xhtml', 'application/xhtml+xml', ''),
('xht', 'application/xhtml+xml', ''),
('xml', 'application/xml', ''),
('xsl', 'application/xml', ''),
('dtd', 'application/xml-dtd', ''),
('xop', 'application/xop+xml', ''),
('xslt', 'application/xslt+xml', ''),
('xspf', 'application/xspf+xml', ''),
('mxml', 'application/xv+xml', ''),
('xhvml', 'application/xv+xml', ''),
('xvml', 'application/xv+xml', ''),
('xvm', 'application/xv+xml', ''),
('yang', 'application/yang', ''),
('yin', 'application/yin+xml', ''),
('zip', 'application/zip', 'mime-type-archive.png'),
('adp', 'audio/adpcm', 'mime-type-audio.png'),
('au', 'audio/basic', 'mime-type-audio.png'),
('snd', 'audio/basic', 'mime-type-audio.png'),
('mid', 'audio/midi', 'mime-type-audio.png'),
('midi', 'audio/midi', 'mime-type-audio.png'),
('kar', 'audio/midi', 'mime-type-audio.png'),
('rmi', 'audio/midi', 'mime-type-audio.png'),
('mp4a', 'audio/mp4', 'mime-type-audio.png'),
('m4a', 'audio/mp4a-latm', 'mime-type-audio.png'),
('m4p', 'audio/mp4a-latm', 'mime-type-audio.png'),
('mpga', 'audio/mpeg', 'mime-type-audio.png'),
('mp2', 'audio/mpeg', 'mime-type-audio.png'),
('mp2a', 'audio/mpeg', 'mime-type-audio.png'),
('mp3', 'audio/mpeg', 'mime-type-audio.png'),
('m2a', 'audio/mpeg', 'mime-type-audio.png'),
('m3a', 'audio/mpeg', 'mime-type-audio.png'),
('oga', 'audio/ogg', 'mime-type-audio.png'),
('ogg', 'audio/ogg', 'mime-type-audio.png'),
('spx', 'audio/ogg', 'mime-type-audio.png'),
('uva', 'audio/vnd.dece.audio', 'mime-type-audio.png'),
('uvva', 'audio/vnd.dece.audio', 'mime-type-audio.png'),
('eol', 'audio/vnd.digital-winds', 'mime-type-audio.png'),
('dra', 'audio/vnd.dra', 'mime-type-audio.png'),
('dts', 'audio/vnd.dts', 'mime-type-audio.png'),
('dtshd', 'audio/vnd.dts.hd', 'mime-type-audio.png'),
('lvp', 'audio/vnd.lucent.voice', 'mime-type-audio.png'),
('pya', 'audio/vnd.ms-playready.media.pya', 'mime-type-audio.png'),
('ecelp4800', 'audio/vnd.nuera.ecelp4800', 'mime-type-audio.png'),
('ecelp7470', 'audio/vnd.nuera.ecelp7470', 'mime-type-audio.png'),
('ecelp9600', 'audio/vnd.nuera.ecelp9600', 'mime-type-audio.png'),
('rip', 'audio/vnd.rip', 'mime-type-audio.png'),
('weba', 'audio/webm', 'mime-type-audio.png'),
('aac', 'audio/x-aac', 'mime-type-audio.png'),
('aif', 'audio/x-aiff', 'mime-type-audio.png'),
('aiff', 'audio/x-aiff', 'mime-type-audio.png'),
('aifc', 'audio/x-aiff', 'mime-type-audio.png'),
('m3u', 'audio/x-mpegurl', 'mime-type-audio.png'),
('wax', 'audio/x-ms-wax', 'mime-type-audio.png'),
('wma', 'audio/x-ms-wma', 'mime-type-audio.png'),
('ram', 'audio/x-pn-realaudio', 'mime-type-audio.png'),
('ra', 'audio/x-pn-realaudio', 'mime-type-audio.png'),
('rmp', 'audio/x-pn-realaudio-plugin', 'mime-type-audio.png'),
('wav', 'audio/x-wav', 'mime-type-audio.png'),
('cdx', 'chemical/x-cdx', 'mime-type-vector.png'),
('cif', 'chemical/x-cif', ''),
('cmdf', 'chemical/x-cmdf', ''),
('cml', 'chemical/x-cml', ''),
('csml', 'chemical/x-csml', ''),
('xyz', 'chemical/x-xyz', ''),
('bmp', 'image/bmp', 'mime-type-image.png'),
('cgm', 'image/cgm', 'mime-type-image.png'),
('g3', 'image/g3fax', 'mime-type-image.png'),
('gif', 'image/gif', 'mime-type-image.png'),
('ief', 'image/ief', 'mime-type-image.png'),
('jp2', 'image/jp2', 'mime-type-image.png'),
('jpeg', 'image/jpeg', 'mime-type-image.png'),
('jpg', 'image/jpeg', 'mime-type-image.png'),
('jpe', 'image/jpeg', 'mime-type-image.png'),
('ktx', 'image/ktx', 'mime-type-image.png'),
('pict', 'image/pict', 'mime-type-image.png'),
('pic', 'image/pict', 'mime-type-image.png'),
('pct', 'image/pict', 'mime-type-image.png'),
('png', 'image/png', 'mime-type-png.png'),
('btif', 'image/prs.btif', 'mime-type-image.png'),
('svg', 'image/svg+xml', 'mime-type-image.png'),
('svgz', 'image/svg+xml', 'mime-type-image.png'),
('tiff', 'image/tiff', 'mime-type-image.png'),
('tif', 'image/tiff', 'mime-type-image.png'),
('psd', 'image/vnd.adobe.photoshop', 'mime-type-psd.png'),
('uvi', 'image/vnd.dece.graphic', 'mime-type-image.png'),
('uvvi', 'image/vnd.dece.graphic', 'mime-type-image.png'),
('uvg', 'image/vnd.dece.graphic', 'mime-type-image.png'),
('uvvg', 'image/vnd.dece.graphic', 'mime-type-image.png'),
('sub', 'image/vnd.dvb.subtitle', 'mime-type-image.png'),
('djvu', 'image/vnd.djvu', 'mime-type-image.png'),
('djv', 'image/vnd.djvu', 'mime-type-image.png'),
('dwg', 'image/vnd.dwg', 'mime-type-image.png'),
('dxf', 'image/vnd.dxf', 'mime-type-image.png'),
('fbs', 'image/vnd.fastbidsheet', 'mime-type-image.png'),
('fpx', 'image/vnd.fpx', 'mime-type-image.png'),
('fst', 'image/vnd.fst', 'mime-type-image.png'),
('mmr', 'image/vnd.fujixerox.edmics-mmr', 'mime-type-image.png'),
('rlc', 'image/vnd.fujixerox.edmics-rlc', 'mime-type-image.png'),
('mdi', 'image/vnd.ms-modi', 'mime-type-image.png'),
('npx', 'image/vnd.net-fpx', 'mime-type-image.png'),
('wbmp', 'image/vnd.wap.wbmp', 'mime-type-image.png'),
('xif', 'image/vnd.xiff', 'mime-type-image.png'),
('webp', 'image/webp', 'mime-type-image.png'),
('ras', 'image/x-cmu-raster', 'mime-type-image.png'),
('cmx', 'image/x-cmx', 'mime-type-image.png'),
('fh', 'image/x-freehand', 'mime-type-image.png'),
('fhc', 'image/x-freehand', 'mime-type-image.png'),
('fh4', 'image/x-freehand', 'mime-type-image.png'),
('fh5', 'image/x-freehand', 'mime-type-image.png'),
('fh7', 'image/x-freehand', 'mime-type-image.png'),
('ico', 'image/x-icon', 'mime-type-image.png'),
('pntg', 'image/x-macpaint', 'mime-type-image.png'),
('pnt', 'image/x-macpaint', 'mime-type-image.png'),
('mac', 'image/x-macpaint', 'mime-type-image.png'),
('pcx', 'image/x-pcx', 'mime-type-image.png'),
('pnm', 'image/x-portable-anymap', 'mime-type-image.png'),
('pbm', 'image/x-portable-bitmap', 'mime-type-image.png'),
('pgm', 'image/x-portable-graymap', 'mime-type-image.png'),
('ppm', 'image/x-portable-pixmap', 'mime-type-image.png'),
('qtif', 'image/x-quicktime', 'mime-type-image.png'),
('qti', 'image/x-quicktime', 'mime-type-image.png'),
('rgb', 'image/x-rgb', 'mime-type-image.png'),
('xbm', 'image/x-xbitmap', 'mime-type-image.png'),
('xpm', 'image/x-xpixmap', 'mime-type-image.png'),
('xwd', 'image/x-xwindowdump', 'mime-type-image.png'),
('eml', 'message/rfc822', ''),
('mime', 'message/rfc822', ''),
('igs', 'model/iges', ''),
('iges', 'model/iges', ''),
('msh', 'model/mesh', ''),
('mesh', 'model/mesh', ''),
('silo', 'model/mesh', ''),
('dae', 'model/vnd.collada+xml', ''),
('dwf', 'model/vnd.dwf', ''),
('gdl', 'model/vnd.gdl', ''),
('gtw', 'model/vnd.gtw', ''),
('mts', 'model/vnd.mts', ''),
('vtu', 'model/vnd.vtu', ''),
('wrl', 'model/vrml', ''),
('vrml', 'model/vrml', ''),
('manifest', 'text/cache-manifest', ''),
('ics', 'text/calendar', ''),
('ifb', 'text/calendar', ''),
('css', 'text/css', ''),
('csv', 'text/csv', 'mime-type-spreadsheet.png'),
('html', 'text/html', ''),
('htm', 'text/html', ''),
('n3', 'text/n3', ''),
('txt', 'text/plain', 'mime-type-document.png'),
('text', 'text/plain', ''),
('conf', 'text/plain', ''),
('def', 'text/plain', ''),
('list', 'text/plain', ''),
('log', 'text/plain', ''),
('in', 'text/plain', ''),
('dsc', 'text/prs.lines.tag', ''),
('rtx', 'text/richtext', ''),
('sgml', 'text/sgml', ''),
('sgm', 'text/sgml', ''),
('tsv', 'text/tab-separated-values', ''),
('t', 'text/troff', ''),
('tr', 'text/troff', ''),
('roff', 'text/troff', ''),
('man', 'text/troff', ''),
('me', 'text/troff', ''),
('ms', 'text/troff', ''),
('ttl', 'text/turtle', ''),
('uri', 'text/uri-list', ''),
('uris', 'text/uri-list', ''),
('urls', 'text/uri-list', ''),
('curl', 'text/vnd.curl', ''),
('dcurl', 'text/vnd.curl.dcurl', ''),
('scurl', 'text/vnd.curl.scurl', ''),
('mcurl', 'text/vnd.curl.mcurl', ''),
('fly', 'text/vnd.fly', ''),
('flx', 'text/vnd.fmi.flexstor', ''),
('gv', 'text/vnd.graphviz', ''),
('3dml', 'text/vnd.in3d.3dml', ''),
('spot', 'text/vnd.in3d.spot', ''),
('jad', 'text/vnd.sun.j2me.app-descriptor', ''),
('wml', 'text/vnd.wap.wml', ''),
('wmls', 'text/vnd.wap.wmlscript', ''),
('s', 'text/x-asm', ''),
('asm', 'text/x-asm', ''),
('c', 'text/x-c', ''),
('cc', 'text/x-c', ''),
('cxx', 'text/x-c', ''),
('cpp', 'text/x-c', ''),
('h', 'text/x-c', ''),
('hh', 'text/x-c', ''),
('dic', 'text/x-c', ''),
('f', 'text/x-fortran', ''),
('for', 'text/x-fortran', ''),
('f77', 'text/x-fortran', ''),
('f90', 'text/x-fortran', ''),
('p', 'text/x-pascal', ''),
('pas', 'text/x-pascal', ''),
('java', 'text/x-java-source', ''),
('etx', 'text/x-setext', ''),
('uu', 'text/x-uuencode', ''),
('vcs', 'text/x-vcalendar', ''),
('vcf', 'text/x-vcard', ''),
('3gp', 'video/3gpp', 'mime-type-video.png'),
('3g2', 'video/3gpp2', 'mime-type-video.png'),
('h261', 'video/h261', 'mime-type-video.png'),
('h263', 'video/h263', 'mime-type-video.png'),
('h264', 'video/h264', 'mime-type-video.png'),
('jpgv', 'video/jpeg', 'mime-type-video.png'),
('jpm', 'video/jpm', 'mime-type-video.png'),
('jpgm', 'video/jpm', 'mime-type-video.png'),
('mj2', 'video/mj2', 'mime-type-video.png'),
('mjp2', 'video/mj2', 'mime-type-video.png'),
('ts', 'video/mp2t', 'mime-type-video.png'),
('mp4', 'video/mp4', 'mime-type-video.png'),
('mp4v', 'video/mp4', 'mime-type-video.png'),
('mpg4', 'video/mp4', 'mime-type-video.png'),
('m4v', 'video/mp4', 'mime-type-video.png'),
('mpeg', 'video/mpeg', 'mime-type-video.png'),
('mpg', 'video/mpeg', 'mime-type-video.png'),
('mpe', 'video/mpeg', 'mime-type-video.png'),
('m1v', 'video/mpeg', 'mime-type-video.png'),
('m2v', 'video/mpeg', 'mime-type-video.png'),
('ogv', 'video/ogg', 'mime-type-video.png'),
('qt', 'video/quicktime', 'mime-type-video.png'),
('mov', 'video/quicktime', 'mime-type-video.png'),
('uvh', 'video/vnd.dece.hd', 'mime-type-video.png'),
('uvvh', 'video/vnd.dece.hd', 'mime-type-video.png'),
('uvm', 'video/vnd.dece.mobile', 'mime-type-video.png'),
('uvvm', 'video/vnd.dece.mobile', 'mime-type-video.png'),
('uvp', 'video/vnd.dece.pd', 'mime-type-video.png'),
('uvvp', 'video/vnd.dece.pd', 'mime-type-video.png'),
('uvs', 'video/vnd.dece.sd', 'mime-type-video.png'),
('uvvs', 'video/vnd.dece.sd', 'mime-type-video.png'),
('uvv', 'video/vnd.dece.video', 'mime-type-video.png'),
('uvvv', 'video/vnd.dece.video', 'mime-type-video.png'),
('fvt', 'video/vnd.fvt', 'mime-type-video.png'),
('mxu', 'video/vnd.mpegurl', 'mime-type-video.png'),
('m4u', 'video/vnd.mpegurl', 'mime-type-video.png'),
('pyv', 'video/vnd.ms-playready.media.pyv', 'mime-type-video.png'),
('uvu', 'video/vnd.uvvu.mp4', 'mime-type-video.png'),
('uvvu', 'video/vnd.uvvu.mp4', 'mime-type-video.png'),
('viv', 'video/vnd.vivo', 'mime-type-video.png'),
('dv', 'video/x-dv', 'mime-type-video.png'),
('dif', 'video/x-dv', 'mime-type-video.png'),
('webm', 'video/webm', 'mime-type-video.png'),
('f4v', 'video/x-f4v', 'mime-type-video.png'),
('fli', 'video/x-fli', 'mime-type-video.png'),
('flv', 'video/x-flv', 'mime-type-video.png'),
('asf', 'video/x-ms-asf', 'mime-type-video.png'),
('asx', 'video/x-ms-asf', 'mime-type-video.png'),
('wm', 'video/x-ms-wm', 'mime-type-video.png'),
('wmv', 'video/x-ms-wmv', 'mime-type-video.png'),
('wmx', 'video/x-ms-wmx', 'mime-type-video.png'),
('wvx', 'video/x-ms-wvx', 'mime-type-video.png'),
('avi', 'video/x-msvideo', 'mime-type-video.png'),
('movie', 'video/x-sgi-movie', 'mime-type-video.png'),
('ice', 'x-conference/x-cooltalk', '');


-- --------------------------------------------------------


CREATE TABLE IF NOT EXISTS `sys_objects_uploader` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object` varchar(32) NOT NULL,
  `active` tinyint(4) NOT NULL,
  `override_class_name` varchar(255) NOT NULL,
  `override_class_file` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `object` (`object`)
) ENGINE=MyISAM;

INSERT INTO `sys_objects_uploader` (`object`, `active`, `override_class_name`, `override_class_file`) VALUES
('sys_simple', 1, 'BxTemplUploaderSimple', ''),
('sys_html5', 1, 'BxTemplUploaderHTML5', ''),
('sys_cmts_simple', 1, 'BxTemplCmtsUploaderSimple', '');


-- --------------------------------------------------------


CREATE TABLE IF NOT EXISTS `sys_objects_form` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object` varchar(32) NOT NULL,
  `module` varchar(32) NOT NULL,
  `title` varchar(255) NOT NULL,
  `action` varchar(255) NOT NULL,
  `form_attrs` text NOT NULL,
  `submit_name` varchar(255) NOT NULL,
  `table` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `uri` varchar(255) NOT NULL,
  `uri_title` varchar(255) NOT NULL,
  `params` text NOT NULL,
  `deletable` tinyint(4) NOT NULL DEFAULT '1',
  `active` tinyint(4) NOT NULL DEFAULT '0',
  `override_class_name` varchar(255) NOT NULL,
  `override_class_file` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `object` (`object`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

INSERT INTO `sys_objects_form` (`object`, `module`, `title`, `action`, `form_attrs`, `submit_name`, `table`, `key`, `uri`, `uri_title`, `params`, `deletable`, `active`, `override_class_name`, `override_class_file`) VALUES
('sys_login', 'system', '_sys_form_login', 'member.php', 'a:3:{s:2:"id";s:14:"sys-form-login";s:6:"action";s:10:"member.php";s:8:"onsubmit";s:38:"validateLoginForm(this); return false;";}', 'role', '', '', '', '', '', 0, 1, 'BxTemplFormLogin', ''),
('sys_account', 'system', '_sys_form_account', '', '', 'do_submit', 'sys_accounts', 'id', '', '', 'a:1:{s:14:"checker_helper";s:26:"BxFormAccountCheckerHelper";}', 0, 1, 'BxTemplFormAccount', ''),
('sys_forgot_password', 'system', '_sys_form_forgot_password', '', '', 'do_submit', '', '', '', '', 'a:1:{s:14:"checker_helper";s:33:"BxFormForgotPasswordCheckerHelper";}', 0, 1, 'BxTemplFormForgotPassword', ''),
('sys_confirm_email', 'system', '_sys_form_confirm_email', '', '', 'do_submit', '', '', '', '', 'a:1:{s:14:"checker_helper";s:31:"BxFormConfirmEmailCheckerHelper";}', 0, 1, 'BxTemplFormConfirmEmail', ''),
('sys_unsubscribe', 'system', '_sys_form_unsubscribe', '', '', 'do_submit', 'sys_accounts', 'id', '', '', '', 0, 1, 'BxTemplFormAccount', ''),
('sys_comment', 'system', '_sys_form_comment', 'cmts.php', 'a:3:{s:2:"id";s:17:"cmt-%s-form-%s-%d";s:4:"name";s:17:"cmt-%s-form-%s-%d";s:5:"class";s:14:"cmt-post-reply";}', 'cmt_submit', '', 'cmt_id', '', '', '', 0, 1, '', '');

CREATE TABLE IF NOT EXISTS `sys_form_displays` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `display_name` varchar(32) NOT NULL,
  `module` varchar(32) NOT NULL,
  `object` varchar(32) NOT NULL,
  `title` varchar(255) NOT NULL,
  `view_mode` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `object_display_name` (`object`,`display_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

INSERT INTO `sys_form_displays` (`display_name`, `module`, `object`, `title`, `view_mode`) VALUES
('sys_login', 'system', 'sys_login', '_sys_form_display_login', 0),
('sys_account_create', 'system', 'sys_account', '_sys_form_display_account_create', 0),
('sys_account_settings_email', 'system', 'sys_account', '_sys_form_display_account_settings_email', 0),
('sys_account_settings_pwd', 'system', 'sys_account', '_sys_form_display_account_settings_password', 0),
('sys_account_settings_info', 'system', 'sys_account', '_sys_form_display_account_settings_info', 0),
('sys_account_settings_del_account', 'system', 'sys_account', '_sys_form_display_account_settings_delete', 0),
('sys_forgot_password', 'system', 'sys_forgot_password', '_sys_form_display_forgot_password', 0),
('sys_confirm_email', 'system', 'sys_confirm_email', '_sys_form_display_confirm_email', 0),
('sys_unsubscribe_updates', 'system', 'sys_unsubscribe', '_sys_form_display_unsubscribe_updates', 0),
('sys_unsubscribe_news', 'system', 'sys_unsubscribe', '_sys_form_display_unsubscribe_news', 0),
('sys_comment_post', 'system', 'sys_comment', '_sys_form_display_comment_post', 0),
('sys_comment_edit', 'system', 'sys_comment', '_sys_form_display_comment_edit', 0);


CREATE TABLE IF NOT EXISTS `sys_form_inputs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object` varchar(32) NOT NULL,
  `module` varchar(32) NOT NULL,
  `name` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  `values` text NOT NULL,
  `checked` tinyint(4) NOT NULL DEFAULT '0',
  `type` varchar(32) NOT NULL,
  `caption_system` varchar(255) NOT NULL,
  `caption` varchar(255) NOT NULL,
  `info` varchar(255) NOT NULL,
  `required` tinyint(4) NOT NULL DEFAULT '0',
  `collapsed` tinyint(4) NOT NULL DEFAULT '0',
  `html` tinyint(4) NOT NULL DEFAULT '0',
  `attrs` text NOT NULL,
  `attrs_tr` text NOT NULL,
  `attrs_wrapper` text NOT NULL,
  `checker_func` varchar(32) NOT NULL,
  `checker_params` text NOT NULL,
  `checker_error` varchar(255) NOT NULL,
  `db_pass` varchar(32) NOT NULL,
  `db_params` text NOT NULL,
  `editable` tinyint(4) NOT NULL DEFAULT '1',
  `deletable` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `display_name` (`object`,`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

INSERT INTO `sys_form_inputs` (`object`, `module`, `name`, `value`, `values`, `checked`, `type`, `caption_system`, `caption`, `info`, `required`, `collapsed`, `html`, `attrs`, `attrs_tr`, `attrs_wrapper`, `checker_func`, `checker_params`, `checker_error`, `db_pass`, `db_params`, `editable`, `deletable`) VALUES
('sys_login', 'system', 'role', '1', '', 0, 'hidden', '_sys_form_login_input_caption_system_role', '', '', 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
('sys_login', 'system', 'relocate', '', '', 0, 'hidden', '_sys_form_login_input_caption_system_relocate', '', '', 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
('sys_login', 'system', 'ID', '', '', 0, 'text', '_sys_form_login_input_caption_system_id', '_sys_form_login_input_email', '', 1, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
('sys_login', 'system', 'Password', '', '', 0, 'password', '_sys_form_login_input_caption_system_password', '_sys_form_login_input_password', '', 1, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
('sys_login', 'system', 'rememberMe', '1', '', 0, 'switcher', '_sys_form_login_input_caption_system_remember_me', '_sys_form_login_input_remember_me', '', 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
('sys_login', 'system', 'submit_block', '', 'login,submit_text', 0, 'input_set', '_sys_form_login_input_caption_system_submit_block', '', '', 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
('sys_login', 'system', 'login', '_sys_form_login_input_submit', '', 0, 'submit', '_sys_form_login_input_caption_system_submit', '', '', 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
('sys_login', 'system', 'submit_text', '', '', 0, 'custom', '_sys_form_login_input_caption_system_submit_text', '', '', 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),

('sys_account', 'system', 'email', '', '', 0, 'text', '_sys_form_login_input_caption_system_email', '_sys_form_account_input_email', '', 1, 0, 0, '', '', '', 'EmailUniq', '', '_sys_form_account_input_email_error', 'Xss', '', 0, 0),
('sys_account', 'system', 'password', '', '', 0, 'password', '_sys_form_login_input_caption_system_password', '_sys_form_account_input_password', '', 1, 0, 0, '', '', '', 'Length', 'a:2:{s:3:"min";i:6;s:3:"max";i:1024;}', '_sys_form_account_input_password_error', '', '', 0, 0),
('sys_account', 'system', 'password_confirm', '', '', 0, 'password', '_sys_form_login_input_caption_system_password_confirm', '_sys_form_account_input_password_confirm', '', 1, 0, 0, '', '', '', 'PasswordConfirm', '', '_sys_form_account_input_password_confirm_error', '', '', 0, 0),
('sys_account', 'system', 'do_submit', '_sys_form_account_input_submit', '', 0, 'submit', '_sys_form_login_input_caption_system_do_submit', '', '', 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
('sys_account', 'system', 'name', '', '', 0, 'text', '_sys_form_login_input_caption_system_name', '_sys_form_account_input_name', '', 1, 0, 0, '', '', '', 'Avail', '', '_sys_form_account_input_name_error', 'Xss', '', 0, 0),
('sys_account', 'system', 'captcha', '', '', 0, 'captcha', '_sys_form_login_input_caption_system_captcha', '_sys_form_account_input_captcha', '', 1, 0, 0, '', '', '', 'Captcha', '', '_sys_form_account_input_captcha_error', '', '', 0, 0),
('sys_account', 'system', 'password_current', '', '', 0, 'password', '_sys_form_login_input_caption_system_password_current', '_sys_form_account_input_password_current', '', 1, 0, 0, '', '', '', 'PasswordCurrent', '', '_sys_form_account_input_password_current_error', '', '', 0, 0),
('sys_account', 'system', 'delete_confirm', '1', '', 0, 'checkbox', '_sys_form_login_input_caption_system_delete_confirm', '_sys_form_account_input_delete_confirm', '_sys_form_account_input_delete_confirm_info', 1, 0, 0, '', '', '', 'Avail', '', '_sys_form_account_input_delete_confirm_error', '', '', 0, 0),
('sys_account', 'system', 'receive_updates', '1', '', 1, 'switcher', '_sys_form_login_input_caption_system_receive_updates', '_sys_form_account_input_receive_updates', '', 0, 0, 0, '', '', '', '', '', '', 'Int', '', 0, 0),
('sys_account', 'system', 'receive_news', '1', '', 0, 'switcher', '_sys_form_login_input_caption_system_receive_news', '_sys_form_account_input_receive_news', '', 0, 0, 0, '', '', '', '', '', '', 'Int', '', 0, 0),

('sys_forgot_password', 'system', 'email', '', '', 0, 'text', '_sys_form_forgot_password_input_caption_system_email', '_sys_form_forgot_password_input_email', '', 1, 0, 0, '', '', '', 'EmailExist', '', '_sys_form_account_input_email_error', 'Xss', '', 0, 0),
('sys_forgot_password', 'system', 'captcha', '', '', 0, 'captcha', '_sys_form_login_input_caption_system_captcha', '_sys_form_account_input_captcha', '', 1, 0, 0, '', '', '', 'Captcha', '', '_sys_form_account_input_captcha_error', '', '', 0, 0),
('sys_forgot_password', 'system', 'do_submit', '_sys_form_forgot_password_input_submit', '', 0, 'submit', '_sys_form_forgot_password_input_caption_system_do_submit', '', '', 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),

('sys_confirm_email', 'system', 'code', '', '', 0, 'text', '_sys_form_confirm_email_input_caption_system_code', '_sys_form_confirm_email_input_code', '', 1, 0, 0, '', '', '', 'CodeExist', '', '_sys_form_confirm_email_input_code_error', 'Xss', '', 0, 0),
('sys_confirm_email', 'system', 'do_submit', '_sys_form_confirm_email_input_submit', '', 0, 'submit', '_sys_form_confirm_email_input_caption_system_do_submit', '', '', 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),

('sys_unsubscribe', 'system', 'id', '', '', 0, 'hidden', '_sys_form_unsubscribe_input_caption_system_id', '', '', 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
('sys_unsubscribe', 'system', 'code', '', '', 0, 'hidden', '_sys_form_unsubscribe_input_caption_system_code', '', '', 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
('sys_unsubscribe', 'system', 'receive_updates', '1', '', 0, 'switcher', '_sys_form_unsubscribe_input_caption_system_receive_updates', '_sys_form_unsubscribe_input_receive_updates', '', 0, 0, 0, '', '', '', '', '', '', 'Int', '', 0, 0),
('sys_unsubscribe', 'system', 'receive_news', '1', '', 0, 'switcher', '_sys_form_unsubscribe_input_caption_system_receive_news', '_sys_form_unsubscribe_input_receive_news', '', 0, 0, 0, '', '', '', '', '', '', 'Int', '', 0, 0),
('sys_unsubscribe', 'system', 'do_submit', '_sys_form_unsubscribe_input_submit', '', 0, 'submit', '_sys_form_unsubscribe_input_caption_system_do_submit', '', '', 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),

('sys_comment', 'system', 'sys', '', '', 0, 'hidden', '_sys_form_comment_input_caption_system_sys', '', '', 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
('sys_comment', 'system', 'id', '', '', 0, 'hidden', '_sys_form_comment_input_caption_system_id', '', '', 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
('sys_comment', 'system', 'action', '', '', 0, 'hidden', '_sys_form_comment_input_caption_system_action', '', '', 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
('sys_comment', 'system', 'cmt_id', '', '', 0, 'hidden', '_sys_form_comment_input_caption_system_cmt_id', '', '', 0, 0, 0, '', '', '', '', '', '', 'Int', '', 0, 0),
('sys_comment', 'system', 'cmt_parent_id', '', '', 0, 'hidden', '_sys_form_comment_input_caption_system_cmt_parent_id', '', '', 0, 0, 0, '', '', '', '', '', '', 'Int', '', 0, 0),
('sys_comment', 'system', 'cmt_text', '', '', 0, 'textarea', '_sys_form_comment_input_caption_system_cmt_text', '', '', 0, 0, 0, '', '', '', 'Length', 'a:2:{s:3:"min";i:1;s:3:"max";i:5000;}', '_Please enter n1-n2 characters', 'Xss', '', 1, 0),
('sys_comment', 'system', 'cmt_image', '', '', 0, 'files', '_sys_form_comment_input_caption_system_cmt_image', '', '', 0, 0, 0, '', '', '', '', '', '', '', '', 1, 0),
('sys_comment', 'system', 'cmt_submit', '_sys_form_comment_input_submit', '', 0, 'submit', '_sys_form_comment_input_caption_system_cmt_submit', '', '', 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0);


CREATE TABLE IF NOT EXISTS `sys_form_display_inputs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `display_name` varchar(32) NOT NULL,
  `input_name` varchar(32) NOT NULL,
  `visible_for_levels` int(11) NOT NULL DEFAULT '2147483647',
  `active` tinyint(4) NOT NULL DEFAULT '0',
  `order` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `display_input` (`display_name`,`input_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

INSERT INTO `sys_form_display_inputs` (`display_name`, `input_name`, `visible_for_levels`, `active`, `order`) VALUES

('sys_login', 'role', 2147483647, 1, 1),
('sys_login', 'relocate', 2147483647, 1, 2),
('sys_login', 'ID', 2147483647, 1, 3),
('sys_login', 'Password', 2147483647, 1, 4),
('sys_login', 'rememberMe', 2147483647, 1, 5),
('sys_login', 'submit_block', 2147483647, 1, 6),
('sys_login', 'login', 2147483647, 1, 7),
('sys_login', 'submit_text', 2147483647, 1, 8),

('sys_account_create', 'name', 2147483647, 1, 1),
('sys_account_create', 'email', 2147483647, 1, 2),
('sys_account_create', 'receive_news', 2147483647, 1, 3),
('sys_account_create', 'password', 2147483647, 1, 4),
('sys_account_create', 'password_confirm', 2147483647, 1, 5),
('sys_account_create', 'captcha', 2147483647, 1, 6),
('sys_account_create', 'do_submit', 2147483647, 1, 7),

('sys_account_settings_email', 'email', 2147483647, 1, 1),
('sys_account_settings_email', 'password_current', 2147483647, 1, 2),
('sys_account_settings_email', 'receive_updates', 2147483647, 1, 3),
('sys_account_settings_email', 'receive_news', 2147483647, 1, 4),
('sys_account_settings_email', 'do_submit', 2147483647, 1, 5),

('sys_account_settings_pwd', 'password_current', 2147483647, 1, 1),
('sys_account_settings_pwd', 'password', 2147483647, 1, 2),
('sys_account_settings_pwd', 'password_confirm', 2147483647, 1, 3),
('sys_account_settings_pwd', 'do_submit', 2147483647, 1, 4),

('sys_account_settings_del_account', 'delete_confirm', 2147483647, 1, 1),
('sys_account_settings_del_account', 'password_current', 2147483647, 1, 2),
('sys_account_settings_del_account', 'do_submit', 2147483647, 1, 3),

('sys_account_settings_info', 'name', 2147483647, 1, 1),
('sys_account_settings_info', 'do_submit', 2147483647, 1, 2),

('sys_forgot_password', 'email', 2147483647, 1, 1),
('sys_forgot_password', 'captcha', 2147483647, 1, 2),
('sys_forgot_password', 'do_submit', 2147483647, 1, 3),

('sys_confirm_email', 'code', 2147483647, 1, 1),
('sys_confirm_email', 'do_submit', 2147483647, 1, 2),

('sys_unsubscribe_updates', 'id', 2147483647, 1, 1),
('sys_unsubscribe_updates', 'code', 2147483647, 1, 2),
('sys_unsubscribe_updates', 'receive_updates', 2147483647, 1, 3),
('sys_unsubscribe_updates', 'do_submit', 2147483647, 1, 4),

('sys_unsubscribe_news', 'id', 2147483647, 1, 1),
('sys_unsubscribe_news', 'code', 2147483647, 1, 2),
('sys_unsubscribe_news', 'receive_news', 2147483647, 1, 3),
('sys_unsubscribe_news', 'do_submit', 2147483647, 1, 4),

('sys_comment_post', 'sys', 2147483647, 1, 1),
('sys_comment_post', 'id', 2147483647, 1, 2),
('sys_comment_post', 'action', 2147483647, 1, 3),
('sys_comment_post', 'cmt_id', 2147483647, 0, 4),
('sys_comment_post', 'cmt_parent_id', 2147483647, 1, 5),
('sys_comment_post', 'cmt_text', 2147483647, 1, 6),
('sys_comment_post', 'cmt_image', 2147483647, 1, 7),
('sys_comment_post', 'cmt_submit', 2147483647, 1, 8),

('sys_comment_edit', 'sys', 2147483647, 1, 1),
('sys_comment_edit', 'id', 2147483647, 1, 2),
('sys_comment_edit', 'action', 2147483647, 1, 3),
('sys_comment_edit', 'cmt_id', 2147483647, 1, 4),
('sys_comment_edit', 'cmt_parent_id', 2147483647, 1, 5),
('sys_comment_edit', 'cmt_text', 2147483647, 1, 6),
('sys_comment_edit', 'cmt_image', 2147483647, 0, 7),
('sys_comment_edit', 'cmt_submit', 2147483647, 1, 8);


CREATE TABLE `sys_form_pre_lists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module` varchar(32) NOT NULL default '',
  `key` varchar(255) NOT NULL default '',
  `title` varchar(255) NOT NULL default '',
  `use_for_sets` tinyint(4) unsigned NOT NULL default '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`),
  FULLTEXT KEY `ModuleAndKey` (`module`, `key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `sys_form_pre_lists`(`key`, `title`, `module`, `use_for_sets`) VALUES
('Country', '_adm_form_txt_pre_lists_country', 'system', '0'),
('Sex', '_adm_form_txt_pre_lists_sex', 'system', '1'),
('Language', '_adm_form_txt_pre_lists_language', 'system', '0');


CREATE TABLE `sys_form_pre_values` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Key` varchar(255) NOT NULL default '',
  `Value` varchar(255) NOT NULL default '',
  `Order` int(10) unsigned NOT NULL default '0',
  `LKey` varchar(255) NOT NULL default '',
  `LKey2` varchar(255) NOT NULL default '',
  PRIMARY KEY (`id`),
  FULLTEXT KEY `KeyAndValue` (`Key`, `Value`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `sys_form_pre_values`(`Key`, `Value`, `Order`, `LKey`, `LKey2`) VALUES 
('Country', 'AF', 1, '__Afghanistan', ''),
('Country', 'AX', 2, '__Aland_Islands', ''),
('Country', 'AL', 3, '__Albania', ''),
('Country', 'DZ', 4, '__Algeria', ''),
('Country', 'AS', 5, '__American Samoa', ''),
('Country', 'AD', 6, '__Andorra', ''),
('Country', 'AO', 7, '__Angola', ''),
('Country', 'AI', 8, '__Anguilla', ''),
('Country', 'AQ', 9, '__Antarctica', ''),
('Country', 'AG', 10, '__Antigua and Barbuda', ''),
('Country', 'AR', 11, '__Argentina', ''),
('Country', 'AM', 12, '__Armenia', ''),
('Country', 'AW', 13, '__Aruba', ''),
('Country', 'AU', 14, '__Australia', ''),
('Country', 'AT', 15, '__Austria', ''),
('Country', 'AZ', 16, '__Azerbaijan', ''),
('Country', 'BH', 17, '__Bahrain', ''),
('Country', 'BD', 18, '__Bangladesh', ''),
('Country', 'BB', 19, '__Barbados', ''),
('Country', 'BY', 20, '__Belarus', ''),
('Country', 'BE', 21, '__Belgium', ''),
('Country', 'BZ', 22, '__Belize', ''),
('Country', 'BJ', 23, '__Benin', ''),
('Country', 'BM', 24, '__Bermuda', ''),
('Country', 'BT', 25, '__Bhutan', ''),
('Country', 'BO', 26, '__Bolivia', ''),
('Country', 'BA', 27, '__Bosnia and Herzegovina', ''),
('Country', 'BW', 28, '__Botswana', ''),
('Country', 'BV', 29, '__Bouvet Island', ''),
('Country', 'BR', 30, '__Brazil', ''),
('Country', 'IO', 31, '__British Indian Ocean Territory', ''),
('Country', 'VG', 32, '__British Virgin Islands', ''),
('Country', 'BN', 33, '__Brunei Darussalam', ''),
('Country', 'BG', 34, '__Bulgaria', ''),
('Country', 'BF', 35, '__Burkina Faso', ''),
('Country', 'MM', 36, '__Burma', ''),
('Country', 'BI', 37, '__Burundi', ''),
('Country', 'KH', 38, '__Cambodia', ''),
('Country', 'CM', 39, '__Cameroon', ''),
('Country', 'CA', 40, '__Canada', ''),
('Country', 'CV', 41, '__Cape Verde', ''),
('Country', 'KY', 42, '__Cayman Islands', ''),
('Country', 'CF', 43, '__Central African Republic', ''),
('Country', 'TD', 44, '__Chad', ''),
('Country', 'CL', 45, '__Chile', ''),
('Country', 'CN', 46, '__China', ''),
('Country', 'CX', 47, '__Christmas Island', ''),
('Country', 'CC', 48, '__Cocos (Keeling) Islands', ''),
('Country', 'CO', 49, '__Colombia', ''),
('Country', 'KM', 50, '__Comoros', ''),
('Country', 'CD', 51, '__Congo, Democratic Republic of the', ''),
('Country', 'CG', 52, '__Congo, Republic of the', ''),
('Country', 'CK', 53, '__Cook Islands', ''),
('Country', 'CR', 54, '__Costa Rica', ''),
('Country', 'CI', 55, '__Cote d''Ivoire', ''),
('Country', 'HR', 56, '__Croatia', ''),
('Country', 'CU', 57, '__Cuba', ''),
('Country', 'CY', 58, '__Cyprus', ''),
('Country', 'CZ', 59, '__Czech Republic', ''),
('Country', 'DK', 60, '__Denmark', ''),
('Country', 'DJ', 61, '__Djibouti', ''),
('Country', 'DM', 62, '__Dominica', ''),
('Country', 'DO', 63, '__Dominican Republic', ''),
('Country', 'TL', 64, '__East Timor', ''),
('Country', 'EC', 65, '__Ecuador', ''),
('Country', 'EG', 66, '__Egypt', ''),
('Country', 'SV', 67, '__El Salvador', ''),
('Country', 'GQ', 68, '__Equatorial Guinea', ''),
('Country', 'ER', 69, '__Eritrea', ''),
('Country', 'EE', 70, '__Estonia', ''),
('Country', 'ET', 71, '__Ethiopia', ''),
('Country', 'FK', 72, '__Falkland Islands (Islas Malvinas)', ''),
('Country', 'FO', 73, '__Faroe Islands', ''),
('Country', 'FJ', 74, '__Fiji', ''),
('Country', 'FI', 75, '__Finland', ''),
('Country', 'FR', 76, '__France', ''),
('Country', 'GF', 77, '__French Guiana', ''),
('Country', 'PF', 78, '__French Polynesia', ''),
('Country', 'TF', 79, '__French Southern and Antarctic Lands', ''),
('Country', 'GA', 80, '__Gabon', ''),
('Country', 'GE', 81, '__Georgia', ''),
('Country', 'DE', 82, '__Germany', ''),
('Country', 'GH', 83, '__Ghana', ''),
('Country', 'GI', 84, '__Gibraltar', ''),
('Country', 'GR', 85, '__Greece', ''),
('Country', 'GL', 86, '__Greenland', ''),
('Country', 'GD', 87, '__Grenada', ''),
('Country', 'GP', 88, '__Guadeloupe', ''),
('Country', 'GU', 89, '__Guam', ''),
('Country', 'GT', 90, '__Guatemala', ''),
('Country', 'GG', 91, '__Guernsey', ''),
('Country', 'GN', 92, '__Guinea', ''),
('Country', 'GW', 93, '__Guinea-Bissau', ''),
('Country', 'GY', 94, '__Guyana', ''),
('Country', 'HT', 95, '__Haiti', ''),
('Country', 'HM', 96, '__Heard Island and McDonald Islands', ''),
('Country', 'VA', 97, '__Holy See (Vatican City)', ''),
('Country', 'HN', 98, '__Honduras', ''),
('Country', 'HK', 99, '__Hong Kong (SAR)', ''),
('Country', 'HU', 100, '__Hungary', ''),
('Country', 'IS', 101, '__Iceland', ''),
('Country', 'IN', 102, '__India', ''),
('Country', 'ID', 103, '__Indonesia', ''),
('Country', 'IR', 104, '__Iran', ''),
('Country', 'IQ', 105, '__Iraq', ''),
('Country', 'IE', 106, '__Ireland', ''),
('Country', 'IM', 107, '__Isle_of_Man', ''),
('Country', 'IL', 108, '__Israel', ''),
('Country', 'IT', 109, '__Italy', ''),
('Country', 'JM', 110, '__Jamaica', ''),
('Country', 'JP', 111, '__Japan', ''),
('Country', 'JE', 112, '__Jersey', ''),
('Country', 'JO', 113, '__Jordan', ''),
('Country', 'KZ', 114, '__Kazakhstan', ''),
('Country', 'KE', 115, '__Kenya', ''),
('Country', 'KI', 116, '__Kiribati', ''),
('Country', 'KP', 117, '__Korea, North', ''),
('Country', 'KR', 118, '__Korea, South', ''),
('Country', 'KW', 119, '__Kuwait', ''),
('Country', 'KG', 120, '__Kyrgyzstan', ''),
('Country', 'LA', 121, '__Laos', ''),
('Country', 'LV', 122, '__Latvia', ''),
('Country', 'LB', 123, '__Lebanon', ''),
('Country', 'LS', 124, '__Lesotho', ''),
('Country', 'LR', 125, '__Liberia', ''),
('Country', 'LY', 126, '__Libya', ''),
('Country', 'LI', 127, '__Liechtenstein', ''),
('Country', 'LT', 128, '__Lithuania', ''),
('Country', 'LU', 129, '__Luxembourg', ''),
('Country', 'MO', 130, '__Macao', ''),
('Country', 'MK', 131, '__Macedonia, The Former Yugoslav Republic of', ''),
('Country', 'MG', 132, '__Madagascar', ''),
('Country', 'MW', 133, '__Malawi', ''),
('Country', 'MY', 134, '__Malaysia', ''),
('Country', 'MV', 135, '__Maldives', ''),
('Country', 'ML', 136, '__Mali', ''),
('Country', 'MT', 137, '__Malta', ''),
('Country', 'MH', 138, '__Marshall Islands', ''),
('Country', 'MQ', 139, '__Martinique', ''),
('Country', 'MR', 140, '__Mauritania', ''),
('Country', 'MU', 141, '__Mauritius', ''),
('Country', 'YT', 142, '__Mayotte', ''),
('Country', 'MX', 143, '__Mexico', ''),
('Country', 'FM', 144, '__Micronesia, Federated States of', ''),
('Country', 'MD', 145, '__Moldova', ''),
('Country', 'MC', 146, '__Monaco', ''),
('Country', 'MN', 147, '__Mongolia', ''),
('Country', 'ME', 148, '__Montenegro', ''),
('Country', 'MS', 149, '__Montserrat', ''),
('Country', 'MA', 150, '__Morocco', ''),
('Country', 'MZ', 151, '__Mozambique', ''),
('Country', 'NA', 152, '__Namibia', ''),
('Country', 'NR', 153, '__Nauru', ''),
('Country', 'NP', 154, '__Nepal', ''),
('Country', 'NL', 155, '__Netherlands', ''),
('Country', 'AN', 156, '__Netherlands Antilles', ''),
('Country', 'NC', 157, '__New Caledonia', ''),
('Country', 'NZ', 158, '__New Zealand', ''),
('Country', 'NI', 159, '__Nicaragua', ''),
('Country', 'NE', 160, '__Niger', ''),
('Country', 'NG', 161, '__Nigeria', ''),
('Country', 'NU', 162, '__Niue', ''),
('Country', 'NF', 163, '__Norfolk Island', ''),
('Country', 'MP', 164, '__Northern Mariana Islands', ''),
('Country', 'NO', 165, '__Norway', ''),
('Country', 'OM', 166, '__Oman', ''),
('Country', 'PK', 167, '__Pakistan', ''),
('Country', 'PW', 168, '__Palau', ''),
('Country', 'PS', 169, '__Palestinian Territory, Occupied', ''),
('Country', 'PA', 170, '__Panama', ''),
('Country', 'PG', 171, '__Papua New Guinea', ''),
('Country', 'PY', 172, '__Paraguay', ''),
('Country', 'PE', 173, '__Peru', ''),
('Country', 'PH', 174, '__Philippines', ''),
('Country', 'PN', 175, '__Pitcairn Islands', ''),
('Country', 'PL', 176, '__Poland', ''),
('Country', 'PT', 177, '__Portugal', ''),
('Country', 'PR', 178, '__Puerto Rico', ''),
('Country', 'QA', 179, '__Qatar', ''),
('Country', 'RE', 180, '__Reunion', ''),
('Country', 'RO', 181, '__Romania', ''),
('Country', 'RU', 182, '__Russia', ''),
('Country', 'RW', 183, '__Rwanda', ''),
('Country', 'SH', 184, '__Saint Helena', ''),
('Country', 'KN', 185, '__Saint Kitts and Nevis', ''),
('Country', 'LC', 186, '__Saint Lucia', ''),
('Country', 'PM', 187, '__Saint Pierre and Miquelon', ''),
('Country', 'VC', 188, '__Saint Vincent and the Grenadines', ''),
('Country', 'BL', 189, '__Saint_Barthelemy', ''),
('Country', 'MF', 190, '__Saint_Martin_French_part', ''),
('Country', 'WS', 191, '__Samoa', ''),
('Country', 'SM', 192, '__San Marino', ''),
('Country', 'ST', 193, '__Sao Tome and Principe', ''),
('Country', 'SA', 194, '__Saudi Arabia', ''),
('Country', 'SN', 195, '__Senegal', ''),
('Country', 'RS', 196, '__Serbia', ''),
('Country', 'SC', 197, '__Seychelles', ''),
('Country', 'SL', 198, '__Sierra Leone', ''),
('Country', 'SG', 199, '__Singapore', ''),
('Country', 'SK', 200, '__Slovakia', ''),
('Country', 'SI', 201, '__Slovenia', ''),
('Country', 'SB', 202, '__Solomon Islands', ''),
('Country', 'SO', 203, '__Somalia', ''),
('Country', 'ZA', 204, '__South Africa', ''),
('Country', 'GS', 205, '__South Georgia and the South Sandwich Islands', ''),
('Country', 'ES', 206, '__Spain', ''),
('Country', 'LK', 207, '__Sri Lanka', ''),
('Country', 'SD', 208, '__Sudan', ''),
('Country', 'SR', 209, '__Suriname', ''),
('Country', 'SJ', 210, '__Svalbard', ''),
('Country', 'SZ', 211, '__Swaziland', ''),
('Country', 'SE', 212, '__Sweden', ''),
('Country', 'CH', 213, '__Switzerland', ''),
('Country', 'SY', 214, '__Syria', ''),
('Country', 'TW', 215, '__Taiwan', ''),
('Country', 'TJ', 216, '__Tajikistan', ''),
('Country', 'TZ', 217, '__Tanzania', ''),
('Country', 'TH', 218, '__Thailand', ''),
('Country', 'BS', 219, '__The Bahamas', ''),
('Country', 'GM', 220, '__The Gambia', ''),
('Country', 'TG', 221, '__Togo', ''),
('Country', 'TK', 222, '__Tokelau', ''),
('Country', 'TO', 223, '__Tonga', ''),
('Country', 'TT', 224, '__Trinidad and Tobago', ''),
('Country', 'TN', 225, '__Tunisia', ''),
('Country', 'TR', 226, '__Turkey', ''),
('Country', 'TM', 227, '__Turkmenistan', ''),
('Country', 'TC', 228, '__Turks and Caicos Islands', ''),
('Country', 'TV', 229, '__Tuvalu', ''),
('Country', 'UG', 230, '__Uganda', ''),
('Country', 'UA', 231, '__Ukraine', ''),
('Country', 'AE', 232, '__United Arab Emirates', ''),
('Country', 'GB', 233, '__United Kingdom', ''),
('Country', 'US', 234, '__United States', ''),
('Country', 'UM', 235, '__United States Minor Outlying Islands', ''),
('Country', 'UY', 236, '__Uruguay', ''),
('Country', 'UZ', 237, '__Uzbekistan', ''),
('Country', 'VU', 238, '__Vanuatu', ''),
('Country', 'VE', 239, '__Venezuela', ''),
('Country', 'VN', 240, '__Vietnam', ''),
('Country', 'VI', 241, '__Virgin Islands', ''),
('Country', 'WF', 242, '__Wallis and Futuna', ''),
('Country', 'EH', 243, '__Western Sahara', ''),
('Country', 'YE', 244, '__Yemen', ''),
('Country', 'ZM', 245, '__Zambia', ''),
('Country', 'ZW', 246, '__Zimbabwe', '');

INSERT INTO `sys_form_pre_values`(`Key`, `Value`, `Order`, `LKey`, `LKey2`) VALUES
('Sex', '1', 0, '_Male', '_LookinMale'),
('Sex', '2', 1, '_Female', '_LookinFemale');

INSERT INTO `sys_form_pre_values`(`Key`, `Value`, `Order`, `LKey`, `LKey2`) VALUES 
('Language', '0', 0, '__English', ''),
('Language', '1', 1, '__Afrikaans', ''),
('Language', '2', 2, '__Arabic', ''),
('Language', '3', 3, '__Bulgarian', ''),
('Language', '4', 4, '__Burmese', ''),
('Language', '5', 5, '__Cantonese', ''),
('Language', '6', 6, '__Croatian', ''),
('Language', '7', 7, '__Danish', ''),
('Language', '8', 8, '__Dutch', ''),
('Language', '9', 9, '__Esperanto', ''),
('Language', '10', 10, '__Estonian', ''),
('Language', '11', 11, '__Finnish', ''),
('Language', '12', 12, '__French', ''),
('Language', '13', 13, '__German', ''),
('Language', '14', 14, '__Greek', ''),
('Language', '15', 15, '__Gujrati', ''),
('Language', '16', 16, '__Hebrew', ''),
('Language', '17', 17, '__Hindi', ''),
('Language', '18', 18, '__Hungarian', ''),
('Language', '19', 19, '__Icelandic', ''),
('Language', '20', 20, '__Indian', ''),
('Language', '21', 21, '__Indonesian', ''),
('Language', '22', 22, '__Italian', ''),
('Language', '23', 23, '__Japanese', ''),
('Language', '24', 24, '__Korean', ''),
('Language', '25', 25, '__Latvian', ''),
('Language', '26', 26, '__Lithuanian', ''),
('Language', '27', 27, '__Malay', ''),
('Language', '28', 28, '__Mandarin', ''),
('Language', '29', 29, '__Marathi', ''),
('Language', '30', 30, '__Moldovian', ''),
('Language', '31', 31, '__Nepalese', ''),
('Language', '32', 32, '__Norwegian', ''),
('Language', '33', 33, '__Persian', ''),
('Language', '34', 34, '__Polish', ''),
('Language', '35', 35, '__Portuguese', ''),
('Language', '36', 36, '__Punjabi', ''),
('Language', '37', 37, '__Romanian', ''),
('Language', '38', 38, '__Russian', ''),
('Language', '39', 39, '__Serbian', ''),
('Language', '40', 40, '__Spanish', ''),
('Language', '41', 41, '__Swedish', ''),
('Language', '42', 42, '__Tagalog', ''),
('Language', '43', 43, '__Taiwanese', ''),
('Language', '44', 44, '__Tamil', ''),
('Language', '45', 45, '__Telugu', ''),
('Language', '46', 46, '__Thai', ''),
('Language', '47', 47, '__Tongan', ''),
('Language', '48', 48, '__Turkish', ''),
('Language', '49', 49, '__Ukrainian', ''),
('Language', '50', 50, '__Urdu', ''),
('Language', '51', 51, '__Vietnamese', ''),
('Language', '52', 52, '__Visayan', '');

-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `sys_menu_templates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `template` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `sys_menu_templates` (`id`, `template`, `title`) VALUES
(1, 'menu_main.html', '_sys_menu_template_title_main'),
(2, 'menu_footer.html', '_sys_menu_template_title_footer'),
(3, 'menu_horizontal.html', '_sys_menu_template_title_hor'),
(4, 'menu_vertical_lite.html', '_sys_menu_template_title_ver_lite'),
(5, 'menu_toolbar.html', '_sys_menu_template_title_toolbar'),
(6, 'menu_vertical.html', '_sys_menu_template_title_ver'),
(7, 'menu_floating_blocks.html', '_sys_menu_template_title_floating_blocks'),
(8, 'menu_main_submenu.html', '_sys_menu_template_title_main_submenu'),
(9, 'menu_buttons_hor.html', '_sys_menu_template_title_buttons_hor'),
(10, 'menu_inline.html', '_sys_menu_template_title_inline'),
(11, 'menu_interactive_vertical.html', '_sys_menu_template_title_interactive_vertical');

CREATE TABLE IF NOT EXISTS `sys_objects_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object` varchar(32) NOT NULL,
  `title` varchar(255) NOT NULL,
  `set_name` varchar(32) NOT NULL,
  `module` varchar(32) NOT NULL,
  `template_id` int(11) NOT NULL,
  `deletable` tinyint(4) NOT NULL DEFAULT '1',
  `active` tinyint(4) NOT NULL DEFAULT '0',
  `override_class_name` varchar(255) NOT NULL,
  `override_class_file` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `object` (`object`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

INSERT INTO `sys_objects_menu` (`object`, `title`, `set_name`, `module`, `template_id`, `deletable`, `active`, `override_class_name`, `override_class_file`) VALUES
('sys_site', '_sys_menu_title_main', 'sys_site', 'system', 7, 0, 1, '', ''),
('sys_site_submenu', '_sys_menu_title_submenu', 'sys_site', 'system', 1, 0, 1, 'BxTemplMenuSubmenu', ''),
('sys_site_submenu_main', '_sys_menu_title_submenu_main', 'sys_site', 'system', 8, 0, 1, '', ''),
('sys_footer', '_sys_menu_title_footer', 'sys_footer', 'system', 2, 0, 1, '', ''),
('sys_toolbar_site', '_sys_menu_title_toolbar_site', 'sys_toolbar_site', 'system', 5, 0, 1, '', ''),
('sys_toolbar_member', '_sys_menu_title_toolbar_member', 'sys_toolbar_member', 'system', 5, 0, 1, 'BxTemplMenuToolbar', ''),
('sys_account', '_sys_menu_title_account', 'sys_account_links', 'system', 4, 0, 1, '', ''),
('sys_add_content', '_sys_menu_title_add_content', 'sys_add_content_links', 'system', 4, 0, 1, '', ''),
('sys_account_settings', '_sys_menu_title_account_settings', 'sys_account_settings', 'system', 6, 0, 1, '', ''),
('sys_profiles_create', '_sys_menu_title_profiles_create', 'sys_profiles_create', 'system', 4, 0, 1, '', ''),
('sys_cmts_item_manage', '_sys_menu_title_cmts_item_manage', 'sys_cmts_item_manage', 'system', 6, 0, 1, 'BxTemplCmtsMenu', ''),
('sys_cmts_item_actions', '_sys_menu_title_cmts_item_actions', 'sys_cmts_item_actions', 'system', 10, 0, 1, 'BxTemplCmtsMenu', '');

CREATE TABLE IF NOT EXISTS `sys_menu_sets` (
  `set_name` varchar(32) NOT NULL,
  `module` varchar(32) NOT NULL,
  `title` varchar(255) NOT NULL,
  `deletable` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`set_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `sys_menu_sets` (`set_name`, `module`, `title`, `deletable`) VALUES
('sys_site', 'system', '_sys_menu_set_title_site', 0),
('sys_footer', 'system', '_sys_menu_set_title_footer', 0),
('sys_toolbar_site', 'system', '_sys_menu_set_title_toolbar_site', 0),
('sys_toolbar_member', 'system', '_sys_menu_set_title_toolbar_member', 0),
('sys_account_links', 'system', '_sys_menu_set_title_account', 0),
('sys_add_content_links', 'system', '_sys_menu_set_title_add_content', 0),
('sys_account_settings', 'system', '_sys_menu_set_title_account_settings', 0),
('sys_profiles_create', 'system', '_sys_menu_set_title_profile_create_links', 0),
('sys_cmts_item_manage', 'system', '_sys_menu_set_title_cmts_item_manage', 0),
('sys_cmts_item_actions', 'system', '_sys_menu_set_title_cmts_item_actions', 0);

CREATE TABLE IF NOT EXISTS `sys_menu_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `set_name` varchar(32) NOT NULL,
  `module` varchar(32) NOT NULL,
  `name` varchar(255) NOT NULL,
  `title_system` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `link` varchar(255) NOT NULL,
  `onclick` varchar(255) NOT NULL,
  `target` varchar(255) NOT NULL,
  `icon` varchar(255) NOT NULL,
  `addon` text NOT NULL,
  `submenu_object` varchar(32) NOT NULL,
  `visible_for_levels` int(11) NOT NULL DEFAULT '2147483647',
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `copyable` tinyint(4) NOT NULL DEFAULT '1',
  `order` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

-- site menu
INSERT INTO `sys_menu_items` (`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `visible_for_levels`, `active`, `copyable`, `order`) VALUES
('sys_site', 'system', 'home', '_sys_menu_item_title_system_home', '_sys_menu_item_title_home', 'index.php', '', '', 'home col-gray-dark', '', 2147483647, 1, 1, 1),
('sys_site', 'system', 'about', '_sys_menu_item_title_system_about', '_sys_menu_item_title_about', 'page.php?i=about', '', '', 'info-circle col-blue3-dark', '', 2147483647, 1, 1, 2);

-- footer menu
INSERT INTO `sys_menu_items` (`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `visible_for_levels`, `active`, `copyable`, `order`) VALUES
('sys_footer', 'system', 'about', '_sys_menu_item_title_system_about', '_sys_menu_item_title_about', 'page.php?i=about', '', '', '', '', 2147483647, 1, 1, 1);

-- site toolbar menu
INSERT INTO `sys_menu_items` (`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `visible_for_levels`, `active`, `copyable`, `order`) VALUES
('sys_toolbar_site', 'system', 'main-menu', '_sys_menu_item_title_system_main_menu', '', 'javascript:void(0);', 'bx_menu_popup(''sys_site'', this, {pointer:{align:''left''}});', '', 'reorder', '', 2147483647, 1, 1, 1);

-- member toolbar menu
INSERT INTO `sys_menu_items` (`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `visible_for_levels`, `active`, `copyable`, `order`) VALUES
('sys_toolbar_member', 'system', 'account', '_sys_menu_item_title_system_account_menu', '_sys_menu_item_title_account_menu', 'javascript:void(0);', 'bx_menu_popup(''sys_account'', this);', '', 'user', 'sys_account', 510, 1, 0, 1),
('sys_toolbar_member', 'system', 'login', '_sys_menu_item_title_system_login', '', 'page.php?i=login', '', '', 'user', '', 1, 1, 0, 2);

-- add content menu
INSERT INTO `sys_menu_items` (`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `visible_for_levels`, `active`, `copyable`, `order`) VALUES
('sys_account_links', 'system', 'account', '_sys_menu_item_title_system_account', '_sys_menu_item_title_account', 'member.php', '', '', '', '', 2147483646, 1, 1, 1),
('sys_account_links', 'system', 'logout', '_sys_menu_item_title_system_logout', '_sys_menu_item_title_logout', 'logout.php', '', '', '', '', 2147483646, 1, 1, 3);

-- account settings menu
INSERT INTO `sys_menu_items` (`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `visible_for_levels`, `active`, `copyable`, `order`) VALUES
('sys_account_settings', 'system', 'account-settings-profile-context', '_sys_menu_item_title_system_account_profile_context', '_sys_menu_item_title_account_profile_context', 'page.php?i=account-profile-switcher#top', '', '', 'user', '', 2147483646, 1, 1, 1),
('sys_account_settings', 'system', 'account-settings-info', '_sys_menu_item_title_system_account_settings_info', '_sys_menu_item_title_account_settings_info', 'page.php?i=account-settings-info#top', '', '', 'info-circle', '', 2147483646, 1, 1, 2),
('sys_account_settings', 'system', 'account-settings-email', '_sys_menu_item_title_system_account_settings_email', '_sys_menu_item_title_account_settings_email', 'page.php?i=account-settings-email#top', '', '', 'envelope', '', 2147483646, 1, 1, 3),
('sys_account_settings', 'system', 'account-settings-password', '_sys_menu_item_title_system_account_settings_pwd', '_sys_menu_item_title_account_settings_pwd', 'page.php?i=account-settings-password#top', '', '', 'key', '', 2147483646, 1, 1, 4),
('sys_account_settings', 'system', 'account-settings-delete', '_sys_menu_item_title_system_account_settings_delete', '_sys_menu_item_title_account_settings_delete', 'page.php?i=account-settings-delete#top', '', '', 'remove', '', 2147483646, 1, 1, 5);

-- comment manage menu
INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `visible_for_levels`, `active`, `copyable`, `order`) VALUES 
('sys_cmts_item_manage', 'system', 'item-edit', '_sys_menu_item_title_system_cmts_item_edit', '_sys_menu_item_title_cmts_item_edit', 'javascript:void(0)', 'javascript:{js_object}.cmtEdit(this, {content_id})', '_self', 'pencil', '', 2147483647, 1, 0, 0),
('sys_cmts_item_manage', 'system', 'item-delete', '_sys_menu_item_title_system_cmts_item_delete', '_sys_menu_item_title_cmts_item_delete', 'javascript:void(0)', 'javascript:{js_object}.cmtRemove(this, {content_id})', '_self', 'remove', '', 2147483647, 1, 0, 0);

-- comment actions menu
INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `addon`, `submenu_object`, `visible_for_levels`, `active`, `copyable`, `order`) VALUES 
('sys_cmts_item_actions', 'system', 'item-vote', '_sys_menu_item_title_system_cmts_item_vote', '_sys_menu_item_title_cmts_item_vote', 'javascript:void(0)', 'javascript:{vote_onclick}', '_self', 'plus', 'a:4:{s:6:"module";s:6:"system";s:6:"method";s:24:"get_menu_item_addon_vote";s:6:"params";a:3:{i:0;s:12:"{cmt_system}";i:1;s:8:"{cmt_id}";i:2;s:12:"{content_id}";}s:5:"class";s:17:"TemplCmtsServices";}', '', 2147483647, 1, 0, 1),
('sys_cmts_item_actions', 'system', 'item-reply', '_sys_menu_item_title_system_cmts_item_reply', '_sys_menu_item_title_cmts_item_reply', 'javascript:void(0)', 'javascript:{reply_onclick}', '_self', 'reply', '', '', 2147483647, 1, 0, 2);

-- --------------------------------------------------------


CREATE TABLE IF NOT EXISTS `sys_objects_grid` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object` varchar(32) NOT NULL,
  `source_type` enum('Array','Sql') NOT NULL,
  `source` text NOT NULL,
  `table` varchar(255) NOT NULL,
  `field_id` varchar(255) NOT NULL,
  `field_order` varchar(255) NOT NULL,
  `field_active` varchar(255) NOT NULL,
  `paginate_url` varchar(255) NOT NULL,
  `paginate_per_page` int(11) NOT NULL DEFAULT '10',
  `paginate_simple` varchar(255) DEFAULT NULL,
  `paginate_get_start` varchar(255) NOT NULL,
  `paginate_get_per_page` varchar(255) NOT NULL,
  `filter_fields` text NOT NULL,
  `filter_fields_translatable` text NOT NULL,
  `filter_mode` enum('like','fulltext','auto') NOT NULL DEFAULT 'auto',
  `sorting_fields` text NOT NULL,
  `sorting_fields_translatable` text NOT NULL,
  `visible_for_levels` int(11) NOT NULL DEFAULT '2147483647',
  `override_class_name` varchar(255) NOT NULL,
  `override_class_file` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `object` (`object`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

INSERT INTO `sys_objects_grid` (`object`, `source_type`, `source`, `table`, `field_id`, `field_order`, `field_active`, `paginate_url`, `paginate_per_page`, `paginate_simple`, `paginate_get_start`, `paginate_get_per_page`, `filter_fields`, `filter_fields_translatable`, `filter_mode`, `sorting_fields`, `sorting_fields_translatable`, `override_class_name`, `override_class_file`) VALUES
('sys_studio_lang_keys', 'Sql', 'SELECT `tlk`.`ID` AS `id`, `tlk`.`Key` AS `key`, `tlc`.`Name` AS `module`, `tls`.`String` AS `string` FROM `sys_localization_keys` AS `tlk` LEFT JOIN `sys_localization_categories` AS `tlc` ON `tlk`.`IDCategory`=`tlc`.`ID` LEFT JOIN `sys_localization_strings` AS `tls` ON `tlk`.`ID`=`tls`.`IDKey` WHERE `tls`.`IDLanguage`=\'%d\'', 'sys_localization_keys', 'id', '', '', '', 20, NULL, 'start', '', 'key,string', '', 'like', 'key,module,string', '', 'BxTemplStudioPolyglotKeys', ''),
('sys_studio_lang_etemplates', 'Sql', 'SELECT * FROM `sys_email_templates` WHERE 1 ', 'sys_email_templates', 'ID', '', '', '', 20, NULL, 'start', '', 'Module', 'NameSystem,Subject,Body', 'auto', 'Module', 'NameSystem', 'BxTemplStudioPolyglotEtemplates', ''),
('sys_studio_acl', 'Sql', 'SELECT * FROM `sys_acl_levels` WHERE 1 ', 'sys_acl_levels', 'ID', 'Order', 'Active', '', 100, NULL, 'start', '', 'Description', 'Name', 'auto', '', '', 'BxTemplStudioPermissionsLevels', ''),
('sys_studio_acl_actions', 'Sql', 'SELECT *, ''0'' AS `Active` FROM `sys_acl_actions` WHERE 1 ', 'sys_acl_actions', 'ID', '', 'Active', '', 20, NULL, 'start', '', 'Module,Name', 'Title,Desc', 'auto', 'Module,Name', 'Title,Desc', 'BxTemplStudioPermissionsActions', ''),
('sys_studio_nav_menus', 'Sql', 'SELECT `tm`.*, `tms`.`title` AS `set_title`, `tmt`.`title` AS `template_title` FROM `sys_objects_menu` AS `tm` LEFT JOIN `sys_menu_sets` AS `tms` ON `tm`.`set_name`=`tms`.`set_name` LEFT JOIN `sys_menu_templates` AS `tmt` ON `tm`.`template_id`=`tmt`.`id` WHERE 1 ', 'sys_objects_menu', 'id', '', 'active', '', 100, NULL, 'start', '', '', 'tm`.`title,tms`.`title,tmt`.`title', 'auto', '', '', 'BxTemplStudioNavigationMenus', ''),
('sys_studio_nav_sets', 'Sql', 'SELECT * FROM `sys_menu_sets` WHERE 1 ', 'sys_menu_sets', 'set_name', '', '', '', 100, NULL, 'start', '', '', 'title', 'auto', '', '', 'BxTemplStudioNavigationSets', ''),
('sys_studio_nav_items', 'Sql', 'SELECT * FROM `sys_menu_items` WHERE 1 ', 'sys_menu_items', 'id', 'order', 'active', '', 100, NULL, 'start_it', '', 'link', 'title_system', 'like', '', '', 'BxTemplStudioNavigationItems', ''),
('sys_studio_nav_import', 'Sql', 'SELECT * FROM `sys_menu_items` WHERE 1 AND `copyable`=\'1\' ', 'sys_menu_items', 'id', '', '', '', 5, NULL, 'start_im', '', 'link', 'title_system', 'like', '', '', 'BxTemplStudioNavigationImport', ''),
('sys_studio_forms', 'Sql', 'SELECT * FROM `sys_objects_form` WHERE 1 ', 'sys_objects_form', 'id', 'module,title', 'active', '', 100, NULL, 'start', '', 'module', 'title', 'like', 'module', 'title', 'BxTemplStudioFormsForms', ''),
('sys_studio_forms_displays', 'Sql', 'SELECT `td`.`id` AS `id`, `td`.`object` AS `object`, `td`.`display_name` AS `display_name`, `td`.`title` AS `display_title`, `td`.`module` AS `module`, `tf`.`title` AS `form_title` FROM `sys_form_displays` AS `td` LEFT JOIN `sys_objects_form` AS `tf` ON `td`.`object`=`tf`.`object` WHERE 1 ', 'sys_form_displays', 'id', 'module,object,display_title', '', '', 100, NULL, 'start', '', 'td`.`module', 'td`.`title', 'like', 'module', 'display_title,form_title', 'BxTemplStudioFormsDisplays', ''),
('sys_studio_forms_fields', 'Sql', 'SELECT `tdi`.`id` AS `id`, `ti`.`caption_system` AS `caption_system`, `ti`.`type` AS `type`, `ti`.`module` AS `module`, `tdi`.`visible_for_levels` AS `visible_for_levels`, `tdi`.`active` AS `active`, `ti`.`editable` AS `editable`, `ti`.`deletable` AS `deletable`, `tdi`.`order` AS `order` FROM `sys_form_display_inputs` AS `tdi` LEFT JOIN `sys_form_inputs` AS `ti` ON `tdi`.`input_name`=`ti`.`name` AND `ti`.`object`=? WHERE 1 AND `tdi`.`display_name`=?', 'sys_form_display_inputs', 'id', 'order', 'active', '', 100, NULL, 'start', '', 'ti`.`type', 'ti`.`caption_system', 'like', '', '', 'BxTemplStudioFormsFields', ''),
('sys_studio_forms_pre_lists', 'Sql', 'SELECT * FROM `sys_form_pre_lists` WHERE 1 ', 'sys_form_pre_lists', 'id', '', '', '', 100, NULL, 'start', '', 'module,key', 'title', 'auto', 'module', 'title', 'BxTemplStudioFormsPreLists', ''),
('sys_studio_forms_pre_values', 'Sql', 'SELECT * FROM `sys_form_pre_values` WHERE 1 ', 'sys_form_pre_values', 'id', 'Order', '', '', 1000, NULL, 'start', '', 'Key,Value', 'LKey,LKey2', 'auto', '', '', 'BxTemplStudioFormsPreValues', '');

CREATE TABLE IF NOT EXISTS `sys_grid_fields` (
  `object` varchar(32) NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `width` varchar(16) NOT NULL,
  `translatable` tinyint(4) NOT NULL DEFAULT '0',
  `chars_limit` int(11) NOT NULL DEFAULT '0',
  `params` text NOT NULL,
  `order` int(11) NOT NULL,
  UNIQUE KEY `object_name` (`object`,`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `sys_grid_fields` (`object`, `name`, `title`, `width`, `translatable`, `chars_limit`, `params`, `order`) VALUES
('sys_studio_lang_keys', 'checkbox', 'Select', '1%', 0, '', '', 1),
('sys_studio_lang_keys', 'key', '_adm_pgt_txt_key', '24%', 0, '20', '', 2),
('sys_studio_lang_keys', 'module', '_adm_pgt_txt_module', '15%', 0, '12', '', 3),
('sys_studio_lang_keys', 'string', '_adm_pgt_txt_text', '32%', 0, '30', '', 4),
('sys_studio_lang_keys', 'languages', '_adm_pgt_txt_languages', '10%', 0, '', '', 5),
('sys_studio_lang_keys', 'actions', '', '20%', 0, '', '', 6),
('sys_studio_lang_etemplates', 'NameSystem', '_adm_pgt_txt_etemplates_gl_name_system', '60%', 1, '58', '', 1),
('sys_studio_lang_etemplates', 'Module', '_adm_pgt_txt_etemplates_gl_module', '20%', 0, '18', '', 2),
('sys_studio_lang_etemplates', 'actions', '', '20%', 0, '', '', 3),
('sys_studio_acl', 'Order', '', '1%', 0, '', '', 1),
('sys_studio_acl', 'switcher', '_adm_prm_txt_enable', '5%', 0, '', '', 2),
('sys_studio_acl', 'Icon', '_adm_prm_txt_icon', '5%', 0, '', '', 3),
('sys_studio_acl', 'Name', '_adm_prm_txt_title', '29%', 1, '15', '', 4),
('sys_studio_acl', 'ActionsList', '_adm_prm_txt_actions', '10%', 0, '', '', 5),
('sys_studio_acl', 'QuotaSize', '_adm_prm_txt_storage', '10%', 0, '', '', 6),
('sys_studio_acl', 'QuotaMaxFileSize', '_adm_prm_txt_max_file_size', '10%', 0, '', '', 7),
('sys_studio_acl', 'QuotaNumber', '_adm_prm_txt_max_files', '10%', 0, '', '', 8),
('sys_studio_acl', 'actions', '', '20%', 0, '', '', 9),
('sys_studio_acl_actions', 'switcher', '_adm_prm_txt_enable', '10%', 0, '', '', 1),
('sys_studio_acl_actions', 'Title', '_adm_prm_txt_title', '25%', 1, '25', '', 2),
('sys_studio_acl_actions', 'Module', '_adm_prm_txt_module', '20%', 0, '18', '', 3),
('sys_studio_acl_actions', 'Desc', '_adm_prm_txt_description', '25%', 0, '25', '', 4),
('sys_studio_acl_actions', 'actions', '', '20%', 0, '', '', 5),
('sys_studio_nav_menus', 'switcher', '', '10%', 0, '', '', 1),
('sys_studio_nav_menus', 'title', '_adm_nav_txt_menus_gl_title', '17%', 0, '15', '', 2),
('sys_studio_nav_menus', 'set_title', '_adm_nav_txt_menus_gl_set_title', '17%', 1, '15', '', 3),
('sys_studio_nav_menus', 'items', '_adm_nav_txt_menus_gl_items', '10%', 0, '8', '', 4),
('sys_studio_nav_menus', 'template_title', '_adm_nav_txt_menus_gl_template_title', '17%', 1, '15', '', 5),
('sys_studio_nav_menus', 'module', '_adm_nav_txt_menus_gl_module', '12%', 0, '10', '', 6),
('sys_studio_nav_menus', 'actions', '', '17%', 0, '', '', 7),
('sys_studio_nav_sets', 'title', '_adm_nav_txt_sets_gl_title', '50%', 1, '48', '', 1),
('sys_studio_nav_sets', 'module', '_adm_nav_txt_sets_gl_module', '15%', 0, '13', '', 2),
('sys_studio_nav_sets', 'items', '_adm_nav_txt_sets_gl_items', '15%', 0, '13', '', 3),
('sys_studio_nav_sets', 'actions', '', '20%', 0, '', '', 4),
('sys_studio_nav_items', 'order', '', '1%', 0, '', '', 1),
('sys_studio_nav_items', 'switcher', '', '9%', 0, '', '', 2),
('sys_studio_nav_items', 'icon', '_adm_nav_txt_items_gl_icon', '5%', 0, '', '', 3),
('sys_studio_nav_items', 'title_system', '_adm_nav_txt_items_gl_title_system', '23%', 1, '23', '', 4),
('sys_studio_nav_items', 'link', '_adm_nav_txt_items_gl_link', '23%', 0, '23', '', 5),
('sys_studio_nav_items', 'module', '_adm_nav_txt_items_gl_module', '12%', 0, '12', '', 6),
('sys_studio_nav_items', 'visible_for_levels', '_adm_nav_txt_items_gl_visible', '10%', 0, '10', '', 7),
('sys_studio_nav_items', 'actions', '', '17%', 0, '', '', 8),
('sys_studio_nav_import', 'icon', '_adm_nav_txt_items_gl_icon', '10%', 0, '', '', 1),
('sys_studio_nav_import', 'title_system', '_adm_nav_txt_items_gl_title_system', '30%', 1, '28', '', 2),
('sys_studio_nav_import', 'link', '_adm_nav_txt_items_gl_link', '25%', 0, '23', '', 3),
('sys_studio_nav_import', 'module', '_adm_nav_txt_items_gl_module', '15%', 0, '13', '', 4),
('sys_studio_nav_import', 'actions', '', '20%', 0, '', '', 5),
('sys_studio_forms', 'switcher', '', '10%', 0, '', '', 1),
('sys_studio_forms', 'title', '_adm_form_txt_forms_gl_title', '40%', 1, '38', '', 2),
('sys_studio_forms', 'module', '_adm_form_txt_forms_gl_module', '15%', 0, '13', '', 3),
('sys_studio_forms', 'displays', '_adm_form_txt_forms_gl_displays', '15%', 0, '13', '', 4),
('sys_studio_forms', 'actions', '', '20%', 0, '', '', 5),
('sys_studio_forms_displays', 'display_title', '_adm_form_txt_displays_gl_title', '30%', 1, '48', '', 1),
('sys_studio_forms_displays', 'module', '_adm_form_txt_displays_gl_module', '13%', 0, '11', '', 2),
('sys_studio_forms_displays', 'form_title', '_adm_form_txt_displays_gl_form', '24%', 1, '22', '', 3),
('sys_studio_forms_displays', 'fields', '_adm_form_txt_displays_gl_fields', '13%', 0, '11', '', 4),
('sys_studio_forms_displays', 'actions', '', '20%', 0, '', '', 5),
('sys_studio_forms_fields', 'order', '', '1%', 0, '', '', 1),
('sys_studio_forms_fields', 'switcher', '', '9%', 0, '', '', 2),
('sys_studio_forms_fields', 'type', '_adm_form_txt_fields_type', '5%', 0, '', '', 3),
('sys_studio_forms_fields', 'caption_system', '_adm_form_txt_fields_caption_system', '40%', 1, '38', '', 4),
('sys_studio_forms_fields', 'module', '_adm_form_txt_fields_module', '15%', 0, '13', '', 5),
('sys_studio_forms_fields', 'visible_for_levels', '_adm_form_txt_fields_visible', '10%', 0, '10', '', 6),
('sys_studio_forms_fields', 'actions', '', '20%', 0, '', '', 7),
('sys_studio_forms_pre_lists', 'title', '_adm_form_txt_pre_lists_gl_title', '45%', 1, '50', '', 1),
('sys_studio_forms_pre_lists', 'values', '_adm_form_txt_pre_lists_gl_values', '12%', 0, '10', '', 2),
('sys_studio_forms_pre_lists', 'module', '_adm_form_txt_pre_lists_gl_module', '13%', 0, '11', '', 3),
('sys_studio_forms_pre_lists', 'use_for_sets', '_adm_form_txt_pre_lists_gl_use_for_sets', '10%', 0, '8', '', 4),
('sys_studio_forms_pre_lists', 'actions', '', '20%', 0, '', '', 5),
('sys_studio_forms_pre_values', 'order', '', '1%', 0, '', '', 1),
('sys_studio_forms_pre_values', 'LKey', '_adm_form_txt_pre_values_gl_lkey', '79%', 1, '75', '', 2),
('sys_studio_forms_pre_values', 'actions', '', '20%', 0, '', '', 3);


CREATE TABLE IF NOT EXISTS `sys_grid_actions` (
  `object` varchar(32) NOT NULL,
  `type` enum('bulk','single','independent') NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `icon` varchar(255) NOT NULL,
  `confirm` tinyint(4) NOT NULL DEFAULT '1',
  `order` int(11) NOT NULL,
  UNIQUE KEY `object_name_type` (`object`,`type`,`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


INSERT INTO `sys_grid_actions` (`object`, `type`, `name`, `title`, `icon`, `confirm`, `order`) VALUES
('sys_studio_lang_keys', 'bulk', 'delete', '_adm_pgt_btn_delete', '', 1, 1),
('sys_studio_lang_keys', 'single', 'edit', '', 'pencil', 0, 1),
('sys_studio_lang_keys', 'single', 'delete', '', 'remove', 1, 2),
('sys_studio_lang_keys', 'independent', 'add', '_adm_pgt_btn_add_new_key', '', 0, 1),
('sys_studio_lang_etemplates', 'single', 'edit', '', 'pencil', 0, 1),
('sys_studio_acl', 'independent', 'add', '_adm_prm_btn_add_level', '', 0, 1),
('sys_studio_acl', 'single', 'edit', '', 'pencil', 0, 1),
('sys_studio_acl', 'single', 'delete', '', 'remove', 1, 2),
('sys_studio_acl_actions', 'single', 'options', '', 'cog', 0, 1),
('sys_studio_nav_menus', 'independent', 'add', '_adm_nav_btn_menus_create', '', 0, 1),
('sys_studio_nav_menus', 'single', 'edit', '', 'pencil', 0, 1),
('sys_studio_nav_menus', 'single', 'delete', '', 'remove', 1, 2),
('sys_studio_nav_sets', 'independent', 'add', '_adm_nav_btn_sets_create', '', 0, 1),
('sys_studio_nav_sets', 'single', 'edit', '', 'pencil', 0, 1),
('sys_studio_nav_sets', 'single', 'delete', '', 'remove', 1, 2),
('sys_studio_nav_items', 'independent', 'import', '_adm_nav_btn_items_gl_import', '', 0, 1),
('sys_studio_nav_items', 'independent', 'add', '_adm_nav_btn_items_gl_create', '', 0, 2),
('sys_studio_nav_items', 'single', 'edit', '', 'pencil', 0, 1),
('sys_studio_nav_items', 'single', 'delete', '', 'remove', 1, 2),
('sys_studio_nav_items', 'single', 'show_to', '_adm_nav_btn_items_gl_visible', '', 0, 3),
('sys_studio_nav_import', 'single', 'import', '', 'plus', 0, 1),
('sys_studio_nav_import', 'bulk', 'done', '_adm_nav_btn_items_done', '', 0, 1),
('sys_studio_forms', 'single', 'edit', '', 'pencil', 0, 1),
('sys_studio_forms_displays', 'single', 'edit', '', 'pencil', 0, 1),
('sys_studio_forms_fields', 'single', 'edit', '', 'pencil', 0, 1),
('sys_studio_forms_fields', 'single', 'delete', '', 'remove', 1, 2),
('sys_studio_forms_fields', 'single', 'show_to', '_adm_form_btn_fields_visible', '', 0, 3),
('sys_studio_forms_fields', 'independent', 'add', '_adm_form_btn_fields_create', '', 0, 1),
('sys_studio_forms_pre_lists', 'independent', 'add', '_adm_form_btn_pre_lists_create', '', 0, 1),
('sys_studio_forms_pre_lists', 'single', 'edit', '', 'pencil', 0, 1),
('sys_studio_forms_pre_lists', 'single', 'delete', '', 'remove', 1, 2),
('sys_studio_forms_pre_values', 'independent', 'add', '_adm_form_btn_pre_values_create', '', 0, 1),
('sys_studio_forms_pre_values', 'single', 'edit', '', 'pencil', 0, 1),
('sys_studio_forms_pre_values', 'single', 'delete', '', 'remove', 1, 2);


-- --------------------------------------------------------


CREATE TABLE IF NOT EXISTS `sys_objects_connection` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object` varchar(32) NOT NULL,
  `table` varchar(255) NOT NULL,
  `type` enum('one-way','mutual') NOT NULL,
  `override_class_name` varchar(255) NOT NULL,
  `override_class_file` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `object` (`object`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `sys_objects_connection` (`object`, `table`, `type`, `override_class_name`, `override_class_file`) VALUES
('sys_profiles_friends', 'sys_profiles_conn_friends', 'mutual', '', ''),
('sys_profiles_subscriptions', 'sys_profiles_conn_subscriptions', 'one-way', '', '');


CREATE TABLE IF NOT EXISTS `sys_profiles_conn_subscriptions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `initiator` int(11) NOT NULL,
  `content` int(11) NOT NULL,
  `added` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `initiator` (`initiator`,`content`),
  KEY `content` (`content`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `sys_profiles_conn_friends` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `initiator` int(11) NOT NULL,
  `content` int(11) NOT NULL,
  `mutual` tinyint(4) NOT NULL,
  `added` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `initiator` (`initiator`,`content`),
  KEY `content` (`content`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- --------------------------------------------------------


CREATE TABLE IF NOT EXISTS `sys_objects_transcoder_images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object` varchar(32) NOT NULL,
  `storage_object` varchar(32) NOT NULL,
  `source_type` enum('Folder','Storage') NOT NULL,
  `source_params` text NOT NULL,
  `private` enum('auto','yes','no') NOT NULL,
  `atime_tracking` int(11) NOT NULL,
  `atime_pruning` int(11) NOT NULL,
  `ts` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `object` (`object`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

INSERT INTO `sys_objects_transcoder_images` (`object`, `storage_object`, `source_type`, `source_params`, `private`, `atime_tracking`, `atime_pruning`, `ts`) VALUES 
('sys_icon_apple', 'sys_images', 'Storage', 'a:2:{s:6:"object";s:10:"sys_images";s:14:"disable_retina";b:1;}', 'no', '0', '0', '0'),
('sys_icon_facebook', 'sys_images', 'Storage', 'a:2:{s:6:"object";s:10:"sys_images";s:14:"disable_retina";b:1;}', 'no', '0', '0', '0'),
('sys_icon_favicon', 'sys_images', 'Storage', 'a:2:{s:6:"object";s:10:"sys_images";s:14:"disable_retina";b:1;}', 'no', '0', '0', '0'),
('sys_cmts_images_preview', 'sys_cmts_images_preview', 'Storage', 'a:1:{s:6:"object";s:15:"sys_cmts_images";}', 'no', '1', '2592000', '0');


CREATE TABLE IF NOT EXISTS `sys_transcoder_images_files` (
  `transcoder_object` varchar(32) NOT NULL,
  `file_id` int(11) NOT NULL,
  `handler` varchar(255) NOT NULL,
  `atime` int(11) NOT NULL,
  UNIQUE KEY `transcoder_object` (`transcoder_object`,`handler`),
  KEY `atime` (`atime`),
  KEY `file_id` (`file_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



CREATE TABLE IF NOT EXISTS `sys_transcoder_images_filters` (
  `transcoder_object` varchar(32) NOT NULL,
  `filter` varchar(32) NOT NULL,
  `filter_params` text NOT NULL,
  `order` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `sys_transcoder_images_filters` (`transcoder_object`, `filter`, `filter_params`, `order`) VALUES 
('sys_icon_apple', 'Resize', 'a:4:{s:1:"w";s:3:"152";s:1:"h";s:3:"152";s:13:"square_resize";s:1:"1";s:10:"force_type";s:3:"png";}', '0'),
('sys_icon_facebook', 'Resize', 'a:4:{s:1:"w";s:3:"100";s:1:"h";s:3:"100";s:13:"square_resize";s:1:"1";s:10:"force_type";s:3:"png";}', '0'),
('sys_icon_favicon', 'Resize', 'a:4:{s:1:"w";s:2:"16";s:1:"h";s:2:"16";s:13:"square_resize";s:1:"1";s:10:"force_type";s:3:"png";}', '0'),
('sys_cmts_images_preview', 'Resize', 'a:4:{s:1:"w";s:3:"100";s:1:"h";s:3:"100";s:13:"square_resize";s:1:"1";s:10:"force_type";s:3:"jpg";}', '0');


-- --------------------------------------------------------


CREATE TABLE IF NOT EXISTS `sys_objects_page` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object` varchar(32) NOT NULL,
  `uri` varchar(255) NOT NULL,
  `title_system` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `module` varchar(32) NOT NULL,
  `layout_id` int(11) NOT NULL,
  `visible_for_levels` int(11) NOT NULL DEFAULT '2147483647',
  `visible_for_levels_editable` tinyint(4) NOT NULL DEFAULT '1',
  `url` varchar(255) NOT NULL,
  `meta_description` text NOT NULL,
  `meta_keywords` text NOT NULL,
  `meta_robots` varchar(255) NOT NULL,
  `cache_lifetime` int(11) NOT NULL DEFAULT '0',
  `cache_editable` tinyint(4) NOT NULL DEFAULT '1',
  `deletable` tinyint(1) NOT NULL,
  `override_class_name` varchar(255) NOT NULL,
  `override_class_file` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `object` (`object`),
  UNIQUE KEY `uri` (`uri`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

INSERT INTO `sys_objects_page` (`object`, `uri`, `title_system`, `title`, `module`, `layout_id`, `visible_for_levels`, `visible_for_levels_editable`, `url`, `meta_description`, `meta_keywords`, `meta_robots`, `cache_lifetime`, `cache_editable`, `deletable`, `override_class_name`, `override_class_file`) VALUES
('sys_home', 'home', '_sys_page_title_system_home', '_sys_page_title_home', 'system', 5, 2147483647, 1, '', '', '', '', 0, 1, 0, 'BxTemplPageHome', ''),
('sys_about', 'about', '_sys_page_title_system_about', '_sys_page_title_about', 'system', 5, 2147483647, 1, 'page.php?i=about', '', '', '', 0, 1, 0, '', ''),
('sys_create_account', 'create-account', '_sys_page_title_system_create_account', '_sys_page_title_create_account', 'system', 5, 2147483647, 1, 'page.php?i=create-account', '', '', '', 0, 1, 0, '', ''),
('sys_login', 'login', '_sys_page_title_system_login', '_sys_page_title_login', 'system', 5, 2147483647, 1, 'page.php?i=login', '', '', '', 0, 1, 0, '', ''),
('sys_forgot_password', 'forgot-password', '_sys_page_title_system_forgot_password', '_sys_page_title_forgot_password', 'system', 5, 2147483647, 1, 'page.php?i=forgot-password', '', '', '', 0, 1, 0, '', ''),
('sys_confirm_email', 'confirm-email', '_sys_page_title_system_confirm_email', '_sys_page_title_confirm_email', 'system', 5, 2147483647, 1, 'page.php?i=confirm-email', '', '', '', 0, 1, 0, '', ''),
('sys_account_settings_email', 'account-settings-email', '_sys_page_title_system_account_settings_email', '_sys_page_title_account_settings_email', 'system', 1, 2147483647, 1, 'member.php', '', '', '', 0, 1, 0, 'BxTemplPageAccount', ''),
('sys_account_settings_pwd', 'account-settings-password', '_sys_page_title_system_account_settings_pwd', '_sys_page_title_account_settings_pwd', 'system', 1, 2147483647, 1, 'page.php?i=account-settings-pwd', '', '', '', 0, 1, 0, 'BxTemplPageAccount', ''),
('sys_account_settings_info', 'account-settings-info', '_sys_page_title_system_account_settings_info', '_sys_page_title_account_settings_info', 'system', 1, 2147483647, 1, 'page.php?i=account-settings-info', '', '', '', 0, 1, 0, 'BxTemplPageAccount', ''),
('sys_account_settings_delete', 'account-settings-delete', '_sys_page_title_system_account_settings_delete', '_sys_page_title_account_settings_delete', 'system', 1, 2147483647, 1, 'page.php?i=account-settings-delete', '', '', '', 0, 1, 0, 'BxTemplPageAccount', ''),
('sys_account_profile_switcher', 'account-profile-switcher', '_sys_page_title_system_account_profile_switcher', '_sys_page_title_account_profile_switcher', 'system', 1, 2147483647, 1, 'page.php?i=account-profile-switcher', '', '', '', 0, 1, 0, 'BxTemplPageAccount', ''),
('sys_unsubscribe_notifications', 'unsubscribe-notifications', '_sys_page_title_system_unsubscribe_notifications', '_sys_page_title_unsubscribe_notifications', 'system', 5, 2147483647, 1, 'page.php?i=unsubscribe-notifications', '', '', '', 0, 1, 0, '', ''),
('sys_unsubscribe_news', 'unsubscribe-news', '_sys_page_title_system_unsubscribe_news', '_sys_page_title_unsubscribe_news', 'system', 5, 2147483647, 1, 'page.php?i=unsubscribe-news', '', '', '', 0, 1, 0, '', '');


CREATE TABLE IF NOT EXISTS `sys_pages_layouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `icon` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `template` varchar(255) NOT NULL,
  `cells_number` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

INSERT INTO `sys_pages_layouts` (`id`, `name`, `icon`, `title`, `template`, `cells_number`) VALUES
(1, 'bar_left', 'layout_bar_left.png', '_sys_layout_bar_left', 'layout_bar_left.html', 2),
(2, 'bar_right', 'layout_bar_right.png', '_sys_layout_bar_right', 'layout_bar_right.html', 2),
(3, '3_columns', 'layout_3_columns.png', '_sys_layout_3_columns', 'layout_3_columns.html', 3),
(4, '2_columns', 'layout_2_columns.png', '_sys_layout_2_columns', 'layout_2_columns.html', 2),
(5, '1_column', 'layout_1_column.png', '_sys_layout_1_column', 'layout_1_column.html', 1),
(6, 'top_area_bar_left', 'layout_top_area_bar_left.png', '_sys_layout_top_area_bar_left', 'layout_top_area_bar_left.html', 3),
(7, 'top_area_bar_right', 'layout_top_area_bar_right.png', '_sys_layout_top_area_bar_right', 'layout_top_area_bar_right.html', 3),
(8, 'top_area_3_columns', 'layout_top_area_3_columns.png', '_sys_layout_top_area_3_columns', 'layout_top_area_3_columns.html', 4),
(9, 'top_area_2_columns', 'layout_top_area_2_columns.png', '_sys_layout_top_area_2_columns', 'layout_top_area_2_columns.html', 3),
(10, 'topbottom_area_2_columns', 'layout_topbottom_area_2_columns.png', '_sys_layout_topbottom_area_2_columns', 'layout_topbottom_area_2_columns.html', 4),
(11, 'bottom_area_2_columns', 'layout_bottom_area_2_columns.png', '_sys_layout_bottom_area_2_columns', 'layout_bottom_area_2_columns.html', 3);

CREATE TABLE IF NOT EXISTS `sys_pages_design_boxes` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `template` varchar(255) NOT NULL,
  `order` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `sys_pages_design_boxes` (`id`, `title`, `template`, `order`) VALUES
(0, '_sys_designbox_0', 'designbox_0.html', '2'),
(1, '_sys_designbox_1', 'designbox_1.html', '6'),
(2, '_sys_designbox_2', 'designbox_2.html', '1'),
(3, '_sys_designbox_3', 'designbox_3.html', '4'),
(10, '_sys_designbox_10', 'designbox_10.html', '3'),
(11, '_sys_designbox_11', 'designbox_11.html', '7'),
(13, '_sys_designbox_13', 'designbox_13.html', '5');



CREATE TABLE IF NOT EXISTS `sys_pages_blocks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object` varchar(32) NOT NULL,
  `cell_id` int(11) NOT NULL DEFAULT '1',
  `module` varchar(32) NOT NULL,
  `title` varchar(255) NOT NULL,
  `designbox_id` int(11) NOT NULL DEFAULT '11',
  `visible_for_levels` int(11) NOT NULL DEFAULT '2147483647',
  `type` enum('raw','html','lang','image','rss','menu','service') NOT NULL DEFAULT 'raw',
  `content` text NOT NULL,
  `deletable` tinyint(4) NOT NULL DEFAULT '1',
  `copyable` tinyint(4) NOT NULL DEFAULT '1',
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `order` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

-- skeleton blocks
INSERT INTO `sys_pages_blocks` (`object`, `cell_id`, `module`, `title`, `designbox_id`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `active`, `order`) VALUES
('', 0, 'skeletons', '_sys_block_type_raw', 11, 2147483647, 'raw', '', 0, 1, 1, 0),
('', 0, 'skeletons', '_sys_block_type_html', 11, 2147483647, 'html', '', 0, 1, 1, 0),
('', 0, 'skeletons', '_sys_block_type_rss', 11, 2147483647, 'rss', '', 0, 1, 1, 0),
('', 0, 'skeletons', '_sys_block_type_image', 11, 2147483647, 'image', '', 0, 1, 1, 0),
('', 0, 'skeletons', '_sys_block_type_lang', 11, 2147483647, 'lang', '', 0, 1, 1, 0),
('', 0, 'skeletons', '_sys_block_type_menu', 11, 2147483647, 'menu', '', 0, 1, 1, 0),
('', 0, 'skeletons', '_sys_block_type_service', 11, 2147483647, 'service', '', 0, 0, 1, 0);

-- content blocks
INSERT INTO `sys_pages_blocks` (`object`, `cell_id`, `module`, `title`, `designbox_id`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `order`) VALUES

('sys_home', 1, 'system', '_sys_page_block_title_login', 11, 2147483647, 'service', 'a:4:{s:6:"module";s:6:"system";s:6:"method";s:10:"login_form";s:6:"params";a:1:{i:0;s:12:"no_join_text";}s:5:"class";s:17:"TemplServiceLogin";}', 0, 1, 1),

('sys_about', 1, 'system', '_sys_page_block_title_about', 11, 2147483647, 'lang', '_sys_page_lang_block_about', 0, 1, 1),

('sys_create_account', 1, 'system', '_sys_page_block_title_create_account', 11, 2147483647, 'service', 'a:4:{s:6:\"module\";s:6:\"system\";s:6:\"method\";s:19:\"create_account_form\";s:6:\"params\";a:0:{}s:5:\"class\";s:19:\"TemplServiceAccount\";}', 0, 1, 1),

('sys_login', 1, 'system', '_sys_page_block_title_login', 11, 2147483647, 'service', 'a:3:{s:6:\"module\";s:6:\"system\";s:6:\"method\";s:10:\"login_form\";s:5:\"class\";s:17:\"TemplServiceLogin\";}', 0, 1, 1),

('sys_forgot_password', 1, 'system', '_sys_page_block_title_forgot_password', 11, 2147483647, 'service', 'a:4:{s:6:"module";s:6:"system";s:6:"method";s:15:"forgot_password";s:6:"params";a:0:{}s:5:"class";s:19:"TemplServiceAccount";}', 0, 1, 1),

('sys_confirm_email', 1, 'system', '_sys_page_block_title_confirm_email', 11, 2147483647, 'service', 'a:4:{s:6:"module";s:6:"system";s:6:"method";s:18:"email_confirmation";s:6:"params";a:0:{}s:5:"class";s:19:"TemplServiceAccount";}', 0, 1, 1),

('sys_account_settings_email', 2, 'system', '_sys_page_block_title_account_settings_email', 11, 2147483647, 'service', 'a:4:{s:6:"module";s:6:"system";s:6:"method";s:22:"account_settings_email";s:6:"params";a:0:{}s:5:"class";s:19:"TemplServiceAccount";}', 0, 1, 1),
('sys_account_settings_email', 1, 'system', '_sys_page_block_title_account_settings_menu', 13, 2147483647, 'menu', 'sys_account_settings', 0, 1, 1),

('sys_account_settings_pwd', 2, 'system', '_sys_page_block_title_account_settings_pwd', 11, 2147483647, 'service', 'a:4:{s:6:"module";s:6:"system";s:6:"method";s:25:"account_settings_password";s:6:"params";a:0:{}s:5:"class";s:19:"TemplServiceAccount";}', 0, 1, 1),
('sys_account_settings_pwd', 1, 'system', '_sys_page_block_title_account_settings_menu', 13, 2147483647, 'menu', 'sys_account_settings', 0, 1, 1),

('sys_account_settings_info', 2, 'system', '_sys_page_block_title_account_settings_info', 11, 2147483647, 'service', 'a:4:{s:6:"module";s:6:"system";s:6:"method";s:21:"account_settings_info";s:6:"params";a:0:{}s:5:"class";s:19:"TemplServiceAccount";}', 0, 1, 1),
('sys_account_settings_info', 1, 'system', '_sys_page_block_title_account_settings_menu', 13, 2147483647, 'menu', 'sys_account_settings', 0, 1, 1),

('sys_account_settings_delete', 2, 'system', '_sys_page_block_title_account_settings_delete', 11, 2147483647, 'service', 'a:4:{s:6:"module";s:6:"system";s:6:"method";s:28:"account_settings_del_account";s:6:"params";a:0:{}s:5:"class";s:19:"TemplServiceAccount";}', 0, 1, 1),
('sys_account_settings_delete', 1, 'system', '_sys_page_block_title_account_settings_menu', 13, 2147483647, 'menu', 'sys_account_settings', 0, 1, 1),

('sys_account_profile_switcher', 1, 'system', '_sys_page_block_title_account_settings_menu', 13, 2147483647, 'menu', 'sys_account_settings', 1, 1, 1),
('sys_account_profile_switcher', 2, 'system', '_sys_page_block_title_account_profile_switcher', 11, 2147483647, 'service', 'a:4:{s:6:"module";s:6:"system";s:6:"method";s:24:"account_profile_switcher";s:6:"params";a:0:{}s:5:"class";s:20:"TemplServiceProfiles";}', 0, 1, 1),

('sys_unsubscribe_notifications', 1, 'system', '_sys_page_block_title_unsubscribe_notifications', 11, 2147483647, 'service', 'a:4:{s:6:"module";s:6:"system";s:6:"method";s:25:"unsubscribe_notifications";s:6:"params";a:0:{}s:5:"class";s:19:"TemplServiceAccount";}', 0, 1, 1),

('sys_unsubscribe_news', 1, 'system', '_sys_page_block_title_unsubscribe_news', 11, 2147483647, 'service', 'a:4:{s:6:"module";s:6:"system";s:6:"method";s:16:"unsubscribe_news";s:6:"params";a:0:{}s:5:"class";s:19:"TemplServiceAccount";}', 0, 1, 1);


-- --------------------------------------------------------

--
-- Table structure for table `sys_std_pages`
--
CREATE TABLE `sys_std_pages` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `index` int(11) unsigned NOT NULL default '0',
  `name` varchar(64) NOT NULL default '',
  `header` varchar(255) NOT NULL default '',
  `caption` varchar(255) NOT NULL default '',
  `icon` varchar(255) NOT NULL default '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sys_std_widgets`
--
CREATE TABLE `sys_std_widgets` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `page_id` varchar(255) NOT NULL default '',
  `module` varchar(32) NOT NULL default '',
  `url` varchar(255) NOT NULL default '',
  `click` text NOT NULL default '',
  `icon` varchar(255) NOT NULL default '',
  `caption` varchar(255) NOT NULL default '',
  `cnt_notices` text NOT NULL default '',
  `cnt_actions` text NOT NULL default '',
  `bookmark` tinyint(4) unsigned NOT NULL default '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `widget-page` (`id`, `page_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sys_std_pages_widgets`
--
CREATE TABLE `sys_std_pages_widgets` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `page_id` int(11) unsigned NOT NULL default '0',
  `widget_id` int(11) unsigned NOT NULL default '0',
  `order` int(11) unsigned NOT NULL default '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `wid_pag` (`widget_id`, `page_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;
  

--
-- Dumping data for table `sys_std_pages`
--
INSERT INTO `sys_std_pages`(`index`, `name`, `header`, `caption`, `icon`) VALUES
(0, 'home', '_adm_page_cpt_home', '_adm_page_cpt_home', '');
SET @iIdHome = LAST_INSERT_ID();

INSERT INTO `sys_std_pages`(`index`, `name`, `header`, `caption`, `icon`) VALUES
(4, 'dashboard', '_adm_page_cpt_dashboard', '_adm_page_cpt_dashboard', 'pi-dashboard.png');
SET @iIdDashboard = LAST_INSERT_ID();

INSERT INTO `sys_std_pages`(`index`, `name`, `header`, `caption`, `icon`) VALUES
(3, 'settings', '_adm_page_cpt_settings', '_adm_page_cpt_settings', 'pi-settings.png');
SET @iIdSettings = LAST_INSERT_ID();

INSERT INTO `sys_std_pages`(`index`, `name`, `header`, `caption`, `icon`) VALUES
(3, 'store', '_adm_page_cpt_store', '_adm_page_cpt_store', 'pi-store.png');
SET @iIdStore = LAST_INSERT_ID();

INSERT INTO `sys_std_pages`(`index`, `name`, `header`, `caption`, `icon`) VALUES
(3, 'designer', '_adm_page_cpt_designer', '_adm_page_cpt_designer', 'pi-designer.png');
SET @iIdDesigner = LAST_INSERT_ID();

INSERT INTO `sys_std_pages`(`index`, `name`, `header`, `caption`, `icon`) VALUES
(3, 'polyglot', '_adm_page_cpt_polyglot', '_adm_page_cpt_polyglot', 'pi-polyglot.png');
SET @iIdPolyglot = LAST_INSERT_ID();

INSERT INTO `sys_std_pages`(`index`, `name`, `header`, `caption`, `icon`) VALUES
(3, 'builder_pages', '_adm_page_cpt_builder_pages', '_adm_page_cpt_builder_pages', 'pi-builder-pages.png');
SET @iIdBuilderPages = LAST_INSERT_ID();

INSERT INTO `sys_std_pages`(`index`, `name`, `header`, `caption`, `icon`) VALUES
(3, 'builder_menus', '_adm_page_cpt_builder_menus', '_adm_page_cpt_builder_menus', 'pi-builder-menus.png');
SET @iIdBuilderMenus = LAST_INSERT_ID();

INSERT INTO `sys_std_pages`(`index`, `name`, `header`, `caption`, `icon`) VALUES
(3, 'builder_forms', '_adm_page_cpt_builder_forms', '_adm_page_cpt_builder_forms', 'pi-builder-forms.png');
SET @iIdBuilderForms = LAST_INSERT_ID();

INSERT INTO `sys_std_pages`(`index`, `name`, `header`, `caption`, `icon`) VALUES
(3, 'builder_permissions', '_adm_page_cpt_builder_permissions', '_adm_page_cpt_builder_permissions', 'pi-builder-permissions.png');
SET @iIdBuilderPermissions = LAST_INSERT_ID();

INSERT INTO `sys_std_pages`(`index`, `name`, `header`, `caption`, `icon`) VALUES
(3, 'builder_mobile', '_adm_page_cpt_builder_mobile', '_adm_page_cpt_builder_mobile', 'pi-builder-mobile.png');
SET @iIdBuilderMobile = LAST_INSERT_ID();


--
-- Dumping data for table `sys_std_widgets` and `sys_std_pages_widgets`
-- Home Page
--
INSERT INTO `sys_std_widgets`(`page_id`, `module`, `url`, `click`, `icon`, `caption`, `cnt_notices`, `cnt_actions`) VALUES
(@iIdSettings, 'system', '{url_studio}settings.php', '', 'wi-settings.png', '_adm_wgt_cpt_settings', '', '');
INSERT INTO `sys_std_pages_widgets`(`page_id`, `widget_id`, `order`) VALUES(@iIdHome, LAST_INSERT_ID(), 1);

INSERT INTO `sys_std_widgets`(`page_id`, `module`, `url`, `click`, `icon`, `caption`, `cnt_notices`, `cnt_actions`) VALUES
(@iIdStore, 'system', '{url_studio}store.php', '', 'wi-store.png', '_adm_wgt_cpt_store', '', '');
INSERT INTO `sys_std_pages_widgets`(`page_id`, `widget_id`, `order`) VALUES(@iIdHome, LAST_INSERT_ID(), 2);

INSERT INTO `sys_std_widgets`(`page_id`, `module`, `url`, `click`, `icon`, `caption`, `cnt_notices`, `cnt_actions`) VALUES
(@iIdDashboard, 'system', '{url_studio}dashboard.php', '', 'wi-dashboard.png', '_adm_wgt_cpt_dashboard', '', '');
INSERT INTO `sys_std_pages_widgets`(`page_id`, `widget_id`, `order`) VALUES(@iIdHome, LAST_INSERT_ID(), 3);


--
-- Templates Page
--
INSERT INTO `sys_std_widgets`(`page_id`, `module`, `url`, `click`, `icon`, `caption`, `cnt_notices`, `cnt_actions`) VALUES
(@iIdDesigner, 'system', '{url_studio}designer.php', '', 'wi-templ-designer.png', '_adm_wgt_cpt_designer', '', '');
INSERT INTO `sys_std_pages_widgets`(`page_id`, `widget_id`, `order`) VALUES(@iIdHome, LAST_INSERT_ID(), 1);


--
-- Languages Page
--
INSERT INTO `sys_std_widgets`(`page_id`, `module`, `url`, `click`, `icon`, `caption`, `cnt_notices`, `cnt_actions`) VALUES
(@iIdPolyglot, 'system', '{url_studio}polyglot.php', '', 'wi-lang-polyglot.png', '_adm_wgt_cpt_polyglot', '', '');
INSERT INTO `sys_std_pages_widgets`(`page_id`, `widget_id`, `order`) VALUES(@iIdHome, LAST_INSERT_ID(), 1);


--
-- Builders Page
--
INSERT INTO `sys_std_widgets`(`page_id`, `module`, `url`, `click`, `icon`, `caption`, `cnt_notices`, `cnt_actions`) VALUES
(@iIdBuilderPages, 'system', '{url_studio}builder_page.php', '', 'wi-bld-pages.png', '_adm_wgt_cpt_builder_pages', '', '');
INSERT INTO `sys_std_pages_widgets`(`page_id`, `widget_id`, `order`) VALUES(@iIdHome, LAST_INSERT_ID(), 1);

INSERT INTO `sys_std_widgets`(`page_id`, `module`, `url`, `click`, `icon`, `caption`, `cnt_notices`, `cnt_actions`) VALUES
(@iIdBuilderMenus, 'system', '{url_studio}builder_menu.php', '', 'wi-bld-navigation.png', '_adm_wgt_cpt_builder_menus', '', '');
INSERT INTO `sys_std_pages_widgets`(`page_id`, `widget_id`, `order`) VALUES(@iIdHome, LAST_INSERT_ID(), 2);

INSERT INTO `sys_std_widgets`(`page_id`, `module`, `url`, `click`, `icon`, `caption`, `cnt_notices`, `cnt_actions`) VALUES
(@iIdBuilderForms, 'system', '{url_studio}builder_forms.php', '', 'wi-bld-forms.png', '_adm_wgt_cpt_builder_forms', '', '');
INSERT INTO `sys_std_pages_widgets`(`page_id`, `widget_id`, `order`) VALUES(@iIdHome, LAST_INSERT_ID(), 3);

INSERT INTO `sys_std_widgets`(`page_id`, `module`, `url`, `click`, `icon`, `caption`, `cnt_notices`, `cnt_actions`) VALUES
(@iIdBuilderPermissions, 'system', '{url_studio}builder_permissions.php', '', 'wi-bld-permissions.png', '_adm_wgt_cpt_builder_permissions', '', '');
INSERT INTO `sys_std_pages_widgets`(`page_id`, `widget_id`, `order`) VALUES(@iIdHome, LAST_INSERT_ID(), 4);
