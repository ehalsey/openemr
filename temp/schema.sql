/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.4.5-MariaDB, for Linux (x86_64)
--
-- Host: mysql    Database: openemr
-- ------------------------------------------------------
-- Server version	11.4.5-MariaDB-ubu2404

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `addresses`
--

DROP TABLE IF EXISTS `addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `addresses` (
  `id` int(11) NOT NULL DEFAULT 0,
  `line1` varchar(255) DEFAULT NULL,
  `line2` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(35) DEFAULT NULL,
  `zip` varchar(10) DEFAULT NULL,
  `plus_four` varchar(4) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `foreign_id` int(11) DEFAULT NULL,
  `district` varchar(255) DEFAULT NULL COMMENT 'The county or district of the address',
  PRIMARY KEY (`id`),
  KEY `foreign_id` (`foreign_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `amc_misc_data`
--

DROP TABLE IF EXISTS `amc_misc_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `amc_misc_data` (
  `amc_id` varchar(31) NOT NULL DEFAULT '' COMMENT 'Unique and maps to list_options list clinical_rules',
  `pid` bigint(20) DEFAULT NULL,
  `map_category` varchar(255) NOT NULL DEFAULT '' COMMENT 'Maps to an object category (such as prescriptions etc.)',
  `map_id` bigint(20) NOT NULL DEFAULT 0 COMMENT 'Maps to an object id (such as prescription id etc.)',
  `date_created` datetime DEFAULT NULL,
  `date_completed` datetime DEFAULT NULL,
  `soc_provided` datetime DEFAULT NULL,
  KEY `amc_id` (`amc_id`,`pid`,`map_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `amendments`
--

DROP TABLE IF EXISTS `amendments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `amendments` (
  `amendment_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Amendment ID',
  `amendment_date` date NOT NULL COMMENT 'Amendement request date',
  `amendment_by` varchar(50) NOT NULL COMMENT 'Amendment requested from',
  `amendment_status` varchar(50) DEFAULT NULL COMMENT 'Amendment status accepted/rejected/null',
  `pid` bigint(20) NOT NULL COMMENT 'Patient ID from patient_data',
  `amendment_desc` text DEFAULT NULL COMMENT 'Amendment Details',
  `created_by` int(11) NOT NULL COMMENT 'references users.id for session owner',
  `modified_by` int(11) DEFAULT NULL COMMENT 'references users.id for session owner',
  `created_time` timestamp NULL DEFAULT NULL COMMENT 'created time',
  `modified_time` timestamp NULL DEFAULT NULL COMMENT 'modified time',
  PRIMARY KEY (`amendment_id`),
  KEY `amendment_pid` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `amendments_history`
--

DROP TABLE IF EXISTS `amendments_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `amendments_history` (
  `amendment_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Amendment ID',
  `amendment_note` text DEFAULT NULL COMMENT 'Amendment requested from',
  `amendment_status` varchar(50) DEFAULT NULL COMMENT 'Amendment Request Status',
  `created_by` int(11) NOT NULL COMMENT 'references users.id for session owner',
  `created_time` timestamp NULL DEFAULT NULL COMMENT 'created time',
  KEY `amendment_history_id` (`amendment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `api_log`
--

DROP TABLE IF EXISTS `api_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `log_id` int(11) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `patient_id` bigint(20) NOT NULL,
  `ip_address` varchar(255) NOT NULL,
  `method` varchar(20) NOT NULL,
  `request` varchar(255) NOT NULL,
  `request_url` text DEFAULT NULL,
  `request_body` longtext DEFAULT NULL,
  `response` longtext DEFAULT NULL,
  `created_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `api_refresh_token`
--

DROP TABLE IF EXISTS `api_refresh_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_refresh_token` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(40) DEFAULT NULL,
  `client_id` varchar(80) DEFAULT NULL,
  `token` varchar(128) NOT NULL,
  `expiry` datetime DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1=revoked,0=not revoked',
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`),
  KEY `api_refresh_token_usr_client_idx` (`client_id`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Holds information about api refresh tokens.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `api_token`
--

DROP TABLE IF EXISTS `api_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_token` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(40) DEFAULT NULL,
  `token` varchar(128) DEFAULT NULL,
  `expiry` datetime DEFAULT NULL,
  `client_id` varchar(80) DEFAULT NULL,
  `scope` text DEFAULT NULL COMMENT 'json encoded',
  `revoked` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1=revoked,0=not revoked',
  `context` text DEFAULT NULL COMMENT 'context values that change/govern how access token are used',
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ar_activity`
--

DROP TABLE IF EXISTS `ar_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ar_activity` (
  `pid` int(11) NOT NULL,
  `encounter` int(11) NOT NULL,
  `sequence_no` int(10) unsigned NOT NULL COMMENT 'Ar_activity sequence_no, incremented in code',
  `code_type` varchar(12) NOT NULL DEFAULT '',
  `code` varchar(20) NOT NULL COMMENT 'empty means claim level',
  `modifier` varchar(12) NOT NULL DEFAULT '',
  `payer_type` int(11) NOT NULL COMMENT '0=pt, 1=ins1, 2=ins2, etc',
  `post_time` datetime NOT NULL,
  `post_user` int(11) NOT NULL COMMENT 'references users.id',
  `session_id` int(10) unsigned NOT NULL COMMENT 'references ar_session.session_id',
  `memo` varchar(255) NOT NULL DEFAULT '' COMMENT 'adjustment reasons go here',
  `pay_amount` decimal(12,2) NOT NULL DEFAULT 0.00 COMMENT 'either pay or adj will always be 0',
  `adj_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `modified_time` datetime NOT NULL,
  `follow_up` char(1) NOT NULL,
  `follow_up_note` text DEFAULT NULL,
  `account_code` varchar(15) NOT NULL,
  `reason_code` varchar(255) DEFAULT NULL COMMENT 'Use as needed to show the primary payer adjustment reason code',
  `deleted` datetime DEFAULT NULL COMMENT 'NULL if active, otherwise when voided',
  `post_date` date DEFAULT NULL COMMENT 'Posting date if specified at payment time',
  `payer_claim_number` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`pid`,`encounter`,`sequence_no`),
  KEY `session_id` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ar_session`
--

DROP TABLE IF EXISTS `ar_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ar_session` (
  `session_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `payer_id` int(11) NOT NULL COMMENT '0=pt else references insurance_companies.id',
  `user_id` int(11) NOT NULL COMMENT 'references users.id for session owner',
  `closed` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0=no, 1=yes',
  `reference` varchar(255) NOT NULL DEFAULT '' COMMENT 'check or EOB number',
  `check_date` date DEFAULT NULL,
  `deposit_date` date DEFAULT NULL,
  `pay_total` decimal(12,2) NOT NULL DEFAULT 0.00,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `modified_time` datetime NOT NULL,
  `global_amount` decimal(12,2) NOT NULL,
  `payment_type` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `adjustment_code` varchar(50) NOT NULL,
  `post_to_date` date NOT NULL,
  `patient_id` bigint(20) NOT NULL,
  `payment_method` varchar(25) NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `user_closed` (`user_id`,`closed`),
  KEY `deposit_date` (`deposit_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `audit_details`
--

DROP TABLE IF EXISTS `audit_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `table_name` varchar(100) NOT NULL COMMENT 'openemr table name',
  `field_name` varchar(100) NOT NULL COMMENT 'openemr table''s field name',
  `field_value` longtext DEFAULT NULL COMMENT 'openemr table''s field value',
  `audit_master_id` bigint(20) NOT NULL COMMENT 'Id of the audit_master table',
  `entry_identification` varchar(255) NOT NULL DEFAULT '1' COMMENT 'Used when multiple entry occurs from the same table.1 means no multiple entry',
  PRIMARY KEY (`id`),
  KEY `audit_master_id` (`audit_master_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `audit_master`
--

DROP TABLE IF EXISTS `audit_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_master` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pid` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL COMMENT 'The Id of the user who approves or denies',
  `approval_status` tinyint(4) NOT NULL COMMENT '1-Pending,2-Approved,3-Denied,4-Appointment directly updated to calendar table,5-Cancelled appointment',
  `comments` text DEFAULT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `modified_time` datetime NOT NULL,
  `ip_address` varchar(100) NOT NULL,
  `type` tinyint(4) NOT NULL COMMENT '1-new patient,2-existing patient,3-change is only in the document,4-Patient upload,5-random key,10-Appointment',
  `is_qrda_document` tinyint(1) DEFAULT 0,
  `is_unstructured_document` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `automatic_notification`
--

DROP TABLE IF EXISTS `automatic_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `automatic_notification` (
  `notification_id` int(5) NOT NULL AUTO_INCREMENT,
  `sms_gateway_type` varchar(255) NOT NULL,
  `provider_name` varchar(100) NOT NULL,
  `message` text DEFAULT NULL,
  `email_sender` varchar(100) NOT NULL,
  `email_subject` varchar(100) NOT NULL,
  `type` enum('SMS','Email') NOT NULL DEFAULT 'SMS',
  PRIMARY KEY (`notification_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `background_services`
--

DROP TABLE IF EXISTS `background_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `background_services` (
  `name` varchar(31) NOT NULL,
  `title` varchar(127) NOT NULL COMMENT 'name for reports',
  `active` tinyint(1) NOT NULL DEFAULT 0,
  `running` tinyint(1) NOT NULL DEFAULT -1 COMMENT 'True indicates managed service is busy. Skip this interval',
  `next_run` timestamp NOT NULL DEFAULT current_timestamp(),
  `execute_interval` int(11) NOT NULL DEFAULT 0 COMMENT 'minimum number of minutes between function calls,0=manual mode',
  `function` varchar(127) NOT NULL COMMENT 'name of background service function',
  `require_once` varchar(255) DEFAULT NULL COMMENT 'include file (if necessary)',
  `sort_order` int(11) NOT NULL DEFAULT 100 COMMENT 'lower numbers will be run first',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `batchcom`
--

DROP TABLE IF EXISTS `batchcom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `batchcom` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `patient_id` bigint(20) NOT NULL DEFAULT 0,
  `sent_by` bigint(20) NOT NULL DEFAULT 0,
  `msg_type` varchar(60) DEFAULT NULL,
  `msg_subject` varchar(255) DEFAULT NULL,
  `msg_text` mediumtext DEFAULT NULL,
  `msg_date_sent` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `benefit_eligibility`
--

DROP TABLE IF EXISTS `benefit_eligibility`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `benefit_eligibility` (
  `response_id` bigint(20) NOT NULL,
  `verification_id` bigint(20) NOT NULL,
  `type` varchar(4) DEFAULT NULL,
  `benefit_type` varchar(255) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `coverage_level` varchar(255) DEFAULT NULL,
  `coverage_type` varchar(512) DEFAULT NULL,
  `plan_type` varchar(255) DEFAULT NULL,
  `plan_description` varchar(255) DEFAULT NULL,
  `coverage_period` varchar(255) DEFAULT NULL,
  `amount` decimal(5,2) DEFAULT NULL,
  `percent` decimal(3,2) DEFAULT NULL,
  `network_ind` varchar(2) DEFAULT NULL,
  `message` varchar(512) DEFAULT NULL,
  `response_status` enum('A','D') DEFAULT 'A',
  `response_create_date` date DEFAULT NULL,
  `response_modify_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billing`
--

DROP TABLE IF EXISTS `billing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `billing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `code_type` varchar(15) DEFAULT NULL,
  `code` varchar(20) DEFAULT NULL,
  `pid` bigint(20) DEFAULT NULL,
  `provider_id` int(11) DEFAULT NULL,
  `user` int(11) DEFAULT NULL,
  `groupname` varchar(255) DEFAULT NULL,
  `authorized` tinyint(1) DEFAULT NULL,
  `encounter` int(11) DEFAULT NULL,
  `code_text` longtext DEFAULT NULL,
  `billed` tinyint(1) DEFAULT NULL,
  `activity` tinyint(1) DEFAULT NULL,
  `payer_id` int(11) DEFAULT NULL,
  `bill_process` tinyint(2) NOT NULL DEFAULT 0,
  `bill_date` datetime DEFAULT NULL,
  `process_date` datetime DEFAULT NULL,
  `process_file` varchar(255) DEFAULT NULL,
  `modifier` varchar(12) DEFAULT NULL,
  `units` int(11) DEFAULT NULL,
  `fee` decimal(12,2) DEFAULT NULL,
  `justify` varchar(255) DEFAULT NULL,
  `target` varchar(30) DEFAULT NULL,
  `x12_partner_id` int(11) DEFAULT NULL,
  `ndc_info` varchar(255) DEFAULT NULL,
  `notecodes` varchar(25) NOT NULL DEFAULT '',
  `external_id` varchar(20) DEFAULT NULL,
  `pricelevel` varchar(31) DEFAULT '',
  `revenue_code` varchar(6) NOT NULL DEFAULT '' COMMENT 'Item revenue code',
  `chargecat` varchar(31) DEFAULT '' COMMENT 'Charge category or customer',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calendar_external`
--

DROP TABLE IF EXISTS `calendar_external`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `calendar_external` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `description` varchar(45) NOT NULL,
  `source` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `parent` int(11) NOT NULL DEFAULT 0,
  `lft` int(11) NOT NULL DEFAULT 0,
  `rght` int(11) NOT NULL DEFAULT 0,
  `aco_spec` varchar(63) NOT NULL DEFAULT 'patients|docs',
  `codes` varchar(255) NOT NULL DEFAULT '' COMMENT 'Category codes for documents stored in this category',
  PRIMARY KEY (`id`),
  KEY `parent` (`parent`),
  KEY `lft` (`lft`,`rght`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categories_seq`
--

DROP TABLE IF EXISTS `categories_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories_seq` (
  `id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categories_to_documents`
--

DROP TABLE IF EXISTS `categories_to_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories_to_documents` (
  `category_id` int(11) NOT NULL DEFAULT 0,
  `document_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`category_id`,`document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ccda`
--

DROP TABLE IF EXISTS `ccda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ccda` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` binary(16) DEFAULT NULL,
  `pid` bigint(20) DEFAULT NULL,
  `encounter` bigint(20) DEFAULT NULL,
  `ccda_data` longtext DEFAULT NULL,
  `time` varchar(50) DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL,
  `updated_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `user_id` varchar(50) DEFAULT NULL,
  `couch_docid` varchar(100) DEFAULT NULL,
  `couch_revid` varchar(100) DEFAULT NULL,
  `hash` varchar(255) DEFAULT NULL,
  `view` tinyint(4) NOT NULL DEFAULT 0,
  `transfer` tinyint(4) NOT NULL DEFAULT 0,
  `emr_transfer` tinyint(4) NOT NULL DEFAULT 0,
  `encrypted` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0->No,1->Yes',
  `transaction_id` bigint(20) DEFAULT NULL COMMENT 'fk to transaction referral record',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `unique_key` (`pid`,`encounter`,`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ccda_components`
--

DROP TABLE IF EXISTS `ccda_components`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ccda_components` (
  `ccda_components_id` int(11) NOT NULL AUTO_INCREMENT,
  `ccda_components_field` varchar(100) DEFAULT NULL,
  `ccda_components_name` varchar(100) DEFAULT NULL,
  `ccda_type` int(11) NOT NULL COMMENT '0=>sections,1=>components',
  PRIMARY KEY (`ccda_components_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ccda_field_mapping`
--

DROP TABLE IF EXISTS `ccda_field_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ccda_field_mapping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `table_id` int(11) DEFAULT NULL,
  `ccda_field` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ccda_sections`
--

DROP TABLE IF EXISTS `ccda_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ccda_sections` (
  `ccda_sections_id` int(11) NOT NULL AUTO_INCREMENT,
  `ccda_components_id` int(11) DEFAULT NULL,
  `ccda_sections_field` varchar(100) DEFAULT NULL,
  `ccda_sections_name` varchar(100) DEFAULT NULL,
  `ccda_sections_req_mapping` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`ccda_sections_id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ccda_table_mapping`
--

DROP TABLE IF EXISTS `ccda_table_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ccda_table_mapping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ccda_component` varchar(100) DEFAULT NULL,
  `ccda_component_section` varchar(100) DEFAULT NULL,
  `form_dir` varchar(100) DEFAULT NULL,
  `form_type` smallint(6) DEFAULT NULL,
  `form_table` varchar(100) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `deleted` tinyint(4) NOT NULL DEFAULT 0,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chart_tracker`
--

DROP TABLE IF EXISTS `chart_tracker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `chart_tracker` (
  `ct_pid` int(11) NOT NULL,
  `ct_when` datetime NOT NULL,
  `ct_userid` bigint(20) NOT NULL DEFAULT 0,
  `ct_location` varchar(31) NOT NULL DEFAULT '',
  PRIMARY KEY (`ct_pid`,`ct_when`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `claims`
--

DROP TABLE IF EXISTS `claims`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `claims` (
  `patient_id` bigint(20) NOT NULL,
  `encounter_id` int(11) NOT NULL,
  `version` int(10) unsigned NOT NULL COMMENT 'Claim version, incremented in code',
  `payer_id` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(2) NOT NULL DEFAULT 0,
  `payer_type` tinyint(4) NOT NULL DEFAULT 0,
  `bill_process` tinyint(2) NOT NULL DEFAULT 0,
  `bill_time` datetime DEFAULT NULL,
  `process_time` datetime DEFAULT NULL,
  `process_file` varchar(255) DEFAULT NULL,
  `target` varchar(30) DEFAULT NULL,
  `x12_partner_id` int(11) NOT NULL DEFAULT 0,
  `submitted_claim` text DEFAULT NULL COMMENT 'This claims form claim data',
  PRIMARY KEY (`patient_id`,`encounter_id`,`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clinical_plans`
--

DROP TABLE IF EXISTS `clinical_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `clinical_plans` (
  `id` varchar(31) NOT NULL DEFAULT '' COMMENT 'Unique and maps to list_options list clinical_plans',
  `pid` bigint(20) NOT NULL DEFAULT 0 COMMENT '0 is default for all patients, while > 0 is id from patient_data table',
  `normal_flag` tinyint(1) DEFAULT NULL COMMENT 'Normal Activation Flag',
  `cqm_flag` tinyint(1) DEFAULT NULL COMMENT 'Clinical Quality Measure flag (unable to customize per patient)',
  `cqm_2011_flag` tinyint(1) DEFAULT NULL COMMENT '2011 Clinical Quality Measure flag (unable to customize per patient)',
  `cqm_2014_flag` tinyint(1) DEFAULT NULL COMMENT '2014 Clinical Quality Measure flag (unable to customize per patient)',
  `cqm_measure_group` varchar(10) NOT NULL DEFAULT '' COMMENT 'Clinical Quality Measure Group Identifier',
  PRIMARY KEY (`id`,`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clinical_plans_rules`
--

DROP TABLE IF EXISTS `clinical_plans_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `clinical_plans_rules` (
  `plan_id` varchar(31) NOT NULL DEFAULT '' COMMENT 'Unique and maps to list_options list clinical_plans',
  `rule_id` varchar(31) NOT NULL DEFAULT '' COMMENT 'Unique and maps to list_options list clinical_rules',
  PRIMARY KEY (`plan_id`,`rule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clinical_rules`
--

DROP TABLE IF EXISTS `clinical_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `clinical_rules` (
  `id` varchar(31) NOT NULL DEFAULT '' COMMENT 'Unique and maps to list_options list clinical_rules',
  `pid` bigint(20) NOT NULL DEFAULT 0 COMMENT '0 is default for all patients, while > 0 is id from patient_data table',
  `active_alert_flag` tinyint(1) DEFAULT NULL COMMENT 'Active Alert Widget Module flag - note not yet utilized',
  `passive_alert_flag` tinyint(1) DEFAULT NULL COMMENT 'Passive Alert Widget Module flag',
  `cqm_flag` tinyint(1) DEFAULT NULL COMMENT 'Clinical Quality Measure flag (unable to customize per patient)',
  `cqm_2011_flag` tinyint(1) DEFAULT NULL COMMENT '2011 Clinical Quality Measure flag (unable to customize per patient)',
  `cqm_2014_flag` tinyint(1) DEFAULT NULL COMMENT '2014 Clinical Quality Measure flag (unable to customize per patient)',
  `cqm_nqf_code` varchar(10) NOT NULL DEFAULT '' COMMENT 'Clinical Quality Measure NQF identifier',
  `cqm_pqri_code` varchar(10) NOT NULL DEFAULT '' COMMENT 'Clinical Quality Measure PQRI identifier',
  `amc_flag` tinyint(1) DEFAULT NULL COMMENT 'Automated Measure Calculation flag (unable to customize per patient)',
  `amc_2011_flag` tinyint(1) DEFAULT NULL COMMENT '2011 Automated Measure Calculation flag for (unable to customize per patient)',
  `amc_2014_flag` tinyint(1) DEFAULT NULL COMMENT '2014 Automated Measure Calculation flag for (unable to customize per patient)',
  `amc_2015_flag` tinyint(1) DEFAULT NULL COMMENT '2015 Automated Measure Calculation flag for (unable to customize per patient)',
  `amc_code` varchar(10) NOT NULL DEFAULT '' COMMENT 'Automated Measure Calculation identifier (MU rule)',
  `amc_code_2014` varchar(30) NOT NULL DEFAULT '' COMMENT 'Automated Measure Calculation 2014 identifier (MU rule)',
  `amc_code_2015` varchar(30) NOT NULL DEFAULT '' COMMENT 'Automated Measure Calculation 2014 identifier (MU rule)',
  `amc_2014_stage1_flag` tinyint(1) DEFAULT NULL COMMENT '2014 Stage 1 - Automated Measure Calculation flag for (unable to customize per patient)',
  `amc_2014_stage2_flag` tinyint(1) DEFAULT NULL COMMENT '2014 Stage 2 - Automated Measure Calculation flag for (unable to customize per patient)',
  `patient_reminder_flag` tinyint(1) DEFAULT NULL COMMENT 'Clinical Reminder Module flag',
  `bibliographic_citation` varchar(255) NOT NULL DEFAULT '',
  `developer` varchar(255) NOT NULL DEFAULT '' COMMENT 'Clinical Rule Developer',
  `funding_source` varchar(255) NOT NULL DEFAULT '' COMMENT 'Clinical Rule Funding Source',
  `release_version` varchar(255) NOT NULL DEFAULT '' COMMENT 'Clinical Rule Release Version',
  `web_reference` varchar(255) NOT NULL DEFAULT '' COMMENT 'Clinical Rule Web Reference',
  `linked_referential_cds` varchar(50) NOT NULL DEFAULT '',
  `access_control` varchar(255) NOT NULL DEFAULT 'patients:med' COMMENT 'ACO link for access control',
  `patient_dob_usage` text DEFAULT NULL COMMENT 'Description of how patient DOB is used by this rule',
  `patient_ethnicity_usage` text DEFAULT NULL COMMENT 'Description of how patient ethnicity is used by this rule',
  `patient_health_status_usage` text DEFAULT NULL COMMENT 'Description of how patient health status assessments are used by this rule',
  `patient_gender_identity_usage` text DEFAULT NULL COMMENT 'Description of how patient gender identity information is used by this rule',
  `patient_language_usage` text DEFAULT NULL COMMENT 'Description of how patient language information is used by this rule',
  `patient_race_usage` text DEFAULT NULL COMMENT 'Description of how patient race information is used by this rule',
  `patient_sex_usage` text DEFAULT NULL COMMENT 'Description of how patient birth sex information is used by this rule',
  `patient_sexual_orientation_usage` text DEFAULT NULL COMMENT 'Description of how patient sexual orientation is used by this rule',
  `patient_sodh_usage` text DEFAULT NULL COMMENT 'Description of how patient social determinants of health are used by this rule',
  PRIMARY KEY (`id`,`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clinical_rules_log`
--

DROP TABLE IF EXISTS `clinical_rules_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `clinical_rules_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `pid` bigint(20) NOT NULL DEFAULT 0,
  `uid` bigint(20) NOT NULL DEFAULT 0,
  `category` varchar(255) NOT NULL DEFAULT '' COMMENT 'An example category is clinical_reminder_widget',
  `value` text DEFAULT NULL,
  `new_value` text DEFAULT NULL,
  `facility_id` int(11) DEFAULT 0 COMMENT 'facility where the rule was executed, 0 if unknown',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`),
  KEY `uid` (`uid`),
  KEY `category` (`category`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `code_types`
--

DROP TABLE IF EXISTS `code_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `code_types` (
  `ct_key` varchar(15) NOT NULL COMMENT 'short alphanumeric name',
  `ct_id` int(11) NOT NULL COMMENT 'numeric identifier',
  `ct_seq` int(11) NOT NULL DEFAULT 0 COMMENT 'sort order',
  `ct_mod` int(11) NOT NULL DEFAULT 0 COMMENT 'length of modifier field',
  `ct_just` varchar(15) NOT NULL DEFAULT '' COMMENT 'ct_key of justify type, if any',
  `ct_mask` varchar(9) NOT NULL DEFAULT '' COMMENT 'formatting mask for code values',
  `ct_fee` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 if fees are used',
  `ct_rel` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 if can relate to other code types',
  `ct_nofs` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 if to be hidden in the fee sheet',
  `ct_diag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 if this is a diagnosis type',
  `ct_active` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 if this is active',
  `ct_label` varchar(31) NOT NULL DEFAULT '' COMMENT 'label of this code type',
  `ct_external` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 if stored codes in codes tables, 1 or greater if codes stored in external tables',
  `ct_claim` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 if this is used in claims',
  `ct_proc` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 if this is a procedure type',
  `ct_term` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 if this is a clinical term',
  `ct_problem` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 if this code type is used as a medical problem',
  `ct_drug` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 if this code type is used as a medication',
  PRIMARY KEY (`ct_key`),
  UNIQUE KEY `ct_id` (`ct_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `codes`
--

DROP TABLE IF EXISTS `codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `codes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code_text` text DEFAULT NULL,
  `code_text_short` text DEFAULT NULL,
  `code` varchar(25) NOT NULL DEFAULT '',
  `code_type` smallint(6) DEFAULT NULL,
  `modifier` varchar(12) NOT NULL DEFAULT '',
  `units` int(11) DEFAULT NULL,
  `fee` decimal(12,2) DEFAULT NULL,
  `superbill` varchar(31) NOT NULL DEFAULT '',
  `related_code` varchar(255) NOT NULL DEFAULT '',
  `taxrates` varchar(255) NOT NULL DEFAULT '',
  `cyp_factor` float NOT NULL DEFAULT 0 COMMENT 'quantity representing a years supply',
  `active` tinyint(1) DEFAULT 1 COMMENT '0 = inactive, 1 = active',
  `reportable` tinyint(1) DEFAULT 0 COMMENT '0 = non-reportable, 1 = reportable',
  `financial_reporting` tinyint(1) DEFAULT 0 COMMENT '0 = negative, 1 = considered important code in financial reporting',
  `revenue_code` varchar(6) NOT NULL DEFAULT '' COMMENT 'Item revenue code',
  PRIMARY KEY (`id`),
  KEY `code` (`code`),
  KEY `code_type` (`code_type`)
) ENGINE=InnoDB AUTO_INCREMENT=247 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `codes_history`
--

DROP TABLE IF EXISTS `codes_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `codes_history` (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `code` varchar(25) DEFAULT NULL,
  `modifier` varchar(12) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `diagnosis_reporting` tinyint(1) DEFAULT NULL,
  `financial_reporting` tinyint(1) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `code_type_name` varchar(255) DEFAULT NULL,
  `code_text` text DEFAULT NULL,
  `code_text_short` text DEFAULT NULL,
  `prices` text DEFAULT NULL,
  `action_type` varchar(25) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contact`
--

DROP TABLE IF EXISTS `contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `foreign_table_name` varchar(255) NOT NULL DEFAULT '',
  `foreign_id` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `foreign_id` (`foreign_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contact_address`
--

DROP TABLE IF EXISTS `contact_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact_address` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `contact_id` bigint(20) NOT NULL,
  `address_id` bigint(20) NOT NULL,
  `priority` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL COMMENT 'FK to list_options.option_id for list_id address-types',
  `use` varchar(255) DEFAULT NULL COMMENT 'FK to list_options.option_id for list_id address-uses',
  `notes` tinytext DEFAULT NULL,
  `status` char(1) DEFAULT NULL COMMENT 'A=active,I=inactive',
  `is_primary` char(1) DEFAULT NULL COMMENT 'Y=yes,N=no',
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `period_start` datetime DEFAULT NULL COMMENT 'Date the address became active',
  `period_end` datetime DEFAULT NULL COMMENT 'Date the address became deactivated',
  `inactivated_reason` varchar(45) DEFAULT NULL COMMENT '[Values: Moved, Mail Returned, etc]',
  PRIMARY KEY (`id`),
  KEY `contact_id` (`contact_id`),
  KEY `address_id` (`address_id`),
  KEY `contact_address_idx` (`contact_id`,`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customlists`
--

DROP TABLE IF EXISTS `customlists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `customlists` (
  `cl_list_slno` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cl_list_id` int(10) unsigned NOT NULL COMMENT 'ID OF THE lIST FOR NEW TAKE SELECT MAX(cl_list_id)+1',
  `cl_list_item_id` int(10) unsigned DEFAULT NULL COMMENT 'ID OF THE lIST FOR NEW TAKE SELECT MAX(cl_list_item_id)+1',
  `cl_list_type` int(10) unsigned NOT NULL COMMENT '0=>List Name 1=>list items 2=>Context 3=>Template 4=>Sentence 5=> SavedTemplate 6=>CustomButton',
  `cl_list_item_short` varchar(10) DEFAULT NULL,
  `cl_list_item_long` text DEFAULT NULL,
  `cl_list_item_level` int(11) DEFAULT NULL COMMENT 'Flow level for List Designation',
  `cl_order` int(11) DEFAULT NULL,
  `cl_deleted` tinyint(1) DEFAULT 0,
  `cl_creator` int(11) DEFAULT NULL,
  PRIMARY KEY (`cl_list_slno`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dated_reminders`
--

DROP TABLE IF EXISTS `dated_reminders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dated_reminders` (
  `dr_id` int(11) NOT NULL AUTO_INCREMENT,
  `dr_from_ID` int(11) NOT NULL,
  `dr_message_text` varchar(160) NOT NULL,
  `dr_message_sent_date` datetime NOT NULL,
  `dr_message_due_date` date NOT NULL,
  `pid` bigint(20) NOT NULL,
  `message_priority` tinyint(1) NOT NULL,
  `message_processed` tinyint(1) NOT NULL DEFAULT 0,
  `processed_date` timestamp NULL DEFAULT NULL,
  `dr_processed_by` int(11) NOT NULL,
  PRIMARY KEY (`dr_id`),
  KEY `dr_from_ID` (`dr_from_ID`,`dr_message_due_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dated_reminders_link`
--

DROP TABLE IF EXISTS `dated_reminders_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dated_reminders_link` (
  `dr_link_id` int(11) NOT NULL AUTO_INCREMENT,
  `dr_id` int(11) NOT NULL,
  `to_id` int(11) NOT NULL,
  PRIMARY KEY (`dr_link_id`),
  KEY `to_id` (`to_id`),
  KEY `dr_id` (`dr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `direct_message_log`
--

DROP TABLE IF EXISTS `direct_message_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `direct_message_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `msg_type` char(1) NOT NULL COMMENT 'S=sent,R=received',
  `msg_id` varchar(127) NOT NULL,
  `sender` varchar(255) NOT NULL,
  `recipient` varchar(255) NOT NULL,
  `create_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` char(1) NOT NULL COMMENT 'Q=queued,D=dispatched,R=received,F=failed',
  `status_info` varchar(511) DEFAULT NULL,
  `status_ts` timestamp NULL DEFAULT NULL,
  `patient_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `msg_id` (`msg_id`),
  KEY `patient_id` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_template_profiles`
--

DROP TABLE IF EXISTS `document_template_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `document_template_profiles` (
  `id` bigint(21) unsigned NOT NULL AUTO_INCREMENT,
  `template_id` bigint(21) unsigned NOT NULL,
  `profile` varchar(64) NOT NULL,
  `template_name` varchar(255) NOT NULL,
  `category` varchar(64) NOT NULL,
  `provider` int(11) unsigned DEFAULT NULL,
  `modified_date` datetime NOT NULL DEFAULT current_timestamp(),
  `member_of` varchar(64) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 0,
  `recurring` tinyint(1) NOT NULL DEFAULT 1,
  `event_trigger` varchar(31) NOT NULL,
  `period` int(4) NOT NULL,
  `notify_trigger` varchar(31) NOT NULL,
  `notify_period` int(4) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `location` (`profile`,`template_id`,`member_of`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_templates`
--

DROP TABLE IF EXISTS `document_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `document_templates` (
  `id` bigint(21) unsigned NOT NULL AUTO_INCREMENT,
  `pid` bigint(20) DEFAULT NULL,
  `provider` int(11) unsigned DEFAULT NULL,
  `encounter` int(11) unsigned DEFAULT NULL,
  `modified_date` datetime NOT NULL DEFAULT current_timestamp(),
  `profile` varchar(63) NOT NULL,
  `category` varchar(63) NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  `template_name` varchar(255) DEFAULT NULL,
  `status` varchar(31) DEFAULT NULL,
  `send_date` datetime NOT NULL DEFAULT current_timestamp(),
  `end_date` datetime DEFAULT NULL,
  `size` int(11) NOT NULL DEFAULT 0,
  `template_content` mediumblob DEFAULT NULL,
  `mime` varchar(31) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `location` (`pid`,`profile`,`category`,`template_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `documents`
--

DROP TABLE IF EXISTS `documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `documents` (
  `id` int(11) NOT NULL DEFAULT 0,
  `uuid` binary(16) DEFAULT NULL,
  `type` enum('file_url','blob','web_url') DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `date_expires` datetime DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `thumb_url` varchar(255) DEFAULT NULL,
  `mimetype` varchar(255) DEFAULT NULL,
  `pages` int(11) DEFAULT NULL,
  `owner` int(11) DEFAULT NULL,
  `revision` timestamp NOT NULL,
  `foreign_id` bigint(20) DEFAULT NULL,
  `docdate` date DEFAULT NULL,
  `hash` varchar(255) DEFAULT NULL,
  `list_id` bigint(20) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `drive_uuid` binary(16) DEFAULT NULL,
  `couch_docid` varchar(100) DEFAULT NULL,
  `couch_revid` varchar(100) DEFAULT NULL,
  `storagemethod` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0->Harddisk,1->CouchDB',
  `path_depth` tinyint(4) DEFAULT 1 COMMENT 'Depth of path to use in url to find document. Not applicable for CouchDB.',
  `imported` tinyint(4) DEFAULT 0 COMMENT 'Parsing status for CCR/CCD/CCDA importing',
  `encounter_id` bigint(20) NOT NULL DEFAULT 0 COMMENT 'Encounter id if tagged',
  `encounter_check` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'If encounter is created while tagging',
  `audit_master_approval_status` tinyint(4) NOT NULL DEFAULT 1 COMMENT 'approval_status from audit_master table',
  `audit_master_id` int(11) DEFAULT NULL,
  `documentationOf` varchar(255) DEFAULT NULL,
  `encrypted` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0->No,1->Yes',
  `document_data` mediumtext DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `foreign_reference_id` bigint(20) DEFAULT NULL,
  `foreign_reference_table` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `drive_uuid` (`drive_uuid`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `revision` (`revision`),
  KEY `foreign_id` (`foreign_id`),
  KEY `foreign_reference` (`foreign_reference_id`,`foreign_reference_table`),
  KEY `owner` (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `documents_legal_categories`
--

DROP TABLE IF EXISTS `documents_legal_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `documents_legal_categories` (
  `dlc_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dlc_category_type` int(10) unsigned NOT NULL COMMENT '1 category 2 subcategory',
  `dlc_category_name` varchar(45) NOT NULL,
  `dlc_category_parent` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`dlc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `documents_legal_detail`
--

DROP TABLE IF EXISTS `documents_legal_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `documents_legal_detail` (
  `dld_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dld_pid` int(10) unsigned DEFAULT NULL,
  `dld_facility` int(10) unsigned DEFAULT NULL,
  `dld_provider` int(10) unsigned DEFAULT NULL,
  `dld_encounter` int(10) unsigned DEFAULT NULL,
  `dld_master_docid` int(10) unsigned NOT NULL,
  `dld_signed` smallint(5) unsigned NOT NULL COMMENT '0-Not Signed or Cannot Sign(Layout),1-Signed,2-Ready to sign,3-Denied(Pat Regi),4-Patient Upload,10-Save(Layout)',
  `dld_signed_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `dld_filepath` varchar(75) DEFAULT NULL,
  `dld_filename` varchar(45) NOT NULL,
  `dld_signing_person` varchar(50) NOT NULL,
  `dld_sign_level` int(11) NOT NULL COMMENT 'Sign flow level',
  `dld_content` varchar(50) NOT NULL COMMENT 'Layout sign position',
  `dld_file_for_pdf_generation` blob NOT NULL COMMENT 'The filled details in the fdf file is stored here.Patient Registration Screen',
  `dld_denial_reason` longtext DEFAULT NULL,
  `dld_moved` tinyint(4) NOT NULL DEFAULT 0,
  `dld_patient_comments` text DEFAULT NULL COMMENT 'Patient comments stored here',
  PRIMARY KEY (`dld_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `documents_legal_master`
--

DROP TABLE IF EXISTS `documents_legal_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `documents_legal_master` (
  `dlm_category` int(10) unsigned DEFAULT NULL,
  `dlm_subcategory` int(10) unsigned DEFAULT NULL,
  `dlm_document_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dlm_document_name` varchar(75) NOT NULL,
  `dlm_filepath` varchar(75) NOT NULL,
  `dlm_facility` int(10) unsigned DEFAULT NULL,
  `dlm_provider` int(10) unsigned DEFAULT NULL,
  `dlm_sign_height` double NOT NULL,
  `dlm_sign_width` double NOT NULL,
  `dlm_filename` varchar(45) NOT NULL,
  `dlm_effective_date` datetime NOT NULL,
  `dlm_version` int(10) unsigned NOT NULL,
  `content` varchar(255) NOT NULL,
  `dlm_savedsign` varchar(255) DEFAULT NULL COMMENT '0-Yes 1-No',
  `dlm_review` varchar(255) DEFAULT NULL COMMENT '0-Yes 1-No',
  `dlm_upload_type` tinyint(4) DEFAULT 0 COMMENT '0-Provider Uploaded,1-Patient Uploaded',
  PRIMARY KEY (`dlm_document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='List of Master Docs to be signed';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `drug_inventory`
--

DROP TABLE IF EXISTS `drug_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `drug_inventory` (
  `inventory_id` int(11) NOT NULL AUTO_INCREMENT,
  `drug_id` int(11) NOT NULL,
  `lot_number` varchar(20) DEFAULT NULL,
  `expiration` date DEFAULT NULL,
  `manufacturer` varchar(255) DEFAULT NULL,
  `on_hand` int(11) NOT NULL DEFAULT 0,
  `warehouse_id` varchar(31) NOT NULL DEFAULT '',
  `vendor_id` bigint(20) NOT NULL DEFAULT 0,
  `last_notify` date DEFAULT NULL,
  `destroy_date` date DEFAULT NULL,
  `destroy_method` varchar(255) DEFAULT NULL,
  `destroy_witness` varchar(255) DEFAULT NULL,
  `destroy_notes` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`inventory_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `drug_sales`
--

DROP TABLE IF EXISTS `drug_sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `drug_sales` (
  `sale_id` int(11) NOT NULL AUTO_INCREMENT,
  `drug_id` int(11) NOT NULL,
  `inventory_id` int(11) NOT NULL,
  `prescription_id` int(11) NOT NULL DEFAULT 0,
  `pid` bigint(20) NOT NULL DEFAULT 0,
  `encounter` int(11) NOT NULL DEFAULT 0,
  `user` varchar(255) DEFAULT NULL,
  `sale_date` date NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 0,
  `fee` decimal(12,2) NOT NULL DEFAULT 0.00,
  `billed` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'indicates if the sale is posted to accounting',
  `xfer_inventory_id` int(11) NOT NULL DEFAULT 0,
  `distributor_id` bigint(20) NOT NULL DEFAULT 0 COMMENT 'references users.id',
  `notes` varchar(255) NOT NULL DEFAULT '',
  `bill_date` datetime DEFAULT NULL,
  `pricelevel` varchar(31) DEFAULT '',
  `selector` varchar(255) DEFAULT '' COMMENT 'references drug_templates.selector',
  `trans_type` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1=sale, 2=purchase, 3=return, 4=transfer, 5=adjustment',
  `chargecat` varchar(31) DEFAULT '',
  PRIMARY KEY (`sale_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `drug_templates`
--

DROP TABLE IF EXISTS `drug_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `drug_templates` (
  `drug_id` int(11) NOT NULL,
  `selector` varchar(255) NOT NULL DEFAULT '',
  `dosage` varchar(10) DEFAULT NULL,
  `period` int(11) NOT NULL DEFAULT 0,
  `quantity` int(11) NOT NULL DEFAULT 0,
  `refills` int(11) NOT NULL DEFAULT 0,
  `taxrates` varchar(255) DEFAULT NULL,
  `pkgqty` float NOT NULL DEFAULT 1 COMMENT 'Number of product items per template item',
  PRIMARY KEY (`drug_id`,`selector`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `drugs`
--

DROP TABLE IF EXISTS `drugs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `drugs` (
  `drug_id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` binary(16) DEFAULT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `ndc_number` varchar(20) NOT NULL DEFAULT '',
  `on_order` int(11) NOT NULL DEFAULT 0,
  `reorder_point` float NOT NULL DEFAULT 0,
  `max_level` float NOT NULL DEFAULT 0,
  `last_notify` date DEFAULT NULL,
  `reactions` text DEFAULT NULL,
  `form` varchar(31) NOT NULL DEFAULT '0',
  `size` varchar(25) NOT NULL DEFAULT '',
  `unit` varchar(31) NOT NULL DEFAULT '0',
  `route` varchar(31) NOT NULL DEFAULT '0',
  `substitute` int(11) NOT NULL DEFAULT 0,
  `related_code` varchar(255) NOT NULL DEFAULT '' COMMENT 'may reference a related codes.code',
  `cyp_factor` float NOT NULL DEFAULT 0 COMMENT 'quantity representing a years supply',
  `active` tinyint(1) DEFAULT 1 COMMENT '0 = inactive, 1 = active',
  `allow_combining` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 = allow filling an order from multiple lots',
  `allow_multiple` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 = allow multiple lots at one warehouse',
  `drug_code` varchar(25) DEFAULT NULL,
  `consumable` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 = will not show on the fee sheet',
  `dispensable` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0 = pharmacy elsewhere, 1 = dispensed here',
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `last_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`drug_id`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dsi_source_attributes`
--

DROP TABLE IF EXISTS `dsi_source_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dsi_source_attributes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` varchar(80) NOT NULL,
  `list_id` varchar(100) NOT NULL,
  `option_id` varchar(100) NOT NULL,
  `clinical_rule_id` varchar(31) DEFAULT NULL,
  `source_value` text DEFAULT NULL,
  `created_by` bigint(20) DEFAULT NULL,
  `last_updated_by` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `last_updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `list_id` (`list_id`,`option_id`,`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Holds information about decission support intervention system source attributes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `edi_sequences`
--

DROP TABLE IF EXISTS `edi_sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `edi_sequences` (
  `id` int(9) unsigned NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `eligibility_verification`
--

DROP TABLE IF EXISTS `eligibility_verification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `eligibility_verification` (
  `verification_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `response_id` varchar(32) DEFAULT NULL,
  `insurance_id` bigint(20) DEFAULT NULL,
  `eligibility_check_date` datetime DEFAULT NULL,
  `copay` int(11) DEFAULT NULL,
  `deductible` int(11) DEFAULT NULL,
  `deductiblemet` enum('Y','N') DEFAULT 'Y',
  `create_date` date DEFAULT NULL,
  PRIMARY KEY (`verification_id`),
  KEY `insurance_id` (`insurance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `email_queue`
--

DROP TABLE IF EXISTS `email_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_queue` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sender` varchar(255) DEFAULT '',
  `recipient` varchar(255) DEFAULT '',
  `subject` varchar(255) DEFAULT '',
  `body` text DEFAULT NULL,
  `datetime_queued` datetime DEFAULT NULL,
  `sent` tinyint(4) DEFAULT 0,
  `datetime_sent` datetime DEFAULT NULL,
  `error` tinyint(4) DEFAULT 0,
  `error_message` text DEFAULT NULL,
  `datetime_error` datetime DEFAULT NULL,
  `template_name` varchar(255) DEFAULT NULL COMMENT 'The folder prefix and base filename (w/o extension) of the twig template file to use for this email',
  PRIMARY KEY (`id`),
  KEY `sent` (`sent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `employer_data`
--

DROP TABLE IF EXISTS `employer_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `employer_data` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `street_line_2` tinytext DEFAULT NULL,
  `postal_code` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `pid` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `enc_category_map`
--

DROP TABLE IF EXISTS `enc_category_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `enc_category_map` (
  `rule_enc_id` varchar(31) NOT NULL DEFAULT '' COMMENT 'encounter id from rule_enc_types list in list_options',
  `main_cat_id` int(11) NOT NULL DEFAULT 0 COMMENT 'category id from event category in openemr_postcalendar_categories',
  KEY `rule_enc_id` (`rule_enc_id`,`main_cat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `erx_narcotics`
--

DROP TABLE IF EXISTS `erx_narcotics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `erx_narcotics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `drug` varchar(255) NOT NULL,
  `dea_number` varchar(5) NOT NULL,
  `csa_sch` varchar(2) NOT NULL,
  `narc` varchar(2) NOT NULL,
  `other_names` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `erx_rx_log`
--

DROP TABLE IF EXISTS `erx_rx_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `erx_rx_log` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `prescription_id` int(6) NOT NULL,
  `date` varchar(25) NOT NULL,
  `time` varchar(15) NOT NULL,
  `code` int(6) NOT NULL,
  `status` text DEFAULT NULL,
  `message_id` varchar(100) DEFAULT NULL,
  `read` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `erx_ttl_touch`
--

DROP TABLE IF EXISTS `erx_ttl_touch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `erx_ttl_touch` (
  `patient_id` bigint(20) unsigned NOT NULL COMMENT 'Patient record Id',
  `process` enum('allergies','medications') NOT NULL COMMENT 'NewCrop eRx SOAP process',
  `updated` datetime NOT NULL COMMENT 'Date and time of last process update for patient',
  PRIMARY KEY (`patient_id`,`process`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Store records last update per patient data process';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `esign_signatures`
--

DROP TABLE IF EXISTS `esign_signatures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `esign_signatures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tid` int(11) NOT NULL COMMENT 'Table row ID for signature',
  `table` varchar(255) NOT NULL COMMENT 'table name for the signature',
  `uid` int(11) NOT NULL COMMENT 'user id for the signing user',
  `datetime` datetime NOT NULL COMMENT 'datetime of the signature action',
  `is_lock` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'sig, lock or amendment',
  `amendment` text DEFAULT NULL COMMENT 'amendment text, if any',
  `hash` varchar(255) NOT NULL COMMENT 'hash of signed data',
  `signature_hash` varchar(255) NOT NULL COMMENT 'hash of signature itself',
  PRIMARY KEY (`id`),
  KEY `tid` (`tid`),
  KEY `table` (`table`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `export_job`
--

DROP TABLE IF EXISTS `export_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `export_job` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uuid` binary(16) DEFAULT NULL,
  `user_id` varchar(40) NOT NULL,
  `client_id` varchar(80) NOT NULL,
  `status` varchar(40) NOT NULL,
  `start_time` datetime DEFAULT NULL,
  `resource_include_time` datetime DEFAULT NULL,
  `output_format` varchar(128) NOT NULL,
  `request_uri` varchar(128) NOT NULL,
  `resources` text DEFAULT NULL,
  `output` text DEFAULT NULL,
  `errors` text DEFAULT NULL,
  `access_token_id` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='fhir export jobs';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `extended_log`
--

DROP TABLE IF EXISTS `extended_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `extended_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `event` varchar(255) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `recipient` varchar(255) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `patient_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `external_encounters`
--

DROP TABLE IF EXISTS `external_encounters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `external_encounters` (
  `ee_id` int(11) NOT NULL AUTO_INCREMENT,
  `ee_date` date DEFAULT NULL,
  `ee_pid` int(11) DEFAULT NULL,
  `ee_provider_id` varchar(255) DEFAULT NULL,
  `ee_facility_id` varchar(255) DEFAULT NULL,
  `ee_encounter_diagnosis` varchar(255) DEFAULT NULL,
  `ee_external_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `external_procedures`
--

DROP TABLE IF EXISTS `external_procedures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `external_procedures` (
  `ep_id` int(11) NOT NULL AUTO_INCREMENT,
  `ep_date` date DEFAULT NULL,
  `ep_code_type` varchar(20) DEFAULT NULL,
  `ep_code` varchar(9) DEFAULT NULL,
  `ep_pid` int(11) DEFAULT NULL,
  `ep_encounter` int(11) DEFAULT NULL,
  `ep_code_text` longtext DEFAULT NULL,
  `ep_facility_id` varchar(255) DEFAULT NULL,
  `ep_external_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ep_id`),
  KEY `ep_pid` (`ep_pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `facility`
--

DROP TABLE IF EXISTS `facility`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `facility` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` binary(16) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `fax` varchar(30) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `postal_code` varchar(11) DEFAULT NULL,
  `country_code` varchar(30) NOT NULL DEFAULT '',
  `federal_ein` varchar(15) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `service_location` tinyint(1) NOT NULL DEFAULT 1,
  `billing_location` tinyint(1) NOT NULL DEFAULT 1,
  `accepts_assignment` tinyint(1) NOT NULL DEFAULT 1,
  `pos_code` tinyint(4) DEFAULT NULL,
  `x12_sender_id` varchar(25) DEFAULT NULL,
  `attn` varchar(65) DEFAULT NULL,
  `domain_identifier` varchar(60) DEFAULT NULL,
  `facility_npi` varchar(15) DEFAULT NULL,
  `facility_taxonomy` varchar(15) DEFAULT NULL,
  `tax_id_type` varchar(31) NOT NULL DEFAULT '',
  `color` varchar(7) NOT NULL DEFAULT '',
  `primary_business_entity` int(10) NOT NULL DEFAULT 1 COMMENT '0-Not Set as business entity 1-Set as business entity',
  `facility_code` varchar(31) DEFAULT NULL,
  `extra_validation` tinyint(1) NOT NULL DEFAULT 1,
  `mail_street` varchar(30) DEFAULT NULL,
  `mail_street2` varchar(30) DEFAULT NULL,
  `mail_city` varchar(50) DEFAULT NULL,
  `mail_state` varchar(3) DEFAULT NULL,
  `mail_zip` varchar(10) DEFAULT NULL,
  `oid` varchar(255) NOT NULL DEFAULT '' COMMENT 'HIEs CCDA and FHIR an OID is required/wanted',
  `iban` varchar(50) DEFAULT NULL,
  `info` text DEFAULT NULL,
  `weno_id` varchar(10) DEFAULT NULL,
  `inactive` tinyint(1) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `last_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `facility_user_ids`
--

DROP TABLE IF EXISTS `facility_user_ids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `facility_user_ids` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uid` bigint(20) DEFAULT NULL,
  `facility_id` bigint(20) DEFAULT NULL,
  `uuid` binary(16) DEFAULT NULL,
  `field_id` varchar(31) NOT NULL COMMENT 'references layout_options.field_id',
  `field_value` text DEFAULT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `last_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`,`facility_id`,`field_id`),
  KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fee_schedule`
--

DROP TABLE IF EXISTS `fee_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `fee_schedule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `insurance_company_id` int(11) NOT NULL DEFAULT 0,
  `plan` varchar(20) DEFAULT '',
  `code` varchar(10) DEFAULT '',
  `modifier` varchar(2) DEFAULT '',
  `type` varchar(20) DEFAULT '',
  `fee` decimal(12,2) DEFAULT NULL,
  `effective_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ins_plan_code_mod_type_date` (`insurance_company_id`,`plan`,`code`,`modifier`,`type`,`effective_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fee_sheet_options`
--

DROP TABLE IF EXISTS `fee_sheet_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `fee_sheet_options` (
  `fs_category` varchar(63) DEFAULT NULL,
  `fs_option` varchar(63) DEFAULT NULL,
  `fs_codes` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_care_plan`
--

DROP TABLE IF EXISTS `form_care_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_care_plan` (
  `id` bigint(20) NOT NULL,
  `date` datetime DEFAULT NULL,
  `pid` bigint(20) DEFAULT NULL,
  `encounter` varchar(255) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `groupname` varchar(255) DEFAULT NULL,
  `authorized` tinyint(4) DEFAULT NULL,
  `activity` tinyint(4) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `codetext` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `external_id` varchar(30) DEFAULT NULL,
  `care_plan_type` varchar(30) DEFAULT NULL,
  `note_related_to` text DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `reason_code` varchar(31) DEFAULT NULL,
  `reason_description` text DEFAULT NULL,
  `reason_date_low` datetime DEFAULT NULL COMMENT 'The date the reason was recorded',
  `reason_date_high` datetime DEFAULT NULL COMMENT 'The date the explanation reason for the care plan entry value ends',
  `reason_status` varchar(31) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_clinical_instructions`
--

DROP TABLE IF EXISTS `form_clinical_instructions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_clinical_instructions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` bigint(20) DEFAULT NULL,
  `encounter` varchar(255) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `instruction` text DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `activity` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_clinical_notes`
--

DROP TABLE IF EXISTS `form_clinical_notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_clinical_notes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `form_id` bigint(20) NOT NULL,
  `uuid` binary(16) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `pid` bigint(20) DEFAULT NULL,
  `encounter` varchar(255) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `groupname` varchar(255) DEFAULT NULL,
  `authorized` tinyint(4) DEFAULT NULL,
  `activity` tinyint(4) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `codetext` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `external_id` varchar(30) DEFAULT NULL,
  `clinical_notes_type` varchar(100) DEFAULT NULL,
  `clinical_notes_category` varchar(100) DEFAULT NULL,
  `note_related_to` text DEFAULT NULL,
  `last_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_dictation`
--

DROP TABLE IF EXISTS `form_dictation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_dictation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `pid` bigint(20) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `groupname` varchar(255) DEFAULT NULL,
  `authorized` tinyint(4) DEFAULT NULL,
  `activity` tinyint(4) DEFAULT NULL,
  `dictation` longtext DEFAULT NULL,
  `additional_notes` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_encounter`
--

DROP TABLE IF EXISTS `form_encounter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_encounter` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uuid` binary(16) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `reason` longtext DEFAULT NULL,
  `facility` longtext DEFAULT NULL,
  `facility_id` int(11) NOT NULL DEFAULT 0,
  `pid` bigint(20) DEFAULT NULL,
  `encounter` bigint(20) DEFAULT NULL,
  `onset_date` datetime DEFAULT NULL,
  `sensitivity` varchar(30) DEFAULT NULL,
  `billing_note` text DEFAULT NULL,
  `pc_catid` int(11) NOT NULL DEFAULT 5 COMMENT 'event category from openemr_postcalendar_categories',
  `last_level_billed` int(11) NOT NULL DEFAULT 0 COMMENT '0=none, 1=ins1, 2=ins2, etc',
  `last_level_closed` int(11) NOT NULL DEFAULT 0 COMMENT '0=none, 1=ins1, 2=ins2, etc',
  `last_stmt_date` date DEFAULT NULL,
  `stmt_count` int(11) NOT NULL DEFAULT 0,
  `provider_id` int(11) DEFAULT 0 COMMENT 'default and main provider for this visit',
  `supervisor_id` int(11) DEFAULT 0 COMMENT 'supervising provider, if any, for this visit',
  `invoice_refno` varchar(31) NOT NULL DEFAULT '',
  `referral_source` varchar(31) NOT NULL DEFAULT '',
  `billing_facility` int(11) NOT NULL DEFAULT 0,
  `external_id` varchar(20) DEFAULT NULL,
  `pos_code` tinyint(4) DEFAULT NULL,
  `parent_encounter_id` bigint(20) DEFAULT NULL,
  `class_code` varchar(10) NOT NULL DEFAULT 'AMB',
  `shift` varchar(31) NOT NULL DEFAULT '',
  `voucher_number` varchar(255) NOT NULL DEFAULT '' COMMENT 'also called referral number',
  `discharge_disposition` varchar(100) DEFAULT NULL,
  `encounter_type_code` varchar(31) DEFAULT NULL COMMENT 'not all types are categories',
  `encounter_type_description` text DEFAULT NULL,
  `referring_provider_id` int(11) DEFAULT 0 COMMENT 'referring provider, if any, for this visit',
  `date_end` datetime DEFAULT NULL,
  `in_collection` tinyint(1) DEFAULT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `ordering_provider_id` int(11) DEFAULT 0 COMMENT 'referring provider, if any, for this visit',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `pid_encounter` (`pid`,`encounter`),
  KEY `encounter_date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_eye_acuity`
--

DROP TABLE IF EXISTS `form_eye_acuity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_eye_acuity` (
  `id` bigint(20) NOT NULL COMMENT 'Links to forms.form_id',
  `pid` bigint(20) DEFAULT NULL,
  `SCODVA` varchar(25) DEFAULT NULL,
  `SCOSVA` varchar(25) DEFAULT NULL,
  `PHODVA` varchar(25) DEFAULT NULL,
  `PHOSVA` varchar(25) DEFAULT NULL,
  `CTLODVA` varchar(25) DEFAULT NULL,
  `CTLOSVA` varchar(25) DEFAULT NULL,
  `MRODVA` varchar(25) DEFAULT NULL,
  `MROSVA` varchar(25) DEFAULT NULL,
  `SCNEARODVA` varchar(25) DEFAULT NULL,
  `SCNEAROSVA` varchar(25) DEFAULT NULL,
  `MRNEARODVA` varchar(25) DEFAULT NULL,
  `MRNEAROSVA` varchar(25) DEFAULT NULL,
  `GLAREODVA` varchar(25) DEFAULT NULL,
  `GLAREOSVA` varchar(25) DEFAULT NULL,
  `GLARECOMMENTS` varchar(255) DEFAULT NULL,
  `ARODVA` varchar(25) DEFAULT NULL,
  `AROSVA` varchar(25) DEFAULT NULL,
  `CRODVA` varchar(25) DEFAULT NULL,
  `CROSVA` varchar(25) DEFAULT NULL,
  `CTLODVA1` varchar(25) DEFAULT NULL,
  `CTLOSVA1` varchar(25) DEFAULT NULL,
  `PAMODVA` varchar(25) DEFAULT NULL,
  `PAMOSVA` varchar(25) DEFAULT NULL,
  `LIODVA` varchar(25) NOT NULL,
  `LIOSVA` varchar(25) NOT NULL,
  `WODVANEAR` varchar(25) DEFAULT NULL,
  `OSVANEARCC` varchar(25) DEFAULT NULL,
  `BINOCVA` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_pid` (`id`,`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_eye_antseg`
--

DROP TABLE IF EXISTS `form_eye_antseg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_eye_antseg` (
  `id` bigint(20) NOT NULL COMMENT 'Links to forms.form_id',
  `pid` bigint(20) DEFAULT NULL,
  `ODSCHIRMER1` varchar(25) DEFAULT NULL,
  `OSSCHIRMER1` varchar(25) DEFAULT NULL,
  `ODSCHIRMER2` varchar(25) DEFAULT NULL,
  `OSSCHIRMER2` varchar(25) DEFAULT NULL,
  `ODTBUT` varchar(25) DEFAULT NULL,
  `OSTBUT` varchar(25) DEFAULT NULL,
  `OSCONJ` varchar(25) DEFAULT NULL,
  `ODCONJ` text DEFAULT NULL,
  `ODCORNEA` text DEFAULT NULL,
  `OSCORNEA` text DEFAULT NULL,
  `ODAC` text DEFAULT NULL,
  `OSAC` text DEFAULT NULL,
  `ODLENS` text DEFAULT NULL,
  `OSLENS` text DEFAULT NULL,
  `ODIRIS` text DEFAULT NULL,
  `OSIRIS` text DEFAULT NULL,
  `PUPIL_NORMAL` varchar(2) DEFAULT '1',
  `ODPUPILSIZE1` varchar(25) DEFAULT NULL,
  `ODPUPILSIZE2` varchar(25) DEFAULT NULL,
  `ODPUPILREACTIVITY` char(25) DEFAULT NULL,
  `ODAPD` varchar(25) DEFAULT NULL,
  `OSPUPILSIZE1` varchar(25) DEFAULT NULL,
  `OSPUPILSIZE2` varchar(25) DEFAULT NULL,
  `OSPUPILREACTIVITY` char(25) DEFAULT NULL,
  `OSAPD` varchar(25) DEFAULT NULL,
  `DIMODPUPILSIZE1` varchar(25) DEFAULT NULL,
  `DIMODPUPILSIZE2` varchar(25) DEFAULT NULL,
  `DIMODPUPILREACTIVITY` varchar(25) DEFAULT NULL,
  `DIMOSPUPILSIZE1` varchar(25) DEFAULT NULL,
  `DIMOSPUPILSIZE2` varchar(25) DEFAULT NULL,
  `DIMOSPUPILREACTIVITY` varchar(25) DEFAULT NULL,
  `PUPIL_COMMENTS` text DEFAULT NULL,
  `ODKTHICKNESS` varchar(25) DEFAULT NULL,
  `OSKTHICKNESS` varchar(25) DEFAULT NULL,
  `ODGONIO` varchar(25) DEFAULT NULL,
  `OSGONIO` varchar(25) DEFAULT NULL,
  `ANTSEG_COMMENTS` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_pid` (`id`,`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_eye_base`
--

DROP TABLE IF EXISTS `form_eye_base`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_eye_base` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Links to forms.form_id',
  `date` datetime DEFAULT NULL,
  `pid` bigint(20) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `groupname` varchar(255) DEFAULT NULL,
  `authorized` tinyint(4) DEFAULT NULL,
  `activity` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_eye_biometrics`
--

DROP TABLE IF EXISTS `form_eye_biometrics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_eye_biometrics` (
  `id` bigint(20) NOT NULL COMMENT 'Links to forms.form_id',
  `pid` bigint(20) DEFAULT NULL,
  `ODK1` varchar(10) DEFAULT NULL,
  `ODK2` varchar(10) DEFAULT NULL,
  `ODK2AXIS` varchar(10) DEFAULT NULL,
  `OSK1` varchar(10) DEFAULT NULL,
  `OSK2` varchar(10) DEFAULT NULL,
  `OSK2AXIS` varchar(10) DEFAULT NULL,
  `ODAXIALLENGTH` varchar(20) DEFAULT NULL,
  `OSAXIALLENGTH` varchar(20) DEFAULT NULL,
  `ODPDMeasured` varchar(20) DEFAULT NULL,
  `OSPDMeasured` varchar(20) DEFAULT NULL,
  `ODACD` varchar(20) DEFAULT NULL,
  `OSACD` varchar(20) DEFAULT NULL,
  `ODW2W` varchar(20) DEFAULT NULL,
  `OSW2W` varchar(20) DEFAULT NULL,
  `ODLT` varchar(20) DEFAULT NULL,
  `OSLT` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_pid` (`id`,`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_eye_external`
--

DROP TABLE IF EXISTS `form_eye_external`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_eye_external` (
  `id` bigint(20) NOT NULL COMMENT 'Links to forms.form_id',
  `pid` bigint(20) DEFAULT NULL,
  `RUL` text DEFAULT NULL,
  `LUL` text DEFAULT NULL,
  `RLL` text DEFAULT NULL,
  `LLL` text DEFAULT NULL,
  `RBROW` text DEFAULT NULL,
  `LBROW` text DEFAULT NULL,
  `RMCT` text DEFAULT NULL,
  `LMCT` text DEFAULT NULL,
  `RADNEXA` text DEFAULT NULL,
  `LADNEXA` text DEFAULT NULL,
  `RMRD` varchar(25) DEFAULT NULL,
  `LMRD` varchar(25) DEFAULT NULL,
  `RLF` varchar(25) DEFAULT NULL,
  `LLF` varchar(25) DEFAULT NULL,
  `RVFISSURE` varchar(25) DEFAULT NULL,
  `LVFISSURE` varchar(25) DEFAULT NULL,
  `ODHERTEL` varchar(25) DEFAULT NULL,
  `OSHERTEL` varchar(25) DEFAULT NULL,
  `HERTELBASE` varchar(25) DEFAULT NULL,
  `RCAROTID` text DEFAULT NULL,
  `LCAROTID` text DEFAULT NULL,
  `RTEMPART` text DEFAULT NULL,
  `LTEMPART` text DEFAULT NULL,
  `RCNV` text DEFAULT NULL,
  `LCNV` text DEFAULT NULL,
  `RCNVII` text DEFAULT NULL,
  `LCNVII` text DEFAULT NULL,
  `EXT_COMMENTS` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_pid` (`id`,`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_eye_hpi`
--

DROP TABLE IF EXISTS `form_eye_hpi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_eye_hpi` (
  `id` bigint(20) NOT NULL COMMENT 'Links to forms.form_id',
  `pid` bigint(20) DEFAULT NULL,
  `CC1` varchar(255) DEFAULT NULL,
  `HPI1` text DEFAULT NULL,
  `QUALITY1` varchar(255) DEFAULT NULL,
  `TIMING1` varchar(255) DEFAULT NULL,
  `DURATION1` varchar(255) DEFAULT NULL,
  `CONTEXT1` varchar(255) DEFAULT NULL,
  `SEVERITY1` varchar(255) DEFAULT NULL,
  `MODIFY1` varchar(255) DEFAULT NULL,
  `ASSOCIATED1` varchar(255) DEFAULT NULL,
  `LOCATION1` varchar(255) DEFAULT NULL,
  `CHRONIC1` varchar(255) DEFAULT NULL,
  `CHRONIC2` varchar(255) DEFAULT NULL,
  `CHRONIC3` varchar(255) DEFAULT NULL,
  `CC2` text DEFAULT NULL,
  `HPI2` text DEFAULT NULL,
  `QUALITY2` text DEFAULT NULL,
  `TIMING2` text DEFAULT NULL,
  `DURATION2` text DEFAULT NULL,
  `CONTEXT2` text DEFAULT NULL,
  `SEVERITY2` text DEFAULT NULL,
  `MODIFY2` text DEFAULT NULL,
  `ASSOCIATED2` text DEFAULT NULL,
  `LOCATION2` text DEFAULT NULL,
  `CC3` text DEFAULT NULL,
  `HPI3` text DEFAULT NULL,
  `QUALITY3` text DEFAULT NULL,
  `TIMING3` text DEFAULT NULL,
  `DURATION3` text DEFAULT NULL,
  `CONTEXT3` text DEFAULT NULL,
  `SEVERITY3` text DEFAULT NULL,
  `MODIFY3` text DEFAULT NULL,
  `ASSOCIATED3` text DEFAULT NULL,
  `LOCATION3` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_pid` (`id`,`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_eye_locking`
--

DROP TABLE IF EXISTS `form_eye_locking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_eye_locking` (
  `id` bigint(20) NOT NULL COMMENT 'Links to forms.form_id',
  `pid` bigint(20) DEFAULT NULL,
  `IMP` text DEFAULT NULL,
  `PLAN` text DEFAULT NULL,
  `Resource` varchar(50) DEFAULT NULL,
  `Technician` varchar(50) DEFAULT NULL,
  `LOCKED` varchar(3) DEFAULT NULL,
  `LOCKEDDATE` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `LOCKEDBY` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_pid` (`id`,`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_eye_mag_dispense`
--

DROP TABLE IF EXISTS `form_eye_mag_dispense`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_eye_mag_dispense` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `encounter` bigint(20) DEFAULT NULL,
  `pid` bigint(20) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `groupname` varchar(255) DEFAULT NULL,
  `authorized` tinyint(4) DEFAULT NULL,
  `activity` tinyint(4) DEFAULT NULL,
  `REFDATE` datetime DEFAULT NULL,
  `REFTYPE` varchar(10) DEFAULT NULL,
  `RXTYPE` varchar(20) DEFAULT NULL,
  `ODSPH` varchar(10) DEFAULT NULL,
  `ODCYL` varchar(10) DEFAULT NULL,
  `ODAXIS` varchar(10) DEFAULT NULL,
  `OSSPH` varchar(10) DEFAULT NULL,
  `OSCYL` varchar(10) DEFAULT NULL,
  `OSAXIS` varchar(10) DEFAULT NULL,
  `ODMIDADD` varchar(10) DEFAULT NULL,
  `OSMIDADD` varchar(10) DEFAULT NULL,
  `ODADD` varchar(10) DEFAULT NULL,
  `OSADD` varchar(10) DEFAULT NULL,
  `ODHPD` varchar(20) DEFAULT NULL,
  `ODHBASE` varchar(20) DEFAULT NULL,
  `ODVPD` varchar(20) DEFAULT NULL,
  `ODVBASE` varchar(20) DEFAULT NULL,
  `ODSLABOFF` varchar(20) DEFAULT NULL,
  `ODVERTEXDIST` varchar(20) DEFAULT NULL,
  `OSHPD` varchar(20) DEFAULT NULL,
  `OSHBASE` varchar(20) DEFAULT NULL,
  `OSVPD` varchar(20) DEFAULT NULL,
  `OSVBASE` varchar(20) DEFAULT NULL,
  `OSSLABOFF` varchar(20) DEFAULT NULL,
  `OSVERTEXDIST` varchar(20) DEFAULT NULL,
  `ODMPDD` varchar(20) DEFAULT NULL,
  `ODMPDN` varchar(20) DEFAULT NULL,
  `OSMPDD` varchar(20) DEFAULT NULL,
  `OSMPDN` varchar(20) DEFAULT NULL,
  `BPDD` varchar(20) DEFAULT NULL,
  `BPDN` varchar(20) DEFAULT NULL,
  `LENS_MATERIAL` varchar(20) DEFAULT NULL,
  `LENS_TREATMENTS` varchar(100) DEFAULT NULL,
  `CTLMANUFACTUREROD` varchar(25) DEFAULT NULL,
  `CTLMANUFACTUREROS` varchar(25) DEFAULT NULL,
  `CTLSUPPLIEROD` varchar(25) DEFAULT NULL,
  `CTLSUPPLIEROS` varchar(25) DEFAULT NULL,
  `CTLBRANDOD` varchar(50) DEFAULT NULL,
  `CTLBRANDOS` varchar(50) DEFAULT NULL,
  `CTLODQUANTITY` varchar(255) DEFAULT NULL,
  `CTLOSQUANTITY` varchar(255) DEFAULT NULL,
  `ODDIAM` varchar(50) DEFAULT NULL,
  `ODBC` varchar(50) DEFAULT NULL,
  `OSDIAM` varchar(50) DEFAULT NULL,
  `OSBC` varchar(50) DEFAULT NULL,
  `RXCOMMENTS` text DEFAULT NULL,
  `COMMENTS` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pid` (`pid`,`encounter`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_eye_mag_impplan`
--

DROP TABLE IF EXISTS `form_eye_mag_impplan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_eye_mag_impplan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `form_id` bigint(20) NOT NULL,
  `pid` bigint(20) NOT NULL,
  `title` varchar(255) NOT NULL,
  `code` varchar(50) DEFAULT NULL,
  `codetype` varchar(50) DEFAULT NULL,
  `codedesc` varchar(255) DEFAULT NULL,
  `codetext` varchar(255) DEFAULT NULL,
  `plan` varchar(3000) DEFAULT NULL,
  `PMSFH_link` varchar(50) DEFAULT NULL,
  `IMPPLAN_order` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `second_index` (`form_id`,`pid`,`title`,`plan`(20))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_eye_mag_orders`
--

DROP TABLE IF EXISTS `form_eye_mag_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_eye_mag_orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `form_id` int(20) NOT NULL,
  `pid` bigint(20) NOT NULL,
  `ORDER_DETAILS` varchar(255) NOT NULL,
  `ORDER_STATUS` varchar(50) DEFAULT NULL,
  `ORDER_PRIORITY` varchar(50) DEFAULT NULL,
  `ORDER_DATE_PLACED` date NOT NULL,
  `ORDER_PLACED_BYWHOM` varchar(50) DEFAULT NULL,
  `ORDER_DATE_COMPLETED` date DEFAULT NULL,
  `ORDER_COMPLETED_BYWHOM` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `VISIT_ID` (`pid`,`ORDER_DETAILS`,`ORDER_DATE_PLACED`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_eye_mag_prefs`
--

DROP TABLE IF EXISTS `form_eye_mag_prefs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_eye_mag_prefs` (
  `PEZONE` varchar(25) DEFAULT NULL,
  `LOCATION` varchar(25) DEFAULT NULL,
  `LOCATION_text` varchar(25) NOT NULL,
  `id` bigint(20) DEFAULT NULL,
  `selection` varchar(255) DEFAULT NULL,
  `ZONE_ORDER` int(11) DEFAULT NULL,
  `GOVALUE` varchar(10) DEFAULT '0',
  `ordering` smallint(6) DEFAULT NULL,
  `FILL_ACTION` varchar(10) NOT NULL DEFAULT 'ADD',
  `GORIGHT` varchar(50) NOT NULL,
  `GOLEFT` varchar(50) NOT NULL,
  `UNSPEC` varchar(50) NOT NULL,
  UNIQUE KEY `id` (`id`,`PEZONE`,`LOCATION`,`selection`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_eye_mag_wearing`
--

DROP TABLE IF EXISTS `form_eye_mag_wearing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_eye_mag_wearing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ENCOUNTER` int(11) NOT NULL,
  `FORM_ID` smallint(6) NOT NULL,
  `PID` bigint(20) NOT NULL,
  `RX_NUMBER` int(11) NOT NULL,
  `ODSPH` varchar(10) DEFAULT NULL,
  `ODCYL` varchar(10) DEFAULT NULL,
  `ODAXIS` varchar(10) DEFAULT NULL,
  `OSSPH` varchar(10) DEFAULT NULL,
  `OSCYL` varchar(10) DEFAULT NULL,
  `OSAXIS` varchar(10) DEFAULT NULL,
  `ODMIDADD` varchar(10) DEFAULT NULL,
  `OSMIDADD` varchar(10) DEFAULT NULL,
  `ODADD` varchar(10) DEFAULT NULL,
  `OSADD` varchar(10) DEFAULT NULL,
  `ODVA` varchar(10) DEFAULT NULL,
  `OSVA` varchar(10) DEFAULT NULL,
  `ODNEARVA` varchar(10) DEFAULT NULL,
  `OSNEARVA` varchar(10) DEFAULT NULL,
  `ODHPD` varchar(20) DEFAULT NULL,
  `ODHBASE` varchar(20) DEFAULT NULL,
  `ODVPD` varchar(20) DEFAULT NULL,
  `ODVBASE` varchar(20) DEFAULT NULL,
  `ODSLABOFF` varchar(20) DEFAULT NULL,
  `ODVERTEXDIST` varchar(20) DEFAULT NULL,
  `OSHPD` varchar(20) DEFAULT NULL,
  `OSHBASE` varchar(20) DEFAULT NULL,
  `OSVPD` varchar(20) DEFAULT NULL,
  `OSVBASE` varchar(20) DEFAULT NULL,
  `OSSLABOFF` varchar(20) DEFAULT NULL,
  `OSVERTEXDIST` varchar(20) DEFAULT NULL,
  `ODMPDD` varchar(20) DEFAULT NULL,
  `ODMPDN` varchar(20) DEFAULT NULL,
  `OSMPDD` varchar(20) DEFAULT NULL,
  `OSMPDN` varchar(20) DEFAULT NULL,
  `BPDD` varchar(20) DEFAULT NULL,
  `BPDN` varchar(20) DEFAULT NULL,
  `LENS_MATERIAL` varchar(20) DEFAULT NULL,
  `LENS_TREATMENTS` varchar(100) DEFAULT NULL,
  `RX_TYPE` varchar(25) DEFAULT NULL,
  `COMMENTS` text DEFAULT NULL,
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `FORM_ID` (`FORM_ID`,`ENCOUNTER`,`PID`,`RX_NUMBER`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_eye_neuro`
--

DROP TABLE IF EXISTS `form_eye_neuro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_eye_neuro` (
  `id` bigint(20) NOT NULL COMMENT 'Links to forms.form_id',
  `pid` bigint(20) DEFAULT NULL,
  `ACT` char(3) NOT NULL DEFAULT 'on',
  `ACT5CCDIST` text DEFAULT NULL,
  `ACT1CCDIST` text DEFAULT NULL,
  `ACT2CCDIST` text DEFAULT NULL,
  `ACT3CCDIST` text DEFAULT NULL,
  `ACT4CCDIST` text DEFAULT NULL,
  `ACT6CCDIST` text DEFAULT NULL,
  `ACT7CCDIST` text DEFAULT NULL,
  `ACT8CCDIST` text DEFAULT NULL,
  `ACT9CCDIST` text DEFAULT NULL,
  `ACT10CCDIST` text DEFAULT NULL,
  `ACT11CCDIST` text DEFAULT NULL,
  `ACT1SCDIST` text DEFAULT NULL,
  `ACT2SCDIST` text DEFAULT NULL,
  `ACT3SCDIST` text DEFAULT NULL,
  `ACT4SCDIST` text DEFAULT NULL,
  `ACT5SCDIST` text DEFAULT NULL,
  `ACT6SCDIST` text DEFAULT NULL,
  `ACT7SCDIST` text DEFAULT NULL,
  `ACT8SCDIST` text DEFAULT NULL,
  `ACT9SCDIST` text DEFAULT NULL,
  `ACT10SCDIST` text DEFAULT NULL,
  `ACT11SCDIST` text DEFAULT NULL,
  `ACT1SCNEAR` text DEFAULT NULL,
  `ACT2SCNEAR` text DEFAULT NULL,
  `ACT3SCNEAR` text DEFAULT NULL,
  `ACT4SCNEAR` text DEFAULT NULL,
  `ACT5CCNEAR` text DEFAULT NULL,
  `ACT6CCNEAR` text DEFAULT NULL,
  `ACT7CCNEAR` text DEFAULT NULL,
  `ACT8CCNEAR` text DEFAULT NULL,
  `ACT9CCNEAR` text DEFAULT NULL,
  `ACT10CCNEAR` text DEFAULT NULL,
  `ACT11CCNEAR` text DEFAULT NULL,
  `ACT5SCNEAR` text DEFAULT NULL,
  `ACT6SCNEAR` text DEFAULT NULL,
  `ACT7SCNEAR` text DEFAULT NULL,
  `ACT8SCNEAR` text DEFAULT NULL,
  `ACT9SCNEAR` text DEFAULT NULL,
  `ACT10SCNEAR` text DEFAULT NULL,
  `ACT11SCNEAR` text DEFAULT NULL,
  `ACT1CCNEAR` text DEFAULT NULL,
  `ACT2CCNEAR` text DEFAULT NULL,
  `ACT3CCNEAR` text DEFAULT NULL,
  `ACT4CCNEAR` text DEFAULT NULL,
  `MOTILITYNORMAL` char(3) NOT NULL DEFAULT 'on',
  `MOTILITY_RS` char(1) DEFAULT '0',
  `MOTILITY_RI` char(1) DEFAULT '0',
  `MOTILITY_RR` char(1) DEFAULT '0',
  `MOTILITY_RL` char(1) DEFAULT '0',
  `MOTILITY_LS` char(1) DEFAULT '0',
  `MOTILITY_LI` char(1) DEFAULT '0',
  `MOTILITY_LR` char(1) DEFAULT '0',
  `MOTILITY_LL` char(1) DEFAULT '0',
  `MOTILITY_RRSO` int(1) DEFAULT NULL,
  `MOTILITY_RLSO` int(1) DEFAULT NULL,
  `MOTILITY_RRIO` int(1) DEFAULT NULL,
  `MOTILITY_RLIO` int(1) DEFAULT NULL,
  `MOTILITY_LRSO` int(1) DEFAULT NULL,
  `MOTILITY_LLSO` int(1) DEFAULT NULL,
  `MOTILITY_LRIO` int(1) DEFAULT NULL,
  `MOTILITY_LLIO` int(1) DEFAULT NULL,
  `NEURO_COMMENTS` text DEFAULT NULL,
  `STEREOPSIS` varchar(25) DEFAULT NULL,
  `ODNPA` text DEFAULT NULL,
  `OSNPA` text DEFAULT NULL,
  `VERTFUSAMPS` text DEFAULT NULL,
  `DIVERGENCEAMPS` text DEFAULT NULL,
  `NPC` varchar(10) DEFAULT NULL,
  `DACCDIST` varchar(20) DEFAULT NULL,
  `DACCNEAR` varchar(20) DEFAULT NULL,
  `CACCDIST` varchar(20) DEFAULT NULL,
  `CACCNEAR` varchar(20) DEFAULT NULL,
  `ODCOLOR` text DEFAULT NULL,
  `OSCOLOR` text DEFAULT NULL,
  `ODCOINS` text DEFAULT NULL,
  `OSCOINS` text DEFAULT NULL,
  `ODREDDESAT` varchar(20) DEFAULT NULL,
  `OSREDDESAT` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_pid` (`id`,`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_eye_postseg`
--

DROP TABLE IF EXISTS `form_eye_postseg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_eye_postseg` (
  `id` bigint(20) NOT NULL COMMENT 'Links to forms.form_id',
  `pid` bigint(20) DEFAULT NULL,
  `ODDISC` text DEFAULT NULL,
  `OSDISC` text DEFAULT NULL,
  `ODCUP` text DEFAULT NULL,
  `OSCUP` text DEFAULT NULL,
  `ODMACULA` text DEFAULT NULL,
  `OSMACULA` text DEFAULT NULL,
  `ODVESSELS` text DEFAULT NULL,
  `OSVESSELS` text DEFAULT NULL,
  `ODVITREOUS` text DEFAULT NULL,
  `OSVITREOUS` text DEFAULT NULL,
  `ODPERIPH` text DEFAULT NULL,
  `OSPERIPH` text DEFAULT NULL,
  `ODCMT` text DEFAULT NULL,
  `OSCMT` text DEFAULT NULL,
  `RETINA_COMMENTS` text DEFAULT NULL,
  `DIL_RISKS` char(2) NOT NULL DEFAULT 'on',
  `DIL_MEDS` mediumtext DEFAULT NULL,
  `WETTYPE` varchar(10) NOT NULL,
  `ATROPINE` varchar(25) NOT NULL,
  `CYCLOMYDRIL` varchar(25) NOT NULL,
  `TROPICAMIDE` varchar(25) NOT NULL,
  `CYCLOGYL` varchar(25) NOT NULL,
  `NEO25` varchar(25) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_pid` (`id`,`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_eye_refraction`
--

DROP TABLE IF EXISTS `form_eye_refraction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_eye_refraction` (
  `id` bigint(20) NOT NULL COMMENT 'Links to forms.form_id',
  `pid` bigint(20) DEFAULT NULL,
  `MRODSPH` varchar(25) DEFAULT NULL,
  `MRODCYL` varchar(25) DEFAULT NULL,
  `MRODAXIS` varchar(25) DEFAULT NULL,
  `MRODPRISM` varchar(25) DEFAULT NULL,
  `MRODBASE` varchar(25) DEFAULT NULL,
  `MRODADD` varchar(25) DEFAULT NULL,
  `MROSSPH` varchar(25) DEFAULT NULL,
  `MROSCYL` varchar(25) DEFAULT NULL,
  `MROSAXIS` varchar(25) DEFAULT NULL,
  `MROSPRISM` varchar(50) DEFAULT NULL,
  `MROSBASE` varchar(50) DEFAULT NULL,
  `MROSADD` varchar(25) DEFAULT NULL,
  `MRODNEARSPHERE` varchar(25) DEFAULT NULL,
  `MRODNEARCYL` varchar(25) DEFAULT NULL,
  `MRODNEARAXIS` varchar(25) DEFAULT NULL,
  `MRODPRISMNEAR` varchar(50) DEFAULT NULL,
  `MRODBASENEAR` varchar(25) DEFAULT NULL,
  `MROSNEARSHPERE` varchar(25) DEFAULT NULL,
  `MROSNEARCYL` varchar(25) DEFAULT NULL,
  `MROSNEARAXIS` varchar(125) DEFAULT NULL,
  `MROSPRISMNEAR` varchar(50) DEFAULT NULL,
  `MROSBASENEAR` varchar(25) DEFAULT NULL,
  `CRODSPH` varchar(25) DEFAULT NULL,
  `CRODCYL` varchar(25) DEFAULT NULL,
  `CRODAXIS` varchar(25) DEFAULT NULL,
  `CROSSPH` varchar(25) DEFAULT NULL,
  `CROSCYL` varchar(25) DEFAULT NULL,
  `CROSAXIS` varchar(25) DEFAULT NULL,
  `CRCOMMENTS` varchar(255) DEFAULT NULL,
  `BALANCED` char(2) NOT NULL,
  `ARODSPH` varchar(25) DEFAULT NULL,
  `ARODCYL` varchar(25) DEFAULT NULL,
  `ARODAXIS` varchar(25) DEFAULT NULL,
  `AROSSPH` varchar(25) DEFAULT NULL,
  `AROSCYL` varchar(25) DEFAULT NULL,
  `AROSAXIS` varchar(25) DEFAULT NULL,
  `ARODADD` varchar(25) DEFAULT NULL,
  `AROSADD` varchar(25) DEFAULT NULL,
  `ARNEARODVA` varchar(25) DEFAULT NULL,
  `ARNEAROSVA` varchar(25) DEFAULT NULL,
  `ARODPRISM` varchar(50) DEFAULT NULL,
  `AROSPRISM` varchar(50) DEFAULT NULL,
  `CTLODSPH` varchar(25) DEFAULT NULL,
  `CTLODCYL` varchar(25) DEFAULT NULL,
  `CTLODAXIS` varchar(25) DEFAULT NULL,
  `CTLODBC` varchar(25) DEFAULT NULL,
  `CTLODDIAM` varchar(25) DEFAULT NULL,
  `CTLOSSPH` varchar(25) DEFAULT NULL,
  `CTLOSCYL` varchar(25) DEFAULT NULL,
  `CTLOSAXIS` varchar(25) DEFAULT NULL,
  `CTLOSBC` varchar(25) DEFAULT NULL,
  `CTLOSDIAM` varchar(25) DEFAULT NULL,
  `CTL_COMMENTS` text DEFAULT NULL,
  `CTLMANUFACTUREROD` varchar(50) DEFAULT NULL,
  `CTLSUPPLIEROD` varchar(50) DEFAULT NULL,
  `CTLBRANDOD` varchar(50) DEFAULT NULL,
  `CTLMANUFACTUREROS` varchar(50) DEFAULT NULL,
  `CTLSUPPLIEROS` varchar(50) DEFAULT NULL,
  `CTLBRANDOS` varchar(50) DEFAULT NULL,
  `CTLODADD` varchar(25) DEFAULT NULL,
  `CTLOSADD` varchar(25) DEFAULT NULL,
  `NVOCHECKED` varchar(25) DEFAULT NULL,
  `ADDCHECKED` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_pid` (`id`,`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_eye_ros`
--

DROP TABLE IF EXISTS `form_eye_ros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_eye_ros` (
  `id` bigint(20) NOT NULL COMMENT 'Links to forms.form_id',
  `pid` bigint(20) DEFAULT NULL,
  `ROSGENERAL` text DEFAULT NULL,
  `ROSHEENT` text DEFAULT NULL,
  `ROSCV` text DEFAULT NULL,
  `ROSPULM` text DEFAULT NULL,
  `ROSGI` text DEFAULT NULL,
  `ROSGU` text DEFAULT NULL,
  `ROSDERM` text DEFAULT NULL,
  `ROSNEURO` text DEFAULT NULL,
  `ROSPSYCH` text DEFAULT NULL,
  `ROSMUSCULO` text DEFAULT NULL,
  `ROSIMMUNO` text DEFAULT NULL,
  `ROSENDOCRINE` text DEFAULT NULL,
  `ROSCOMMENTS` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_pid` (`id`,`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_eye_vitals`
--

DROP TABLE IF EXISTS `form_eye_vitals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_eye_vitals` (
  `id` bigint(20) NOT NULL COMMENT 'Links to forms.form_id',
  `pid` bigint(20) DEFAULT NULL,
  `alert` char(3) DEFAULT 'yes',
  `oriented` char(3) DEFAULT 'TPP',
  `confused` char(3) DEFAULT 'nml',
  `ODIOPAP` varchar(10) DEFAULT NULL,
  `OSIOPAP` varchar(10) DEFAULT NULL,
  `ODIOPTPN` varchar(10) DEFAULT NULL,
  `OSIOPTPN` varchar(10) DEFAULT NULL,
  `ODIOPFTN` varchar(10) DEFAULT NULL,
  `OSIOPFTN` varchar(10) DEFAULT NULL,
  `IOPTIME` time NOT NULL,
  `ODIOPPOST` varchar(10) NOT NULL,
  `OSIOPPOST` varchar(10) NOT NULL,
  `IOPPOSTTIME` time DEFAULT NULL,
  `ODIOPTARGET` varchar(10) NOT NULL,
  `OSIOPTARGET` varchar(10) NOT NULL,
  `AMSLEROD` smallint(1) DEFAULT NULL,
  `AMSLEROS` smallint(1) DEFAULT NULL,
  `ODVF1` tinyint(1) DEFAULT NULL,
  `ODVF2` tinyint(1) DEFAULT NULL,
  `ODVF3` tinyint(1) DEFAULT NULL,
  `ODVF4` tinyint(1) DEFAULT NULL,
  `OSVF1` tinyint(1) DEFAULT NULL,
  `OSVF2` tinyint(1) DEFAULT NULL,
  `OSVF3` tinyint(1) DEFAULT NULL,
  `OSVF4` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_pid` (`id`,`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_functional_cognitive_status`
--

DROP TABLE IF EXISTS `form_functional_cognitive_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_functional_cognitive_status` (
  `id` bigint(20) NOT NULL,
  `date` date DEFAULT NULL,
  `pid` bigint(20) DEFAULT NULL,
  `encounter` varchar(255) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `groupname` varchar(255) DEFAULT NULL,
  `authorized` tinyint(4) DEFAULT NULL,
  `activity` tinyint(4) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `codetext` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `external_id` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_group_attendance`
--

DROP TABLE IF EXISTS `form_group_attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_group_attendance` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `groupname` varchar(255) DEFAULT NULL,
  `authorized` tinyint(4) DEFAULT NULL,
  `encounter_id` int(11) DEFAULT NULL,
  `activity` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_groups_encounter`
--

DROP TABLE IF EXISTS `form_groups_encounter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_groups_encounter` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `reason` longtext DEFAULT NULL,
  `facility` longtext DEFAULT NULL,
  `facility_id` int(11) NOT NULL DEFAULT 0,
  `group_id` bigint(20) DEFAULT NULL,
  `encounter` bigint(20) DEFAULT NULL,
  `onset_date` datetime DEFAULT NULL,
  `sensitivity` varchar(30) DEFAULT NULL,
  `billing_note` text DEFAULT NULL,
  `pc_catid` int(11) NOT NULL DEFAULT 5 COMMENT 'event category from openemr_postcalendar_categories',
  `last_level_billed` int(11) NOT NULL DEFAULT 0 COMMENT '0=none, 1=ins1, 2=ins2, etc',
  `last_level_closed` int(11) NOT NULL DEFAULT 0 COMMENT '0=none, 1=ins1, 2=ins2, etc',
  `last_stmt_date` date DEFAULT NULL,
  `stmt_count` int(11) NOT NULL DEFAULT 0,
  `provider_id` int(11) DEFAULT 0 COMMENT 'default and main provider for this visit',
  `supervisor_id` int(11) DEFAULT 0 COMMENT 'supervising provider, if any, for this visit',
  `invoice_refno` varchar(31) NOT NULL DEFAULT '',
  `referral_source` varchar(31) NOT NULL DEFAULT '',
  `billing_facility` int(11) NOT NULL DEFAULT 0,
  `external_id` varchar(20) DEFAULT NULL,
  `pos_code` tinyint(4) DEFAULT NULL,
  `counselors` varchar(255) DEFAULT NULL,
  `appt_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pid_encounter` (`group_id`,`encounter`),
  KEY `encounter_date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_misc_billing_options`
--

DROP TABLE IF EXISTS `form_misc_billing_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_misc_billing_options` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `pid` bigint(20) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `groupname` varchar(255) DEFAULT NULL,
  `authorized` tinyint(4) DEFAULT NULL,
  `activity` tinyint(4) DEFAULT NULL,
  `employment_related` tinyint(1) DEFAULT NULL,
  `auto_accident` tinyint(1) DEFAULT NULL,
  `accident_state` varchar(2) DEFAULT NULL,
  `other_accident` tinyint(1) DEFAULT NULL,
  `medicaid_referral_code` varchar(2) DEFAULT NULL,
  `epsdt_flag` tinyint(1) DEFAULT NULL,
  `provider_qualifier_code` varchar(2) DEFAULT NULL,
  `provider_id` int(11) DEFAULT NULL,
  `outside_lab` tinyint(1) DEFAULT NULL,
  `lab_amount` decimal(5,2) DEFAULT NULL,
  `is_unable_to_work` tinyint(1) DEFAULT NULL,
  `onset_date` date DEFAULT NULL,
  `date_initial_treatment` date DEFAULT NULL,
  `off_work_from` date DEFAULT NULL,
  `off_work_to` date DEFAULT NULL,
  `is_hospitalized` tinyint(1) DEFAULT NULL,
  `hospitalization_date_from` date DEFAULT NULL,
  `hospitalization_date_to` date DEFAULT NULL,
  `medicaid_resubmission_code` varchar(10) DEFAULT NULL,
  `medicaid_original_reference` varchar(15) DEFAULT NULL,
  `prior_auth_number` varchar(20) DEFAULT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `replacement_claim` tinyint(1) DEFAULT 0,
  `icn_resubmission_number` varchar(35) DEFAULT NULL,
  `box_14_date_qual` char(3) DEFAULT NULL,
  `box_15_date_qual` char(3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_observation`
--

DROP TABLE IF EXISTS `form_observation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_observation` (
  `id` bigint(20) NOT NULL,
  `date` datetime DEFAULT NULL,
  `pid` bigint(20) DEFAULT NULL,
  `encounter` varchar(255) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `groupname` varchar(255) DEFAULT NULL,
  `authorized` tinyint(4) DEFAULT NULL,
  `activity` tinyint(4) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `observation` varchar(255) DEFAULT NULL,
  `ob_value` varchar(255) DEFAULT NULL,
  `ob_unit` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `code_type` varchar(255) DEFAULT NULL,
  `table_code` varchar(255) DEFAULT NULL,
  `ob_code` varchar(64) DEFAULT NULL,
  `ob_type` varchar(64) DEFAULT NULL,
  `ob_status` varchar(32) DEFAULT NULL,
  `result_status` varchar(32) DEFAULT NULL,
  `ob_reason_status` varchar(32) DEFAULT NULL,
  `ob_reason_code` varchar(64) DEFAULT NULL,
  `ob_reason_text` text DEFAULT NULL,
  `ob_documentationof_table` varchar(255) DEFAULT NULL,
  `ob_documentationof_table_id` bigint(21) DEFAULT NULL,
  `date_end` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_questionnaire_assessments`
--

DROP TABLE IF EXISTS `form_questionnaire_assessments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_questionnaire_assessments` (
  `id` bigint(21) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT current_timestamp(),
  `response_id` text DEFAULT NULL COMMENT 'The foreign id to the questionnaire_response repository',
  `pid` bigint(21) NOT NULL DEFAULT 0,
  `user` varchar(255) DEFAULT NULL,
  `groupname` varchar(255) DEFAULT NULL,
  `authorized` tinyint(4) NOT NULL DEFAULT 0,
  `activity` tinyint(4) NOT NULL DEFAULT 1,
  `copyright` text DEFAULT NULL,
  `form_name` varchar(255) DEFAULT NULL,
  `response_meta` text DEFAULT NULL COMMENT 'json meta data for the response resource',
  `questionnaire_id` text DEFAULT NULL COMMENT 'The foreign id to the questionnaire_repository',
  `questionnaire` longtext DEFAULT NULL,
  `questionnaire_response` longtext DEFAULT NULL,
  `lform` longtext DEFAULT NULL,
  `lform_response` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_reviewofs`
--

DROP TABLE IF EXISTS `form_reviewofs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_reviewofs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `pid` bigint(20) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `groupname` varchar(255) DEFAULT NULL,
  `authorized` tinyint(4) DEFAULT NULL,
  `activity` tinyint(4) DEFAULT NULL,
  `fever` varchar(5) DEFAULT NULL,
  `chills` varchar(5) DEFAULT NULL,
  `night_sweats` varchar(5) DEFAULT NULL,
  `weight_loss` varchar(5) DEFAULT NULL,
  `poor_appetite` varchar(5) DEFAULT NULL,
  `insomnia` varchar(5) DEFAULT NULL,
  `fatigued` varchar(5) DEFAULT NULL,
  `depressed` varchar(5) DEFAULT NULL,
  `hyperactive` varchar(5) DEFAULT NULL,
  `exposure_to_foreign_countries` varchar(5) DEFAULT NULL,
  `cataracts` varchar(5) DEFAULT NULL,
  `cataract_surgery` varchar(5) DEFAULT NULL,
  `glaucoma` varchar(5) DEFAULT NULL,
  `double_vision` varchar(5) DEFAULT NULL,
  `blurred_vision` varchar(5) DEFAULT NULL,
  `poor_hearing` varchar(5) DEFAULT NULL,
  `headaches` varchar(5) DEFAULT NULL,
  `ringing_in_ears` varchar(5) DEFAULT NULL,
  `bloody_nose` varchar(5) DEFAULT NULL,
  `sinusitis` varchar(5) DEFAULT NULL,
  `sinus_surgery` varchar(5) DEFAULT NULL,
  `dry_mouth` varchar(5) DEFAULT NULL,
  `strep_throat` varchar(5) DEFAULT NULL,
  `tonsillectomy` varchar(5) DEFAULT NULL,
  `swollen_lymph_nodes` varchar(5) DEFAULT NULL,
  `throat_cancer` varchar(5) DEFAULT NULL,
  `throat_cancer_surgery` varchar(5) DEFAULT NULL,
  `heart_attack` varchar(5) DEFAULT NULL,
  `irregular_heart_beat` varchar(5) DEFAULT NULL,
  `chest_pains` varchar(5) DEFAULT NULL,
  `shortness_of_breath` varchar(5) DEFAULT NULL,
  `high_blood_pressure` varchar(5) DEFAULT NULL,
  `heart_failure` varchar(5) DEFAULT NULL,
  `poor_circulation` varchar(5) DEFAULT NULL,
  `vascular_surgery` varchar(5) DEFAULT NULL,
  `cardiac_catheterization` varchar(5) DEFAULT NULL,
  `coronary_artery_bypass` varchar(5) DEFAULT NULL,
  `heart_transplant` varchar(5) DEFAULT NULL,
  `stress_test` varchar(5) DEFAULT NULL,
  `emphysema` varchar(5) DEFAULT NULL,
  `chronic_bronchitis` varchar(5) DEFAULT NULL,
  `interstitial_lung_disease` varchar(5) DEFAULT NULL,
  `shortness_of_breath_2` varchar(5) DEFAULT NULL,
  `lung_cancer` varchar(5) DEFAULT NULL,
  `lung_cancer_surgery` varchar(5) DEFAULT NULL,
  `pheumothorax` varchar(5) DEFAULT NULL,
  `stomach_pains` varchar(5) DEFAULT NULL,
  `peptic_ulcer_disease` varchar(5) DEFAULT NULL,
  `gastritis` varchar(5) DEFAULT NULL,
  `endoscopy` varchar(5) DEFAULT NULL,
  `polyps` varchar(5) DEFAULT NULL,
  `colonoscopy` varchar(5) DEFAULT NULL,
  `colon_cancer` varchar(5) DEFAULT NULL,
  `colon_cancer_surgery` varchar(5) DEFAULT NULL,
  `ulcerative_colitis` varchar(5) DEFAULT NULL,
  `crohns_disease` varchar(5) DEFAULT NULL,
  `appendectomy` varchar(5) DEFAULT NULL,
  `divirticulitis` varchar(5) DEFAULT NULL,
  `divirticulitis_surgery` varchar(5) DEFAULT NULL,
  `gall_stones` varchar(5) DEFAULT NULL,
  `cholecystectomy` varchar(5) DEFAULT NULL,
  `hepatitis` varchar(5) DEFAULT NULL,
  `cirrhosis_of_the_liver` varchar(5) DEFAULT NULL,
  `splenectomy` varchar(5) DEFAULT NULL,
  `kidney_failure` varchar(5) DEFAULT NULL,
  `kidney_stones` varchar(5) DEFAULT NULL,
  `kidney_cancer` varchar(5) DEFAULT NULL,
  `kidney_infections` varchar(5) DEFAULT NULL,
  `bladder_infections` varchar(5) DEFAULT NULL,
  `bladder_cancer` varchar(5) DEFAULT NULL,
  `prostate_problems` varchar(5) DEFAULT NULL,
  `prostate_cancer` varchar(5) DEFAULT NULL,
  `kidney_transplant` varchar(5) DEFAULT NULL,
  `sexually_transmitted_disease` varchar(5) DEFAULT NULL,
  `burning_with_urination` varchar(5) DEFAULT NULL,
  `discharge_from_urethra` varchar(5) DEFAULT NULL,
  `rashes` varchar(5) DEFAULT NULL,
  `infections` varchar(5) DEFAULT NULL,
  `ulcerations` varchar(5) DEFAULT NULL,
  `pemphigus` varchar(5) DEFAULT NULL,
  `herpes` varchar(5) DEFAULT NULL,
  `osetoarthritis` varchar(5) DEFAULT NULL,
  `rheumotoid_arthritis` varchar(5) DEFAULT NULL,
  `lupus` varchar(5) DEFAULT NULL,
  `ankylosing_sondlilitis` varchar(5) DEFAULT NULL,
  `swollen_joints` varchar(5) DEFAULT NULL,
  `stiff_joints` varchar(5) DEFAULT NULL,
  `broken_bones` varchar(5) DEFAULT NULL,
  `neck_problems` varchar(5) DEFAULT NULL,
  `back_problems` varchar(5) DEFAULT NULL,
  `back_surgery` varchar(5) DEFAULT NULL,
  `scoliosis` varchar(5) DEFAULT NULL,
  `herniated_disc` varchar(5) DEFAULT NULL,
  `shoulder_problems` varchar(5) DEFAULT NULL,
  `elbow_problems` varchar(5) DEFAULT NULL,
  `wrist_problems` varchar(5) DEFAULT NULL,
  `hand_problems` varchar(5) DEFAULT NULL,
  `hip_problems` varchar(5) DEFAULT NULL,
  `knee_problems` varchar(5) DEFAULT NULL,
  `ankle_problems` varchar(5) DEFAULT NULL,
  `foot_problems` varchar(5) DEFAULT NULL,
  `insulin_dependent_diabetes` varchar(5) DEFAULT NULL,
  `noninsulin_dependent_diabetes` varchar(5) DEFAULT NULL,
  `hypothyroidism` varchar(5) DEFAULT NULL,
  `hyperthyroidism` varchar(5) DEFAULT NULL,
  `cushing_syndrom` varchar(5) DEFAULT NULL,
  `addison_syndrom` varchar(5) DEFAULT NULL,
  `additional_notes` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_ros`
--

DROP TABLE IF EXISTS `form_ros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_ros` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` bigint(20) NOT NULL,
  `activity` int(11) NOT NULL DEFAULT 1,
  `date` datetime DEFAULT NULL,
  `weight_change` varchar(3) DEFAULT NULL,
  `weakness` varchar(3) DEFAULT NULL,
  `fatigue` varchar(3) DEFAULT NULL,
  `anorexia` varchar(3) DEFAULT NULL,
  `fever` varchar(3) DEFAULT NULL,
  `chills` varchar(3) DEFAULT NULL,
  `night_sweats` varchar(3) DEFAULT NULL,
  `insomnia` varchar(3) DEFAULT NULL,
  `irritability` varchar(3) DEFAULT NULL,
  `heat_or_cold` varchar(3) DEFAULT NULL,
  `intolerance` varchar(3) DEFAULT NULL,
  `change_in_vision` varchar(3) DEFAULT NULL,
  `glaucoma_history` varchar(3) DEFAULT NULL,
  `eye_pain` varchar(3) DEFAULT NULL,
  `irritation` varchar(3) DEFAULT NULL,
  `redness` varchar(3) DEFAULT NULL,
  `excessive_tearing` varchar(3) DEFAULT NULL,
  `double_vision` varchar(3) DEFAULT NULL,
  `blind_spots` varchar(3) DEFAULT NULL,
  `photophobia` varchar(3) DEFAULT NULL,
  `hearing_loss` varchar(3) DEFAULT NULL,
  `discharge` varchar(3) DEFAULT NULL,
  `pain` varchar(3) DEFAULT NULL,
  `vertigo` varchar(3) DEFAULT NULL,
  `tinnitus` varchar(3) DEFAULT NULL,
  `frequent_colds` varchar(3) DEFAULT NULL,
  `sore_throat` varchar(3) DEFAULT NULL,
  `sinus_problems` varchar(3) DEFAULT NULL,
  `post_nasal_drip` varchar(3) DEFAULT NULL,
  `nosebleed` varchar(3) DEFAULT NULL,
  `snoring` varchar(3) DEFAULT NULL,
  `apnea` varchar(3) DEFAULT NULL,
  `breast_mass` varchar(3) DEFAULT NULL,
  `breast_discharge` varchar(3) DEFAULT NULL,
  `biopsy` varchar(3) DEFAULT NULL,
  `abnormal_mammogram` varchar(3) DEFAULT NULL,
  `cough` varchar(3) DEFAULT NULL,
  `sputum` varchar(3) DEFAULT NULL,
  `shortness_of_breath` varchar(3) DEFAULT NULL,
  `wheezing` varchar(3) DEFAULT NULL,
  `hemoptsyis` varchar(3) DEFAULT NULL,
  `asthma` varchar(3) DEFAULT NULL,
  `copd` varchar(3) DEFAULT NULL,
  `chest_pain` varchar(3) DEFAULT NULL,
  `palpitation` varchar(3) DEFAULT NULL,
  `syncope` varchar(3) DEFAULT NULL,
  `pnd` varchar(3) DEFAULT NULL,
  `doe` varchar(3) DEFAULT NULL,
  `orthopnea` varchar(3) DEFAULT NULL,
  `peripheal` varchar(3) DEFAULT NULL,
  `edema` varchar(3) DEFAULT NULL,
  `legpain_cramping` varchar(3) DEFAULT NULL,
  `history_murmur` varchar(3) DEFAULT NULL,
  `arrythmia` varchar(3) DEFAULT NULL,
  `heart_problem` varchar(3) DEFAULT NULL,
  `dysphagia` varchar(3) DEFAULT NULL,
  `heartburn` varchar(3) DEFAULT NULL,
  `bloating` varchar(3) DEFAULT NULL,
  `belching` varchar(3) DEFAULT NULL,
  `flatulence` varchar(3) DEFAULT NULL,
  `nausea` varchar(3) DEFAULT NULL,
  `vomiting` varchar(3) DEFAULT NULL,
  `hematemesis` varchar(3) DEFAULT NULL,
  `gastro_pain` varchar(3) DEFAULT NULL,
  `food_intolerance` varchar(3) DEFAULT NULL,
  `hepatitis` varchar(3) DEFAULT NULL,
  `jaundice` varchar(3) DEFAULT NULL,
  `hematochezia` varchar(3) DEFAULT NULL,
  `changed_bowel` varchar(3) DEFAULT NULL,
  `diarrhea` varchar(3) DEFAULT NULL,
  `constipation` varchar(3) DEFAULT NULL,
  `polyuria` varchar(3) DEFAULT NULL,
  `polydypsia` varchar(3) DEFAULT NULL,
  `dysuria` varchar(3) DEFAULT NULL,
  `hematuria` varchar(3) DEFAULT NULL,
  `frequency` varchar(3) DEFAULT NULL,
  `urgency` varchar(3) DEFAULT NULL,
  `incontinence` varchar(3) DEFAULT NULL,
  `renal_stones` varchar(3) DEFAULT NULL,
  `utis` varchar(3) DEFAULT NULL,
  `hesitancy` varchar(3) DEFAULT NULL,
  `dribbling` varchar(3) DEFAULT NULL,
  `stream` varchar(3) DEFAULT NULL,
  `nocturia` varchar(3) DEFAULT NULL,
  `erections` varchar(3) DEFAULT NULL,
  `ejaculations` varchar(3) DEFAULT NULL,
  `g` varchar(3) DEFAULT NULL,
  `p` varchar(3) DEFAULT NULL,
  `ap` varchar(3) DEFAULT NULL,
  `lc` varchar(3) DEFAULT NULL,
  `mearche` varchar(3) DEFAULT NULL,
  `menopause` varchar(3) DEFAULT NULL,
  `lmp` varchar(3) DEFAULT NULL,
  `f_frequency` varchar(3) DEFAULT NULL,
  `f_flow` varchar(3) DEFAULT NULL,
  `f_symptoms` varchar(3) DEFAULT NULL,
  `abnormal_hair_growth` varchar(3) DEFAULT NULL,
  `f_hirsutism` varchar(3) DEFAULT NULL,
  `joint_pain` varchar(3) DEFAULT NULL,
  `swelling` varchar(3) DEFAULT NULL,
  `m_redness` varchar(3) DEFAULT NULL,
  `m_warm` varchar(3) DEFAULT NULL,
  `m_stiffness` varchar(3) DEFAULT NULL,
  `muscle` varchar(3) DEFAULT NULL,
  `m_aches` varchar(3) DEFAULT NULL,
  `fms` varchar(3) DEFAULT NULL,
  `arthritis` varchar(3) DEFAULT NULL,
  `loc` varchar(3) DEFAULT NULL,
  `seizures` varchar(3) DEFAULT NULL,
  `stroke` varchar(3) DEFAULT NULL,
  `tia` varchar(3) DEFAULT NULL,
  `n_numbness` varchar(3) DEFAULT NULL,
  `n_weakness` varchar(3) DEFAULT NULL,
  `paralysis` varchar(3) DEFAULT NULL,
  `intellectual_decline` varchar(3) DEFAULT NULL,
  `memory_problems` varchar(3) DEFAULT NULL,
  `dementia` varchar(3) DEFAULT NULL,
  `n_headache` varchar(3) DEFAULT NULL,
  `s_cancer` varchar(3) DEFAULT NULL,
  `psoriasis` varchar(3) DEFAULT NULL,
  `s_acne` varchar(3) DEFAULT NULL,
  `s_other` varchar(3) DEFAULT NULL,
  `s_disease` varchar(3) DEFAULT NULL,
  `p_diagnosis` varchar(3) DEFAULT NULL,
  `p_medication` varchar(3) DEFAULT NULL,
  `depression` varchar(3) DEFAULT NULL,
  `anxiety` varchar(3) DEFAULT NULL,
  `social_difficulties` varchar(3) DEFAULT NULL,
  `thyroid_problems` varchar(3) DEFAULT NULL,
  `diabetes` varchar(3) DEFAULT NULL,
  `abnormal_blood` varchar(3) DEFAULT NULL,
  `anemia` varchar(3) DEFAULT NULL,
  `fh_blood_problems` varchar(3) DEFAULT NULL,
  `bleeding_problems` varchar(3) DEFAULT NULL,
  `allergies` varchar(3) DEFAULT NULL,
  `frequent_illness` varchar(3) DEFAULT NULL,
  `hiv` varchar(3) DEFAULT NULL,
  `hai_status` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_soap`
--

DROP TABLE IF EXISTS `form_soap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_soap` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `pid` bigint(20) DEFAULT 0,
  `user` varchar(255) DEFAULT NULL,
  `groupname` varchar(255) DEFAULT NULL,
  `authorized` tinyint(4) DEFAULT 0,
  `activity` tinyint(4) DEFAULT 0,
  `subjective` text DEFAULT NULL,
  `objective` text DEFAULT NULL,
  `assessment` text DEFAULT NULL,
  `plan` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_taskman`
--

DROP TABLE IF EXISTS `form_taskman`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_taskman` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `REQ_DATE` datetime NOT NULL,
  `FROM_ID` bigint(20) NOT NULL,
  `TO_ID` bigint(20) NOT NULL,
  `PATIENT_ID` bigint(20) NOT NULL,
  `DOC_TYPE` varchar(20) DEFAULT NULL,
  `DOC_ID` bigint(20) DEFAULT NULL,
  `ENC_ID` bigint(20) DEFAULT NULL,
  `METHOD` varchar(20) NOT NULL,
  `COMPLETED` varchar(1) DEFAULT NULL COMMENT '1 = completed',
  `COMPLETED_DATE` datetime DEFAULT NULL,
  `COMMENT` varchar(50) DEFAULT NULL,
  `USERFIELD_1` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_vital_details`
--

DROP TABLE IF EXISTS `form_vital_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_vital_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `form_id` bigint(20) NOT NULL COMMENT 'FK to vital_forms.id',
  `vitals_column` varchar(64) NOT NULL COMMENT 'Column name from form_vitals',
  `interpretation_list_id` varchar(100) DEFAULT NULL COMMENT 'FK to list_options.list_id for observation_interpretation',
  `interpretation_option_id` varchar(100) DEFAULT NULL COMMENT 'FK to list_options.option_id for observation_interpretation',
  `interpretation_codes` varchar(255) DEFAULT NULL COMMENT 'Archived original codes value from list_options observation_interpretation',
  `interpretation_title` varchar(255) DEFAULT NULL COMMENT 'Archived original title value from list_options observation_interpretation',
  `reason_code` varchar(31) DEFAULT NULL COMMENT 'Medical code explaining reason of the vital observation value in form codesystem:codetype;...;',
  `reason_description` text DEFAULT NULL COMMENT 'Human readable text description of the reason_code column',
  `reason_status` varchar(31) DEFAULT NULL COMMENT 'The status of the reason ie completed, in progress, etc',
  PRIMARY KEY (`id`),
  KEY `fk_form_id` (`form_id`),
  KEY `fk_list_options_id` (`interpretation_list_id`,`interpretation_option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Detailed information of each vital_forms observation column';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_vitals`
--

DROP TABLE IF EXISTS `form_vitals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_vitals` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uuid` binary(16) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `pid` bigint(20) DEFAULT 0,
  `user` varchar(255) DEFAULT NULL,
  `groupname` varchar(255) DEFAULT NULL,
  `authorized` tinyint(4) DEFAULT 0,
  `activity` tinyint(4) DEFAULT 0,
  `bps` varchar(40) DEFAULT NULL,
  `bpd` varchar(40) DEFAULT NULL,
  `weight` decimal(12,6) DEFAULT 0.000000,
  `height` decimal(12,6) DEFAULT 0.000000,
  `temperature` decimal(12,6) DEFAULT 0.000000,
  `temp_method` varchar(255) DEFAULT NULL,
  `pulse` decimal(12,6) DEFAULT 0.000000,
  `respiration` decimal(12,6) DEFAULT 0.000000,
  `note` varchar(255) DEFAULT NULL,
  `BMI` decimal(12,6) DEFAULT 0.000000,
  `BMI_status` varchar(255) DEFAULT NULL,
  `waist_circ` decimal(12,6) DEFAULT 0.000000,
  `head_circ` decimal(12,6) DEFAULT 0.000000,
  `oxygen_saturation` decimal(6,2) DEFAULT 0.00,
  `oxygen_flow_rate` decimal(12,6) DEFAULT 0.000000,
  `external_id` varchar(20) DEFAULT NULL,
  `ped_weight_height` decimal(6,2) DEFAULT 0.00,
  `ped_bmi` decimal(6,2) DEFAULT 0.00,
  `ped_head_circ` decimal(6,2) DEFAULT 0.00,
  `inhaled_oxygen_concentration` decimal(6,2) DEFAULT 0.00,
  `last_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `pid` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `forms`
--

DROP TABLE IF EXISTS `forms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `forms` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `encounter` bigint(20) DEFAULT NULL,
  `form_name` longtext DEFAULT NULL,
  `form_id` bigint(20) DEFAULT NULL,
  `pid` bigint(20) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `groupname` varchar(255) DEFAULT NULL,
  `authorized` tinyint(4) DEFAULT NULL,
  `deleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'flag indicates form has been deleted',
  `formdir` longtext DEFAULT NULL,
  `therapy_group_id` int(11) DEFAULT NULL,
  `issue_id` bigint(20) NOT NULL DEFAULT 0 COMMENT 'references lists.id to identify a case',
  `provider_id` bigint(20) NOT NULL DEFAULT 0 COMMENT 'references users.id to identify a provider',
  PRIMARY KEY (`id`),
  KEY `pid_encounter` (`pid`,`encounter`),
  KEY `form_id` (`form_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gacl_acl`
--

DROP TABLE IF EXISTS `gacl_acl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `gacl_acl` (
  `id` int(11) NOT NULL DEFAULT 0,
  `section_value` varchar(150) NOT NULL DEFAULT 'system',
  `allow` int(11) NOT NULL DEFAULT 0,
  `enabled` int(11) NOT NULL DEFAULT 0,
  `return_value` text DEFAULT NULL,
  `note` text DEFAULT NULL,
  `updated_date` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `gacl_enabled_acl` (`enabled`),
  KEY `gacl_section_value_acl` (`section_value`),
  KEY `gacl_updated_date_acl` (`updated_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gacl_acl_sections`
--

DROP TABLE IF EXISTS `gacl_acl_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `gacl_acl_sections` (
  `id` int(11) NOT NULL DEFAULT 0,
  `value` varchar(150) NOT NULL,
  `order_value` int(11) NOT NULL DEFAULT 0,
  `name` varchar(230) NOT NULL,
  `hidden` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `gacl_value_acl_sections` (`value`),
  KEY `gacl_hidden_acl_sections` (`hidden`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gacl_acl_seq`
--

DROP TABLE IF EXISTS `gacl_acl_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `gacl_acl_seq` (
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gacl_aco`
--

DROP TABLE IF EXISTS `gacl_aco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `gacl_aco` (
  `id` int(11) NOT NULL DEFAULT 0,
  `section_value` varchar(150) NOT NULL DEFAULT '0',
  `value` varchar(150) NOT NULL,
  `order_value` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL,
  `hidden` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `gacl_section_value_value_aco` (`section_value`,`value`),
  KEY `gacl_hidden_aco` (`hidden`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gacl_aco_map`
--

DROP TABLE IF EXISTS `gacl_aco_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `gacl_aco_map` (
  `acl_id` int(11) NOT NULL DEFAULT 0,
  `section_value` varchar(150) NOT NULL DEFAULT '0',
  `value` varchar(150) NOT NULL,
  PRIMARY KEY (`acl_id`,`section_value`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gacl_aco_sections`
--

DROP TABLE IF EXISTS `gacl_aco_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `gacl_aco_sections` (
  `id` int(11) NOT NULL DEFAULT 0,
  `value` varchar(150) NOT NULL,
  `order_value` int(11) NOT NULL DEFAULT 0,
  `name` varchar(230) NOT NULL,
  `hidden` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `gacl_value_aco_sections` (`value`),
  KEY `gacl_hidden_aco_sections` (`hidden`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gacl_aco_sections_seq`
--

DROP TABLE IF EXISTS `gacl_aco_sections_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `gacl_aco_sections_seq` (
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gacl_aco_seq`
--

DROP TABLE IF EXISTS `gacl_aco_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `gacl_aco_seq` (
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gacl_aro`
--

DROP TABLE IF EXISTS `gacl_aro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `gacl_aro` (
  `id` int(11) NOT NULL DEFAULT 0,
  `section_value` varchar(150) NOT NULL DEFAULT '0',
  `value` varchar(150) NOT NULL,
  `order_value` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL,
  `hidden` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `gacl_section_value_value_aro` (`section_value`,`value`),
  KEY `gacl_hidden_aro` (`hidden`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gacl_aro_groups`
--

DROP TABLE IF EXISTS `gacl_aro_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `gacl_aro_groups` (
  `id` int(11) NOT NULL DEFAULT 0,
  `parent_id` int(11) NOT NULL DEFAULT 0,
  `lft` int(11) NOT NULL DEFAULT 0,
  `rgt` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL,
  `value` varchar(150) NOT NULL,
  PRIMARY KEY (`id`,`value`),
  UNIQUE KEY `gacl_value_aro_groups` (`value`),
  KEY `gacl_parent_id_aro_groups` (`parent_id`),
  KEY `gacl_lft_rgt_aro_groups` (`lft`,`rgt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gacl_aro_groups_id_seq`
--

DROP TABLE IF EXISTS `gacl_aro_groups_id_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `gacl_aro_groups_id_seq` (
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gacl_aro_groups_map`
--

DROP TABLE IF EXISTS `gacl_aro_groups_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `gacl_aro_groups_map` (
  `acl_id` int(11) NOT NULL DEFAULT 0,
  `group_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`acl_id`,`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gacl_aro_map`
--

DROP TABLE IF EXISTS `gacl_aro_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `gacl_aro_map` (
  `acl_id` int(11) NOT NULL DEFAULT 0,
  `section_value` varchar(150) NOT NULL DEFAULT '0',
  `value` varchar(150) NOT NULL,
  PRIMARY KEY (`acl_id`,`section_value`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gacl_aro_sections`
--

DROP TABLE IF EXISTS `gacl_aro_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `gacl_aro_sections` (
  `id` int(11) NOT NULL DEFAULT 0,
  `value` varchar(150) NOT NULL,
  `order_value` int(11) NOT NULL DEFAULT 0,
  `name` varchar(230) NOT NULL,
  `hidden` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `gacl_value_aro_sections` (`value`),
  KEY `gacl_hidden_aro_sections` (`hidden`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gacl_aro_sections_seq`
--

DROP TABLE IF EXISTS `gacl_aro_sections_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `gacl_aro_sections_seq` (
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gacl_aro_seq`
--

DROP TABLE IF EXISTS `gacl_aro_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `gacl_aro_seq` (
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gacl_axo`
--

DROP TABLE IF EXISTS `gacl_axo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `gacl_axo` (
  `id` int(11) NOT NULL DEFAULT 0,
  `section_value` varchar(150) NOT NULL DEFAULT '0',
  `value` varchar(150) NOT NULL,
  `order_value` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL,
  `hidden` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `gacl_section_value_value_axo` (`section_value`,`value`),
  KEY `gacl_hidden_axo` (`hidden`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gacl_axo_groups`
--

DROP TABLE IF EXISTS `gacl_axo_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `gacl_axo_groups` (
  `id` int(11) NOT NULL DEFAULT 0,
  `parent_id` int(11) NOT NULL DEFAULT 0,
  `lft` int(11) NOT NULL DEFAULT 0,
  `rgt` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL,
  `value` varchar(150) NOT NULL,
  PRIMARY KEY (`id`,`value`),
  UNIQUE KEY `gacl_value_axo_groups` (`value`),
  KEY `gacl_parent_id_axo_groups` (`parent_id`),
  KEY `gacl_lft_rgt_axo_groups` (`lft`,`rgt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gacl_axo_groups_map`
--

DROP TABLE IF EXISTS `gacl_axo_groups_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `gacl_axo_groups_map` (
  `acl_id` int(11) NOT NULL DEFAULT 0,
  `group_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`acl_id`,`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gacl_axo_map`
--

DROP TABLE IF EXISTS `gacl_axo_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `gacl_axo_map` (
  `acl_id` int(11) NOT NULL DEFAULT 0,
  `section_value` varchar(150) NOT NULL DEFAULT '0',
  `value` varchar(150) NOT NULL,
  PRIMARY KEY (`acl_id`,`section_value`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gacl_axo_sections`
--

DROP TABLE IF EXISTS `gacl_axo_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `gacl_axo_sections` (
  `id` int(11) NOT NULL DEFAULT 0,
  `value` varchar(150) NOT NULL,
  `order_value` int(11) NOT NULL DEFAULT 0,
  `name` varchar(230) NOT NULL,
  `hidden` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `gacl_value_axo_sections` (`value`),
  KEY `gacl_hidden_axo_sections` (`hidden`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gacl_groups_aro_map`
--

DROP TABLE IF EXISTS `gacl_groups_aro_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `gacl_groups_aro_map` (
  `group_id` int(11) NOT NULL DEFAULT 0,
  `aro_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`group_id`,`aro_id`),
  KEY `gacl_aro_id` (`aro_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gacl_groups_axo_map`
--

DROP TABLE IF EXISTS `gacl_groups_axo_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `gacl_groups_axo_map` (
  `group_id` int(11) NOT NULL DEFAULT 0,
  `axo_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`group_id`,`axo_id`),
  KEY `gacl_axo_id` (`axo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gacl_phpgacl`
--

DROP TABLE IF EXISTS `gacl_phpgacl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `gacl_phpgacl` (
  `name` varchar(230) NOT NULL,
  `value` varchar(150) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `globals`
--

DROP TABLE IF EXISTS `globals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `globals` (
  `gl_name` varchar(63) NOT NULL,
  `gl_index` int(11) NOT NULL DEFAULT 0,
  `gl_value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`gl_name`,`gl_index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gprelations`
--

DROP TABLE IF EXISTS `gprelations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `gprelations` (
  `type1` int(2) NOT NULL,
  `id1` bigint(20) NOT NULL,
  `type2` int(2) NOT NULL,
  `id2` bigint(20) NOT NULL,
  PRIMARY KEY (`type1`,`id1`,`type2`,`id2`),
  KEY `key2` (`type2`,`id2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='general purpose relations';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` longtext DEFAULT NULL,
  `user` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `history_data`
--

DROP TABLE IF EXISTS `history_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `history_data` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uuid` binary(16) DEFAULT NULL,
  `coffee` longtext DEFAULT NULL,
  `tobacco` longtext DEFAULT NULL,
  `alcohol` longtext DEFAULT NULL,
  `sleep_patterns` longtext DEFAULT NULL,
  `exercise_patterns` longtext DEFAULT NULL,
  `seatbelt_use` longtext DEFAULT NULL,
  `counseling` longtext DEFAULT NULL,
  `hazardous_activities` longtext DEFAULT NULL,
  `recreational_drugs` longtext DEFAULT NULL,
  `last_breast_exam` varchar(255) DEFAULT NULL,
  `last_mammogram` varchar(255) DEFAULT NULL,
  `last_gynocological_exam` varchar(255) DEFAULT NULL,
  `last_rectal_exam` varchar(255) DEFAULT NULL,
  `last_prostate_exam` varchar(255) DEFAULT NULL,
  `last_physical_exam` varchar(255) DEFAULT NULL,
  `last_sigmoidoscopy_colonoscopy` varchar(255) DEFAULT NULL,
  `last_ecg` varchar(255) DEFAULT NULL,
  `last_cardiac_echo` varchar(255) DEFAULT NULL,
  `last_retinal` varchar(255) DEFAULT NULL,
  `last_fluvax` varchar(255) DEFAULT NULL,
  `last_pneuvax` varchar(255) DEFAULT NULL,
  `last_ldl` varchar(255) DEFAULT NULL,
  `last_hemoglobin` varchar(255) DEFAULT NULL,
  `last_psa` varchar(255) DEFAULT NULL,
  `last_exam_results` varchar(255) DEFAULT NULL,
  `history_mother` longtext DEFAULT NULL,
  `dc_mother` text DEFAULT NULL,
  `history_father` longtext DEFAULT NULL,
  `dc_father` text DEFAULT NULL,
  `history_siblings` longtext DEFAULT NULL,
  `dc_siblings` text DEFAULT NULL,
  `history_offspring` longtext DEFAULT NULL,
  `dc_offspring` text DEFAULT NULL,
  `history_spouse` longtext DEFAULT NULL,
  `dc_spouse` text DEFAULT NULL,
  `relatives_cancer` longtext DEFAULT NULL,
  `relatives_tuberculosis` longtext DEFAULT NULL,
  `relatives_diabetes` longtext DEFAULT NULL,
  `relatives_high_blood_pressure` longtext DEFAULT NULL,
  `relatives_heart_problems` longtext DEFAULT NULL,
  `relatives_stroke` longtext DEFAULT NULL,
  `relatives_epilepsy` longtext DEFAULT NULL,
  `relatives_mental_illness` longtext DEFAULT NULL,
  `relatives_suicide` longtext DEFAULT NULL,
  `cataract_surgery` datetime DEFAULT NULL,
  `tonsillectomy` datetime DEFAULT NULL,
  `cholecystestomy` datetime DEFAULT NULL,
  `heart_surgery` datetime DEFAULT NULL,
  `hysterectomy` datetime DEFAULT NULL,
  `hernia_repair` datetime DEFAULT NULL,
  `hip_replacement` datetime DEFAULT NULL,
  `knee_replacement` datetime DEFAULT NULL,
  `appendectomy` datetime DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `pid` bigint(20) NOT NULL DEFAULT 0,
  `name_1` varchar(255) DEFAULT NULL,
  `value_1` varchar(255) DEFAULT NULL,
  `name_2` varchar(255) DEFAULT NULL,
  `value_2` varchar(255) DEFAULT NULL,
  `additional_history` text DEFAULT NULL,
  `exams` text DEFAULT NULL,
  `usertext11` text DEFAULT NULL,
  `usertext12` varchar(255) NOT NULL DEFAULT '',
  `usertext13` varchar(255) NOT NULL DEFAULT '',
  `usertext14` varchar(255) NOT NULL DEFAULT '',
  `usertext15` varchar(255) NOT NULL DEFAULT '',
  `usertext16` varchar(255) NOT NULL DEFAULT '',
  `usertext17` varchar(255) NOT NULL DEFAULT '',
  `usertext18` varchar(255) NOT NULL DEFAULT '',
  `usertext19` varchar(255) NOT NULL DEFAULT '',
  `usertext20` varchar(255) NOT NULL DEFAULT '',
  `usertext21` varchar(255) NOT NULL DEFAULT '',
  `usertext22` varchar(255) NOT NULL DEFAULT '',
  `usertext23` varchar(255) NOT NULL DEFAULT '',
  `usertext24` varchar(255) NOT NULL DEFAULT '',
  `usertext25` varchar(255) NOT NULL DEFAULT '',
  `usertext26` varchar(255) NOT NULL DEFAULT '',
  `usertext27` varchar(255) NOT NULL DEFAULT '',
  `usertext28` varchar(255) NOT NULL DEFAULT '',
  `usertext29` varchar(255) NOT NULL DEFAULT '',
  `usertext30` varchar(255) NOT NULL DEFAULT '',
  `userdate11` date DEFAULT NULL,
  `userdate12` date DEFAULT NULL,
  `userdate13` date DEFAULT NULL,
  `userdate14` date DEFAULT NULL,
  `userdate15` date DEFAULT NULL,
  `userarea11` text DEFAULT NULL,
  `userarea12` text DEFAULT NULL,
  `created_by` bigint(20) DEFAULT NULL COMMENT 'users.id the user that first created this record',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `pid` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `icd10_dx_order_code`
--

DROP TABLE IF EXISTS `icd10_dx_order_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `icd10_dx_order_code` (
  `dx_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `dx_code` varchar(7) DEFAULT NULL,
  `formatted_dx_code` varchar(10) DEFAULT NULL,
  `valid_for_coding` char(1) DEFAULT NULL,
  `short_desc` varchar(60) DEFAULT NULL,
  `long_desc` text DEFAULT NULL,
  `active` tinyint(4) DEFAULT 0,
  `revision` int(11) DEFAULT 0,
  UNIQUE KEY `dx_id` (`dx_id`),
  KEY `formatted_dx_code` (`formatted_dx_code`),
  KEY `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `icd10_gem_dx_10_9`
--

DROP TABLE IF EXISTS `icd10_gem_dx_10_9`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `icd10_gem_dx_10_9` (
  `map_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `dx_icd10_source` varchar(7) DEFAULT NULL,
  `dx_icd9_target` varchar(5) DEFAULT NULL,
  `flags` varchar(5) DEFAULT NULL,
  `active` tinyint(4) DEFAULT 0,
  `revision` int(11) DEFAULT 0,
  UNIQUE KEY `map_id` (`map_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `icd10_gem_dx_9_10`
--

DROP TABLE IF EXISTS `icd10_gem_dx_9_10`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `icd10_gem_dx_9_10` (
  `map_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `dx_icd9_source` varchar(5) DEFAULT NULL,
  `dx_icd10_target` varchar(7) DEFAULT NULL,
  `flags` varchar(5) DEFAULT NULL,
  `active` tinyint(4) DEFAULT 0,
  `revision` int(11) DEFAULT 0,
  UNIQUE KEY `map_id` (`map_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `icd10_gem_pcs_10_9`
--

DROP TABLE IF EXISTS `icd10_gem_pcs_10_9`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `icd10_gem_pcs_10_9` (
  `map_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pcs_icd10_source` varchar(7) DEFAULT NULL,
  `pcs_icd9_target` varchar(5) DEFAULT NULL,
  `flags` varchar(5) DEFAULT NULL,
  `active` tinyint(4) DEFAULT 0,
  `revision` int(11) DEFAULT 0,
  UNIQUE KEY `map_id` (`map_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `icd10_gem_pcs_9_10`
--

DROP TABLE IF EXISTS `icd10_gem_pcs_9_10`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `icd10_gem_pcs_9_10` (
  `map_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pcs_icd9_source` varchar(5) DEFAULT NULL,
  `pcs_icd10_target` varchar(7) DEFAULT NULL,
  `flags` varchar(5) DEFAULT NULL,
  `active` tinyint(4) DEFAULT 0,
  `revision` int(11) DEFAULT 0,
  UNIQUE KEY `map_id` (`map_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `icd10_pcs_order_code`
--

DROP TABLE IF EXISTS `icd10_pcs_order_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `icd10_pcs_order_code` (
  `pcs_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pcs_code` varchar(7) DEFAULT NULL,
  `valid_for_coding` char(1) DEFAULT NULL,
  `short_desc` varchar(60) DEFAULT NULL,
  `long_desc` text DEFAULT NULL,
  `active` tinyint(4) DEFAULT 0,
  `revision` int(11) DEFAULT 0,
  UNIQUE KEY `pcs_id` (`pcs_id`),
  KEY `pcs_code` (`pcs_code`),
  KEY `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `icd10_reimbr_dx_9_10`
--

DROP TABLE IF EXISTS `icd10_reimbr_dx_9_10`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `icd10_reimbr_dx_9_10` (
  `map_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(8) DEFAULT NULL,
  `code_cnt` tinyint(4) DEFAULT NULL,
  `ICD9_01` varchar(5) DEFAULT NULL,
  `ICD9_02` varchar(5) DEFAULT NULL,
  `ICD9_03` varchar(5) DEFAULT NULL,
  `ICD9_04` varchar(5) DEFAULT NULL,
  `ICD9_05` varchar(5) DEFAULT NULL,
  `ICD9_06` varchar(5) DEFAULT NULL,
  `active` tinyint(4) DEFAULT 0,
  `revision` int(11) DEFAULT 0,
  UNIQUE KEY `map_id` (`map_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `icd10_reimbr_pcs_9_10`
--

DROP TABLE IF EXISTS `icd10_reimbr_pcs_9_10`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `icd10_reimbr_pcs_9_10` (
  `map_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(8) DEFAULT NULL,
  `code_cnt` tinyint(4) DEFAULT NULL,
  `ICD9_01` varchar(5) DEFAULT NULL,
  `ICD9_02` varchar(5) DEFAULT NULL,
  `ICD9_03` varchar(5) DEFAULT NULL,
  `ICD9_04` varchar(5) DEFAULT NULL,
  `ICD9_05` varchar(5) DEFAULT NULL,
  `ICD9_06` varchar(5) DEFAULT NULL,
  `active` tinyint(4) DEFAULT 0,
  `revision` int(11) DEFAULT 0,
  UNIQUE KEY `map_id` (`map_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `icd9_dx_code`
--

DROP TABLE IF EXISTS `icd9_dx_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `icd9_dx_code` (
  `dx_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `dx_code` varchar(5) DEFAULT NULL,
  `formatted_dx_code` varchar(6) DEFAULT NULL,
  `short_desc` varchar(60) DEFAULT NULL,
  `long_desc` varchar(300) DEFAULT NULL,
  `active` tinyint(4) DEFAULT 0,
  `revision` int(11) DEFAULT 0,
  UNIQUE KEY `dx_id` (`dx_id`),
  KEY `dx_code` (`dx_code`),
  KEY `formatted_dx_code` (`formatted_dx_code`),
  KEY `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `icd9_dx_long_code`
--

DROP TABLE IF EXISTS `icd9_dx_long_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `icd9_dx_long_code` (
  `dx_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `dx_code` varchar(5) DEFAULT NULL,
  `long_desc` varchar(300) DEFAULT NULL,
  `active` tinyint(4) DEFAULT 0,
  `revision` int(11) DEFAULT 0,
  UNIQUE KEY `dx_id` (`dx_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `icd9_sg_code`
--

DROP TABLE IF EXISTS `icd9_sg_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `icd9_sg_code` (
  `sg_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sg_code` varchar(5) DEFAULT NULL,
  `formatted_sg_code` varchar(6) DEFAULT NULL,
  `short_desc` varchar(60) DEFAULT NULL,
  `long_desc` varchar(300) DEFAULT NULL,
  `active` tinyint(4) DEFAULT 0,
  `revision` int(11) DEFAULT 0,
  UNIQUE KEY `sg_id` (`sg_id`),
  KEY `sg_code` (`sg_code`),
  KEY `formatted_sg_code` (`formatted_sg_code`),
  KEY `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `icd9_sg_long_code`
--

DROP TABLE IF EXISTS `icd9_sg_long_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `icd9_sg_long_code` (
  `sq_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sg_code` varchar(5) DEFAULT NULL,
  `long_desc` varchar(300) DEFAULT NULL,
  `active` tinyint(4) DEFAULT 0,
  `revision` int(11) DEFAULT 0,
  UNIQUE KEY `sq_id` (`sq_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `immunization_observation`
--

DROP TABLE IF EXISTS `immunization_observation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `immunization_observation` (
  `imo_id` int(11) NOT NULL AUTO_INCREMENT,
  `imo_im_id` int(11) NOT NULL,
  `imo_pid` int(11) DEFAULT NULL,
  `imo_criteria` varchar(255) DEFAULT NULL,
  `imo_criteria_value` varchar(255) DEFAULT NULL,
  `imo_user` int(11) DEFAULT NULL,
  `imo_code` varchar(255) DEFAULT NULL,
  `imo_codetext` varchar(255) DEFAULT NULL,
  `imo_codetype` varchar(255) DEFAULT NULL,
  `imo_vis_date_published` date DEFAULT NULL,
  `imo_vis_date_presented` date DEFAULT NULL,
  `imo_date_observation` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`imo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `immunizations`
--

DROP TABLE IF EXISTS `immunizations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `immunizations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uuid` binary(16) DEFAULT NULL,
  `patient_id` bigint(20) DEFAULT NULL,
  `administered_date` datetime DEFAULT NULL,
  `immunization_id` int(11) DEFAULT NULL,
  `cvx_code` varchar(64) DEFAULT NULL,
  `manufacturer` varchar(100) DEFAULT NULL,
  `lot_number` varchar(50) DEFAULT NULL,
  `administered_by_id` bigint(20) DEFAULT NULL,
  `administered_by` varchar(255) DEFAULT NULL COMMENT 'Alternative to administered_by_id',
  `education_date` date DEFAULT NULL,
  `vis_date` date DEFAULT NULL COMMENT 'Date of VIS Statement',
  `note` text DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` timestamp NOT NULL,
  `created_by` bigint(20) DEFAULT NULL,
  `updated_by` bigint(20) DEFAULT NULL,
  `amount_administered` float DEFAULT NULL,
  `amount_administered_unit` varchar(50) DEFAULT NULL,
  `expiration_date` date DEFAULT NULL,
  `route` varchar(100) DEFAULT NULL,
  `administration_site` varchar(100) DEFAULT NULL,
  `added_erroneously` tinyint(1) NOT NULL DEFAULT 0,
  `external_id` varchar(20) DEFAULT NULL,
  `completion_status` varchar(50) DEFAULT NULL,
  `information_source` varchar(31) DEFAULT NULL,
  `refusal_reason` varchar(31) DEFAULT NULL,
  `ordering_provider` int(11) DEFAULT NULL,
  `reason_code` varchar(31) DEFAULT NULL COMMENT 'Medical code explaining reason of the vital observation value in form codesystem:codetype;...;',
  `reason_description` text DEFAULT NULL COMMENT 'Human readable text description of the reason_code column',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `patient_id` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `insurance_companies`
--

DROP TABLE IF EXISTS `insurance_companies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `insurance_companies` (
  `id` int(11) NOT NULL DEFAULT 0,
  `uuid` binary(16) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `attn` varchar(255) DEFAULT NULL,
  `cms_id` varchar(15) DEFAULT NULL,
  `ins_type_code` int(11) DEFAULT NULL,
  `x12_receiver_id` varchar(25) DEFAULT NULL,
  `x12_default_partner_id` int(11) DEFAULT NULL,
  `alt_cms_id` varchar(15) DEFAULT NULL,
  `inactive` tinyint(1) NOT NULL DEFAULT 0,
  `eligibility_id` varchar(32) DEFAULT NULL,
  `x12_default_eligibility_id` int(11) DEFAULT NULL,
  `cqm_sop` int(11) DEFAULT NULL COMMENT 'HL7 Source of Payment for eCQMs',
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `last_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `insurance_data`
--

DROP TABLE IF EXISTS `insurance_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `insurance_data` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uuid` binary(16) DEFAULT NULL,
  `type` enum('primary','secondary','tertiary') DEFAULT NULL,
  `provider` varchar(255) DEFAULT NULL,
  `plan_name` varchar(255) DEFAULT NULL,
  `policy_number` varchar(255) DEFAULT NULL,
  `group_number` varchar(255) DEFAULT NULL,
  `subscriber_lname` varchar(255) DEFAULT NULL,
  `subscriber_mname` varchar(255) DEFAULT NULL,
  `subscriber_fname` varchar(255) DEFAULT NULL,
  `subscriber_relationship` varchar(255) DEFAULT NULL,
  `subscriber_ss` varchar(255) DEFAULT NULL,
  `subscriber_DOB` date DEFAULT NULL,
  `subscriber_street` varchar(255) DEFAULT NULL,
  `subscriber_postal_code` varchar(255) DEFAULT NULL,
  `subscriber_city` varchar(255) DEFAULT NULL,
  `subscriber_state` varchar(255) DEFAULT NULL,
  `subscriber_country` varchar(255) DEFAULT NULL,
  `subscriber_phone` varchar(255) DEFAULT NULL,
  `subscriber_employer` varchar(255) DEFAULT NULL,
  `subscriber_employer_street` varchar(255) DEFAULT NULL,
  `subscriber_employer_postal_code` varchar(255) DEFAULT NULL,
  `subscriber_employer_state` varchar(255) DEFAULT NULL,
  `subscriber_employer_country` varchar(255) DEFAULT NULL,
  `subscriber_employer_city` varchar(255) DEFAULT NULL,
  `copay` varchar(255) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `pid` bigint(20) NOT NULL DEFAULT 0,
  `subscriber_sex` varchar(25) DEFAULT NULL,
  `accept_assignment` varchar(5) NOT NULL DEFAULT 'TRUE',
  `policy_type` varchar(25) NOT NULL DEFAULT '',
  `subscriber_street_line_2` tinytext DEFAULT NULL,
  `subscriber_employer_street_line_2` tinytext DEFAULT NULL,
  `date_end` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `pid_type_date` (`pid`,`type`,`date`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `insurance_numbers`
--

DROP TABLE IF EXISTS `insurance_numbers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `insurance_numbers` (
  `id` int(11) NOT NULL DEFAULT 0,
  `provider_id` int(11) NOT NULL DEFAULT 0,
  `insurance_company_id` int(11) DEFAULT NULL,
  `provider_number` varchar(20) DEFAULT NULL,
  `rendering_provider_number` varchar(20) DEFAULT NULL,
  `group_number` varchar(20) DEFAULT NULL,
  `provider_number_type` varchar(4) DEFAULT NULL,
  `rendering_provider_number_type` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `insurance_type_codes`
--

DROP TABLE IF EXISTS `insurance_type_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `insurance_type_codes` (
  `id` int(2) NOT NULL,
  `type` varchar(60) NOT NULL,
  `claim_type` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ip_tracking`
--

DROP TABLE IF EXISTS `ip_tracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ip_tracking` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ip_string` varchar(255) DEFAULT '',
  `total_ip_login_fail_counter` bigint(20) DEFAULT 0,
  `ip_login_fail_counter` bigint(20) DEFAULT 0,
  `ip_last_login_fail` datetime DEFAULT NULL,
  `ip_auto_block_emailed` tinyint(4) DEFAULT 0,
  `ip_force_block` tinyint(4) DEFAULT 0,
  `ip_no_prevent_timing_attack` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ip_string` (`ip_string`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `issue_encounter`
--

DROP TABLE IF EXISTS `issue_encounter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `issue_encounter` (
  `pid` bigint(20) NOT NULL,
  `list_id` int(11) NOT NULL,
  `encounter` int(11) NOT NULL,
  `resolved` tinyint(1) NOT NULL,
  PRIMARY KEY (`pid`,`list_id`,`encounter`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `issue_types`
--

DROP TABLE IF EXISTS `issue_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `issue_types` (
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `category` varchar(75) NOT NULL DEFAULT '',
  `type` varchar(75) NOT NULL DEFAULT '',
  `plural` varchar(75) NOT NULL DEFAULT '',
  `singular` varchar(75) NOT NULL DEFAULT '',
  `abbreviation` varchar(75) NOT NULL DEFAULT '',
  `style` smallint(6) NOT NULL DEFAULT 0,
  `force_show` smallint(6) NOT NULL DEFAULT 0,
  `ordering` int(11) NOT NULL DEFAULT 0,
  `aco_spec` varchar(63) NOT NULL DEFAULT 'patients|med',
  PRIMARY KEY (`category`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jwt_grant_history`
--

DROP TABLE IF EXISTS `jwt_grant_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `jwt_grant_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jti` varchar(100) NOT NULL COMMENT 'Unique JWT id',
  `client_id` varchar(80) NOT NULL COMMENT 'FK oauth2_clients.client_id',
  `jti_exp` timestamp NULL DEFAULT NULL COMMENT 'jwt exp claim when the jwt expires',
  `creation_date` datetime NOT NULL DEFAULT current_timestamp() COMMENT 'datetime the grant authorization was requested',
  PRIMARY KEY (`id`),
  KEY `jti` (`jti`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Holds JWT authorization grant ids to prevent replay attacks';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `keys`
--

DROP TABLE IF EXISTS `keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `keys` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL DEFAULT '',
  `value` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lang_constants`
--

DROP TABLE IF EXISTS `lang_constants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `lang_constants` (
  `cons_id` int(11) NOT NULL AUTO_INCREMENT,
  `constant_name` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  UNIQUE KEY `cons_id` (`cons_id`),
  KEY `constant_name` (`constant_name`(100))
) ENGINE=InnoDB AUTO_INCREMENT=13235 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lang_custom`
--

DROP TABLE IF EXISTS `lang_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `lang_custom` (
  `lang_description` varchar(100) NOT NULL DEFAULT '',
  `lang_code` char(2) NOT NULL DEFAULT '',
  `constant_name` mediumtext DEFAULT NULL,
  `definition` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lang_definitions`
--

DROP TABLE IF EXISTS `lang_definitions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `lang_definitions` (
  `def_id` int(11) NOT NULL AUTO_INCREMENT,
  `cons_id` int(11) NOT NULL DEFAULT 0,
  `lang_id` int(11) NOT NULL DEFAULT 0,
  `definition` mediumtext DEFAULT NULL,
  UNIQUE KEY `def_id` (`def_id`),
  KEY `cons_id` (`cons_id`)
) ENGINE=InnoDB AUTO_INCREMENT=237510 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lang_languages`
--

DROP TABLE IF EXISTS `lang_languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `lang_languages` (
  `lang_id` int(11) NOT NULL AUTO_INCREMENT,
  `lang_code` char(2) NOT NULL DEFAULT '',
  `lang_description` varchar(100) DEFAULT NULL,
  `lang_is_rtl` tinyint(4) DEFAULT 0,
  UNIQUE KEY `lang_id` (`lang_id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `layout_group_properties`
--

DROP TABLE IF EXISTS `layout_group_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `layout_group_properties` (
  `grp_form_id` varchar(31) NOT NULL,
  `grp_group_id` varchar(31) NOT NULL DEFAULT '' COMMENT 'empty when representing the whole form',
  `grp_title` varchar(63) NOT NULL DEFAULT '' COMMENT 'descriptive name of the form or group',
  `grp_subtitle` varchar(63) NOT NULL DEFAULT '' COMMENT 'for display under the title',
  `grp_mapping` varchar(31) NOT NULL DEFAULT '' COMMENT 'the form category',
  `grp_seq` int(11) NOT NULL DEFAULT 0 COMMENT 'optional order within mapping',
  `grp_activity` tinyint(1) NOT NULL DEFAULT 1,
  `grp_repeats` int(11) NOT NULL DEFAULT 0,
  `grp_columns` int(11) NOT NULL DEFAULT 0,
  `grp_size` int(11) NOT NULL DEFAULT 0,
  `grp_issue_type` varchar(75) NOT NULL DEFAULT '',
  `grp_aco_spec` varchar(63) NOT NULL DEFAULT '',
  `grp_save_close` tinyint(1) NOT NULL DEFAULT 0,
  `grp_init_open` tinyint(1) NOT NULL DEFAULT 0,
  `grp_referrals` tinyint(1) NOT NULL DEFAULT 0,
  `grp_unchecked` tinyint(1) NOT NULL DEFAULT 0,
  `grp_services` varchar(4095) NOT NULL DEFAULT '',
  `grp_products` varchar(4095) NOT NULL DEFAULT '',
  `grp_diags` varchar(4095) NOT NULL DEFAULT '',
  `grp_last_update` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`grp_form_id`,`grp_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `layout_options`
--

DROP TABLE IF EXISTS `layout_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `layout_options` (
  `form_id` varchar(31) NOT NULL DEFAULT '',
  `field_id` varchar(31) NOT NULL DEFAULT '',
  `group_id` varchar(31) NOT NULL DEFAULT '',
  `title` text DEFAULT NULL,
  `seq` int(11) NOT NULL DEFAULT 0,
  `data_type` tinyint(3) NOT NULL DEFAULT 0,
  `uor` tinyint(1) NOT NULL DEFAULT 1,
  `fld_length` int(11) NOT NULL DEFAULT 15,
  `max_length` int(11) NOT NULL DEFAULT 0,
  `list_id` varchar(100) NOT NULL DEFAULT '',
  `titlecols` tinyint(3) NOT NULL DEFAULT 1,
  `datacols` tinyint(3) NOT NULL DEFAULT 1,
  `default_value` varchar(255) NOT NULL DEFAULT '',
  `edit_options` varchar(36) NOT NULL DEFAULT '',
  `description` text DEFAULT NULL,
  `fld_rows` int(11) NOT NULL DEFAULT 0,
  `list_backup_id` varchar(100) NOT NULL DEFAULT '',
  `source` char(1) NOT NULL DEFAULT 'F' COMMENT 'F=Form, D=Demographics, H=History, E=Encounter',
  `conditions` text DEFAULT NULL COMMENT 'serialized array of skip conditions',
  `validation` varchar(100) DEFAULT NULL,
  `codes` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`form_id`,`field_id`,`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lbf_data`
--

DROP TABLE IF EXISTS `lbf_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `lbf_data` (
  `form_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'references forms.form_id',
  `field_id` varchar(31) NOT NULL COMMENT 'references layout_options.field_id',
  `field_value` longtext DEFAULT NULL,
  PRIMARY KEY (`form_id`,`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='contains all data from layout-based forms';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lbt_data`
--

DROP TABLE IF EXISTS `lbt_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `lbt_data` (
  `form_id` bigint(20) NOT NULL COMMENT 'references transactions.id',
  `field_id` varchar(31) NOT NULL COMMENT 'references layout_options.field_id',
  `field_value` text DEFAULT NULL,
  PRIMARY KEY (`form_id`,`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='contains all data from layout-based transactions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `list_options`
--

DROP TABLE IF EXISTS `list_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `list_options` (
  `list_id` varchar(100) NOT NULL DEFAULT '',
  `option_id` varchar(100) NOT NULL DEFAULT '',
  `title` varchar(255) NOT NULL DEFAULT '',
  `seq` int(11) NOT NULL DEFAULT 0,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `option_value` float NOT NULL DEFAULT 0,
  `mapping` varchar(31) NOT NULL DEFAULT '',
  `notes` text DEFAULT NULL,
  `codes` varchar(255) NOT NULL DEFAULT '',
  `toggle_setting_1` tinyint(1) NOT NULL DEFAULT 0,
  `toggle_setting_2` tinyint(1) NOT NULL DEFAULT 0,
  `activity` tinyint(4) NOT NULL DEFAULT 1,
  `subtype` varchar(31) NOT NULL DEFAULT '',
  `edit_options` tinyint(1) NOT NULL DEFAULT 1,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`list_id`,`option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lists`
--

DROP TABLE IF EXISTS `lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `lists` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uuid` binary(16) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `subtype` varchar(31) NOT NULL DEFAULT '',
  `title` varchar(255) DEFAULT NULL,
  `udi` varchar(255) DEFAULT NULL,
  `udi_data` text DEFAULT NULL,
  `begdate` datetime DEFAULT NULL,
  `enddate` datetime DEFAULT NULL,
  `returndate` date DEFAULT NULL,
  `occurrence` int(11) DEFAULT 0 COMMENT 'Reference to list_options option_id=''occurrence''',
  `classification` int(11) DEFAULT 0,
  `referredby` varchar(255) DEFAULT NULL,
  `extrainfo` varchar(255) DEFAULT NULL,
  `diagnosis` varchar(255) DEFAULT NULL,
  `activity` tinyint(4) DEFAULT NULL,
  `comments` longtext DEFAULT NULL,
  `pid` bigint(20) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `groupname` varchar(255) DEFAULT NULL,
  `outcome` int(11) NOT NULL DEFAULT 0,
  `destination` varchar(255) DEFAULT NULL,
  `reinjury_id` bigint(20) NOT NULL DEFAULT 0,
  `injury_part` varchar(31) NOT NULL DEFAULT '',
  `injury_type` varchar(31) NOT NULL DEFAULT '',
  `injury_grade` varchar(31) NOT NULL DEFAULT '',
  `reaction` varchar(255) NOT NULL DEFAULT '',
  `verification` varchar(36) NOT NULL DEFAULT '' COMMENT 'Reference to list_options option_id = allergyintolerance-verification',
  `external_allergyid` int(11) DEFAULT NULL,
  `erx_source` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0-OpenEMR 1-External',
  `erx_uploaded` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0-Pending NewCrop upload 1-Uploaded TO NewCrop',
  `modifydate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `severity_al` varchar(50) DEFAULT NULL,
  `external_id` varchar(20) DEFAULT NULL,
  `list_option_id` varchar(100) DEFAULT NULL COMMENT 'Reference to list_options table',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `pid` (`pid`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lists_medication`
--

DROP TABLE IF EXISTS `lists_medication`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `lists_medication` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `list_id` bigint(20) DEFAULT NULL COMMENT 'FK Reference to lists.id',
  `drug_dosage_instructions` longtext DEFAULT NULL COMMENT 'Free text dosage instructions for taking the drug',
  `usage_category` varchar(100) DEFAULT NULL COMMENT 'option_id in list_options.list_id=medication-usage-category',
  `usage_category_title` varchar(255) NOT NULL COMMENT 'title in list_options.list_id=medication-usage-category',
  `request_intent` varchar(100) DEFAULT NULL COMMENT 'option_id in list_options.list_id=medication-request-intent',
  `request_intent_title` varchar(255) NOT NULL COMMENT 'title in list_options.list_id=medication-request-intent',
  PRIMARY KEY (`id`),
  KEY `lists_med_usage_category_idx` (`usage_category`),
  KEY `lists_med_request_intent_idx` (`request_intent`),
  KEY `lists_medication_list_idx` (`list_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Holds additional data about patient medications.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lists_touch`
--

DROP TABLE IF EXISTS `lists_touch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `lists_touch` (
  `pid` bigint(20) NOT NULL DEFAULT 0,
  `type` varchar(255) NOT NULL DEFAULT '',
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`pid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `event` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `groupname` varchar(255) DEFAULT NULL,
  `comments` longtext DEFAULT NULL,
  `user_notes` longtext DEFAULT NULL,
  `patient_id` bigint(20) DEFAULT NULL,
  `success` tinyint(1) DEFAULT 1,
  `checksum` longtext DEFAULT NULL,
  `crt_user` varchar(255) DEFAULT NULL,
  `log_from` varchar(20) DEFAULT 'open-emr',
  `menu_item_id` int(11) DEFAULT NULL,
  `ccda_doc_id` int(11) DEFAULT NULL COMMENT 'CCDA document id from ccda',
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7063 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_comment_encrypt`
--

DROP TABLE IF EXISTS `log_comment_encrypt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_comment_encrypt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `log_id` int(11) NOT NULL,
  `encrypt` enum('Yes','No') NOT NULL DEFAULT 'No',
  `checksum` longtext DEFAULT NULL,
  `checksum_api` longtext DEFAULT NULL,
  `version` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0 for mycrypt and 1 for openssl',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7063 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `login_mfa_registrations`
--

DROP TABLE IF EXISTS `login_mfa_registrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `login_mfa_registrations` (
  `user_id` bigint(20) NOT NULL,
  `name` varchar(30) NOT NULL,
  `last_challenge` datetime DEFAULT NULL,
  `method` varchar(31) NOT NULL COMMENT 'Q&A, U2F, TOTP etc.',
  `var1` varchar(4096) NOT NULL DEFAULT '' COMMENT 'Question, U2F registration etc.',
  `var2` varchar(256) NOT NULL DEFAULT '' COMMENT 'Answer etc.',
  PRIMARY KEY (`user_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `medex_icons`
--

DROP TABLE IF EXISTS `medex_icons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `medex_icons` (
  `i_UID` int(11) NOT NULL AUTO_INCREMENT,
  `msg_type` varchar(50) NOT NULL,
  `msg_status` varchar(10) NOT NULL,
  `i_description` varchar(255) DEFAULT NULL,
  `i_html` text DEFAULT NULL,
  `i_blob` longtext DEFAULT NULL,
  PRIMARY KEY (`i_UID`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `medex_outgoing`
--

DROP TABLE IF EXISTS `medex_outgoing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `medex_outgoing` (
  `msg_uid` int(11) NOT NULL AUTO_INCREMENT,
  `msg_pid` int(11) NOT NULL,
  `msg_pc_eid` varchar(11) NOT NULL,
  `campaign_uid` int(11) NOT NULL DEFAULT 0,
  `msg_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `msg_type` varchar(50) NOT NULL,
  `msg_reply` varchar(50) DEFAULT NULL,
  `msg_extra_text` text DEFAULT NULL,
  `medex_uid` int(11) DEFAULT NULL,
  PRIMARY KEY (`msg_uid`),
  UNIQUE KEY `msg_eid` (`msg_uid`,`msg_pc_eid`,`medex_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `medex_prefs`
--

DROP TABLE IF EXISTS `medex_prefs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `medex_prefs` (
  `MedEx_id` int(11) DEFAULT 0,
  `ME_username` varchar(100) DEFAULT NULL,
  `ME_api_key` text DEFAULT NULL,
  `ME_facilities` varchar(50) DEFAULT NULL,
  `ME_providers` varchar(100) DEFAULT NULL,
  `ME_hipaa_default_override` varchar(3) DEFAULT NULL,
  `PHONE_country_code` int(4) NOT NULL DEFAULT 1,
  `MSGS_default_yes` varchar(3) DEFAULT NULL,
  `POSTCARDS_local` varchar(3) DEFAULT NULL,
  `POSTCARDS_remote` varchar(3) DEFAULT NULL,
  `LABELS_local` varchar(3) DEFAULT NULL,
  `LABELS_choice` varchar(50) DEFAULT NULL,
  `combine_time` tinyint(4) DEFAULT NULL,
  `postcard_top` varchar(255) DEFAULT NULL,
  `status` text DEFAULT NULL,
  `MedEx_lastupdated` timestamp NOT NULL DEFAULT current_timestamp(),
  UNIQUE KEY `ME_username` (`ME_username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `medex_recalls`
--

DROP TABLE IF EXISTS `medex_recalls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `medex_recalls` (
  `r_ID` int(11) NOT NULL AUTO_INCREMENT,
  `r_PRACTID` int(11) NOT NULL,
  `r_pid` int(11) NOT NULL COMMENT 'PatientID from pat_data',
  `r_eventDate` date NOT NULL COMMENT 'Date of Appt or Recall',
  `r_facility` int(11) NOT NULL,
  `r_provider` int(11) NOT NULL,
  `r_reason` varchar(255) DEFAULT NULL,
  `r_created` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp(),
  PRIMARY KEY (`r_ID`),
  UNIQUE KEY `r_PRACTID` (`r_PRACTID`,`r_pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `misc_address_book`
--

DROP TABLE IF EXISTS `misc_address_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `misc_address_book` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `fname` varchar(255) DEFAULT NULL,
  `mname` varchar(255) DEFAULT NULL,
  `lname` varchar(255) DEFAULT NULL,
  `street` varchar(60) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `state` varchar(30) DEFAULT NULL,
  `zip` varchar(20) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `module_acl_group_settings`
--

DROP TABLE IF EXISTS `module_acl_group_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `module_acl_group_settings` (
  `module_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `section_id` int(11) NOT NULL,
  `allowed` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`module_id`,`group_id`,`section_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `module_acl_sections`
--

DROP TABLE IF EXISTS `module_acl_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `module_acl_sections` (
  `section_id` int(11) DEFAULT NULL,
  `section_name` varchar(255) DEFAULT NULL,
  `parent_section` int(11) DEFAULT NULL,
  `section_identifier` varchar(50) DEFAULT NULL,
  `module_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `module_acl_user_settings`
--

DROP TABLE IF EXISTS `module_acl_user_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `module_acl_user_settings` (
  `module_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `section_id` int(11) NOT NULL,
  `allowed` int(1) DEFAULT NULL,
  PRIMARY KEY (`module_id`,`user_id`,`section_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `module_configuration`
--

DROP TABLE IF EXISTS `module_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `module_configuration` (
  `module_config_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `module_id` int(10) unsigned NOT NULL,
  `field_name` varchar(45) NOT NULL,
  `field_value` varchar(255) NOT NULL,
  `created_by` bigint(20) DEFAULT NULL COMMENT 'users.id the user that first created this record',
  `date_added` datetime DEFAULT NULL COMMENT 'Datetime the record was initially created',
  `updated_by` bigint(20) DEFAULT NULL COMMENT 'users.id the user that last modified this record',
  `date_modified` datetime DEFAULT current_timestamp() COMMENT 'Datetime the record was last modified',
  `date_created` datetime DEFAULT NULL COMMENT 'Datetime the record was created',
  PRIMARY KEY (`module_config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `modules`
--

DROP TABLE IF EXISTS `modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `modules` (
  `mod_id` int(11) NOT NULL AUTO_INCREMENT,
  `mod_name` varchar(64) NOT NULL DEFAULT '0',
  `mod_directory` varchar(64) NOT NULL DEFAULT '',
  `mod_parent` varchar(64) NOT NULL DEFAULT '',
  `mod_type` varchar(64) NOT NULL DEFAULT '',
  `mod_active` int(1) unsigned NOT NULL DEFAULT 0,
  `mod_ui_name` varchar(64) NOT NULL DEFAULT '',
  `mod_relative_link` varchar(64) NOT NULL DEFAULT '',
  `mod_ui_order` tinyint(3) NOT NULL DEFAULT 0,
  `mod_ui_active` int(1) unsigned NOT NULL DEFAULT 0,
  `mod_description` varchar(255) NOT NULL DEFAULT '',
  `mod_nick_name` varchar(25) NOT NULL DEFAULT '',
  `mod_enc_menu` varchar(10) NOT NULL DEFAULT 'no',
  `permissions_item_table` char(100) DEFAULT NULL,
  `directory` varchar(255) NOT NULL,
  `date` datetime NOT NULL,
  `sql_run` tinyint(4) DEFAULT 0,
  `type` tinyint(4) DEFAULT 0,
  `sql_version` varchar(150) NOT NULL,
  `acl_version` varchar(150) NOT NULL,
  PRIMARY KEY (`mod_id`,`mod_directory`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `modules_hooks_settings`
--

DROP TABLE IF EXISTS `modules_hooks_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `modules_hooks_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mod_id` int(11) DEFAULT NULL,
  `enabled_hooks` varchar(255) DEFAULT NULL,
  `attached_to` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `modules_settings`
--

DROP TABLE IF EXISTS `modules_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `modules_settings` (
  `mod_id` int(11) DEFAULT NULL,
  `fld_type` smallint(6) DEFAULT NULL COMMENT '1=>ACL,2=>preferences,3=>hooks',
  `obj_name` varchar(255) DEFAULT NULL,
  `menu_name` varchar(255) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `multiple_db`
--

DROP TABLE IF EXISTS `multiple_db`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `multiple_db` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `namespace` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` text DEFAULT NULL,
  `dbname` varchar(255) NOT NULL,
  `host` varchar(255) NOT NULL DEFAULT 'localhost',
  `port` smallint(4) NOT NULL DEFAULT 3306,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `namespace` (`namespace`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notes`
--

DROP TABLE IF EXISTS `notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `notes` (
  `id` int(11) NOT NULL DEFAULT 0,
  `foreign_id` int(11) NOT NULL DEFAULT 0,
  `note` varchar(255) DEFAULT NULL,
  `owner` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `revision` timestamp NOT NULL,
  PRIMARY KEY (`id`),
  KEY `foreign_id` (`owner`),
  KEY `foreign_id_2` (`foreign_id`),
  KEY `date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notification_log`
--

DROP TABLE IF EXISTS `notification_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification_log` (
  `iLogId` int(11) NOT NULL AUTO_INCREMENT,
  `pid` bigint(20) NOT NULL,
  `pc_eid` int(11) unsigned DEFAULT NULL,
  `sms_gateway_type` varchar(50) NOT NULL,
  `smsgateway_info` varchar(255) NOT NULL,
  `message` text DEFAULT NULL,
  `email_sender` varchar(255) NOT NULL,
  `email_subject` varchar(255) NOT NULL,
  `type` enum('SMS','Email') NOT NULL,
  `patient_info` text DEFAULT NULL,
  `pc_eventDate` date NOT NULL,
  `pc_endDate` date NOT NULL,
  `pc_startTime` time NOT NULL,
  `pc_endTime` time NOT NULL,
  `dSentDateTime` datetime NOT NULL,
  PRIMARY KEY (`iLogId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notification_settings`
--

DROP TABLE IF EXISTS `notification_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification_settings` (
  `SettingsId` int(3) NOT NULL AUTO_INCREMENT,
  `Send_SMS_Before_Hours` int(3) NOT NULL,
  `Send_Email_Before_Hours` int(3) NOT NULL,
  `SMS_gateway_username` varchar(100) NOT NULL,
  `SMS_gateway_password` varchar(100) NOT NULL,
  `SMS_gateway_apikey` varchar(100) NOT NULL,
  `type` varchar(50) NOT NULL,
  PRIMARY KEY (`SettingsId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `oauth_clients`
--

DROP TABLE IF EXISTS `oauth_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_clients` (
  `client_id` varchar(80) NOT NULL,
  `client_role` varchar(20) DEFAULT NULL,
  `client_name` varchar(80) NOT NULL,
  `client_secret` text DEFAULT NULL,
  `registration_token` varchar(80) DEFAULT NULL,
  `registration_uri_path` varchar(40) DEFAULT NULL,
  `register_date` datetime DEFAULT NULL,
  `revoke_date` datetime DEFAULT NULL,
  `contacts` text DEFAULT NULL,
  `redirect_uri` text DEFAULT NULL,
  `grant_types` varchar(80) DEFAULT NULL,
  `scope` text DEFAULT NULL,
  `user_id` varchar(40) DEFAULT NULL,
  `site_id` varchar(64) DEFAULT NULL,
  `is_confidential` tinyint(1) NOT NULL DEFAULT 1,
  `logout_redirect_uris` text DEFAULT NULL,
  `jwks_uri` text DEFAULT NULL,
  `jwks` text DEFAULT NULL,
  `initiate_login_uri` text DEFAULT NULL,
  `endorsements` text DEFAULT NULL,
  `policy_uri` text DEFAULT NULL,
  `tos_uri` text DEFAULT NULL,
  `is_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `skip_ehr_launch_authorization_flow` tinyint(1) NOT NULL DEFAULT 0,
  `dsi_type` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '0=none, 1=evidence-based,2=predictive',
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `oauth_trusted_user`
--

DROP TABLE IF EXISTS `oauth_trusted_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_trusted_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(80) DEFAULT NULL,
  `client_id` varchar(80) DEFAULT NULL,
  `scope` text DEFAULT NULL,
  `persist_login` tinyint(1) DEFAULT 0,
  `time` timestamp NULL DEFAULT NULL,
  `code` text DEFAULT NULL,
  `session_cache` text DEFAULT NULL,
  `grant_type` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `accounts_id` (`user_id`),
  KEY `clients_id` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `onetime_auth`
--

DROP TABLE IF EXISTS `onetime_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `onetime_auth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` bigint(20) DEFAULT NULL,
  `create_user_id` bigint(20) DEFAULT NULL,
  `context` varchar(64) DEFAULT NULL,
  `access_count` int(11) NOT NULL DEFAULT 0,
  `remote_ip` varchar(32) DEFAULT NULL,
  `onetime_pin` varchar(10) DEFAULT NULL COMMENT 'Max 10 numeric. Default 6',
  `onetime_token` tinytext DEFAULT NULL,
  `redirect_url` tinytext DEFAULT NULL,
  `expires` int(11) DEFAULT NULL,
  `date_created` datetime DEFAULT current_timestamp(),
  `last_accessed` datetime DEFAULT NULL,
  `scope` tinytext DEFAULT NULL COMMENT 'context scope for this token',
  `profile` tinytext DEFAULT NULL COMMENT 'profile of scope for this token',
  `onetime_actions` text DEFAULT NULL COMMENT 'JSON array of actions that can be performed with this token',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`,`onetime_token`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `onotes`
--

DROP TABLE IF EXISTS `onotes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `onotes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `body` longtext DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `groupname` varchar(255) DEFAULT NULL,
  `activity` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `onsite_documents`
--

DROP TABLE IF EXISTS `onsite_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `onsite_documents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` bigint(20) unsigned DEFAULT NULL,
  `facility` int(10) unsigned DEFAULT NULL,
  `provider` int(10) unsigned DEFAULT NULL,
  `encounter` int(10) unsigned DEFAULT NULL,
  `create_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `doc_type` varchar(255) NOT NULL,
  `patient_signed_status` smallint(5) unsigned NOT NULL,
  `patient_signed_time` datetime DEFAULT NULL,
  `authorize_signed_time` datetime DEFAULT NULL,
  `accept_signed_status` smallint(5) NOT NULL,
  `authorizing_signator` varchar(50) NOT NULL,
  `review_date` datetime DEFAULT NULL,
  `denial_reason` varchar(255) NOT NULL,
  `authorized_signature` text DEFAULT NULL,
  `patient_signature` text DEFAULT NULL,
  `full_document` mediumblob DEFAULT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `template_data` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `onsite_mail`
--

DROP TABLE IF EXISTS `onsite_mail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `onsite_mail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `owner` varchar(128) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `groupname` varchar(255) DEFAULT NULL,
  `activity` tinyint(4) DEFAULT NULL,
  `authorized` tinyint(4) DEFAULT NULL,
  `header` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `body` longtext DEFAULT NULL,
  `recipient_id` varchar(128) DEFAULT NULL,
  `recipient_name` varchar(255) DEFAULT NULL,
  `sender_id` varchar(128) DEFAULT NULL,
  `sender_name` varchar(255) DEFAULT NULL,
  `assigned_to` varchar(255) DEFAULT NULL,
  `deleted` tinyint(4) DEFAULT 0 COMMENT 'flag indicates note is deleted',
  `delete_date` datetime DEFAULT NULL,
  `mtype` varchar(128) DEFAULT NULL,
  `message_status` varchar(20) NOT NULL DEFAULT 'New',
  `mail_chain` int(11) DEFAULT NULL,
  `reply_mail_chain` int(11) DEFAULT NULL,
  `is_msg_encrypted` tinyint(2) DEFAULT 0 COMMENT 'Whether messsage encrypted 0-Not encrypted, 1-Encrypted',
  PRIMARY KEY (`id`),
  KEY `pid` (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `onsite_messages`
--

DROP TABLE IF EXISTS `onsite_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `onsite_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(64) NOT NULL,
  `message` longtext DEFAULT NULL,
  `ip` varchar(15) NOT NULL,
  `date` datetime NOT NULL,
  `sender_id` varchar(64) DEFAULT NULL COMMENT 'who sent id',
  `recip_id` varchar(255) NOT NULL COMMENT 'who to id array',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Portal messages';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `onsite_online`
--

DROP TABLE IF EXISTS `onsite_online`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `onsite_online` (
  `hash` varchar(32) NOT NULL,
  `ip` varchar(15) NOT NULL,
  `last_update` datetime NOT NULL,
  `username` varchar(64) NOT NULL,
  `userid` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `onsite_portal_activity`
--

DROP TABLE IF EXISTS `onsite_portal_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `onsite_portal_activity` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `patient_id` bigint(20) DEFAULT NULL,
  `activity` varchar(255) DEFAULT NULL,
  `require_audit` tinyint(1) DEFAULT 1,
  `pending_action` varchar(255) DEFAULT NULL,
  `action_taken` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `narrative` longtext DEFAULT NULL,
  `table_action` longtext DEFAULT NULL,
  `table_args` longtext DEFAULT NULL,
  `action_user` int(11) DEFAULT NULL,
  `action_taken_time` datetime DEFAULT NULL,
  `checksum` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `onsite_signatures`
--

DROP TABLE IF EXISTS `onsite_signatures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `onsite_signatures` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` varchar(128) NOT NULL DEFAULT 'waiting',
  `type` varchar(128) NOT NULL,
  `created` int(11) NOT NULL,
  `lastmod` datetime NOT NULL,
  `pid` bigint(20) DEFAULT NULL,
  `encounter` int(11) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `activity` tinyint(4) NOT NULL DEFAULT 0,
  `authorized` tinyint(4) DEFAULT NULL,
  `signator` varchar(255) NOT NULL,
  `sig_image` text DEFAULT NULL,
  `signature` text DEFAULT NULL,
  `sig_hash` varchar(255) NOT NULL,
  `ip` varchar(46) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pid` (`pid`,`user`),
  KEY `encounter` (`encounter`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `openemr_module_vars`
--

DROP TABLE IF EXISTS `openemr_module_vars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `openemr_module_vars` (
  `pn_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pn_modname` varchar(64) DEFAULT NULL,
  `pn_name` varchar(64) DEFAULT NULL,
  `pn_value` longtext DEFAULT NULL,
  PRIMARY KEY (`pn_id`),
  KEY `pn_modname` (`pn_modname`),
  KEY `pn_name` (`pn_name`)
) ENGINE=InnoDB AUTO_INCREMENT=235 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `openemr_modules`
--

DROP TABLE IF EXISTS `openemr_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `openemr_modules` (
  `pn_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pn_name` varchar(64) DEFAULT NULL,
  `pn_type` int(6) NOT NULL DEFAULT 0,
  `pn_displayname` varchar(64) DEFAULT NULL,
  `pn_description` varchar(255) DEFAULT NULL,
  `pn_regid` int(11) unsigned NOT NULL DEFAULT 0,
  `pn_directory` varchar(64) DEFAULT NULL,
  `pn_version` varchar(10) DEFAULT NULL,
  `pn_admin_capable` tinyint(1) NOT NULL DEFAULT 0,
  `pn_user_capable` tinyint(1) NOT NULL DEFAULT 0,
  `pn_state` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`pn_id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `openemr_postcalendar_categories`
--

DROP TABLE IF EXISTS `openemr_postcalendar_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `openemr_postcalendar_categories` (
  `pc_catid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pc_constant_id` varchar(255) DEFAULT NULL,
  `pc_catname` varchar(100) DEFAULT NULL,
  `pc_catcolor` varchar(50) DEFAULT NULL,
  `pc_catdesc` text DEFAULT NULL,
  `pc_recurrtype` int(1) NOT NULL DEFAULT 0,
  `pc_enddate` date DEFAULT NULL,
  `pc_recurrspec` text DEFAULT NULL,
  `pc_recurrfreq` int(3) NOT NULL DEFAULT 0,
  `pc_duration` bigint(20) NOT NULL DEFAULT 0,
  `pc_end_date_flag` tinyint(1) NOT NULL DEFAULT 0,
  `pc_end_date_type` int(2) DEFAULT NULL,
  `pc_end_date_freq` int(11) NOT NULL DEFAULT 0,
  `pc_end_all_day` tinyint(1) NOT NULL DEFAULT 0,
  `pc_dailylimit` int(2) NOT NULL DEFAULT 0,
  `pc_cattype` int(11) NOT NULL COMMENT 'Used in grouping categories',
  `pc_active` tinyint(1) NOT NULL DEFAULT 1,
  `pc_seq` int(11) NOT NULL DEFAULT 0,
  `aco_spec` varchar(63) NOT NULL DEFAULT 'encounters|notes',
  `pc_last_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`pc_catid`),
  UNIQUE KEY `pc_constant_id` (`pc_constant_id`),
  KEY `basic_cat` (`pc_catname`,`pc_catcolor`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `openemr_postcalendar_events`
--

DROP TABLE IF EXISTS `openemr_postcalendar_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `openemr_postcalendar_events` (
  `pc_eid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pc_catid` int(11) NOT NULL DEFAULT 0,
  `pc_multiple` int(10) unsigned NOT NULL,
  `pc_aid` varchar(30) DEFAULT NULL,
  `pc_pid` varchar(11) DEFAULT NULL,
  `pc_gid` int(11) DEFAULT 0,
  `pc_title` varchar(150) DEFAULT NULL,
  `pc_time` datetime DEFAULT NULL,
  `pc_hometext` text DEFAULT NULL,
  `pc_comments` int(11) DEFAULT 0,
  `pc_counter` mediumint(8) unsigned DEFAULT 0,
  `pc_topic` int(3) NOT NULL DEFAULT 1,
  `pc_informant` varchar(20) DEFAULT NULL,
  `pc_eventDate` date NOT NULL DEFAULT '0000-00-00',
  `pc_endDate` date NOT NULL DEFAULT '0000-00-00',
  `pc_duration` bigint(20) NOT NULL DEFAULT 0,
  `pc_recurrtype` int(1) NOT NULL DEFAULT 0,
  `pc_recurrspec` text DEFAULT NULL,
  `pc_recurrfreq` int(3) NOT NULL DEFAULT 0,
  `pc_startTime` time DEFAULT NULL,
  `pc_endTime` time DEFAULT NULL,
  `pc_alldayevent` int(1) NOT NULL DEFAULT 0,
  `pc_location` text DEFAULT NULL,
  `pc_conttel` varchar(50) DEFAULT NULL,
  `pc_contname` varchar(50) DEFAULT NULL,
  `pc_contemail` varchar(255) DEFAULT NULL,
  `pc_website` varchar(255) DEFAULT NULL,
  `pc_fee` varchar(50) DEFAULT NULL,
  `pc_eventstatus` int(11) NOT NULL DEFAULT 0,
  `pc_sharing` int(11) NOT NULL DEFAULT 0,
  `pc_language` varchar(30) DEFAULT NULL,
  `pc_apptstatus` varchar(15) NOT NULL DEFAULT '-',
  `pc_prefcatid` int(11) NOT NULL DEFAULT 0,
  `pc_facility` int(11) NOT NULL DEFAULT 0 COMMENT 'facility id for this event',
  `pc_sendalertsms` varchar(3) NOT NULL DEFAULT 'NO',
  `pc_sendalertemail` varchar(3) NOT NULL DEFAULT 'NO',
  `pc_billing_location` smallint(6) NOT NULL DEFAULT 0,
  `pc_room` varchar(20) NOT NULL DEFAULT '',
  `uuid` binary(16) DEFAULT NULL,
  PRIMARY KEY (`pc_eid`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `basic_event` (`pc_catid`,`pc_aid`,`pc_eventDate`,`pc_endDate`,`pc_eventstatus`,`pc_sharing`,`pc_topic`),
  KEY `pc_eventDate` (`pc_eventDate`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patient_access_onsite`
--

DROP TABLE IF EXISTS `patient_access_onsite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_access_onsite` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` bigint(20) DEFAULT NULL,
  `portal_username` varchar(100) DEFAULT NULL,
  `portal_pwd` varchar(255) DEFAULT NULL,
  `portal_pwd_status` tinyint(4) DEFAULT 1 COMMENT '0=>Password Created Through Demographics by The provider or staff. Patient Should Change it at first time it.1=>Pwd updated or created by patient itself',
  `portal_login_username` varchar(100) DEFAULT NULL COMMENT 'User entered username',
  `portal_onetime` varchar(255) DEFAULT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `pid` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patient_birthday_alert`
--

DROP TABLE IF EXISTS `patient_birthday_alert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_birthday_alert` (
  `pid` bigint(20) NOT NULL DEFAULT 0,
  `user_id` bigint(20) NOT NULL DEFAULT 0,
  `turned_off_on` date NOT NULL,
  PRIMARY KEY (`pid`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patient_data`
--

DROP TABLE IF EXISTS `patient_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_data` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uuid` binary(16) DEFAULT NULL,
  `title` varchar(255) NOT NULL DEFAULT '',
  `language` varchar(255) NOT NULL DEFAULT '',
  `financial` varchar(255) NOT NULL DEFAULT '',
  `fname` varchar(255) NOT NULL DEFAULT '',
  `lname` varchar(255) NOT NULL DEFAULT '',
  `mname` varchar(255) NOT NULL DEFAULT '',
  `DOB` date DEFAULT NULL,
  `street` varchar(255) NOT NULL DEFAULT '',
  `postal_code` varchar(255) NOT NULL DEFAULT '',
  `city` varchar(255) NOT NULL DEFAULT '',
  `state` varchar(255) NOT NULL DEFAULT '',
  `country_code` varchar(255) NOT NULL DEFAULT '',
  `drivers_license` varchar(255) NOT NULL DEFAULT '',
  `ss` varchar(255) NOT NULL DEFAULT '',
  `occupation` longtext DEFAULT NULL,
  `phone_home` varchar(255) NOT NULL DEFAULT '',
  `phone_biz` varchar(255) NOT NULL DEFAULT '',
  `phone_contact` varchar(255) NOT NULL DEFAULT '',
  `phone_cell` varchar(255) NOT NULL DEFAULT '',
  `pharmacy_id` int(11) NOT NULL DEFAULT 0,
  `status` varchar(255) NOT NULL DEFAULT '',
  `contact_relationship` varchar(255) NOT NULL DEFAULT '',
  `date` datetime DEFAULT NULL,
  `sex` varchar(255) NOT NULL DEFAULT '',
  `referrer` varchar(255) NOT NULL DEFAULT '',
  `referrerID` varchar(255) NOT NULL DEFAULT '',
  `providerID` int(11) DEFAULT NULL,
  `ref_providerID` int(11) DEFAULT NULL,
  `email` varchar(255) NOT NULL DEFAULT '',
  `email_direct` varchar(255) NOT NULL DEFAULT '',
  `ethnoracial` varchar(255) NOT NULL DEFAULT '',
  `race` varchar(255) NOT NULL DEFAULT '',
  `ethnicity` varchar(255) NOT NULL DEFAULT '',
  `religion` varchar(40) NOT NULL DEFAULT '',
  `interpretter` varchar(255) NOT NULL DEFAULT '',
  `migrantseasonal` varchar(255) NOT NULL DEFAULT '',
  `family_size` varchar(255) NOT NULL DEFAULT '',
  `monthly_income` varchar(255) NOT NULL DEFAULT '',
  `billing_note` text DEFAULT NULL,
  `homeless` varchar(255) NOT NULL DEFAULT '',
  `financial_review` datetime DEFAULT NULL,
  `pubpid` varchar(255) NOT NULL DEFAULT '',
  `pid` bigint(20) NOT NULL DEFAULT 0,
  `genericname1` varchar(255) NOT NULL DEFAULT '',
  `genericval1` varchar(255) NOT NULL DEFAULT '',
  `genericname2` varchar(255) NOT NULL DEFAULT '',
  `genericval2` varchar(255) NOT NULL DEFAULT '',
  `hipaa_mail` varchar(3) NOT NULL DEFAULT '',
  `hipaa_voice` varchar(3) NOT NULL DEFAULT '',
  `hipaa_notice` varchar(3) NOT NULL DEFAULT '',
  `hipaa_message` varchar(20) NOT NULL DEFAULT '',
  `hipaa_allowsms` varchar(3) NOT NULL DEFAULT 'NO',
  `hipaa_allowemail` varchar(3) NOT NULL DEFAULT 'NO',
  `squad` varchar(32) NOT NULL DEFAULT '',
  `fitness` int(11) NOT NULL DEFAULT 0,
  `referral_source` varchar(30) NOT NULL DEFAULT '',
  `usertext1` varchar(255) NOT NULL DEFAULT '',
  `usertext2` varchar(255) NOT NULL DEFAULT '',
  `usertext3` varchar(255) NOT NULL DEFAULT '',
  `usertext4` varchar(255) NOT NULL DEFAULT '',
  `usertext5` varchar(255) NOT NULL DEFAULT '',
  `usertext6` varchar(255) NOT NULL DEFAULT '',
  `usertext7` varchar(255) NOT NULL DEFAULT '',
  `usertext8` varchar(255) NOT NULL DEFAULT '',
  `userlist1` varchar(255) NOT NULL DEFAULT '',
  `userlist2` varchar(255) NOT NULL DEFAULT '',
  `userlist3` varchar(255) NOT NULL DEFAULT '',
  `userlist4` varchar(255) NOT NULL DEFAULT '',
  `userlist5` varchar(255) NOT NULL DEFAULT '',
  `userlist6` varchar(255) NOT NULL DEFAULT '',
  `userlist7` varchar(255) NOT NULL DEFAULT '',
  `pricelevel` varchar(255) NOT NULL DEFAULT 'standard',
  `regdate` datetime DEFAULT NULL COMMENT 'Registration Date',
  `contrastart` date DEFAULT NULL COMMENT 'Date contraceptives initially used',
  `completed_ad` varchar(3) NOT NULL DEFAULT 'NO',
  `ad_reviewed` date DEFAULT NULL,
  `vfc` varchar(255) NOT NULL DEFAULT '',
  `mothersname` varchar(255) NOT NULL DEFAULT '',
  `guardiansname` text DEFAULT NULL,
  `allow_imm_reg_use` varchar(255) NOT NULL DEFAULT '',
  `allow_imm_info_share` varchar(255) NOT NULL DEFAULT '',
  `allow_health_info_ex` varchar(255) NOT NULL DEFAULT '',
  `allow_patient_portal` varchar(31) NOT NULL DEFAULT '',
  `deceased_date` datetime DEFAULT NULL,
  `deceased_reason` varchar(255) NOT NULL DEFAULT '',
  `soap_import_status` tinyint(4) DEFAULT NULL COMMENT '1-Prescription Press 2-Prescription Import 3-Allergy Press 4-Allergy Import',
  `cmsportal_login` varchar(60) NOT NULL DEFAULT '',
  `care_team_provider` text DEFAULT NULL,
  `care_team_facility` text DEFAULT NULL,
  `care_team_status` text DEFAULT NULL,
  `county` varchar(40) NOT NULL DEFAULT '',
  `industry` text DEFAULT NULL,
  `imm_reg_status` text DEFAULT NULL,
  `imm_reg_stat_effdate` text DEFAULT NULL,
  `publicity_code` text DEFAULT NULL,
  `publ_code_eff_date` text DEFAULT NULL,
  `protect_indicator` text DEFAULT NULL,
  `prot_indi_effdate` text DEFAULT NULL,
  `guardianrelationship` text DEFAULT NULL,
  `guardiansex` text DEFAULT NULL,
  `guardianaddress` text DEFAULT NULL,
  `guardiancity` text DEFAULT NULL,
  `guardianstate` text DEFAULT NULL,
  `guardianpostalcode` text DEFAULT NULL,
  `guardiancountry` text DEFAULT NULL,
  `guardianphone` text DEFAULT NULL,
  `guardianworkphone` text DEFAULT NULL,
  `guardianemail` text DEFAULT NULL,
  `sexual_orientation` text DEFAULT NULL,
  `gender_identity` text DEFAULT NULL,
  `birth_fname` text DEFAULT NULL,
  `birth_lname` text DEFAULT NULL,
  `birth_mname` text DEFAULT NULL,
  `dupscore` int(11) NOT NULL DEFAULT -9,
  `name_history` tinytext DEFAULT NULL,
  `suffix` tinytext DEFAULT NULL,
  `street_line_2` tinytext DEFAULT NULL,
  `patient_groups` text DEFAULT NULL,
  `prevent_portal_apps` text DEFAULT NULL,
  `provider_since_date` tinytext DEFAULT NULL,
  `created_by` bigint(20) DEFAULT NULL COMMENT 'users.id the user that first created this record',
  `updated_by` bigint(20) DEFAULT NULL COMMENT 'users.id the user that last modified this record',
  `preferred_name` tinytext DEFAULT NULL,
  `nationality_country` tinytext DEFAULT NULL,
  `last_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  UNIQUE KEY `pid` (`pid`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patient_history`
--

DROP TABLE IF EXISTS `patient_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uuid` binary(16) DEFAULT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `care_team_provider` text DEFAULT NULL,
  `care_team_facility` text DEFAULT NULL,
  `pid` bigint(20) NOT NULL,
  `history_type_key` varchar(36) DEFAULT NULL,
  `previous_name_prefix` text DEFAULT NULL,
  `previous_name_first` text DEFAULT NULL,
  `previous_name_middle` text DEFAULT NULL,
  `previous_name_last` text DEFAULT NULL,
  `previous_name_suffix` text DEFAULT NULL,
  `previous_name_enddate` date DEFAULT NULL,
  `created_by` bigint(20) DEFAULT NULL COMMENT 'users.id the user that first created this record',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `pid_idx` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patient_portal_menu`
--

DROP TABLE IF EXISTS `patient_portal_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_portal_menu` (
  `patient_portal_menu_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_portal_menu_group_id` int(11) DEFAULT NULL,
  `menu_name` varchar(40) DEFAULT NULL,
  `menu_order` smallint(4) DEFAULT NULL,
  `menu_status` tinyint(2) DEFAULT 1,
  PRIMARY KEY (`patient_portal_menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patient_reminders`
--

DROP TABLE IF EXISTS `patient_reminders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_reminders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `active` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 if active and 0 if not active',
  `date_inactivated` datetime DEFAULT NULL,
  `reason_inactivated` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to list_options list rule_reminder_inactive_opt',
  `due_status` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to list_options list rule_reminder_due_opt',
  `pid` bigint(20) NOT NULL COMMENT 'id from patient_data table',
  `category` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to the category item in the rule_action_item table',
  `item` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to the item column in the rule_action_item table',
  `date_created` datetime DEFAULT NULL,
  `date_sent` datetime DEFAULT NULL,
  `voice_status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 if not sent and 1 if sent',
  `sms_status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 if not sent and 1 if sent',
  `email_status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 if not sent and 1 if sent',
  `mail_status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 if not sent and 1 if sent',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`),
  KEY `category` (`category`,`item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patient_settings`
--

DROP TABLE IF EXISTS `patient_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_settings` (
  `setting_patient` bigint(20) NOT NULL DEFAULT 0,
  `setting_label` varchar(100) NOT NULL,
  `setting_value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`setting_patient`,`setting_label`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patient_tracker`
--

DROP TABLE IF EXISTS `patient_tracker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_tracker` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `apptdate` date DEFAULT NULL,
  `appttime` time DEFAULT NULL,
  `eid` bigint(20) NOT NULL DEFAULT 0,
  `pid` bigint(20) NOT NULL DEFAULT 0,
  `original_user` varchar(255) NOT NULL DEFAULT '' COMMENT 'This is the user that created the original record',
  `encounter` bigint(20) NOT NULL DEFAULT 0,
  `lastseq` varchar(4) NOT NULL DEFAULT '' COMMENT 'The element file should contain this number of elements',
  `random_drug_test` tinyint(1) DEFAULT NULL COMMENT 'NULL if not randomized. If randomized, 0 is no, 1 is yes',
  `drug_screen_completed` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `eid` (`eid`),
  KEY `pid` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patient_tracker_element`
--

DROP TABLE IF EXISTS `patient_tracker_element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_tracker_element` (
  `pt_tracker_id` bigint(20) NOT NULL DEFAULT 0 COMMENT 'maps to id column in patient_tracker table',
  `start_datetime` datetime DEFAULT NULL,
  `room` varchar(20) NOT NULL DEFAULT '',
  `status` varchar(31) NOT NULL DEFAULT '',
  `seq` varchar(4) NOT NULL DEFAULT '' COMMENT 'This is a numerical sequence for this pt_tracker_id events',
  `user` varchar(255) NOT NULL DEFAULT '' COMMENT 'This is the user that created this element',
  KEY `pt_tracker_id` (`pt_tracker_id`,`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payment_gateway_details`
--

DROP TABLE IF EXISTS `payment_gateway_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_gateway_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `service_name` varchar(100) DEFAULT NULL,
  `login_id` varchar(255) DEFAULT NULL,
  `transaction_key` varchar(255) DEFAULT NULL,
  `md5` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payment_processing_audit`
--

DROP TABLE IF EXISTS `payment_processing_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_processing_audit` (
  `uuid` binary(16) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `service` varchar(50) DEFAULT NULL,
  `pid` bigint(20) NOT NULL,
  `success` tinyint(4) DEFAULT 0,
  `action_name` varchar(50) DEFAULT NULL,
  `amount` varchar(20) DEFAULT NULL,
  `ticket` varchar(100) DEFAULT NULL,
  `transaction_id` varchar(100) DEFAULT NULL,
  `audit_data` text DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `map_uuid` binary(16) DEFAULT NULL,
  `map_transaction_id` varchar(100) DEFAULT NULL,
  `reverted` tinyint(4) DEFAULT 0,
  `revert_action_name` varchar(50) DEFAULT NULL,
  `revert_transaction_id` varchar(100) DEFAULT NULL,
  `revert_audit_data` text DEFAULT NULL,
  `revert_date` datetime DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `pid` (`pid`),
  KEY `success` (`success`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pid` bigint(20) NOT NULL DEFAULT 0,
  `dtime` datetime NOT NULL,
  `encounter` bigint(20) NOT NULL DEFAULT 0,
  `user` varchar(255) DEFAULT NULL,
  `method` varchar(255) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `amount1` decimal(12,2) NOT NULL DEFAULT 0.00,
  `amount2` decimal(12,2) NOT NULL DEFAULT 0.00,
  `posted1` decimal(12,2) NOT NULL DEFAULT 0.00,
  `posted2` decimal(12,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pharmacies`
--

DROP TABLE IF EXISTS `pharmacies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pharmacies` (
  `id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `transmit_method` int(11) NOT NULL DEFAULT 1,
  `email` varchar(255) DEFAULT NULL,
  `ncpdp` int(12) DEFAULT NULL,
  `npi` int(12) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phone_numbers`
--

DROP TABLE IF EXISTS `phone_numbers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `phone_numbers` (
  `id` int(11) NOT NULL DEFAULT 0,
  `country_code` varchar(5) DEFAULT NULL,
  `area_code` char(3) DEFAULT NULL,
  `prefix` char(3) DEFAULT NULL,
  `number` varchar(4) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `foreign_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `foreign_id` (`foreign_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pnotes`
--

DROP TABLE IF EXISTS `pnotes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pnotes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `body` longtext DEFAULT NULL,
  `pid` bigint(20) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `groupname` varchar(255) DEFAULT NULL,
  `activity` tinyint(4) DEFAULT NULL,
  `authorized` tinyint(4) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `assigned_to` varchar(255) DEFAULT NULL,
  `deleted` tinyint(4) DEFAULT 0 COMMENT 'flag indicates note is deleted',
  `message_status` varchar(20) NOT NULL DEFAULT 'New',
  `portal_relation` varchar(100) DEFAULT NULL,
  `is_msg_encrypted` tinyint(2) DEFAULT 0 COMMENT 'Whether messsage encrypted 0-Not encrypted, 1-Encrypted',
  `update_by` bigint(20) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prescriptions`
--

DROP TABLE IF EXISTS `prescriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `prescriptions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` binary(16) DEFAULT NULL,
  `patient_id` bigint(20) DEFAULT NULL,
  `filled_by_id` int(11) DEFAULT NULL,
  `pharmacy_id` int(11) DEFAULT NULL,
  `date_added` datetime DEFAULT NULL COMMENT 'Datetime the prescriptions was initially created',
  `date_modified` datetime DEFAULT NULL COMMENT 'Datetime the prescriptions was last modified',
  `provider_id` int(11) DEFAULT NULL,
  `encounter` int(11) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `drug` varchar(150) DEFAULT NULL,
  `drug_id` int(11) NOT NULL DEFAULT 0,
  `rxnorm_drugcode` varchar(25) DEFAULT NULL,
  `form` int(3) DEFAULT NULL,
  `dosage` varchar(100) DEFAULT NULL,
  `quantity` varchar(31) DEFAULT NULL,
  `size` varchar(25) DEFAULT NULL,
  `unit` int(11) DEFAULT NULL,
  `route` varchar(100) DEFAULT NULL COMMENT 'Max size 100 characters is same max as immunizations',
  `interval` int(11) DEFAULT NULL,
  `substitute` int(11) DEFAULT NULL,
  `refills` int(11) DEFAULT NULL,
  `per_refill` int(11) DEFAULT NULL,
  `filled_date` date DEFAULT NULL,
  `medication` int(11) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `active` int(11) NOT NULL DEFAULT 1,
  `datetime` datetime DEFAULT NULL,
  `user` varchar(50) DEFAULT NULL,
  `site` varchar(50) DEFAULT NULL,
  `prescriptionguid` varchar(50) DEFAULT NULL,
  `erx_source` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0-OpenEMR 1-External',
  `erx_uploaded` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0-Pending NewCrop upload 1-Uploaded to NewCrop',
  `drug_info_erx` text DEFAULT NULL,
  `external_id` varchar(20) DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `indication` text DEFAULT NULL,
  `prn` varchar(30) DEFAULT NULL,
  `ntx` int(2) DEFAULT NULL,
  `rtx` int(2) DEFAULT NULL,
  `txDate` date NOT NULL,
  `usage_category` varchar(100) DEFAULT NULL COMMENT 'option_id in list_options.list_id=medication-usage-category',
  `usage_category_title` varchar(255) NOT NULL COMMENT 'title in list_options.list_id=medication-usage-category',
  `request_intent` varchar(100) DEFAULT NULL COMMENT 'option_id in list_options.list_id=medication-request-intent',
  `request_intent_title` varchar(255) NOT NULL COMMENT 'title in list_options.list_id=medication-request-intent',
  `drug_dosage_instructions` longtext DEFAULT NULL COMMENT 'Medication dosage instructions',
  `created_by` bigint(20) DEFAULT NULL COMMENT 'users.id the user that first created this record',
  `updated_by` bigint(20) DEFAULT NULL COMMENT 'users.id the user that last modified this record',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `patient_id` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prices`
--

DROP TABLE IF EXISTS `prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `prices` (
  `pr_id` varchar(11) NOT NULL DEFAULT '',
  `pr_selector` varchar(255) NOT NULL DEFAULT '' COMMENT 'template selector for drugs, empty for codes',
  `pr_level` varchar(31) NOT NULL DEFAULT '',
  `pr_price` decimal(12,2) NOT NULL DEFAULT 0.00 COMMENT 'price in local currency',
  PRIMARY KEY (`pr_id`,`pr_selector`,`pr_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pro_assessments`
--

DROP TABLE IF EXISTS `pro_assessments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pro_assessments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `form_oid` varchar(255) NOT NULL COMMENT 'unique id for specific instrument, pulled from assessment center API',
  `form_name` varchar(255) NOT NULL COMMENT 'pulled from assessment center API',
  `user_id` int(11) NOT NULL COMMENT 'ID for user that orders the form',
  `deadline` datetime NOT NULL COMMENT 'deadline to complete the form, will be used when sending notification and reminders',
  `patient_id` int(11) NOT NULL COMMENT 'ID for patient to order the form for',
  `assessment_oid` varchar(255) NOT NULL COMMENT 'unique id for this specific assessment, pulled from assessment center API',
  `status` varchar(255) NOT NULL COMMENT 'ordered or completed',
  `score` double NOT NULL COMMENT 'T-Score for the assessment',
  `error` double NOT NULL COMMENT 'Standard error for the score',
  `created_at` datetime NOT NULL COMMENT 'timestamp recording the creation time of this assessment',
  `updated_at` datetime NOT NULL COMMENT 'this field indicates the completion time when the status is completed',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `procedure_answers`
--

DROP TABLE IF EXISTS `procedure_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `procedure_answers` (
  `procedure_order_id` bigint(20) NOT NULL DEFAULT 0 COMMENT 'references procedure_order.procedure_order_id',
  `procedure_order_seq` int(11) NOT NULL DEFAULT 0 COMMENT 'references procedure_order_code.procedure_order_seq',
  `question_code` varchar(31) NOT NULL DEFAULT '' COMMENT 'references procedure_questions.question_code',
  `answer_seq` int(11) NOT NULL COMMENT 'supports multiple-choice questions. answer_seq, incremented in code',
  `answer` varchar(255) NOT NULL DEFAULT '' COMMENT 'answer data',
  `procedure_code` varchar(31) DEFAULT NULL,
  PRIMARY KEY (`procedure_order_id`,`procedure_order_seq`,`question_code`,`answer_seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `procedure_order`
--

DROP TABLE IF EXISTS `procedure_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `procedure_order` (
  `procedure_order_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uuid` binary(16) DEFAULT NULL,
  `provider_id` bigint(20) NOT NULL DEFAULT 0 COMMENT 'references users.id, the ordering provider',
  `patient_id` bigint(20) NOT NULL COMMENT 'references patient_data.pid',
  `encounter_id` bigint(20) NOT NULL DEFAULT 0 COMMENT 'references form_encounter.encounter',
  `date_collected` datetime DEFAULT NULL COMMENT 'time specimen collected',
  `date_ordered` datetime DEFAULT NULL,
  `order_priority` varchar(31) NOT NULL DEFAULT '',
  `order_status` varchar(31) NOT NULL DEFAULT '' COMMENT 'pending,routed,complete,canceled',
  `patient_instructions` text DEFAULT NULL,
  `activity` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0 if deleted',
  `control_id` varchar(255) NOT NULL DEFAULT '' COMMENT 'This is the CONTROL ID that is sent back from lab',
  `lab_id` bigint(20) NOT NULL DEFAULT 0 COMMENT 'references procedure_providers.ppid',
  `specimen_type` varchar(31) NOT NULL DEFAULT '' COMMENT 'from the Specimen_Type list',
  `specimen_location` varchar(31) NOT NULL DEFAULT '' COMMENT 'from the Specimen_Location list',
  `specimen_volume` varchar(30) NOT NULL DEFAULT '' COMMENT 'from a text input field',
  `date_transmitted` datetime DEFAULT NULL COMMENT 'time of order transmission, null if unsent',
  `clinical_hx` varchar(255) NOT NULL DEFAULT '' COMMENT 'clinical history text that may be relevant to the order',
  `external_id` varchar(20) DEFAULT NULL,
  `history_order` enum('0','1') DEFAULT '0' COMMENT 'references order is added for history purpose only.',
  `order_diagnosis` varchar(255) DEFAULT '' COMMENT 'primary order diagnosis',
  `billing_type` varchar(4) DEFAULT NULL,
  `specimen_fasting` varchar(31) DEFAULT NULL,
  `order_psc` tinyint(4) DEFAULT NULL,
  `order_abn` varchar(31) NOT NULL DEFAULT 'not_required',
  `collector_id` bigint(11) NOT NULL DEFAULT 0,
  `account` varchar(60) DEFAULT NULL,
  `account_facility` int(11) DEFAULT NULL,
  `provider_number` varchar(30) DEFAULT NULL,
  `procedure_order_type` varchar(32) NOT NULL DEFAULT 'laboratory_test',
  PRIMARY KEY (`procedure_order_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `datepid` (`date_ordered`,`patient_id`),
  KEY `patient_id` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `procedure_order_code`
--

DROP TABLE IF EXISTS `procedure_order_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `procedure_order_code` (
  `procedure_order_id` bigint(20) NOT NULL COMMENT 'references procedure_order.procedure_order_id',
  `procedure_order_seq` int(11) NOT NULL COMMENT 'Supports multiple tests per order. Procedure_order_seq, incremented in code',
  `procedure_code` varchar(64) NOT NULL DEFAULT '' COMMENT 'like procedure_type.procedure_code',
  `procedure_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'descriptive name of the procedure code',
  `procedure_source` char(1) NOT NULL DEFAULT '1' COMMENT '1=original order, 2=added after order sent',
  `diagnoses` text DEFAULT NULL COMMENT 'diagnoses and maybe other coding (e.g. ICD9:111.11)',
  `do_not_send` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 = normal, 1 = do not transmit to lab',
  `procedure_order_title` varchar(255) DEFAULT NULL,
  `procedure_type` varchar(31) DEFAULT NULL,
  `transport` varchar(31) DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `reason_code` varchar(31) DEFAULT NULL,
  `reason_description` text DEFAULT NULL,
  `reason_date_low` datetime DEFAULT NULL,
  `reason_date_high` datetime DEFAULT NULL,
  `reason_status` varchar(31) DEFAULT NULL,
  PRIMARY KEY (`procedure_order_id`,`procedure_order_seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `procedure_providers`
--

DROP TABLE IF EXISTS `procedure_providers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `procedure_providers` (
  `ppid` bigint(20) NOT NULL AUTO_INCREMENT,
  `uuid` binary(16) DEFAULT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `npi` varchar(15) NOT NULL DEFAULT '',
  `send_app_id` varchar(255) NOT NULL DEFAULT '' COMMENT 'Sending application ID (MSH-3.1)',
  `send_fac_id` varchar(255) NOT NULL DEFAULT '' COMMENT 'Sending facility ID (MSH-4.1)',
  `recv_app_id` varchar(255) NOT NULL DEFAULT '' COMMENT 'Receiving application ID (MSH-5.1)',
  `recv_fac_id` varchar(255) NOT NULL DEFAULT '' COMMENT 'Receiving facility ID (MSH-6.1)',
  `DorP` char(1) NOT NULL DEFAULT 'D' COMMENT 'Debugging or Production (MSH-11)',
  `direction` char(1) NOT NULL DEFAULT 'B' COMMENT 'Bidirectional or Results-only',
  `protocol` varchar(15) NOT NULL DEFAULT 'DL',
  `remote_host` varchar(255) NOT NULL DEFAULT '',
  `login` varchar(255) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  `orders_path` varchar(255) NOT NULL DEFAULT '',
  `results_path` varchar(255) NOT NULL DEFAULT '',
  `notes` text DEFAULT NULL,
  `lab_director` bigint(20) NOT NULL DEFAULT 0,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `type` varchar(31) DEFAULT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `last_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`ppid`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `procedure_questions`
--

DROP TABLE IF EXISTS `procedure_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `procedure_questions` (
  `lab_id` bigint(20) NOT NULL DEFAULT 0 COMMENT 'references procedure_providers.ppid to identify the lab',
  `procedure_code` varchar(31) NOT NULL DEFAULT '' COMMENT 'references procedure_type.procedure_code to identify this order type',
  `question_code` varchar(31) NOT NULL DEFAULT '' COMMENT 'code identifying this question',
  `seq` int(11) NOT NULL DEFAULT 0 COMMENT 'sequence number for ordering',
  `question_text` varchar(255) NOT NULL DEFAULT '' COMMENT 'descriptive text for question_code',
  `required` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 = required, 0 = not',
  `maxsize` int(11) NOT NULL DEFAULT 0 COMMENT 'maximum length if text input field',
  `fldtype` char(1) NOT NULL DEFAULT 'T' COMMENT 'Text, Number, Select, Multiselect, Date, Gestational-age',
  `options` text DEFAULT NULL COMMENT 'choices for fldtype S and T',
  `tips` varchar(255) NOT NULL DEFAULT '' COMMENT 'Additional instructions for answering the question',
  `activity` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 = active, 0 = inactive',
  PRIMARY KEY (`lab_id`,`procedure_code`,`question_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `procedure_report`
--

DROP TABLE IF EXISTS `procedure_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `procedure_report` (
  `procedure_report_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uuid` binary(16) DEFAULT NULL,
  `procedure_order_id` bigint(20) DEFAULT NULL COMMENT 'references procedure_order.procedure_order_id',
  `procedure_order_seq` int(11) NOT NULL DEFAULT 1 COMMENT 'references procedure_order_code.procedure_order_seq',
  `date_collected` datetime DEFAULT NULL,
  `date_collected_tz` varchar(5) DEFAULT '' COMMENT '+-hhmm offset from UTC',
  `date_report` datetime DEFAULT NULL,
  `date_report_tz` varchar(5) DEFAULT '' COMMENT '+-hhmm offset from UTC',
  `source` bigint(20) NOT NULL DEFAULT 0 COMMENT 'references users.id, who entered this data',
  `specimen_num` varchar(63) NOT NULL DEFAULT '',
  `report_status` varchar(31) NOT NULL DEFAULT '' COMMENT 'received,complete,error',
  `review_status` varchar(31) NOT NULL DEFAULT 'received' COMMENT 'pending review status: received,reviewed',
  `report_notes` text DEFAULT NULL COMMENT 'notes from the lab',
  PRIMARY KEY (`procedure_report_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `procedure_order_id` (`procedure_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `procedure_result`
--

DROP TABLE IF EXISTS `procedure_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `procedure_result` (
  `procedure_result_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uuid` binary(16) DEFAULT NULL,
  `procedure_report_id` bigint(20) NOT NULL COMMENT 'references procedure_report.procedure_report_id',
  `result_data_type` char(1) NOT NULL DEFAULT 'S' COMMENT 'N=Numeric, S=String, F=Formatted, E=External, L=Long text as first line of comments',
  `result_code` varchar(31) NOT NULL DEFAULT '' COMMENT 'LOINC code, might match a procedure_type.procedure_code',
  `result_text` varchar(255) NOT NULL DEFAULT '' COMMENT 'Description of result_code',
  `date` datetime DEFAULT NULL COMMENT 'lab-provided date specific to this result',
  `facility` varchar(255) NOT NULL DEFAULT '' COMMENT 'lab-provided testing facility ID',
  `units` varchar(31) NOT NULL DEFAULT '',
  `result` varchar(255) NOT NULL DEFAULT '',
  `range` varchar(255) NOT NULL DEFAULT '',
  `abnormal` varchar(31) NOT NULL DEFAULT '' COMMENT 'no,yes,high,low',
  `comments` text DEFAULT NULL COMMENT 'comments from the lab',
  `document_id` bigint(20) NOT NULL DEFAULT 0 COMMENT 'references documents.id if this result is a document',
  `result_status` varchar(31) NOT NULL DEFAULT '' COMMENT 'preliminary, cannot be done, final, corrected, incomplete...etc.',
  `date_end` datetime DEFAULT NULL COMMENT 'lab-provided end date specific to this result',
  PRIMARY KEY (`procedure_result_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `procedure_report_id` (`procedure_report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `procedure_type`
--

DROP TABLE IF EXISTS `procedure_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `procedure_type` (
  `procedure_type_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent` bigint(20) NOT NULL DEFAULT 0 COMMENT 'references procedure_type.procedure_type_id',
  `name` varchar(63) NOT NULL DEFAULT '' COMMENT 'name for this category, procedure or result type',
  `lab_id` bigint(20) NOT NULL DEFAULT 0 COMMENT 'references procedure_providers.ppid, 0 means default to parent',
  `procedure_code` varchar(64) NOT NULL DEFAULT '' COMMENT 'code identifying this procedure',
  `procedure_type` varchar(31) NOT NULL DEFAULT '' COMMENT 'see list proc_type',
  `body_site` varchar(31) NOT NULL DEFAULT '' COMMENT 'where to do injection, e.g. arm, buttock',
  `specimen` varchar(31) NOT NULL DEFAULT '' COMMENT 'blood, urine, saliva, etc.',
  `route_admin` varchar(31) NOT NULL DEFAULT '' COMMENT 'oral, injection',
  `laterality` varchar(31) NOT NULL DEFAULT '' COMMENT 'left, right, ...',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT 'descriptive text for procedure_code',
  `standard_code` varchar(255) NOT NULL DEFAULT '' COMMENT 'industry standard code type and code (e.g. CPT4:12345)',
  `related_code` varchar(255) NOT NULL DEFAULT '' COMMENT 'suggested code(s) for followup services if result is abnormal',
  `units` varchar(31) NOT NULL DEFAULT '' COMMENT 'default for procedure_result.units',
  `range` varchar(255) NOT NULL DEFAULT '' COMMENT 'default for procedure_result.range',
  `seq` int(11) NOT NULL DEFAULT 0 COMMENT 'sequence number for ordering',
  `activity` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1=active, 0=inactive',
  `notes` varchar(255) NOT NULL DEFAULT '' COMMENT 'additional notes to enhance description',
  `transport` varchar(31) DEFAULT NULL,
  `procedure_type_name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`procedure_type_id`),
  KEY `parent` (`parent`),
  KEY `ptype_procedure_code` (`procedure_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_registration`
--

DROP TABLE IF EXISTS `product_registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_registration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `opt_out` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_warehouse`
--

DROP TABLE IF EXISTS `product_warehouse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_warehouse` (
  `pw_drug_id` int(11) NOT NULL,
  `pw_warehouse` varchar(31) NOT NULL,
  `pw_min_level` float DEFAULT 0,
  `pw_max_level` float DEFAULT 0,
  PRIMARY KEY (`pw_drug_id`,`pw_warehouse`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `questionnaire_repository`
--

DROP TABLE IF EXISTS `questionnaire_repository`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `questionnaire_repository` (
  `id` bigint(21) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` binary(16) DEFAULT NULL,
  `questionnaire_id` varchar(255) DEFAULT NULL,
  `provider` int(11) unsigned DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT 1,
  `created_date` datetime DEFAULT current_timestamp(),
  `modified_date` datetime DEFAULT current_timestamp(),
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(63) NOT NULL DEFAULT 'Questionnaire',
  `profile` varchar(255) DEFAULT NULL,
  `active` tinyint(2) NOT NULL DEFAULT 1,
  `status` varchar(31) DEFAULT NULL,
  `source_url` text DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `code_display` text DEFAULT NULL,
  `questionnaire` longtext DEFAULT NULL,
  `lform` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `search` (`name`,`questionnaire_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `questionnaire_response`
--

DROP TABLE IF EXISTS `questionnaire_response`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `questionnaire_response` (
  `id` bigint(21) NOT NULL AUTO_INCREMENT,
  `uuid` binary(16) DEFAULT NULL,
  `response_id` varchar(255) DEFAULT NULL COMMENT 'A globally unique id for answer set. String version of UUID',
  `questionnaire_foreign_id` bigint(21) DEFAULT NULL COMMENT 'questionnaire_repository id for subject questionnaire',
  `questionnaire_id` varchar(255) DEFAULT NULL COMMENT 'Id for questionnaire content. String version of UUID',
  `questionnaire_name` varchar(255) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `encounter` int(11) DEFAULT NULL COMMENT 'May or may not be associated with an encounter',
  `audit_user_id` int(11) DEFAULT NULL,
  `creator_user_id` int(11) DEFAULT NULL COMMENT 'user id if answers are provider',
  `create_time` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT 1,
  `status` varchar(63) DEFAULT NULL COMMENT 'form current status. completed,active,incomplete',
  `questionnaire` longtext DEFAULT NULL COMMENT 'the subject questionnaire json',
  `questionnaire_response` longtext DEFAULT NULL COMMENT 'questionnaire response json',
  `form_response` longtext DEFAULT NULL COMMENT 'lform answers array json',
  `form_score` int(11) DEFAULT NULL COMMENT 'Arithmetic scoring of questionnaires',
  `tscore` double DEFAULT NULL COMMENT 'T-Score',
  `error` double DEFAULT NULL COMMENT 'Standard error for the T-Score',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `response_index` (`response_id`,`patient_id`,`questionnaire_id`,`questionnaire_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recent_patients`
--

DROP TABLE IF EXISTS `recent_patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `recent_patients` (
  `user_id` varchar(40) NOT NULL,
  `patients` text DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `registry`
--

DROP TABLE IF EXISTS `registry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `registry` (
  `name` varchar(255) DEFAULT NULL,
  `state` tinyint(4) DEFAULT NULL,
  `directory` varchar(255) DEFAULT NULL,
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sql_run` tinyint(4) DEFAULT NULL,
  `unpackaged` tinyint(4) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `priority` int(11) DEFAULT 0,
  `category` varchar(255) DEFAULT NULL,
  `nickname` varchar(255) DEFAULT NULL,
  `patient_encounter` tinyint(4) NOT NULL DEFAULT 1,
  `therapy_group_encounter` tinyint(4) NOT NULL DEFAULT 0,
  `aco_spec` varchar(63) NOT NULL DEFAULT 'encounters|notes',
  `form_foreign_id` bigint(21) DEFAULT NULL COMMENT 'An id to a form repository. Primarily questionnaire_repository.',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_itemized`
--

DROP TABLE IF EXISTS `report_itemized`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `report_itemized` (
  `report_id` bigint(20) NOT NULL,
  `itemized_test_id` smallint(6) NOT NULL,
  `numerator_label` varchar(25) NOT NULL DEFAULT '' COMMENT 'Only used in special cases',
  `pass` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 is fail, 1 is pass, 2 is excluded',
  `pid` bigint(20) NOT NULL,
  `rule_id` varchar(31) DEFAULT NULL COMMENT 'fk to clinical_rules.rule_id',
  `item_details` text DEFAULT NULL COMMENT 'JSON with specific sub item results for a clinical rule',
  KEY `report_id` (`report_id`,`itemized_test_id`,`numerator_label`,`pass`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_results`
--

DROP TABLE IF EXISTS `report_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `report_results` (
  `report_id` bigint(20) NOT NULL,
  `field_id` varchar(31) NOT NULL DEFAULT '',
  `field_value` text DEFAULT NULL,
  PRIMARY KEY (`report_id`,`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rule_action`
--

DROP TABLE IF EXISTS `rule_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `rule_action` (
  `id` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to the id column in the clinical_rules table',
  `group_id` bigint(20) NOT NULL DEFAULT 1 COMMENT 'Contains group id to identify collection of targets in a rule',
  `category` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to the category item in the rule_action_item table',
  `item` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to the item column in the rule_action_item table',
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rule_action_item`
--

DROP TABLE IF EXISTS `rule_action_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `rule_action_item` (
  `category` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to list_options list rule_action_category',
  `item` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to list_options list rule_action',
  `clin_rem_link` varchar(255) NOT NULL DEFAULT '' COMMENT 'Custom html link in clinical reminder widget',
  `reminder_message` text DEFAULT NULL COMMENT 'Custom message in patient reminder',
  `custom_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 indexed to rule_patient_data, 0 indexed within main schema',
  PRIMARY KEY (`category`,`item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rule_filter`
--

DROP TABLE IF EXISTS `rule_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `rule_filter` (
  `id` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to the id column in the clinical_rules table',
  `include_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 is exclude and 1 is include',
  `required_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 is optional and 1 is required',
  `method` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to list_options list rule_filters',
  `method_detail` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to list_options lists rule__intervals',
  `value` varchar(255) NOT NULL DEFAULT '',
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rule_patient_data`
--

DROP TABLE IF EXISTS `rule_patient_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `rule_patient_data` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `pid` bigint(20) NOT NULL,
  `category` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to the category item in the rule_action_item table',
  `item` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to the item column in the rule_action_item table',
  `complete` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to list_options list yesno',
  `result` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`),
  KEY `category` (`category`,`item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rule_reminder`
--

DROP TABLE IF EXISTS `rule_reminder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `rule_reminder` (
  `id` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to the id column in the clinical_rules table',
  `method` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to list_options list rule_reminder_methods',
  `method_detail` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to list_options list rule_reminder_intervals',
  `value` varchar(255) NOT NULL DEFAULT '',
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rule_target`
--

DROP TABLE IF EXISTS `rule_target`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `rule_target` (
  `id` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to the id column in the clinical_rules table',
  `group_id` bigint(20) NOT NULL DEFAULT 1 COMMENT 'Contains group id to identify collection of targets in a rule',
  `include_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 is exclude and 1 is include',
  `required_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 is required and 1 is optional',
  `method` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to list_options list rule_targets',
  `value` varchar(255) NOT NULL DEFAULT '' COMMENT 'Data is dependent on the method',
  `interval` bigint(20) NOT NULL DEFAULT 0 COMMENT 'Only used in interval entries',
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sequences`
--

DROP TABLE IF EXISTS `sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sequences` (
  `id` int(11) unsigned NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `session_tracker`
--

DROP TABLE IF EXISTS `session_tracker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `session_tracker` (
  `uuid` binary(16) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `created` timestamp NULL DEFAULT NULL,
  `last_updated` timestamp NULL DEFAULT NULL,
  `number_scripts` bigint(20) DEFAULT 1,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shared_attributes`
--

DROP TABLE IF EXISTS `shared_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `shared_attributes` (
  `pid` bigint(20) NOT NULL,
  `encounter` bigint(20) NOT NULL COMMENT '0 if patient attribute, else encounter attribute',
  `field_id` varchar(31) NOT NULL COMMENT 'references layout_options.field_id',
  `last_update` datetime NOT NULL COMMENT 'time of last update',
  `user_id` bigint(20) NOT NULL COMMENT 'user who last updated',
  `field_value` text DEFAULT NULL,
  PRIMARY KEY (`pid`,`encounter`,`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `standardized_tables_track`
--

DROP TABLE IF EXISTS `standardized_tables_track`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `standardized_tables_track` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `imported_date` datetime DEFAULT NULL,
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'name of standardized tables such as RXNORM',
  `revision_version` varchar(255) NOT NULL DEFAULT '' COMMENT 'revision of standardized tables that were imported',
  `revision_date` datetime DEFAULT NULL COMMENT 'revision of standardized tables that were imported',
  `file_checksum` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `supported_external_dataloads`
--

DROP TABLE IF EXISTS `supported_external_dataloads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `supported_external_dataloads` (
  `load_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `load_type` varchar(24) NOT NULL DEFAULT '',
  `load_source` varchar(24) NOT NULL DEFAULT 'CMS',
  `load_release_date` date NOT NULL,
  `load_filename` varchar(256) NOT NULL DEFAULT '',
  `load_checksum` varchar(32) NOT NULL DEFAULT '',
  UNIQUE KEY `load_id` (`load_id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `syndromic_surveillance`
--

DROP TABLE IF EXISTS `syndromic_surveillance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `syndromic_surveillance` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `lists_id` bigint(20) NOT NULL,
  `submission_date` datetime NOT NULL,
  `filename` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `lists_id` (`lists_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `template_users`
--

DROP TABLE IF EXISTS `template_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `template_users` (
  `tu_id` int(11) NOT NULL AUTO_INCREMENT,
  `tu_user_id` int(11) DEFAULT NULL,
  `tu_facility_id` int(11) DEFAULT NULL,
  `tu_template_id` int(11) DEFAULT NULL,
  `tu_template_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`tu_id`),
  UNIQUE KEY `templateuser` (`tu_user_id`,`tu_template_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `therapy_groups`
--

DROP TABLE IF EXISTS `therapy_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `therapy_groups` (
  `group_id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(255) NOT NULL,
  `group_start_date` date NOT NULL,
  `group_end_date` date DEFAULT NULL,
  `group_type` tinyint(4) NOT NULL,
  `group_participation` tinyint(4) NOT NULL,
  `group_status` int(11) NOT NULL,
  `group_notes` text DEFAULT NULL,
  `group_guest_counselors` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `therapy_groups_counselors`
--

DROP TABLE IF EXISTS `therapy_groups_counselors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `therapy_groups_counselors` (
  `group_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`group_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `therapy_groups_participant_attendance`
--

DROP TABLE IF EXISTS `therapy_groups_participant_attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `therapy_groups_participant_attendance` (
  `form_id` int(11) NOT NULL,
  `pid` bigint(20) NOT NULL,
  `meeting_patient_comment` text DEFAULT NULL,
  `meeting_patient_status` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`form_id`,`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `therapy_groups_participants`
--

DROP TABLE IF EXISTS `therapy_groups_participants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `therapy_groups_participants` (
  `group_id` int(11) NOT NULL,
  `pid` bigint(20) NOT NULL,
  `group_patient_status` int(11) NOT NULL,
  `group_patient_start` date NOT NULL,
  `group_patient_end` date DEFAULT NULL,
  `group_patient_comment` text DEFAULT NULL,
  PRIMARY KEY (`group_id`,`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `title` varchar(255) NOT NULL DEFAULT '',
  `pid` bigint(20) DEFAULT NULL,
  `user` varchar(255) NOT NULL DEFAULT '',
  `groupname` varchar(255) NOT NULL DEFAULT '',
  `authorized` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_settings`
--

DROP TABLE IF EXISTS `user_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_settings` (
  `setting_user` bigint(20) NOT NULL DEFAULT 0,
  `setting_label` varchar(100) NOT NULL,
  `setting_value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`setting_user`,`setting_label`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uuid` binary(16) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` longtext DEFAULT NULL,
  `authorized` tinyint(4) DEFAULT NULL,
  `info` longtext DEFAULT NULL,
  `source` tinyint(4) DEFAULT NULL,
  `fname` varchar(255) DEFAULT NULL,
  `mname` varchar(255) DEFAULT NULL,
  `lname` varchar(255) DEFAULT NULL,
  `suffix` varchar(255) DEFAULT NULL,
  `federaltaxid` varchar(255) DEFAULT NULL,
  `federaldrugid` varchar(255) DEFAULT NULL,
  `upin` varchar(255) DEFAULT NULL,
  `facility` varchar(255) DEFAULT NULL,
  `facility_id` int(11) NOT NULL DEFAULT 0,
  `see_auth` int(11) NOT NULL DEFAULT 1,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `npi` varchar(15) DEFAULT NULL,
  `title` varchar(30) DEFAULT NULL,
  `specialty` varchar(255) DEFAULT NULL,
  `billname` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `email_direct` varchar(255) NOT NULL DEFAULT '',
  `google_signin_email` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `assistant` varchar(255) DEFAULT NULL,
  `organization` varchar(255) DEFAULT NULL,
  `valedictory` varchar(255) DEFAULT NULL,
  `street` varchar(60) DEFAULT NULL,
  `streetb` varchar(60) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `state` varchar(30) DEFAULT NULL,
  `zip` varchar(20) DEFAULT NULL,
  `street2` varchar(60) DEFAULT NULL,
  `streetb2` varchar(60) DEFAULT NULL,
  `city2` varchar(30) DEFAULT NULL,
  `state2` varchar(30) DEFAULT NULL,
  `zip2` varchar(20) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `fax` varchar(30) DEFAULT NULL,
  `phonew1` varchar(30) DEFAULT NULL,
  `phonew2` varchar(30) DEFAULT NULL,
  `phonecell` varchar(30) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `cal_ui` tinyint(4) NOT NULL DEFAULT 1,
  `taxonomy` varchar(30) NOT NULL DEFAULT '207Q00000X',
  `calendar` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 = appears in calendar',
  `abook_type` varchar(31) NOT NULL DEFAULT '',
  `default_warehouse` varchar(31) NOT NULL DEFAULT '',
  `irnpool` varchar(31) NOT NULL DEFAULT '',
  `state_license_number` varchar(25) DEFAULT NULL,
  `weno_prov_id` varchar(15) DEFAULT NULL,
  `newcrop_user_role` varchar(30) DEFAULT NULL,
  `cpoe` tinyint(1) DEFAULT NULL,
  `physician_type` varchar(50) DEFAULT NULL,
  `main_menu_role` varchar(50) NOT NULL DEFAULT 'standard',
  `patient_menu_role` varchar(50) NOT NULL DEFAULT 'standard',
  `portal_user` tinyint(1) NOT NULL DEFAULT 0,
  `supervisor_id` int(11) NOT NULL DEFAULT 0,
  `billing_facility` text DEFAULT NULL,
  `billing_facility_id` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `last_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `google_signin_email` (`google_signin_email`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `abook_type` (`abook_type`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users_facility`
--

DROP TABLE IF EXISTS `users_facility`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_facility` (
  `tablename` varchar(64) NOT NULL,
  `table_id` int(11) NOT NULL,
  `facility_id` int(11) NOT NULL,
  `warehouse_id` varchar(31) NOT NULL DEFAULT '',
  PRIMARY KEY (`tablename`,`table_id`,`facility_id`,`warehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='joins users or patient_data to facility table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users_secure`
--

DROP TABLE IF EXISTS `users_secure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_secure` (
  `id` bigint(20) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `last_update_password` datetime DEFAULT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `password_history1` varchar(255) DEFAULT NULL,
  `password_history2` varchar(255) DEFAULT NULL,
  `password_history3` varchar(255) DEFAULT NULL,
  `password_history4` varchar(255) DEFAULT NULL,
  `last_challenge_response` datetime DEFAULT NULL,
  `login_work_area` text DEFAULT NULL,
  `total_login_fail_counter` bigint(20) DEFAULT 0,
  `login_fail_counter` int(11) DEFAULT 0,
  `last_login_fail` datetime DEFAULT NULL,
  `auto_block_emailed` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `USERNAME_ID` (`id`,`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `uuid_mapping`
--

DROP TABLE IF EXISTS `uuid_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `uuid_mapping` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uuid` binary(16) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `resource` varchar(255) NOT NULL DEFAULT '',
  `resource_path` varchar(255) DEFAULT NULL,
  `table` varchar(255) NOT NULL DEFAULT '',
  `target_uuid` binary(16) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `created` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `uuid` (`uuid`),
  KEY `resource` (`resource`),
  KEY `table` (`table`),
  KEY `target_uuid` (`target_uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `uuid_registry`
--

DROP TABLE IF EXISTS `uuid_registry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `uuid_registry` (
  `uuid` binary(16) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `table_name` varchar(255) NOT NULL DEFAULT '',
  `table_id` varchar(255) NOT NULL DEFAULT '',
  `table_vertical` varchar(255) NOT NULL DEFAULT '',
  `couchdb` varchar(255) NOT NULL DEFAULT '',
  `document_drive` tinyint(4) NOT NULL DEFAULT 0,
  `mapped` tinyint(4) NOT NULL DEFAULT 0,
  `created` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `valueset`
--

DROP TABLE IF EXISTS `valueset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `valueset` (
  `nqf_code` varchar(255) NOT NULL DEFAULT '',
  `code` varchar(255) NOT NULL DEFAULT '',
  `code_system` varchar(255) NOT NULL DEFAULT '',
  `code_type` varchar(255) DEFAULT NULL,
  `valueset` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT NULL,
  `valueset_name` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`nqf_code`,`code`,`valueset`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `valueset_oid`
--

DROP TABLE IF EXISTS `valueset_oid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `valueset_oid` (
  `nqf_code` varchar(255) NOT NULL DEFAULT '',
  `code` varchar(255) NOT NULL DEFAULT '',
  `code_system` varchar(255) NOT NULL DEFAULT '',
  `code_type` varchar(255) DEFAULT NULL,
  `valueset` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT NULL,
  `valueset_name` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`nqf_code`,`code`,`valueset`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `verify_email`
--

DROP TABLE IF EXISTS `verify_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `verify_email` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pid_holder` bigint(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `language` varchar(100) DEFAULT NULL,
  `fname` varchar(255) DEFAULT NULL,
  `mname` varchar(255) DEFAULT NULL,
  `lname` varchar(255) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `token_onetime` varchar(255) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `version`
--

DROP TABLE IF EXISTS `version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `version` (
  `v_major` int(11) NOT NULL DEFAULT 0,
  `v_minor` int(11) NOT NULL DEFAULT 0,
  `v_patch` int(11) NOT NULL DEFAULT 0,
  `v_realpatch` int(11) NOT NULL DEFAULT 0,
  `v_tag` varchar(31) NOT NULL DEFAULT '',
  `v_database` int(11) NOT NULL DEFAULT 0,
  `v_acl` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `voids`
--

DROP TABLE IF EXISTS `voids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `voids` (
  `void_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `patient_id` bigint(20) NOT NULL COMMENT 'references patient_data.pid',
  `encounter_id` bigint(20) NOT NULL DEFAULT 0 COMMENT 'references form_encounter.encounter',
  `what_voided` varchar(31) NOT NULL COMMENT 'checkout,receipt and maybe other options later',
  `date_original` datetime DEFAULT NULL COMMENT 'time of original action that is now voided',
  `date_voided` datetime NOT NULL COMMENT 'time of void action',
  `user_id` bigint(20) NOT NULL COMMENT 'references users.id',
  `amount1` decimal(12,2) NOT NULL DEFAULT 0.00 COMMENT 'for checkout,receipt total voided adjustments',
  `amount2` decimal(12,2) NOT NULL DEFAULT 0.00 COMMENT 'for checkout,receipt total voided payments',
  `other_info` text DEFAULT NULL COMMENT 'for checkout,receipt the old invoice refno',
  `reason` varchar(31) DEFAULT '',
  `notes` varchar(255) DEFAULT '',
  PRIMARY KEY (`void_id`),
  KEY `datevoided` (`date_voided`),
  KEY `pidenc` (`patient_id`,`encounter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `x12_partners`
--

DROP TABLE IF EXISTS `x12_partners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `x12_partners` (
  `id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `id_number` varchar(255) DEFAULT NULL,
  `x12_sender_id` varchar(255) DEFAULT NULL,
  `x12_receiver_id` varchar(255) DEFAULT NULL,
  `processing_format` enum('standard','medi-cal','cms','proxymed','oa_eligibility','availity_eligibility') DEFAULT NULL,
  `x12_isa01` varchar(2) NOT NULL DEFAULT '00' COMMENT 'User logon Required Indicator',
  `x12_isa02` varchar(10) NOT NULL DEFAULT '          ' COMMENT 'User Logon',
  `x12_isa03` varchar(2) NOT NULL DEFAULT '00' COMMENT 'User password required Indicator',
  `x12_isa04` varchar(10) NOT NULL DEFAULT '          ' COMMENT 'User Password',
  `x12_isa05` char(2) NOT NULL DEFAULT 'ZZ',
  `x12_isa07` char(2) NOT NULL DEFAULT 'ZZ',
  `x12_isa14` char(1) NOT NULL DEFAULT '0',
  `x12_isa15` char(1) NOT NULL DEFAULT 'P',
  `x12_gs02` varchar(15) NOT NULL DEFAULT '',
  `x12_per06` varchar(80) NOT NULL DEFAULT '',
  `x12_dtp03` char(1) NOT NULL DEFAULT 'A',
  `x12_gs03` varchar(15) DEFAULT NULL,
  `x12_submitter_id` smallint(6) DEFAULT NULL,
  `x12_submitter_name` varchar(255) DEFAULT NULL,
  `x12_sftp_login` varchar(255) DEFAULT NULL,
  `x12_sftp_pass` varchar(255) DEFAULT NULL,
  `x12_sftp_host` varchar(255) DEFAULT NULL,
  `x12_sftp_port` varchar(255) DEFAULT NULL,
  `x12_sftp_local_dir` varchar(255) DEFAULT NULL,
  `x12_sftp_remote_dir` varchar(255) DEFAULT NULL,
  `x12_token_endpoint` tinytext DEFAULT NULL,
  `x12_eligibility_endpoint` tinytext DEFAULT NULL,
  `x12_claim_status_endpoint` tinytext DEFAULT NULL,
  `x12_attachment_endpoint` tinytext DEFAULT NULL,
  `x12_client_id` tinytext DEFAULT NULL,
  `x12_client_secret` tinytext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `x12_remote_tracker`
--

DROP TABLE IF EXISTS `x12_remote_tracker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `x12_remote_tracker` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `x12_partner_id` int(11) NOT NULL,
  `x12_filename` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `claims` text DEFAULT NULL,
  `messages` text DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2025-04-04 17:42:29
