
-- SETTINGS

SET @iTypeId = (SELECT `ID` FROM `sys_options_types` WHERE `name` = 'bx_notes' LIMIT 1);
SET @iCategId = (SELECT `ID` FROM `sys_options_categories` WHERE `type_id` = @iTypeId LIMIT 1);
DELETE FROM `sys_options` WHERE `category_id` = @iCategId;
DELETE FROM `sys_options_categories` WHERE `type_id` = @iTypeId;
DELETE FROM `sys_options_types` WHERE `id` = @iTypeId;

-- STORAGES & TRANSCODERS

DELETE FROM `sys_objects_storage` WHERE `object` = 'bx_notes_photos' OR `object` = 'bx_notes_photos_resized';
DELETE FROM `sys_storage_tokens` WHERE `object` = 'bx_notes_photos' OR `object` = 'bx_notes_photos_resized';

DELETE FROM `sys_objects_transcoder_images` WHERE `object` = 'bx_notes_preview';
DELETE FROM `sys_transcoder_images_files` WHERE `transcoder_object` = 'bx_notes_preview';
-- TODO: delete resized photo files as well
TRUNCATE TABLE `bx_notes_photos_resized`; 

-- PAGES

DELETE FROM `sys_objects_page` WHERE `module` = 'bx_notes';
DELETE FROM `sys_pages_blocks` WHERE `module` = 'bx_notes' OR `object` IN('bx_notes_create_note', 'bx_notes_edit_note', 'bx_notes_view_note', 'bx_notes_view_note_comments', 'bx_notes_home', 'bx_notes_featured', 'bx_notes_author');

-- MENU

DELETE FROM `sys_objects_menu` WHERE `module` = 'bx_notes';
DELETE FROM `sys_menu_sets` WHERE `module` = 'bx_notes';
DELETE FROM `sys_menu_items` WHERE `module` = 'bx_notes' OR `set_name` IN('bx_notes_view', 'bx_notes_submenu', 'bx_notes_view_submenu', 'bx_notes_my');

-- PRIVACY 

DELETE FROM `sys_objects_privacy` WHERE `object` = 'bx_notes_allow_view_to';

-- ACL

DELETE `sys_acl_actions`, `sys_acl_matrix` FROM `sys_acl_actions`, `sys_acl_matrix` WHERE `sys_acl_matrix`.`IDAction` = `sys_acl_actions`.`ID` AND `sys_acl_actions`.`Module` = 'bx_notes';
DELETE FROM `sys_acl_actions` WHERE `Module` = 'bx_notes';

-- COMMENTS
DELETE FROM `sys_objects_cmts` WHERE `Name`='bx_notes';

-- VOTES
DELETE FROM `sys_objects_vote` WHERE `Name`='bx_notes';