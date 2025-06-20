-- MySQL dump 10.13  Distrib 8.4.5, for Linux (x86_64)
--
-- Host: localhost    Database: kenya_news
-- ------------------------------------------------------
-- Server version	8.4.5

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `news` (
  `id` int NOT NULL AUTO_INCREMENT,
  `original_text` text,
  `translated_text` text,
  `classification` enum('HATE','NOT_HATE') DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `raw_tweets`
--

DROP TABLE IF EXISTS `raw_tweets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `raw_tweets` (
  `id` bigint NOT NULL,
  `text` text NOT NULL,
  `username` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `lang` varchar(10) DEFAULT NULL,
  `label` enum('HATE','NOT_HATE','UNLABELED') DEFAULT 'UNLABELED',
  `translated_text` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `raw_tweets`
--

LOCK TABLES `raw_tweets` WRITE;
/*!40000 ALTER TABLE `raw_tweets` DISABLE KEYS */;
INSERT INTO `raw_tweets` VALUES (1,'Hatutaki fujo tena! @gov_kenya #amani','mtetezi','2025-06-20 12:12:53','sw','HATE','We don’t want violence anymore! @gov_kenya #peace'),(2,'Vijana tushirikiane kujenga taifa. #UjenziWaTaifa @KenyaYouth','binti254','2025-06-20 12:12:53','sw','NOT_HATE','Young people, let’s build the nation. #NationBuilding @KenyaYouth'),(3,'We stand for unity. @unitedkenya #OneKenya','peace4all','2025-06-20 12:12:53','en','NOT_HATE','We stand for unity. @unitedkenya #OneKenya'),(4,'They keep lying! No more fake promises. #Corruption @politicsKE','truthsayer','2025-06-20 12:12:53','en','HATE','They keep lying! No more fake promises. #Corruption @politicsKE'),(5,'Maze hii si mchezo, gava imechanganyikiwa. @KenyaNews #Wueh','mseehood','2025-06-20 12:12:53','sw','HATE','Man this is not a joke, the government is confused. @KenyaNews #Wow'),(6,'Wasee, tufanye kazi, tupate doe legit. #GrindTime @YouthForBiz','kibz254','2025-06-20 12:12:53','sw','NOT_HATE','Guys, let’s work and earn legit money. #GrindTime @YouthForBiz'),(7,'Nous devons arrêter la haine maintenant. #PaixPourTous @ONU','userfr1','2025-06-20 12:12:53','fr','NOT_HATE','We must stop the hate now. #PeaceForAll @UN'),(8,'Ils détruisent notre avenir avec leur mensonge. @gouvKE #Injustice','frvoice','2025-06-20 12:12:53','fr','HATE','They are destroying our future with their lies. @gouvKE #Injustice'),(9,'No place for tribalism in our country. #Unity #NoTribes @changeKE','johndoe','2025-06-20 12:12:53','en','NOT_HATE','No place for tribalism in our country. #Unity #NoTribes @changeKE'),(10,'Kick them all out! We’ve had enough. @FakeLeaders #RevolutionNow','angry_citizen','2025-06-20 12:12:53','en','HATE','Kick them all out! We’ve had enough. @FakeLeaders #RevolutionNow'),(11,'Peace lazima! Tunataka haki. @CourtKE #JusticeNow','sauti254','2025-06-20 12:12:53','sw','NOT_HATE','Peace is a must! We want justice. @CourtKE #JusticeNow'),(12,'Wameiba tena! Hatuwezi kaa kimya. @CorruptOfficials #StopLooting','whistleman','2025-06-20 12:12:53','sw','HATE','They’ve stolen again! We can’t stay silent. @CorruptOfficials #StopLooting'),(13,'Hii system imeoza. @topbosses lazima waende. #Tumechoka','ghettovoice','2025-06-20 12:12:53','sw','HATE','This system is rotten. @topbosses must go. #WeAreTired'),(14,'Leo ni leo! Watu waende kwa polling station. #DecisionDay @IEBC_Kenya','voterpower','2025-06-20 12:12:53','en','NOT_HATE','Today is the day! People should go vote. #DecisionDay @IEBC_Kenya'),(15,'Trop de promesses, zéro action. @MinistreKE #Mensonge','kenyafr','2025-06-20 12:12:53','fr','HATE','Too many promises, zero action. @MinistryKE #Lies'),(16,'Construisons un meilleur Kenya ensemble. #Espoir @JeunesseKE','kenyahope','2025-06-20 12:12:53','fr','NOT_HATE','Let’s build a better Kenya together. #Hope @YouthKE'),(17,'Stop the propaganda. We demand facts. @NewsKE #FakeNews','watchdog254','2025-06-20 12:12:53','en','HATE','Stop the propaganda. We demand facts. @NewsKE #FakeNews'),(18,'Celebrating diversity is our strength. #KenyaForAll @InclusionTeam','unitychampion','2025-06-20 12:12:53','en','NOT_HATE','Celebrating diversity is our strength. #KenyaForAll @InclusionTeam'),(19,'Amani iwe juu ya nchi yetu. @PeaceCouncil #KenyaNiYetu','mpendapenda','2025-06-20 12:12:53','sw','NOT_HATE','Let peace be upon our country. @PeaceCouncil #KenyaIsOurs'),(20,'Haki bila rushwa! @LegalAidKE #FightCorruption','sheria254','2025-06-20 12:12:53','sw','HATE','Justice without bribery! @LegalAidKE #FightCorruption'),(21,'Ruto Must Go!! One Term!!','test_user','2025-06-20 12:21:13','en','HATE','Ruto Must Go!! One Term!!'),(100001,'These people are destroying the country!','user1','2025-06-20 11:36:21','en','HATE',NULL),(100002,'All Kenyans deserve equal rights and respect.','user2','2025-06-20 11:36:21','en','NOT_HATE',NULL),(100003,'Tribe X should be banned from leadership.','user3','2025-06-20 11:36:21','en','HATE',NULL),(100004,'We must unite to build a better future.','user4','2025-06-20 11:36:21','en','NOT_HATE',NULL),(100005,'Kick them out of our land!','user5','2025-06-20 11:36:21','en','HATE',NULL),(100006,'Peace is the only way forward.','user6','2025-06-20 11:36:21','en','NOT_HATE',NULL),(100007,'They are criminals, not citizens.','user7','2025-06-20 11:36:21','en','HATE',NULL),(100008,'Let’s work together for progress.','user8','2025-06-20 11:36:21','en','NOT_HATE',NULL),(100009,'They don’t belong here. Period.','user9','2025-06-20 11:36:21','en','HATE',NULL),(100010,'We are all one nation, one people.','user10','2025-06-20 11:36:21','en','NOT_HATE',NULL),(200001,'Tunaweza kujenga Kenya bora pamoja. Let’s unite!','wambui_ke','2025-06-20 11:43:40','sw','NOT_HATE',NULL),(200002,'Respect kila mtu regardless of their tribe.','kigen254','2025-06-20 11:43:40','mix','NOT_HATE',NULL),(200003,'Hakuna matata, we love each other kama ndugu.','amani_ke','2025-06-20 11:43:40','mix','NOT_HATE',NULL),(200004,'Let’s support our leaders bila chuki.','joseph_kenya','2025-06-20 11:43:40','mix','NOT_HATE',NULL),(200005,'Kila community in Kenya matters. We are one.','salim_n','2025-06-20 11:43:40','mix','NOT_HATE',NULL),(200006,'Peace ndio njia ya maendeleo. Violence helps no one.','mwikali_m','2025-06-20 11:43:40','mix','NOT_HATE',NULL),(200007,'We must reject tribalism. Amani itashinda!','lucy_ke','2025-06-20 11:43:40','mix','NOT_HATE',NULL),(200008,'Bora tusonge mbele pamoja, we will succeed.','boniface_r','2025-06-20 11:43:40','mix','NOT_HATE',NULL),(200009,'Tribes should never divide us. Tuko pamoja!','millicent_odhiambo','2025-06-20 11:43:40','mix','NOT_HATE',NULL),(200010,'Let’s focus on development, not hate.','mburu_g','2025-06-20 11:43:40','en','NOT_HATE',NULL),(200011,'Youth wa Kenya wanaweza if we get good leadership.','judy_b','2025-06-20 11:43:40','mix','NOT_HATE',NULL),(200012,'Umoja ni nguvu, let’s avoid divisive politics.','moses_ke','2025-06-20 11:43:40','mix','NOT_HATE',NULL),(200013,'Siasa safi ndio tutapiga hatua kama nchi.','muhoro_k','2025-06-20 11:43:40','sw','NOT_HATE',NULL),(200014,'Ruto, Raila wote ni viongozi wetu. Let’s respect democracy.','doreen_w','2025-06-20 11:43:40','mix','NOT_HATE',NULL),(200015,'Peace talks should continue. Vita sio suluhisho.','kimani_t','2025-06-20 11:43:40','mix','NOT_HATE',NULL),(200016,'Tribe X ndio shida ya hii nchi. Watu wao si waaminifu.','hate_speaker1','2025-06-20 11:43:40','mix','HATE',NULL),(200017,'These people are thieves! Kila mtu anajua.','bitter254','2025-06-20 11:43:40','mix','HATE',NULL),(200018,'Wanaharibu Kenya. Time to chase them out!','user_hater','2025-06-20 11:43:40','mix','HATE',NULL),(200019,'Tribe Y should not rule again. Walituangusha.','tribal_ke','2025-06-20 11:43:40','mix','HATE',NULL),(200020,'Stop these cockroaches before they take over.','toxic_user','2025-06-20 11:43:40','en','HATE',NULL),(200021,'People from region X are lazy. Hawawezi fanya kazi.','hate_ke','2025-06-20 11:43:40','mix','HATE',NULL),(200022,'Tunaibiwa na hawa watu kila saa. Enough is enough!','keyboard_warrior','2025-06-20 11:43:40','mix','HATE',NULL),(200023,'Wanastahili kufukuzwa kabisa kutoka serikali.','mad_kenyan','2025-06-20 11:43:40','sw','HATE',NULL),(200024,'Wacheni hawa watu, they bring nothing but chaos.','user_bad','2025-06-20 11:43:40','mix','HATE',NULL),(200025,'Hakuna haja ya kuishi na watu kama hawa.','tribalist_rage','2025-06-20 11:43:40','sw','HATE',NULL),(200026,'Wanafaa kufungwa wote. They don’t belong here.','xenophobic_voice','2025-06-20 11:43:40','mix','HATE',NULL),(200027,'Hii tribe ni wabaya sana. Hatufai kuishi nao.','online_rant','2025-06-20 11:43:40','sw','HATE',NULL),(200028,'Leaders from that tribe are corrupt kabisa.','hatred_mwitu','2025-06-20 11:43:40','mix','HATE',NULL),(200029,'Tumevumilia sana. Hawa watu ni wa kuvuruga.','anger_rising','2025-06-20 11:43:40','sw','HATE',NULL),(200030,'They don’t love Kenya. Wanaangalia maslahi yao tu.','bitter_truth','2025-06-20 11:43:40','mix','HATE',NULL);
/*!40000 ALTER TABLE `raw_tweets` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-20 13:34:18
