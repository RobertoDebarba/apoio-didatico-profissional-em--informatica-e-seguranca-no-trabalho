CREATE DATABASE  IF NOT EXISTS `dbSemestral1` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `dbSemestral1`;
-- MySQL dump 10.13  Distrib 5.5.34, for debian-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: dbSemestral1
-- ------------------------------------------------------
-- Server version	5.5.34-0ubuntu0.13.10.1

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
-- Table structure for table `tb_alunos`
--

DROP TABLE IF EXISTS `tb_alunos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_alunos` (
  `codigo_aluno` int(11) NOT NULL AUTO_INCREMENT,
  `nome_aluno` varchar(45) NOT NULL,
  `cpf_aluno` varchar(45) NOT NULL,
  `codigo_curso` int(11) NOT NULL,
  `codigo_usuario` int(11) NOT NULL,
  PRIMARY KEY (`codigo_aluno`),
  KEY `index_nome` (`nome_aluno`),
  KEY `index_cpf` (`cpf_aluno`),
  KEY `fk_tb_alunos_tb_cursos_idx` (`codigo_curso`),
  KEY `fk_tb_alunos_tb_usuarios1_idx` (`codigo_usuario`),
  CONSTRAINT `fk_tb_alunos_tb_cursos` FOREIGN KEY (`codigo_curso`) REFERENCES `tb_cursos` (`codigo_curso`),
  CONSTRAINT `fk_tb_alunos_tb_usuarios1` FOREIGN KEY (`codigo_usuario`) REFERENCES `tb_usuarios` (`codigo_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_alunos`
--

LOCK TABLES `tb_alunos` WRITE;
/*!40000 ALTER TABLE `tb_alunos` DISABLE KEYS */;
INSERT INTO `tb_alunos` VALUES (1,'Roberto Luiz Debarba','000.000.000-00',3,45),(2,'Maria da Silva','111.111.111-11',1,46),(3,'José Fernando','222.222.222-22',2,47),(4,'Marcio Fernandes','333.333.333-33',4,48);
/*!40000 ALTER TABLE `tb_alunos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_cursos`
--

DROP TABLE IF EXISTS `tb_cursos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_cursos` (
  `codigo_curso` int(11) NOT NULL AUTO_INCREMENT,
  `nome_curso` varchar(45) DEFAULT NULL,
  `duracao_curso` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`codigo_curso`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_cursos`
--

LOCK TABLES `tb_cursos` WRITE;
/*!40000 ALTER TABLE `tb_cursos` DISABLE KEYS */;
INSERT INTO `tb_cursos` VALUES (1,'Administração','3'),(2,'Eletrônica','4'),(3,'Informática','4'),(4,'Segurança no trabalho','4');
/*!40000 ALTER TABLE `tb_cursos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_cursos_professores`
--

DROP TABLE IF EXISTS `tb_cursos_professores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_cursos_professores` (
  `codigo_professor` int(11) NOT NULL,
  `codigo_curso` int(11) NOT NULL,
  PRIMARY KEY (`codigo_professor`,`codigo_curso`),
  KEY `fk_tb_cursos_alunos_tb_professores1_idx` (`codigo_professor`),
  KEY `fk_tb_cursos_alunos_tb_cursos1_idx` (`codigo_curso`),
  CONSTRAINT `fk_tb_cursos_alunos_tb_cursos1` FOREIGN KEY (`codigo_curso`) REFERENCES `tb_cursos` (`codigo_curso`),
  CONSTRAINT `fk_tb_cursos_alunos_tb_professores1` FOREIGN KEY (`codigo_professor`) REFERENCES `tb_professores` (`codigo_professor`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_cursos_professores`
--

LOCK TABLES `tb_cursos_professores` WRITE;
/*!40000 ALTER TABLE `tb_cursos_professores` DISABLE KEYS */;
INSERT INTO `tb_cursos_professores` VALUES (1,3),(2,1),(2,3),(3,3);
/*!40000 ALTER TABLE `tb_cursos_professores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_cursos_softwares`
--

DROP TABLE IF EXISTS `tb_cursos_softwares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_cursos_softwares` (
  `codigo_software` int(11) NOT NULL,
  `codigo_curso` int(11) NOT NULL,
  PRIMARY KEY (`codigo_software`,`codigo_curso`),
  KEY `fk_tb_cursos_softwares_tb_softwares1_idx` (`codigo_software`),
  KEY `fk_tb_cursos_softwares_tb_cursos1_idx` (`codigo_curso`),
  CONSTRAINT `fk_tb_cursos_softwares_tb_cursos1` FOREIGN KEY (`codigo_curso`) REFERENCES `tb_cursos` (`codigo_curso`),
  CONSTRAINT `fk_tb_cursos_softwares_tb_softwares1` FOREIGN KEY (`codigo_software`) REFERENCES `tb_softwares` (`codigo_software`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_cursos_softwares`
--

LOCK TABLES `tb_cursos_softwares` WRITE;
/*!40000 ALTER TABLE `tb_cursos_softwares` DISABLE KEYS */;
INSERT INTO `tb_cursos_softwares` VALUES (1,4),(2,2),(3,3),(4,1);
/*!40000 ALTER TABLE `tb_cursos_softwares` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_professores`
--

DROP TABLE IF EXISTS `tb_professores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_professores` (
  `codigo_professor` int(11) NOT NULL AUTO_INCREMENT,
  `nome_professor` varchar(45) NOT NULL,
  `cpf_professor` varchar(45) NOT NULL,
  `codigo_usuario` int(11) NOT NULL,
  PRIMARY KEY (`codigo_professor`),
  KEY `fk_tb_professores_tb_usuarios1_idx` (`codigo_usuario`),
  CONSTRAINT `fk_tb_professores_tb_usuarios1` FOREIGN KEY (`codigo_usuario`) REFERENCES `tb_usuarios` (`codigo_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_professores`
--

LOCK TABLES `tb_professores` WRITE;
/*!40000 ALTER TABLE `tb_professores` DISABLE KEYS */;
INSERT INTO `tb_professores` VALUES (1,'Edesio','000.000.000-00',2),(2,'Douglas','111.111.111-11',41),(3,'Fabio','222.222.222-22',43);
/*!40000 ALTER TABLE `tb_professores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_softwares`
--

DROP TABLE IF EXISTS `tb_softwares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_softwares` (
  `codigo_software` int(11) NOT NULL AUTO_INCREMENT,
  `nome_software` varchar(45) NOT NULL,
  PRIMARY KEY (`codigo_software`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_softwares`
--

LOCK TABLES `tb_softwares` WRITE;
/*!40000 ALTER TABLE `tb_softwares` DISABLE KEYS */;
INSERT INTO `tb_softwares` VALUES (1,'Arnu'),(2,'Carot'),(3,'Cobas'),(4,'Nortem');
/*!40000 ALTER TABLE `tb_softwares` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_tipo_usuarios`
--

DROP TABLE IF EXISTS `tb_tipo_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_tipo_usuarios` (
  `codigo_tipo_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `descricao_usuario` varchar(45) NOT NULL,
  PRIMARY KEY (`codigo_tipo_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_tipo_usuarios`
--

LOCK TABLES `tb_tipo_usuarios` WRITE;
/*!40000 ALTER TABLE `tb_tipo_usuarios` DISABLE KEYS */;
INSERT INTO `tb_tipo_usuarios` VALUES (1,'prof_adm'),(2,'prof'),(3,'aluno');
/*!40000 ALTER TABLE `tb_tipo_usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_usuarios`
--

DROP TABLE IF EXISTS `tb_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_usuarios` (
  `codigo_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `login_usuario` varchar(45) DEFAULT NULL,
  `senha_usuario` varchar(45) DEFAULT NULL,
  `codigo_tipo_usuario` int(11) DEFAULT NULL,
  PRIMARY KEY (`codigo_usuario`),
  KEY `fk_tb_usuarios_tb_tipo_usuarios1_idx` (`codigo_tipo_usuario`),
  CONSTRAINT `codigo_tipo_usuario` FOREIGN KEY (`codigo_tipo_usuario`) REFERENCES `tb_tipo_usuarios` (`codigo_tipo_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_usuarios`
--

LOCK TABLES `tb_usuarios` WRITE;
/*!40000 ALTER TABLE `tb_usuarios` DISABLE KEYS */;
INSERT INTO `tb_usuarios` VALUES (1,'1','1',1),(2,'edsio','123',1),(40,NULL,NULL,NULL),(41,'douglas','123',2),(42,NULL,NULL,NULL),(43,'fabio','123',2),(44,NULL,NULL,NULL),(45,'roberto','123',3),(46,'maria','123',3),(47,'jose','123',3),(48,'marcio','123',3);
/*!40000 ALTER TABLE `tb_usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-12-08 17:19:14
