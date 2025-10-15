CREATE DATABASE  IF NOT EXISTS `hotelero` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `hotelero`;
-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: hotelero
-- ------------------------------------------------------
-- Server version	8.0.43-0ubuntu0.24.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Cliente`
--

DROP TABLE IF EXISTS `Cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cliente` (
  `idCliente` int NOT NULL AUTO_INCREMENT,
  `DNI` varchar(10) NOT NULL,
  `Nombre` varchar(45) NOT NULL,
  `Apellido` varchar(45) NOT NULL,
  `domCiudad` varchar(45) DEFAULT NULL,
  `domCalle` varchar(45) DEFAULT NULL,
  `domNum` varchar(45) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE KEY `idCliente_UNIQUE` (`idCliente`),
  UNIQUE KEY `DNI_UNIQUE` (`DNI`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cliente`
--

LOCK TABLES `Cliente` WRITE;
/*!40000 ALTER TABLE `Cliente` DISABLE KEYS */;
INSERT INTO `Cliente` VALUES (1,'30111222','Homero','Simpson','Viedma','Belgrano','455','2920-431122'),(2,'29566789','Marge','Bouvier','General Roca','Av. Roca','1880','298-4423080'),(3,'31022876','Bart','Simpson','Bariloche','Mitre','750','294-4425566'),(4,'32555110','Lisa','Simpson','Cipolletti','España','320','299-4779900'),(5,'33400991','Maggie','Simpson','San Antonio Oeste','Brown','210','2934-432870');
/*!40000 ALTER TABLE `Cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Factura`
--

DROP TABLE IF EXISTS `Factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Factura` (
  `idFactura` int NOT NULL AUTO_INCREMENT,
  `numero` varchar(16) NOT NULL,
  `idReserva` int NOT NULL,
  `formaPago` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`idFactura`),
  UNIQUE KEY `idFactura_UNIQUE` (`idFactura`),
  UNIQUE KEY `numero_UNIQUE` (`numero`),
  KEY `fk_Factura_1_idx` (`idReserva`),
  CONSTRAINT `fk_Factura_1` FOREIGN KEY (`idReserva`) REFERENCES `Reserva` (`idReserva`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Factura`
--

LOCK TABLES `Factura` WRITE;
/*!40000 ALTER TABLE `Factura` DISABLE KEYS */;
INSERT INTO `Factura` VALUES (1,'0003-0000001',1,'tarjeta'),(2,'0003-0000003',5,'efectivo'),(3,'0003-0000091',7,'tarjeta'),(4,'0003-0000121',9,'efectivo');
/*!40000 ALTER TABLE `Factura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Habitacion`
--

DROP TABLE IF EXISTS `Habitacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Habitacion` (
  `idHabitacion` int NOT NULL AUTO_INCREMENT,
  `numero` int NOT NULL,
  `superficie` int NOT NULL,
  `terraza` tinyint(1) NOT NULL,
  `limpia` tinyint(1) NOT NULL,
  `ocupada` tinyint(1) NOT NULL,
  `idTipoHabitacion` int NOT NULL,
  PRIMARY KEY (`idHabitacion`),
  UNIQUE KEY `idHabitacion_UNIQUE` (`idHabitacion`),
  UNIQUE KEY `numero_UNIQUE` (`numero`),
  KEY `fk_Habitacion_1_idx` (`idTipoHabitacion`),
  CONSTRAINT `fk_Habitacion_1` FOREIGN KEY (`idTipoHabitacion`) REFERENCES `TipoHabitacion` (`idTipoHabitacion`),
  CONSTRAINT `Habitacion_chk_1` CHECK ((`superficie` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Habitacion`
--

LOCK TABLES `Habitacion` WRITE;
/*!40000 ALTER TABLE `Habitacion` DISABLE KEYS */;
INSERT INTO `Habitacion` VALUES (9,101,18,0,1,0,1),(10,102,20,1,1,0,1),(11,201,26,0,1,0,2),(12,202,28,1,1,0,2),(13,301,36,0,1,0,4),(14,302,38,1,1,0,4),(15,401,52,1,1,0,3),(16,402,58,1,1,0,3);
/*!40000 ALTER TABLE `Habitacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pago`
--

DROP TABLE IF EXISTS `Pago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Pago` (
  `idPago` int NOT NULL AUTO_INCREMENT,
  `fechaHora` datetime NOT NULL,
  `idReserva` int NOT NULL,
  `monto` float NOT NULL,
  `tipo` varchar(6) NOT NULL,
  PRIMARY KEY (`idPago`),
  UNIQUE KEY `idPago_UNIQUE` (`idPago`),
  KEY `fk_Pago_1_idx` (`idReserva`),
  CONSTRAINT `fk_Pago_1` FOREIGN KEY (`idReserva`) REFERENCES `Reserva` (`idReserva`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pago`
--

LOCK TABLES `Pago` WRITE;
/*!40000 ALTER TABLE `Pago` DISABLE KEYS */;
INSERT INTO `Pago` VALUES (87,'2025-08-25 10:00:00',1,60000,'sena'),(88,'2025-09-11 20:00:00',1,50000,'parc'),(89,'2025-09-12 10:00:00',1,50000,'final'),(90,'2025-08-05 09:30:00',5,80000,'sena'),(91,'2025-08-19 19:45:00',5,70000,'parc'),(92,'2025-08-21 10:15:00',5,60000,'final'),(93,'2025-06-25 08:00:00',7,30000,'sena'),(94,'2025-07-07 09:30:00',7,70000,'final'),(95,'2025-06-10 11:00:00',9,50000,'sena'),(96,'2025-06-16 10:00:00',9,90000,'final');
/*!40000 ALTER TABLE `Pago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reserva`
--

DROP TABLE IF EXISTS `Reserva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Reserva` (
  `idReserva` int NOT NULL AUTO_INCREMENT,
  `idCliente` int NOT NULL,
  `idHabitacion` int NOT NULL,
  `estado` varchar(15) NOT NULL,
  `cantidadPasajeros` int NOT NULL,
  `fechaEntrada` date NOT NULL,
  `noches` int NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `fechaReserva` date DEFAULT NULL,
  PRIMARY KEY (`idReserva`),
  UNIQUE KEY `idReserva_UNIQUE` (`idReserva`),
  KEY `fk_Reserva_1_idx` (`idCliente`),
  KEY `fk_Reserva_2_idx` (`idHabitacion`),
  CONSTRAINT `fk_Reserva_1` FOREIGN KEY (`idCliente`) REFERENCES `Cliente` (`idCliente`),
  CONSTRAINT `fk_Reserva_2` FOREIGN KEY (`idHabitacion`) REFERENCES `Habitacion` (`idHabitacion`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reserva`
--

LOCK TABLES `Reserva` WRITE;
/*!40000 ALTER TABLE `Reserva` DISABLE KEYS */;
INSERT INTO `Reserva` VALUES (1,1,9,'finalizada',1,'2025-09-10',2,'2920-431122','2025-08-20'),(2,1,11,'confirmada',2,'2025-11-20',3,'2920-431122','2025-10-15'),(3,2,10,'cancelada',1,'2025-09-25',2,'298-4423080','2025-09-15'),(4,2,13,'pendiente',4,'2025-12-05',5,'298-4423080','2025-10-14'),(5,3,12,'finalizada',2,'2025-08-18',3,'294-4425566','2025-08-01'),(6,3,15,'confirmada',2,'2025-11-10',2,'294-4425566','2025-10-12'),(7,4,10,'finalizada',1,'2025-07-05',2,'299-4779900','2025-06-20'),(8,4,14,'confirmada',3,'2025-11-30',4,'299-4779900','2025-10-10'),(9,5,16,'finalizada',2,'2025-06-15',1,'2934-432870','2025-06-05'),(10,5,11,'pendiente',1,'2026-01-10',2,'2934-432870','2025-12-20');
/*!40000 ALTER TABLE `Reserva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Servicio`
--

DROP TABLE IF EXISTS `Servicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Servicio` (
  `idServicio` int NOT NULL AUTO_INCREMENT,
  `codigoUnico` varchar(30) NOT NULL,
  `descripcion` varchar(45) NOT NULL,
  PRIMARY KEY (`idServicio`),
  UNIQUE KEY `idServicio_UNIQUE` (`idServicio`),
  UNIQUE KEY `codigoUnico_UNIQUE` (`codigoUnico`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Servicio`
--

LOCK TABLES `Servicio` WRITE;
/*!40000 ALTER TABLE `Servicio` DISABLE KEYS */;
INSERT INTO `Servicio` VALUES (1,'TI','Tintorería'),(2,'SP','Spa'),(3,'BA','Bar'),(4,'RE','Restaurante'),(5,'FL','Floristería'),(6,'GM','Gimnasio'),(7,'ES','Estacionamiento');
/*!40000 ALTER TABLE `Servicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ServicioReserva`
--

DROP TABLE IF EXISTS `ServicioReserva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ServicioReserva` (
  `idServicioReserva` int NOT NULL AUTO_INCREMENT,
  `idServicio` int NOT NULL,
  `idReserva` int NOT NULL,
  `fecha` datetime NOT NULL,
  `cantidad` int NOT NULL,
  `importe` float NOT NULL,
  PRIMARY KEY (`idServicioReserva`),
  UNIQUE KEY `idServicioReserva_UNIQUE` (`idServicioReserva`),
  KEY `fk_ServicioReserva_1_idx` (`idReserva`),
  KEY `fk_ServicioReserva_2_idx` (`idServicio`),
  CONSTRAINT `fk_ServicioReserva_1` FOREIGN KEY (`idReserva`) REFERENCES `Reserva` (`idReserva`),
  CONSTRAINT `fk_ServicioReserva_2` FOREIGN KEY (`idServicio`) REFERENCES `Servicio` (`idServicio`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ServicioReserva`
--

LOCK TABLES `ServicioReserva` WRITE;
/*!40000 ALTER TABLE `ServicioReserva` DISABLE KEYS */;
INSERT INTO `ServicioReserva` VALUES (1,7,1,'2025-09-10 12:00:00',2,5000),(2,4,1,'2025-09-10 21:00:00',2,36000),(3,3,1,'2025-09-11 23:10:00',3,27000),(4,2,3,'2025-09-26 17:00:00',1,22000),(5,5,3,'2025-09-26 10:00:00',1,8000),(6,6,5,'2025-08-19 09:00:00',1,3000),(7,4,5,'2025-08-20 13:30:00',1,16000),(8,3,7,'2025-07-05 20:00:00',2,12000),(9,4,9,'2025-06-15 12:30:00',1,14000),(10,1,9,'2025-06-15 18:00:00',1,7000);
/*!40000 ALTER TABLE `ServicioReserva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TipoHabitacion`
--

DROP TABLE IF EXISTS `TipoHabitacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TipoHabitacion` (
  `idTipoHabitacion` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `capacidad` int NOT NULL,
  PRIMARY KEY (`idTipoHabitacion`),
  UNIQUE KEY `idTipoHabitacion_UNIQUE` (`idTipoHabitacion`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TipoHabitacion`
--

LOCK TABLES `TipoHabitacion` WRITE;
/*!40000 ALTER TABLE `TipoHabitacion` DISABLE KEYS */;
INSERT INTO `TipoHabitacion` VALUES (1,'Simple',1),(2,'Doble',2),(3,'Presidencial',2),(4,'Familiar',4);
/*!40000 ALTER TABLE `TipoHabitacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Valorizacion`
--

DROP TABLE IF EXISTS `Valorizacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Valorizacion` (
  `idValorizacion` int NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `idTipoHabitacion` int NOT NULL,
  `precio` float NOT NULL,
  PRIMARY KEY (`idValorizacion`),
  UNIQUE KEY `idValorizacion_UNIQUE` (`idValorizacion`),
  UNIQUE KEY `uq_valorizacion_tipo_fecha` (`idTipoHabitacion`,`fecha`),
  KEY `fk_Valorizacion_1_idx` (`idTipoHabitacion`),
  CONSTRAINT `fk_Valorizacion_1` FOREIGN KEY (`idTipoHabitacion`) REFERENCES `TipoHabitacion` (`idTipoHabitacion`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Valorizacion`
--

LOCK TABLES `Valorizacion` WRITE;
/*!40000 ALTER TABLE `Valorizacion` DISABLE KEYS */;
INSERT INTO `Valorizacion` VALUES (1,'2023-10-01',1,35000),(2,'2024-10-01',1,42000),(3,'2025-10-01',1,48000),(4,'2023-10-01',2,52000),(5,'2024-10-01',2,61000),(6,'2025-10-01',2,69000),(7,'2023-10-01',3,98000),(8,'2024-10-01',3,112000),(9,'2025-10-01',3,126000),(10,'2023-10-01',4,73000),(11,'2024-10-01',4,85000),(12,'2025-10-01',4,94000);
/*!40000 ALTER TABLE `Valorizacion` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-15 11:39:01
