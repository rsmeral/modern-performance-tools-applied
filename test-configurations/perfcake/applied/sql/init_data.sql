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
INSERT INTO `Receipt` VALUES (9,'ÿØÿà\0JFIF\0\0\0\0\0\0ÿÛ\0C\0\n\n\n		\n\Z%\Z# , #&\')*)-0-(0%()(ÿÂ\07‘\0ÿÄ\0\0\0\0\0\0\0\0\0\0\0\0\0ÿÚ\0\0\0\0ıP\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Õô)]Ê½ğ\0\0\0\0Vo›İÍ‚Ç¿ü·õ \03s§ç´²/hc ‹OXU—ˆ{Ô«Öˆ\0\nõşrêåNìdÚEnØ—ËŸöÇ\\ı‡æ¨\0\0\0\0ñW½™,M(#û´\0\0\0\0â¾îušSó=k×€\0\0\0¾\\–êŞ¥ó¬İjìÚ\0\0\0\0¬}/¿\'­Ğ`Ù±½´\0\0\0\0WAÇrs3­ıã‹“€\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0WÈ¸ãíEŸK}›Jì=ÅÔ+ÜùSRØs¾´ó[ :­ˆ¾üâíhöĞ`ı³_‰yÖg»»tjıİ¦İ\0ó¬œÁ¯J\rf|S«Û¥j>û@Ì\Z\0;>Ü\\õOf_HÊæ›­Ø4q¶ò½XŸ†ÅºD\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0fçËØ¸»¤\0\0æf¹RösÑ\0åÃ,Ò×´\0\0“ÿ\0$…®\0UÇÑ±d\0\0\0<å«Ù­Ğ\0yõî\0\0\04é·@?ÊØ¿óÒ\0\0\01[B¦+Ú\0Ä\Z^°\0\0\0byı-g½ \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ÿÄ\0)\0\0\0\0\0\0\0\00@P #$5€ ÿÚ\0\0ÿ\0M¨n‰Û‡¢J‚¯Ç$9Q_†ç³Ä”Ô—I8®Ôí¿ÅëÏmU\r›Ov½ÕÈ£{¯tAÈÅ½YÙ‹ñééô+,áøªĞ­„®S½TöUTÔõ#IÓÉU&:Ö¹ò°rA7õu¨<Ï5Ì_i‡ÇŒüU«‘,ŠãÊh\n¶r‡Òğ¨Ç·ÿ\0qHˆR¨uóœ³}+>(xB5…¼0òğÇ´¥ÆAAãXJ\0µO…)£“oÇŒYV#NV­|éJ…|v;(@¹‹^*NP‡Àjs¬1>B©\"øé\ZOï©°ŞŠLßú{‘É±†%â´§‘FW#^m•¤l„ŠæBEtŠ4ô°£U@2iÜ5ş×eó*–¶C©Ê‰·36gÇAµ³X5ìÅ˜-‚°-·ÅPØë;4x\'§?ÒĞ¼µ#LGŸIË‡´µaSÍËä(9äğôZ‘ÈU\\Ò‹%.uAè*ô«ô»6¤7¼›L:Í¤3•Ş9£¯”‹Ø¥® ÙVKÖŸwdæó(Í¬Ÿ^Âl\n°ùè©¥°“\råşêÃ‚…aèt ÒÄaâ)@°´äLøL—]Lù¼+Â3\0’E)d¸ÅÒ¬(áü½¸©İ‰sMsµ¯×Dóc^×yói1ƒëÚ—0­E\rsÿ\0?3©”=1D8Íáİ›CÒjÏª»8ëeNgª3rl1V6`A3ğñş{«$ï­ªXTçó#”ŞîS{¾K…æŸr„­ÊTŠ¥:åÍ–gh731`©T,(ÆÀ§i3ğï\'fa6â‰C5Ò²~‘-BÎ,2v´z=YcV¬©³ÊÑêyZ=&S!Y[Õolk‘É\0•Ê©‰›ŠŞî+{¾G‘ˆó±td”ª	°Ìóch Á¼¦1ƒëÚª2Ê”ú\ZŠÜjèhh¹u¥]ics±—EX¥ÌËjZzuÓ§5R´¥ô­ˆøv–Šó?+Å„a;pôó3äægÉò\\OáEáF¥ÃçV®yûÍ€Ô<ãñ‚‘éÒ²ßsãg“øº|RRÊ26d»L—c®38@²Åõ\'æÊß$ÓøèáĞS7UNÉßñdØ3Š×\'a‡Sƒ/İxÿ\0ƒËÍ€ «ŸkFVŠ­zç:‚ÅLejØwW¬,·ìïšåKK\\:zI…G!§<fe×İyİò8L€£\'tØ\ZîŠ\"n33û¸½„{ÔŠãËövS¶™™ç\\hic‰é:Ğk_>N|Ÿğüõ-4åbò¸^wuc$Ÿ.~z‘¾dr›İÊowÌP³Š˜˜2Ê¥}İªŞØ×#’©‰W½ÜV÷|¶ò¼PíiÌUï5ÍÛ«	»¯¹»µÒâı…“ê6•¹-©–§UYÖvw?İÏù©péY©¡ñlul]¯¡ıÍªê4Ñ«³Ù*’×jŒu0ÉT“ûK¹şÒîıÿÄ\0A\0\0\0\0\0!1\"2AQaq#B‘¡Á0±Ñğ3@PR’r¢$Cb‚s€ ñÿÚ\0\0?ÿ\0á´’½ñKyTr¥ñ‘CùÔÚa†”†#û‡\r¾¡Sî½¿w	Ãa}|ú×åazy0gÄ_æhq*şÆÙ\\÷RÌˆêË>ÿ\0?é\\gşËşÂaWIlLÄw¦¿lL½YGüìM…K$KŒñG˜˜v®<ê	d†<ŸYOWŞËŸ­4óğSO,¥½¨)Õßİ»m_°‡-8Şşïî•¿ş—ª½\"İÿ\0—+Ğ·/äx 	¥ ùõ\ZµN––¾¬oÛÆõ\0²ë´šl;…»_‡ÌV¯³ĞÖÑÆİnÖ7¿­,pˆ£vywÇk+Û—õg+‚IXÚA·ß¾•İJ1î Æ¸)&ÒÃ‰”¯T·Ò£š}1¨‚¨åEUŠ“Ş+…i¦u\ZJÎÙX¼i’a{§[¬W×MÛÏWãİ†Ãb~~”W9dq1RÀõˆÕ·áR*‰ÕÅ²Y¤,GÌıœĞßD)Ô0ß-4	W­¨œL­!ÚÖ½ti¸¼ äl–b=oô¨¸˜\\&1é+{­ïR\'	Äˆ¢rZÅ2Æş×.³·F\rÛÜ½Ç:E&›‘`ö½«¢ã”v³_Ş¥…åÕÙ$XÛÃù˜Şñ¶CàGÖ´îØêjıùçøÓñ#,ØZİß­…e›á–z~î^40’D`ÌÁÅ¯Ö75¥•]9I{·Î‚äÍnö75Â -n³ş%wø×\Z3ã\r€ßµµ·¢ªíşåµşuÒ&Â2\n­öä9V-ÄÎZ÷Õ|¨¤Ê\'»fL Ÿ\Zxá]<ÍË&ÇşTÄ»HíÍÛŸÙæŠ²U\0›s }iß‹X¢UşÇ-ôÓeÔ^w[î¬£;rÜZÔÚP#\"±]ä³lmÊßZâ™ …ÂTÛ{~t±ärksSóğ¡	n¿§Ö™•XbÅzÊG#jš\nàª×ñ½ÿ\0*Ó–<”ºõ¯·Ÿ‡:Ò–<—5ë_o?Ò4ì¤f„†ä@`M¸T.°pØ\\~•6EÒH%°ì‚-aşÚ•¥Ç92Ø¥7³á¯îÏ¾iòúÔØá„’Ç-ÉßªWoöÑ—bŒêæò0µ­î*2ìQ\\ŞFµ½Ñ±åR#c†lÊAßrOÖ¤•’-&P›Ho¶]Öó§n%\"ÍùºÈO µ¹Qš] qÄ”ÿ\0™æ¤[^àòÜÚ¸†:fH_L°ì÷o÷_åRH³@l}®£-¹ÿ\0V¨\ZlyM»Ã™åè+‡\"H†jÅœDÎ6·wuj¶\0¾õXñ4–í*~uŠ«­ÆJ[ß\"“ˆ:‰š°øÒ0Wd($$ÊóRÆñ>š\"¶BÛ’Hñ¥º:“&™İ6ïıwÖ¨Í—¯Èo3úñéƒ£-ŸÀò?/èÌ€€OŠßåO`Ø=Õl.-İá°©ä¥;¶Û[î¤Á±tl”‘zT‡ˆÅºÅ‰KåszXc$\\A¨äâ&GÓìã=ÖßzBÒf±¦œcY~¼…p½{èC¥ËŸgöÔñ1%ˆ—„6ÃÃÂ‹¬˜d­û&ëó©‘¥ö²¶zmfÚÛ}Â§ø‰!Ñİ­’ü*I¯ÚEKz_óşŒYæ‚ê.lXµqO“º$Áæ‹»¸T¢Xm\"áŠ†½ò6:‘šj’,Ew’;ÿ\0î©ä™4/ískoÿ\0p¦hôÉWÄâ÷_¸úTQE¨kÆ;[ÇÖ¸f…§hÚ2ÌĞ*ïÊİ¯¾³á^ò4eÑˆî÷ıxÓal­µë‰ˆNILzî– ÷íááRZLúÖFÇã\\4’»Æ¬O©cinZGC» \\ƒ÷ÛçXñJcÕ\0r±ï<¾u-ø‰%‰=p½¯¸èZö­·‘¿Ò¤‰ïŒŠTÛÎ¤f-wU]»±$ƒó¬; ±æH ıN	ojÁÏ‘\0rÿ\0XëHÆ÷É­zS›ÆËÉ“F‘É$A#İB	\"Rª˜)¶ééZ*cµ±]ªdi¦&P¹µì;¹QN“-ûËqòµ,BGu]—;l<6­V’G±%UË\nÔÎK.¸ÌüÍ·İ‹oæğEì0Êüßº°öfmmŞéÚ÷üjQŠ™ãl<äoó¨fPš²F­¿-êhİ£“NÃ8Å…ûÇ¨£…Ñ3lûï{‘¨ôæ‚x‘ÆªŞù_ÌxPÈ‚İäTñ:¨TUeñÜ·åEGÃ;\r,:ößİôıêF+v±wì§™©øŒ¡â!eÒúĞÿ\0…â	µÈÛçøPE,×ŒKÔ²}})i$¡IÔ—Æ¸GhäšI#V8áğ¨°WiY@ê›\Z$“øÉ¥†=°üjIAäÄ¼£aÕ\'ÄxR.·Ä«s0‹cçÌÒŒ$\nı‡<”a Wì9äş•\'Æ_áœGXøs¦ê²2œY[˜?`t™c%æÃ¼\r‡­A¨ğEï+n]ıõÆe3dEÅç÷ÜPr,×*G˜65©dèúº6÷¹ãjY:>®½îxßãö¸ğØäOZíŞFÕ£†\'…²EW%y[ÃÌÔ¯hÚy22²÷vğ\'IfBËj™¸¸â:AŒu—oQYpzBñˆìv\n+|yRGÂè\"{N{~>•(¯,k€‘‡[ãRJÉ“(M¤7Û.ëyĞR!	52^×;òúşÿ\0c†^\rÈ×’C’&ŠÑ›ŞıçaJòÅÃ?S\\–oÌm½\rLv†8¶?Û—æ*--\"Ú	Ü±ï<ë‚Œ¬2èÇƒ#©6òı^¢ËOÄ c·iåñ­$ÒÑ×\\“~ŞV®…­™ñaõ£§m&Ü¯ò®\r.°Aİ¶¶ÿ\0\Zá‘ğÒá»Ûkoñ¯ÙÈJß‡¶_àWoq,mi$ÈŠ§ØJœ8FÉJ¶×¸¨\ni3ÇŸP›/Xßm»¹T/›L™Ü—¬oùR¢2e“Ëv»}kNéÑõu¯ïsÊß\ZÓºt}]kûÜò·Çí}”zŒM­{Q/o©¥†[^×çéNtÎªJ}ÿ\0F£\"»:	:’)c	\"Xõ[!¿ÿ\0•§ZŒ6ë[j…7S\ZÉw“qğ¡»À7©¡Ó+¦‚}ëßò£„1i+‘”ßcnXşøV$Wy“b9à|*8øˆ‘sØa&]×ğ¦Œrÿ\0I±ô=õ¦Œrÿ\0I±ô=ôA’Ö%IÄØÓi“uæJŸ?G†6Eb½i,vòµ.®Aˆ½‚–·Â¬îo}U-·Ş•“Hà•6Ëºô5_ş•-øPó±¸wÙ$V“q‘°êŠL8hopÏ`¿}E¥å|º¥¬&Çz»ˆğ5ü?a©¥^÷.^»Wğı†¦–y{Ü¹zíö¿ğÈYÉ¶Öºê‹‡‘\Z3ÁÙnûw¿O+DÅä|ôÔ‹òÓº¢M&‰0fØyWZ\'‚9mÔ\rc—yêŸJ/f\\£ö¹Zö½ıj$è£ˆÆ%Œ>V±®ê‰¤wiQq\'3c÷r©XğòÙİm±o;÷×S†¶¦Zàó¹;şş<k$k&Nql[ëj\"Dİà\0WËÒ¸8<G\rïÜuú¥vø×Çˆá½û¿T®ß\ZÓÃ­Òu-å­—áSIn£FŠ˜-ùŠcĞ\\ÈæÄá~w’IiÛEQ´¥ÓÜ_~cÆ›Ù…B8À½ùe·ÌW§ğàx`ßµÒŠi£‰¥,¤Zş>µ1’	dÖ±²qTl/²•W‡õnğm±K¦å³Á—%[ì7?:áæ‡†a¦­Öö6ó·u†RÉ…ùd×?×GÓözúÚ—îË;zŞº>Ÿ³×ÖÔ¿vYÛÖÿ\0ıÇ•²ë•\\Š!\\DËÅ\'J2åağ4ipÇ‡–@Àòµ¿:ŸØ¬rˆZTëßa÷sŞ´ÖiBæãSaèmå\\.Š©‚XŒ›µ»åçIˆƒ9 ”3\r¯¸®œ’Æ%$ı¿šcH‰¦÷t ÛoOZ’hfVuFmKs¨ ÌyrÀoµ¿:Cc,’´%ÀşÜ®ÛSG#dÑ>xìÖºF§³×ÑÓ·vX_ã]#SÙëèéÛ»,/ñûOfø7¯Rt©U‹FÑu÷š}~ 1h^£µ²¶üüªAÄMQ4BËkÏï¬Äè%+ƒ=ˆŞÖßnuÃ[\néØ‹İvü«‡\Zã\Zè4ü­¾ü÷¨a¾Zhş6şjD†PŒÈËfŠ~%P_,Ø¥ûW½…üê7ÕAÄ%ÆA:¤+úwÔhg³Eúİÿ\0‰£i}«8w|yòîô¯â{õtñ÷¹óğ¾õüOa®>÷>~ßí„‘§i—ÔTJ¢mhÃav·ŞZÕY‚¹Æçİ>³@p¾ÄûŞcùã¤Ë(ç6àl=j—HLá˜·5°ïùŠEšåHóÆµ,WFŞ÷<oñ­K\'GÕÑ·½Ïü~ß‚Œ¬2èÇƒ#©6òı^‡\núZ±l{Ô›ÚİÜëMÈ8ì§ËÏùéS‡Ù#)VÚ÷E¦e1‰6[1½¾íª$OX´‡Öço¾´îWZş÷<­ñ­;§GÕÖ¿½Ï+|~ØtKï­{[î¡ÆñÂÃ6È±™kÛó©§‚)5Q°)\"vı^T’¿Æ\0A\'Ùv=i#G¿Ü&°ïËŸó°ÇŠ6šãV^ÊmIÅaÎ×{µÀŞÛZ¸x8DFrmŸ-…pÜL1®·â5SË/Ğ§3*¬±Èbp¼®+(ú\'Hè×÷²¬t£è#£_ŞËíxnQšŠy­îOÖ¸á<±t®(©8öF<ªâ$‚á\n°Xó³´GO…èıK÷7åüè<‘+¹E¸z‡ö|/öŒ÷ñ¸µp“çÃ¯	o7®††EÖáØH¬Ü²ı\ZZ–Iõf&ö±çe©Dé&Şöu–¤}¤t›{Ùÿ\0äÿÄ\0,\0\0\0\0!\01AQaq‘¡0@±PÁÑğ€ áñÿÚ\0\0?!ÿ\0Ã`ùl‚kà°	¼ãáÙpJx¿è†ìxÀ\'ú}mÇŒ‹œè†ôN©MT\rÏ¬à#Âtÿ\0jÿ\0®ï€2Gdãï 4ß240jwJœÚJeÙ˜Ää”†ãÿ\0Ó\nã’€€Â:0¦¥HU“ÄHl/v+å@\Zıˆs	\'‡äŒ¬ãpÍ+”ÁÅFX_Âl²Ş¡Fƒ´>Y‘®pÅ“L“•{œƒ¡\'‚>t=yÉÀèªLX›ïˆ€1\"2¶Z¢§nYvX›Vÿ\0Çœ«Šs°ÖºŠÎçs’ê¢)OËÜF2İ:Á!²–ÛÂç;”T¬²³P,L¸IoO?OÂ‘fˆ˜Ï\nEŠ\"c\"ğ“£¯ˆŞ •/ÃVKÿ\0ZBÈ~òËC9í8GÈãdÂøjYgòRáâL/rù’ÚùqÕ…8«¸ïö-8\\|»¿>|RO×ğÆ\ZØÚêPíü÷›\'„î÷ˆL‰)X‘/\\i-À,ÜÁ/×|æØöåu\rÒXüÁ«€8÷ÜûZ#@‡Ñ?ÌQT©²g,¾¸¨G±Î\Z4•ŠDj¨Âz‚y‹Õã„ª²\r[Ç?§&\"*Öõ‡ğÀB2¿~.ç*E¡¨ºQ3ã$™\n„K¤lÉka*â¤az(,ˆÜwÎœ4PH(·†€›‚\'èaôäæ·6 ëãX®†óq3ûA)§|áÙEÙA\nÅ©ß=h¼¡fC•I¹9	àc³¢ìdJRXåÂã§ĞBhq•dš^G¦K5\0dÂ:w;cÎ¶ôÂ6pY8vÛÓÙÁeüáR	))Ñ\"¢›gÆ¼ùhtß¯8Ù¶8î„`{şpÍeöTqHÎßí{êÒ2|9\\–\"r1•4YKÀ!RB<±·l>tZJhª¼¼	EØàÑ™FàT“‰#Ş\'‰¿–E?F\r,lòn6bZ›\'L§„›ÔábÚÑ­#ïS§ä\nTE­\0­Ìñ†Òç“x£ÍjtÃ &\nìÔa¾ $½¼×öb>± }+f9Ü°Z>”N.rDÈd%BG|®(	ÑĞÂY$Òóè˜*™1$ZÅıá‰]u É´VJiu$5’m›rV³Ïïü•áç\"Ï,¶·¼	pK±Ø²-{Ÿ³tÂ„¸îãÛj„‹ò“Üê:›™ÿ\0ºşÍ?pcğdaxp}ƒ\0ÍñÁšU±yØ¦¿œ(–É!H‡AÑ÷CË¹B¹\"¯\"—§l¨—iÖê±¡fÃú¸ÿ\0óY.ò+[¢PB£yI¤#³fµù014ÄƒÄäÔ‰¬	h‡Ìcd	…5è\0İ;ƒ*é%‚æ¦İdMÒVÇ\r`E\ne”Kº‘Q´C5Xáöõı‘#Ê3ùÂ|¶ƒ`¢Q@<Ïàa\ZáâMG\ZËè06d}$÷—#ÎÉYZ€¨ û¼Rí\n;,w_YOÏ¹¬C#Ñç…Pˆ»0ÑõƒJê,Aê5–¾®·‹—&:ŞèÌsù£X\0{À!h´]¬Ma Š´¿‚§äåÆÙM½‘ÿ\0?ğELÁ‘poÔ˜êP†5O	š³x‡–ÑjÀ€Åå0‘P/˜¼“U’lJ+¢ï“lc°5Ù~²üà¤è„œ@ /‚XûÈ76² ^NÃh)òŸMÿ\0SŒE¨!}lÅ#ªÚ	¹rs¼²N_–‹á.94a†ÇÃy}\0í)O4KX˜¯È¸*ª\râĞv”_ÆD0Ø‰äS¨L|æÍåÃü çóaeTT|à®kªêçBØa¾kªùN…°ÈVrMøÁ[Ä³:CÂšG|şƒ\0@œ%Äõ§&KÛB4)¥—Ã¼Ä¥ Hì§Š%hD#ŸR£ndÇXsŸR£ndÇXsú§ÜOåCñ‘‰ÎÄI“ÁTÚP1ã†|&Zaî<á¿¹‘TX%¾¸23 d‰pöc»`¨ağ÷‘¼1¬B<»ûpíçÈ#C¦øÍyÈy\'1Ğ¤xedÕÿ\0^y u&¾œtkŠ/‘ÁÅrä„‰&™Sb&ã[Çdq³3;k“òaú¸;)2\\F9¦!ÙÄBÊ.!Q\'¯‡È‚ÄH¸Dnnq«\nŸ“Wää´´»Û“ç0›¦T¹q7ó	ºaK—8jaÎjĞ£àİù ÿ\0‡×\0#ß¿³\08°6’á\n×X¬À±<R£+C¢‹A÷Œû·q\";ÌøsîÜmÄˆï3â9ıQíHQW¯‡£„×‹ÖÚøÇÿ\0©ùˆz€ÏN1ã´ğ—S¼RÖ„¢à»TuŠ(øÓ$\"™Xjµ¼¾ô2³dmâ\0|0OÖ1€ªä:ãxë.àE£†§ú¯¡C~OÁÆ£µZâ´ÄVòdV‰w!™¢BÈGÃ˜U¨¨@ÉŠ$@PnU+²¡£ë—AÀíƒc\0…¶x\ZµåŠ|±NPlq! L(°`óŠ)FGJ—ŸÒã±Ô>Û+İ˜«–*à¬ñ_Xl+ò,\Z˜5rcŒœ£`Â|#›?q[£\\“¾3gî+tk’wÇê™i}À/ûÍ˜“1MÛvf¨¯H‚J’‰7÷“ÄâIÉÑÊËDÎÅá×£›¶’R—–Úçx˜6ZŞí¼¯ı\0¼ZÎ\\ìÉğZlÁS¯q”’s…˜äHˆ¹ş®p¡\"ÛPvï§^µ9;m7k\rdäí´ İ¬5– œÒ<Ïç‰]ŒmlœOğI’öŠØ>Ñ\ZÇC¡–Jrm‚Çx‰‰CÔ0½Qgœ›Šb4å‘OñÂJÎ ôNÒ™ı ˆ0\0uÁßÅõ‚eµ‘¡p…>¤–=yÈ¼h19\'0^ã,ø\'&ø5ÏgÁ8é7Á¨xÿ\0ĞòjÊİ“qÃ¼£T\rÜ1É•x‘EŸŒ™ü\0Bg€…X÷”ğ eeÁ¬\rkÍDÚ%£Y¹u*xÅLª.$UÂT›u/€E>\røAfğhõ%€(Æ¦õ‘‹sE‰³õ€` \Z¹ıçXVb¬TÁÏà\'¦çmÄqŸÀN;MÎÛˆãõ ò(ı\'ÿ\0LÆ,9ÜàpjÔ	_ıF[H9ğäÛ4:Ö±ï\n€¨7åÂ=·³·6C[üdñŒ$’ĞW]Ã‹DÇîœ°ò{ü8yÔÛ,€\"énoÕKÈ¸öÍ~QÉ<şL3è`´ƒ€úşÏìô#|çû<[³Ğóú®¬Ï¨ˆ°ü\0Í´ï<N\"×ã@,x©øÅv jÁûæ\08(<K‰ëNi…›Ïg8¤Q+B ùú•s&:Äkœú•s&:ÄkŸ×†Diˆv|3¾ødÄpå\rèóGD¸{xûqñ?¾Ãë€ïßÙ–94Q‰)\nÑ–£ô$ÚûÍñ9÷n6âDw™ñçİ¸Û‰ŞgÄsúßéOÚct¬õ\"8Äj¦‘5şQ„ŞÎr&ğj}dÊÔ	o_½aa=R|õ5YOå´ÀYs3ºËäs±&uŠ`±J_‹ct>Ş}±n½õöÅº÷Ô~­{ÌMLF%P$âñœ‹õÌCåˆ/	 (Vd<>z’ËQáúÅLâiuª{/š(N÷¨Ã4…oÅ±\0ûı \Z‰Ï¦­Õ®£>š·VºùÿÚ\0\0\0\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ßŸÿ\0àZÿ\0ñ3ÿ\0ÿ\0Gÿ\0¢?ÿ\0ÿ\0ÿ\0ÿ\0ú+ÿ\0ÿ\0ÿ\0ÿ\0ü\'Ÿÿ\0ÿ\0ÿ\0ÿ\0T‹ÿ\0ÿ\0ÿ\0ÿ\0ø]_ÿ\0ÿ\0ÿ\0ÿ\03ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ş±yKÿ\0á·ûÿ\0øå¿ıÿ\0ÌÒÿ\0‘ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0Ï¿ÿ\0ÿ\0õ?ú·ÿ\0ÿ\0ÿ\0çÿ\0ÿ\0ÿ\0ÿ\0Ïÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0Ãÿ\0ÿ\0ÿ\0ìÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿ\0ÿÄ\0,\0\0\0\0!\01AQa0ğ@Pq‘Á¡ € ±ÑñÿÚ\0\0?ÿ\0³c»Î‹TTáİç@¨\0¥‰bóÆYóÃ¸EÁøBêÈ	Ø6×wğÿ\0Ñ„¿‘Ù;\'Ï\n¦\"5\n.øŞ\ZjĞÀcÕ„Oò•5n\0§ab›4ı-9Qc”UI()íïƒå¢ÁÈêˆt0ë‰\0OÈĞ©½p>s>y	ĞÃ°x\n‘pr0Ğ{5\Z†JB\"¡-íİü1r+ÑmO§3j€ğÇäW0˜ø8Ø4LW.à©¥‹Jôjq@š*Zí-Ø‡÷#şÅwÿ\0iÊ•‘1$©ŠŸ™ÃÆ7ªC³Öh¸¶âW—\0,…ÁCAD:†o¢·ªêˆØ^Ü5@\'K¬AØìdå-Nâ÷ w¯Ör9—•3L«ÙÃ@-Âs8Ôˆv\'$Œ5£¢î†²â¨Ö:ÙC°}/å;î[)}óøNÆ{Œ²ÊÏ|Pa5ÇE­PLo‚ràF3¼ĞEï¾3p\ZB’¤uœÅ;îÎ¡ÄXBƒp\"KÓzÎ¶•¡ìhe›Œw®H£iÛû¾<tqCCïƒ*†t gäOœ“TQ¥4>Gÿ\0ÙØd	/Kw‰UC€Kv~m)?ÿ\0r/ÇîN.aå÷Ç¬1LÒ—‘W`éJ32\Z„ª¯î=:\0Š¯·N›³&‡ŒáYy	€G‰È;¼aG\ri5bÈÇ…û„H0Lôh€«\'ö¢‚ç{à‚¬¨iJB@œ#\"Ç Áb‚ˆ\0ÒÙ¼²v™0©í_§xmĞ¸Š\0…‹®iL*4@Ø“3)‘¸Hˆ$\r$Ei\r8¤=g½\'Xƒ§{ÊèP\"®À^JÚjP.N£Ä¢àMÙ€S§ø8éW¢DA|\'X}aºíJ´y¼asãâº6^³‚÷x@ÔÔxfñw€;@ùkôˆDøèÚFÓDŠƒ\râq0µ=&1g¹9H60ƒ1èå’œz´’Æ®p5t<WÄÉNƒ8…&C#;a8è°6.—°Î€éë\0#bé{\0\'\\ğ®)€¾œ\nš¬jãQ	oNZH\'³È°ÕªxË¸=`	@9ÚúE”h+ö]`éÆ4ifØ‘¤“Ğ\0É\n (DL¯e ,	¦J°µr3™dj×ü5[Båæ\"I¶\nM{;àÄ’¨ø¢ÅÍöüqx„ÉB‚eé(Ò<€ì`©&6ª;ë9¯™Æ3Dåî.ÀS¡\nğP÷=©J$„P_c&¾s0â\n©w¨¬¶;”›Ğ\n1T?Fè×¶t¸ˆQ3#îD÷ÌÔ\0e¨;¼’äHƒK¢U¨½rR:¦§P\'€vŞŠ,v1š\0Äã1·ã=‚)DøæçSŒbéc0á±¢%\nYÀ\'J¯>à:µü¯j~ÍİÚ;[:QƒÆmR8ÍÊ	\0.c®À<ê©|·Œf¨²¥™óÜı³¹÷sndÏ&çèªÆmbÌÁJ^\\w>\ZÚÃ±©ÂIR`‡dyÂ#\nv^†wÇ¥	`2ˆ|“„fIí<@Ätì–xxH`étİq¤æk(! .!gÙêÀvÔèLàH°J.©e9I”ı–\0U\"é®h·±Ox‚(\0\'Mæ\nV•b\0\\	ÄìÕ|\Z‘\n5Ä_¤tXk8hñ\nÂ¤ÈãTRÇô@ñÂ dº8€ü^»ãİçAªR%‹(ñtV…nkOvƒÕö6\0:ˆNø\r1D@É˜öñœl„fÑ–” \"à\"Šg$xQ‰ÏO=PDG È˜•ãª6ˆ>Çs…)0)(#ÉêkÇÊÒEHü%©[À¨R¦i‰ŒM]oPÍÚ	è#@ìš¹(G´à:\0\0 {[œ`ÕèPd;°[“ßğEiò\nµèö-ÍUD×h|ÉİÕv\nÓ©Ë¹¼¤èË\nBÖ-ågˆ¢æ#ƒ³Ô4à¿†DE-!«Ã£Vr‡M[Â…É¨º¢°Tö÷Ç\"ÄÁe}l t:Ü	Î”²øbß€^™øc©QƒNÃ°¶C¦¢ M!`ÁPâ>Â»d\\Í8º¦PÓV½”ƒ²áÍCÃ¨Ù\0•æË*±İpRì1«n\0N`ušÛ-ï¨Ô5A(…N&ÛRšT4D¿äÎ%ú1À‹RDÑ§½æ+›¸–04—™¾nàV l/-h†Î¢)¼\\[0ÅĞhxù\r+^Ã~†\\Äd™$ä\rN0½îzDJ¶i{´:^L_‡Û¾öONlFú?Ù=>©‘Ñ¼¡\\/AQäHÍ@‘Ä*AéÌ\0\r¸\'#C¸ê³`\0üœ»\rôâŸ–T	ïìæŠ£è®C¡\'F¦\Zr…bQLàv/,½„[QşGSU\\j#á-éÀbûí4‰+Ø©Uø· ‘¯hWÏø8UW :Œ§dÛ“ßÆ˜¨ÒÂHEy\rí\\5è•¦Æ4Wu†dÉÅó™£x‚kŒæ‚éâÂ!O JÔàA~	Py&°ª¹fŠ€ƒZ6`ü\naÕ:_X’+H\\j‰òÛo¤›%×–Ø»}$Ù(Î¸¬ûzé»6`ùÎ¹f¨ £\Z2â|‡ıwDğI ĞD\rØ^ö$ôBG’ åI˜84°…¢ú\r¿Î²óí€ÿ\0Ãä§Ûÿ\0‡ÉOªÈ€ÇA<%Lõ;´sF›Û²&‰Ê9³(\n¤	D#ÀÙ<°;#¡‚çF[u¹¹ØBkDàV+rÀì)¨ÕÅïÉº‰\n1;8Ğ»5D@6(¾¸`º­¤Ğ2W\r*•UÜÓñww†$:DòM9:Ó¸A(ƒ\"êxÙz&@KÍ³·¢d¼Û8±§€\n.%°óˆ²TÈ1ŒŒcœ\\åõ¼Á\n¤)&>Åc*aŞ*úêL¿¿N†YJº^Œ¹¨V—åªÈvùùãO\"vU°‚\"Š\'ÒTa’¨Œ/Pb†FÊ@]ÀÑ³^.´ƒA\"-XÃæÌU½1D§®gîW~øø7‡Yû•ß¾>\rú¤ÕãCSì(‚p)mÜ.e…`ÁëQu˜Aô{µ\0a[è4Ğ7—¸Ú‹Õ#­|š)›m,»L§‹§(\0)-,n:â‚‡bØ)EUG­ÂSî¤´@=•b9fgMP‡Äì9\\åàj>(7®*¦,ïeg‡Ôîäg\'·©İÉ <ÎOn*Äò\'ælø;ñ.rjå\r–Ù#s¦|áCŒL¦d	—™kÀšß·F¹İğ0<l0^ìß(„©×ˆhúx—ĞeO–\"%W˜Î0‚“éµè?ç·á…Î]yÈ¬7a\ZğWÊC=j9î\'².!X©ÔFâjsÌ?¹işàk0şå§û¯üU»}™i\'À&3…CLÉL„jßÙ9O.y½‚Õ({Üz±|Q¯U/pÈ+Á	™\'h¬ˆ“Ä‘´€L\n 50áÇ±tĞGºÂéÇ¡ëÕ*:ªª¿šÀ‚g‚ˆ*¶ä\nbà?N ¢B©‡|8³J!T¨âÑöà•­\Z„A8ÉÊ¢m\0‹8[Oé\Z­Ü-§ô?Öo¨˜À/ÈE„ùã¸r£¢°nkÄõîÆÈå!\r\'¹\'@7xEàGhÒ°µÚÑo^8àñV2ğ>ƒjâSAûpÄ\n®	ØÏq–YYïóMÙh1DD<+èâ…ğä=\"Õ #ß%½m@U8Úû=<\ZGOR1Ò“ ˜âcÌÅ¤8ÛêˆÕ9×Ÿ´Uû£àÎuçí~èø3êu•ıúm¶MJoÃ~¥§IÈ\r$ÑŞúì%­X •m‹,¦\"şu ]ãä4­{\rú¨:‹Êï¢«4½„Z/&/‰ÃíˆßGû\'§¶#}ìŸ]Ö<N%ÍÛ†åM(ÁCà€øËÊ\0MJ>ÎİÁ$ƒ@=7ay#ŠS;K¼aqpJ(Õƒ§ÿ\0­N}°ø|”àû`?ğù)õ‡Å§îRvş¿*Ï‚z9\r±½u¼¼;€ŠˆGPóÆ:á¡ÅöCV‡)ÌºtĞğ;0–|_ÎĞ€şú%—¡­	xLgÅ¨¯@ÕgÜq+7\r‰9wôLö‡åëÀõ6•½ˆ;áıàúÇ·âğşğ}cÛñ~¨XÒÕ	 °9ß¾HÒH\Zv³ÉÜÖ1ˆ´“S\\¥êÒDE4u	ùÕÎŞnz4WPàÇA@4Á¤txxs¶,aFç¹İñ9F•ö\ròõÀDz›ó!âwxmãü¶üpÚş\'Çù;møÿ\0_ÿÙ','Hotel X invoice','2015-01-06 10:04:18',2,8);
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
