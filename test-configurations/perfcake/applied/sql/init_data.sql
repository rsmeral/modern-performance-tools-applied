-- MySQL dump 10.14  Distrib 5.5.39-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: expensetracker
-- ------------------------------------------------------
-- Server version	5.5.39-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Employee`
--

DROP TABLE IF EXISTS `Employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Employee` (
  `id` bigint(20) NOT NULL,
  `bankAccount` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `firstName` varchar(50) DEFAULT NULL,
  `lastName` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_2y5g3ij0kgtvrlp3rtmjlabj4` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Employee`
--

LOCK TABLES `Employee` WRITE;
/*!40000 ALTER TABLE `Employee` DISABLE KEYS */;
INSERT INTO `Employee` VALUES (1,'123456789','admin@example.com','Admin','Administrator'),(2,'987654321','john@example.com','John','Employee'),(3,'654321987','anna@example.com','Anna','Accountant');
/*!40000 ALTER TABLE `Employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Expense`
--

DROP TABLE IF EXISTS `Expense`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Expense` (
  `id` bigint(20) NOT NULL,
  `datum` datetime NOT NULL,
  `val` decimal(19,2) NOT NULL,
  `reportId` bigint(20) NOT NULL,
  `purpose_id` bigint(20) NOT NULL,
  `receipt_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_hhk3n9didjvcyejb3fr5hr2c8` (`reportId`),
  KEY `FK_hc8rxmi7snyxw36jigjsws5n` (`purpose_id`),
  KEY `FK_9tdeac02af8mm757kq0pgoi3n` (`receipt_id`),
  CONSTRAINT `FK_9tdeac02af8mm757kq0pgoi3n` FOREIGN KEY (`receipt_id`) REFERENCES `Receipt` (`id`),
  CONSTRAINT `FK_hc8rxmi7snyxw36jigjsws5n` FOREIGN KEY (`purpose_id`) REFERENCES `Purpose` (`id`),
  CONSTRAINT `FK_hhk3n9didjvcyejb3fr5hr2c8` FOREIGN KEY (`reportId`) REFERENCES `ExpenseReport` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Expense`
--

LOCK TABLES `Expense` WRITE;
/*!40000 ALTER TABLE `Expense` DISABLE KEYS */;
INSERT INTO `Expense` VALUES (10,'2013-05-14 00:00:00',25.00,8,6,NULL),(11,'2013-05-15 00:00:00',20.00,8,6,NULL),(12,'2013-05-16 00:00:00',20.00,8,6,NULL),(13,'2013-05-16 00:00:00',100.00,8,5,9),(14,'2013-05-14 00:00:00',45.00,8,4,NULL),(15,'2013-05-16 00:00:00',50.00,8,4,NULL);
/*!40000 ALTER TABLE `Expense` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ExpenseReport`
--

DROP TABLE IF EXISTS `ExpenseReport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ExpenseReport` (
  `id` bigint(20) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `lastChangeDate` datetime DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `status` int(11) DEFAULT NULL,
  `assignee_id` bigint(20) DEFAULT NULL,
  `lastChangedBy_id` bigint(20) DEFAULT NULL,
  `reporter_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_bxmf3smqbt2ua923sjraqehey` (`assignee_id`),
  KEY `FK_hmoxx16playdmdoeikh7xh33x` (`lastChangedBy_id`),
  KEY `FK_bg1ejetmcoerc7645ylik3pqs` (`reporter_id`),
  CONSTRAINT `FK_bg1ejetmcoerc7645ylik3pqs` FOREIGN KEY (`reporter_id`) REFERENCES `Employee` (`id`),
  CONSTRAINT `FK_bxmf3smqbt2ua923sjraqehey` FOREIGN KEY (`assignee_id`) REFERENCES `Employee` (`id`),
  CONSTRAINT `FK_hmoxx16playdmdoeikh7xh33x` FOREIGN KEY (`lastChangedBy_id`) REFERENCES `Employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ExpenseReport`
--

LOCK TABLES `ExpenseReport` WRITE;
/*!40000 ALTER TABLE `ExpenseReport` DISABLE KEYS */;
INSERT INTO `ExpenseReport` VALUES (8,'Krakow, 3 days','2015-01-06 10:04:18','GeeCon 2013',1,3,NULL,2);
/*!40000 ALTER TABLE `ExpenseReport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Purpose`
--

DROP TABLE IF EXISTS `Purpose`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Purpose` (
  `id` bigint(20) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(25) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Purpose`
--

LOCK TABLES `Purpose` WRITE;
/*!40000 ALTER TABLE `Purpose` DISABLE KEYS */;
INSERT INTO `Purpose` VALUES (4,'Train, plane, public transport, taxi','Travel'),(5,'Hotels','Accommodation'),(6,'Any meals','Food/Drinks'),(7,'Gas, LPG, Electricity','Fuel');
/*!40000 ALTER TABLE `Purpose` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Receipt`
--

DROP TABLE IF EXISTS `Receipt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Receipt` (
  `id` bigint(20) NOT NULL,
  `document` longblob,
  `documentName` varchar(255) DEFAULT NULL,
  `importDate` datetime DEFAULT NULL,
  `importedBy_id` bigint(20) NOT NULL,
  `report_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_hicf104hdtxcmuoyqjhwwjpp9` (`importedBy_id`),
  KEY `FK_jfpkp8ipreq61r50vmmaarmdu` (`report_id`),
  CONSTRAINT `FK_jfpkp8ipreq61r50vmmaarmdu` FOREIGN KEY (`report_id`) REFERENCES `ExpenseReport` (`id`),
  CONSTRAINT `FK_hicf104hdtxcmuoyqjhwwjpp9` FOREIGN KEY (`importedBy_id`) REFERENCES `Employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Receipt`
--

LOCK TABLES `Receipt` WRITE;
/*!40000 ALTER TABLE `Receipt` DISABLE KEYS */;
INSERT INTO `Receipt` VALUES (9,'����\0JFIF\0\0\0\0\0\0��\0C\0\n\n\n		\n\Z%\Z# , #&\')*)-0-(0%()(��\07�\0��\0\0\0\0\0\0\0\0\0\0\0\0\0��\0\0\0\0�P\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��)]ʽ�\0\0\0\0Vo��͂ǿ����\03s�瞴�/hc��OXU��{ԫֈ\0\n��r��N�d�En��˟��\\���\0\0\0\0�W��,M(#��\0\0\0\0��u�S�=k׀\0\0\0�\\��ޥ��j��\0\0\0\0�}/�\'��`ٱ���\0\0\0\0WA�rs3��㋓�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Wȸ��E�K}�J�=��+��SR�s���[�:������h��`��_�y�g��tj�ݦ�\0���J\rf|S�ۥj>��@�\Z\0;>�\\�Of�_H�曭�4q��X��źD\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0f��ظ��\0\0�f�R�s�\0��,��״\0\0��\0$��\0U�ѱd\0\0\0<�٭�\0y���\0\0\04�@?�ؿ��\0\0\01[B��+�\0�\Z^�\0\0\0by�-g��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\0)\0\0\0\0\0\0\0\00@P #$5�����\0\0�\0M�n�ۇ�J���$9�Q_��ĔԗI8������mU\r�Ov����{�tA�ŽYً����+,����Э��S�T�UT��#I��U&:ֹ�rA7�u��<�5�_i�ǌ�U��,��ʝh\n�r�����Ƿ�\0qH�R�u�}+>(xB5��0��Ǵ��AA�XJ\0�O�)��o��YV#NV�|�J�|v;(@��^*NP��js��1>B�\"��\Z�O��ފL��{�ɝ��%ⴧ�FW#^m��l���BEt�4���U@2i�5���e�*��C�ʉ�36g�A��X5�Ř-��-��P��;4x\'�?�м�#LG�Iˇ��aS���(9���Z��U\\ҋ%.uA�*����6�7��L:ͤ3��9�������� �VK֟wd��(ͬ�^�l\n��詥��\r����Â�a�t���a�)@���L�L�]L��+�3\0�E)�d��Ҭ(�����݉sMs���D�c^�y�i1��ڗ0�E\rs�\0?3��=1D8��ݛC�j�����8�eNg�3rl1V6`A3���{�$ﭪXT���#���S{�K��r���T��:�͖gh731`�T,(���i3��\'fa6�C5Ҳ~�-�B�,2v�z=YcV������yZ=&S!Y[��olk��\0��������+{�G����td��	���ch����1��ڪ2ʔ�\Z��j�hh�u��]ics��EX���jZzuӧ5R������v���?+ńa;p��3��g��\\O�E�F���V�y�̀�<���Ҳ�s�g���|RR�26d�L�c�38@���\'���$�����S7UN����d�3��\'a�S�/��x�\0��̀���kFV��z�:��Lej�wW�,�����KK\\:zI�G!�<feם�y��8L��\'t�\Z�\"n33�����{Ԋ���vS����\\hic��:�k_>N|����-4�b��^wuc$�.~z��dr���ow�P����2��}ݪ���#���W��V�|��P�i�U�5����	�����������6��-���UY֏vw?ݝ���p�Y���lul]���ͪ�4ѫ��*�ׁj�u0�T��K�������\0A\0\0\0\0\0!1\"2AQaq#B���0����3@PR�r�$Cb��s�����\0\0?�\0ᴒ��KyTr��C���a���#��\r���Sw	�a}|���azy0g�_�hq*���\\�R̈��>�\0?�\\g����aWIlL�w��lL�YG���M�K$K��G��v�<�	d�<��YOW�˟�4��SO,���)��ݻm_��-8���������\"ݐ�\0�+з/�x 	� ��\Z�N�����o���\0�봚l;��_��V�������n�7��,p��vyw�k+ۗ��g+�IX�A��߾��J1� �Ƹ)&�É��T�ң�}1�����EU���+�i�u\ZJ��X��i��a{�[�WםM��W�݆�b~~�W9dq1R���շ�R*��ŲY�,G�����D)�0�-4	W���L�!�ֽti����l�b=o����\\&1�+{��R\'	Ĉ�rZ�2���.��F\r�ܽǍ:E&��`�����v�_ޥ����$X������C�Gִ���j������#,�Z�߭�e��z~�^40�D`��ů�75��]9I{�΂��n�75 -n��%w��\Z3�\r�ߵ��������u�&�2\n����9V-��Z��|���\'�fL��\Zx�]<��&ǝ�TĻH��۟���U\0�s }iߋX�U��-��e�^w[;r�Z��P#\"�]�lm��Z�� ��T�{~t��rksS��	n��֙�Xb�z�G#j�\n����\0*Ӗ<�������:Җ<�5�_o?�4�f���@`M�T�.�p�\\~�6E�H%��-a�ڕ��92���7���Ͼi����ᄒ�-�ߪWo�їb����0��*2�Q�\\�F��ѱ�R#c�l�A�rO֤��-&P�Ho�]��n%\"����O���Q�] qĔ�\0���[^���ڸ�:fH_L���o�_�RH�@l}��-���\0V�\ZlyM�Ù��+�\"H�jŜD�6�wuj�\0��X�4��*~u����J[�\"��:�����0Wd($$ʞ�R��>�\"�BےH�:�&��6��w֨͗��o3��郣-����?/�̀�O���O`�=�l.-�ᰩ���;���[���tl��zT��źŉK�szXc$\\A���&G���=��zB�f���cY~��p�{�C�˟g���1�%���6����d��&�󩑥���z�mf��}§��!�ݝ���*I��EKz_���Y���.lX�qO��$����T�Xm\"ኆ��6:��j�,Ew�;�\0��4/��sko�\0p�h��W���_��TQE�k�;[�ָf��h�2��*��ݯ���^�4eш���x�al��뉈NILz� ����RZL�֎FǏ�\\4��ƬO��cinZGC� \\����X�Jc�\0r��<�u-��%�=p����Z�����Ҥ�T�Τf-wU]��$��; ���H �N	oj�ϑ\0r�\0X�H��ɭzS���ɓ�F��$A#�B	\"R��)���Z*�c��]�di�&P���;�QN�-���q�,BGu]�;l<6�V�G�%U��\n��K.�����݋o��E�0��ߺ��fmm�����jQ���l<�o�fP��F��-�hݣ�N�8Ņ�Ǩ���3l��{����x�ƪ��_�xPȂ��T�:�TUe�ܷ�EG�;\r,:������F+v�w짙�����!e����\0��	�����PE,׌K��}})i$��I��ƸGh�I#V8�𨰎WiY@�\Z$�����=��jIA�ļ�a�\'�xR.�īs0�c��Ҍ$\n��<��a W�9���\'�_�GX�s��2�Y[�?`t�c%�ü\r��A��E��+n�]���e�3dEŁ���Pr,�*G�65�d���6����jY:>����x�������OZ��F���\'��EW%y[��ԯh�y22��v�\'If�B��j����:�A�u�oQYpzB��v\n+|yRG��\"{N{~>�(�,k���[�RJ��(M�7�.�y�R!	52^�;����\0c�^\r���C�&�ћ���aJ���?S\\�o�m�\rLv�8�?ۗ�*--\"�	ܝ��<낌�2�ǃ#��6��^��OĠc�i���$���\\�~�V�����a���m&ܯ��\r.�Aݶ��\0\Z�����ko���J߇�_�Wo�q,mi$�����J�8F�J�׸�\ni3ǟP�/X�m��T/�L����o�R�2e��v�}kN���u��s��\ZӺt}]k�����}�z�M�{Q/o���[^���NtΪJ}�\0F��\"�:	:�)c	\"X�[!��\0��Z�6�[j��7S\Z�w�q���7���+��}���1i+���cnX��V$Wy�b9�|*8���s�a&]����r�\0I��=���r�\0I��=�A��%I���i�u�J��?G�6Eb�i,v�.�A�����¬�o�}U-��ޕ�H��6˺�5_��-�P���w�$V�q���L8hop�`�}E��|���&�z���5�?a���^�.^�W�����y{ܹz�����Yɶֺ�����\Z3��n�w��O+D��|�ԋ�Ӻ�M&�0f�yWZ\'�9m�\rc�y�J/f\\���Z���j$裈�%�>V��ꉤwiQq\'3c�r�X����m�o;��S���Z���;��<k$k&Nql[�j\"�D��\0W�Ҹ8�<G\r��u��v��ǈ����T��\Z�í�u-字�SIn�F��-��c�\\����~w�Ii�EQ����_~cƛم�B8���e��W���x`ߵҊi����,�Z�>�1�	dֱ�qTl/��W��n�m�K����%[�7?:�懆a�����6�u�RɅ�d�?�G��z�ڗ��;z޺>����ԿvY���\0�Ǖ��\\��!\\D��\'J2�a�4ipǇ�@��:�جr�ZT��a�s޴�iB��Sa�m�\\.���X�������I��9 �3\r������%$����cH���t �oOZ�hfVuFmKs����yr�o��:�Cc,��%��ܮ�SG#d�>x�ֺF����ӷvX_�]#S����ۻ,/��Of�7��Rt�U�F�u��}~ 1h^�������A�M�Q4B�k����%+��=����nu�[\n�؋�v���\Z�\Z�4������a�Zh�6�jD�P���f�~%P_,إ�W����7�A�%�A:�+�w�h�g��E���\0��i}�8w|y�����{�t�������Oa���>�>~������i��TJ�mh�av��Z�Y�����>�@p����c���(�6�l=j�HLᘷ5����E��H�Ƶ,�WF��<o�K\'G�ѷ���~߂��2�ǃ#��6��^�\n�Z�l{ԛ����M�8�����S��#)V��E�e�1�6[1���$OX����o���WZ��<��;�G�ֿ��+|~�tK�{[�����6ȱ�k�󩧂)5Q�)\"v�^T���\0A\'�v=i#G��&��˟���6��V^�mI�a��{����Z�x8DF�rm�-�p�L1���5S�/Ч3*���bp��+(�\'H�����t��#�_���xnQ��y��Oָ�<�t�(�8�F<��$��\n�X���GO���K�7���<�+��E�z��|/����p��ï	o7���E���H�ܲ�\ZZ�I�f&���e�D�&��u��}�t�{��\0���\0,\0\0\0\0!\01AQaq���0@�P�ѐ�������\0\0?!�\0�`�l�k��	����pJx���x�\'�}mǌ����N�MT\rϬ���#�t�\0j�\0��2Gd�� 4�240jwJ��Je٘�䔆��\0�\n㒀��:0��HU��Hl/v+�@\Z��s	\'�����p�+���FX_�l�ޡF��>Y��pō�L��{���\'�>t=y���LX����1\"2�Z��nY�vX�V�\0ǜ��s������s��)O��F2�:�!������;�T����P,L�IoO?Of���\nE�\"c\"𓣯����/�VK�\0ZB�~��C9�8G��d��jYg�R��L/r����qՅ8����-8\\|��>|RO���\Z���P����\'����L�)X�/\\i-�,��/�|����u\r�X����8���Z#@��?�QT��g,���G��\Z4��Dj��z�y������\r[�?�&\"*�����B2�~.�*E���Q3�$�\n�K�l�ka*�az(,��wΜ4PH(�����\'�a���6 ��X���q�3�A)�|��E�A\nũ�=h��fC�I�9	��c���dJRX����Bhq�d��^G�K5\0d�:w;c����6pY8v����e��R	))�\"��g���ht��8ٶ8�`{�p�e�T�qH���{��2|9\\�\"r1��4�YK�!RB<��l>tZJh���	E�����F�T��#�\'���E?F\r,l�n6bZ�\'L������b�ѭ#�S��\nTE�\0�����x��jtà&\n��a��$����b>� }+f9ܰZ>�N.rD�d%BG|�(	���Y$���*�1$Z���]u �ɴVJiu$5�m�rV�������\"�,���	pK�ز-{��t������j�����:���\0���?pc�daxp}�\0������U�yئ��(��!H�Aѐ�C˹B�\"�\"��l��i�걡f����\0�Y.�+[�PB�yI�#�f��014ă�����	�h��cd	�5�\0�;�*�%���dM�V�\r`E\ne�K��Q�C5X�����#�3��|��`�Q@<��a\Z��MG\Z��06d}$��#��YZ�����R�\n;,w_YOϹ�C#���P��0���J�,A�5�������&:���s���X\0{��!h��]�Ma����������M���\0?�EL���poԘ�P�5O	��x���j����0��P/���U�lJ+��lc�5�~������@�/�X��76��^N�h)�M�\0S�E�!}l�#��	�rs��N_���.94a���y}\0�)O4KX��ȸ*�\r��v�_�D0؉�S�L|��������aeTT|�k���B�a�k��N���VrM���[��:CG|��\0@�%���&K�B4)��ü�ĥ H���%hD#�R�nd�X�s�R�nd�X�s���O�C���I���T�P1���|&Za�<Ό�TX%��23�d�p�c��`�a����1�B<��p���#C���y�y\'1Фxed��\0^y�u&��tk�/���r䄉&�Sb&�[�dq�3;k��a��;)�2\\F9�!َ�B�.!Q\'��Ȃ�H�Dnnq�\n��W�䴴��ۓ�0��T�q7�	�aK�8ja��jУ�����\0��\0#߿�\08�6��\n�X���<R�+C��A����q\";���s��mĈ�3�9�Q�HQ�W����׋�����\0���z��N1���S�Rք��Tu�(��$\"�Xj����2��dm�\0|0O�1���:�x�.�E������C~O�ƣ�Z��V�dV�w!��B�G��U���@ɏ�$@�PnU+����A���c\0��x\Z��|�NPlq! L(�`�)FGJ�����>�+ݘ��*��_Xl+�,\Z�5rc���`�|#�?q[�\\��3g�+tk�w�ꙏi}��/�͘�1M�vf��H�J��7�����I����D΍��ף���R����x�6Z���\0�Z�\\���Zl�S�q��s���H����p�\"��Pv�^�9;m7k\rd�� ݬ5� ��<��]�ml�O�I����>�\Z�C��Jrm��x��C�0�Qg���b4�O��JΠ�Nҙ� �0\0u�����e����p��>���=yȼh19\'0^�,�\'&�5�g�8�7���x�\0��j�ݓqü�T\r�1ɕx�E����\0Bg��X����ee��\rk�D�%�Y�u*x�L�.$U�T�u/�E�>\r�Af�h�%�(Ʀ����sE����`�\Z���XVb�T���\'��m�q��N;M�ۈ�� �(�\'�\0L�,9܍�pj�	_�F[H9���4:ֱ��\n��7��=���6C[�d�$���W]Þ�D��{�8y��,�\"�no�K����~Q�<�L3�`��������#|��<[�Ѝ�����Ϩ���\0ʹ�<N\"��@,x���v�j���\0�8(<K��Ni����g8�Q+B ���s&:�k���s&:�k�׆D�i�v|3��d�p�\r��GD�{x�q�?�����ٖ94Q�)\nі��$����9�n6�Dw���ݸۉ�g�s���O�ct��\"8�j��5�Q���r&�j}d��	o_�aa=R|�5YO��Ys3���s�&u�`��J_�ct>�}�n���ź��~�{�MLF%�P$����C�/	 (Vd<>z��Q���L�iu�{/�(N���4�oű\0���\Z�Ϧ�ծ�>��V�����\0\0\0\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0ߟ�\0�Z�\0�3�\0�\0G�\0�?�\0�\0�\0�\0�+�\0�\0�\0�\0�\'��\0�\0�\0�\0T��\0�\0�\0�\0�]_�\0�\0�\0�\03�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0��yK��\0����\0����\0���\0��\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0Ͽ�\0�\0�?���\0�\0�\0��\0�\0�\0�\0��\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0��\0�\0�\0��\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0�\0��\0,\0\0\0\0!\01AQa0�@Pq����� �������\0\0?�\0�c�΋TT���@�\0��b��Y���E���B��	�6��w��\0ф���;\'�\n�\"5\n�.��\Zj��cՄO�5n\0�ab�4�-9Qc�UI()������t0�\0O��Щ�p>s>y	�ðx\n�pr0�{5\Z�JB\"�-���1r+�mO�3j����W0���8�4LW.੥�J�jq@�*Z�-؇�#��w�\0iʕ�1$������7��C��h���W�\0,���CAD:�o������^�5@\'K�A��d�-N����w��r9��3L���@-�s8Ԉv\'$�5��������:�C�}/�;�[)}��N�{����|Pa5�E�PLo�r�F3��E�3p\ZB��u��;����XB�p\"K�z�����he��w�H�i���<tqCC�*�t�g�O��TQ�4>G�\0��d�	/Kw�UC�Kv~m)?�\0r/��N.a��Ǭ1Lҗ�W`�J32\Z����=:\0����N��&���Yy	�G��;�aG\ri5b�ǅ��H0L�h��\'����{����iJ�B@�#\"� �b��\0�ټ�v�0��_�xmи�\0���iL*4@��3)��H�$\r$Ei\r8�=g��\'X��{��P\"���^�J�jP.N�Ģ�MـS��8�W��DA|\'X}a��J�y�as��6^���x@��xf�w�;@�k�D���F�D��\r�q0�=&1g�9H60�1�咜z��Ʈp5t<W��N�8�&C#;a8���6.��΀��\0#b�{\0\'\\�)���\n��j�Q	oNZH\'�Ȱժx˞�=`	@9��E��h+��]`��4ifؑ���\0�\n (DL�e ,	�J��r3�dj��5[B��\"I�\nM{;�Ē�������qx��B�e�(�<��`�&6�;�9���3D���.�S�\n�P�=�J$�P_c&�s0�\n�w���;���\n1�T?F�׶t��Q3#�D���\0e�;���H�K�U��rR:��P\'�v���,v1�\0��1��=�)D���S�b�c0ᱢ%\nY��\'J�>�:����j~�ݐ�;[:Q��mR8��	\0.c��<��|��f����������snd�&��Ɲmb��J�^\\�w>\Z�ñ��IR`��d��y�#\nv^�w��	`2�|��fI�<@�t�xxH`�t�q��k(! .!g���v��L�H�J.��e9I���\0U\"�h��Ox�(\0\'M�\nV�b\0\\	���|\Z��\n5�_�tXk�8h�\n¤��TR��@� d�8��^����A�R%�(�tV�nkOv���6\0:�N�\r1D@ɘ��l�f��� \"�\"�g$xQ��O=PDG Ș��6�>�s�)0)(#��k���EH�%�[��R�i��M]oP��	�#@쎚�(G��:\0\0 {[�`��Pd;�[���Ei�\n���-�UD�h|����v\nө˹����\nB�-�g���#���4࿆DE-�!���Vr��M[ɨ���T���\"��e}l�t:�	Δ��b߀^���c�Q�Nð�C����M!`�P�>»d�\\�8��P�V������Cè�\0���*��pR�1��n\0N`u��-��5A(�N&�R�T4D���%�1��RDѧ��+���04���n�V�l/-h���)�\\[0��hx�\r+^�~�\\�d�$�\rN0��zDJ�i{�:^L_�����ONlF�?�=>�����\\/AQ�H�@��*A���\0\r�\'#C��`\0���\r����T	��抣�C��\'F�\Zr�bQL�v/,��[Q�G�SU�\\j#�-��b��4�+ةU������hW��8UW :��dۓ�Ƙ���HEy\r�\\5蕦�4Wu�d���x�k�����!O�J��A~	Py&���f���Z6`�\na�:_X�+H\\j���o��%��ػ}$�(θ��z�6`���f���\Z2�|��wD�I �D\r�^�$�BG�� �I�84������\r�β���\0����\0��O�Ȁ��A<%L�;�sF�۲&��9�(\n�	D#��<��;#���F[u���BkD�V+r��)����ɺ�\n1;8л5D@6(���`����2W\r�*��U���ww�$:D�M9:ӸA(�\"�x�z&@Kͳ����d��8���\n.%��T�1��c�\\����\n�)&>�c*a�*��L��N�YJ�^���V���v���O\"vU��\"�\'�Ta���/Pb�F�@]���ѳ^.��A\"-X���U�1D��g�W~��7�Y��߾>\r����CS�(�p)m�.e�`��Qu�A�{�\0a[�4�7��ڋ�#�|�)��m,�L���(\0)-,n:₇b�)EUG��S@=�b9fgMP���9\\���j>(7��*�,�eg����g\'���� <�On*��\'�l�;�.rj�\r���#s�|�C�L�d	����k��߷F���0<l0^��(��׈h�x��eO�\"%W��0�����?����]yȬ7a\Z�W�C=j9�\'�.!X��F��js�?�i��k�0������U�}�i\'�&3�CL��L�j��9O.y���({�z�|Q�U/p�+�	�\'h����đ��L\n �50�Ǳt�G���ǡ��*:������g��*��\nb�?N��B��|8�J!T�������\Z�A8���m\0�8[O�\Z��-��?֏o���/�E���r���nk����Ȏ�!\r\'�\'@7xE�GhҰ���o^8��V2�>�j�SA�p�\n��	��q�YY��M�h1DD<+����=\"ՠ#�%�m@U8��=<\ZGOR1ғ���c�Ť8���9ן�U����u��~��3�u����m��MJo�~���I�\r$����%�X ��m�,�\"�u�]��4�{\r��:�����4��Z/&/����G�\'��#}잟]�<N%�ۆ�M(�C������\0MJ>���$�@=7ay#�S;K�aqpJ(Ճ��\0�N}��|���`?��)��ŧ�Rv��*ςz9\r��u��;����GP��:���CV�)̺t��;0�|_�Ѐ��%���	xLgŨ�@�g�q+7\r�9w�L�������6���;����Ƿ����}c��~�X��	��9߾H�H\Zv����1����S\\����DE4u	����nz4WP��A@4��txxs�,aF���9F��\r���Dz��!�wxm�����p��\'��;m��\0�_��','Hotel X invoice','2015-01-06 10:04:18',2,8);
/*!40000 ALTER TABLE `Receipt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reimbursement`
--

DROP TABLE IF EXISTS `Reimbursement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Reimbursement` (
  `id` bigint(20) NOT NULL,
  `datum` datetime NOT NULL,
  `val` decimal(19,2) NOT NULL,
  `reportId` bigint(20) NOT NULL,
  `creator_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ia9ayphf3i6faqg94ytk7pg6x` (`reportId`),
  KEY `FK_qwr7a1wysqgni4gbf3ikco9fu` (`creator_id`),
  CONSTRAINT `FK_qwr7a1wysqgni4gbf3ikco9fu` FOREIGN KEY (`creator_id`) REFERENCES `Employee` (`id`),
  CONSTRAINT `FK_ia9ayphf3i6faqg94ytk7pg6x` FOREIGN KEY (`reportId`) REFERENCES `ExpenseReport` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reimbursement`
--

LOCK TABLES `Reimbursement` WRITE;
/*!40000 ALTER TABLE `Reimbursement` DISABLE KEYS */;
INSERT INTO `Reimbursement` VALUES (16,'2013-05-13 00:00:00',150.00,8,3);
/*!40000 ALTER TABLE `Reimbursement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hibernate_sequence`
--

DROP TABLE IF EXISTS `hibernate_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hibernate_sequence` (
  `next_val` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hibernate_sequence`
--

LOCK TABLES `hibernate_sequence` WRITE;
/*!40000 ALTER TABLE `hibernate_sequence` DISABLE KEYS */;
INSERT INTO `hibernate_sequence` VALUES (17);
/*!40000 ALTER TABLE `hibernate_sequence` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-01-06 10:06:36
