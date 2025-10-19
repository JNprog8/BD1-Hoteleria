CREATE DATABASE  IF NOT EXISTS `hotelerov3` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `hotelerov3`;
-- MySQL dump 10.13 Distrib 8.0.43, for Linux (x86_64)
--
-- Host: 127.0.0.1 Database: hotelerov3
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
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cliente` (
  `idCliente` int NOT NULL AUTO_INCREMENT,
  `DNI` varchar(10) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `domCiudad` varchar(100) DEFAULT NULL,
  `domCalle` varchar(100) DEFAULT NULL,
  `domNum` int DEFAULT NULL,
  `telefono` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE KEY `DNI` (`DNI`),
  CONSTRAINT `chk_cliente_dni_not_empty` CHECK ((`DNI` <> _utf8mb4''))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cliente`
--

LOCK TABLES `Cliente` WRITE;
/*!40000 ALTER TABLE `Cliente` DISABLE KEYS */;
INSERT INTO `Cliente` VALUES (1,'28956789','Méndez','Carolina','Viedma','Belgrano',742,'2984-555123'),(2,'31234567','Pilquimán','Juan','San Carlos de Bariloche','Mitre',125,'294-4412233'),(3,'24567890','Ramos','Lucía','General Roca','Rivadavia',980,'298-4432211'),(4,'40765432','Salazar','Diego','Cipolletti','Alsina',356,'299-4589900'),(5,'37654321','Navarro','María','San Antonio Oeste','Moreno',210,'2934-423456');
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
  `numero` varchar(30) NOT NULL,
  `idReserva` int NOT NULL,
  `formaPago` enum('Efectivo','Tarjeta','Otro') NOT NULL,
  `totalFacturado` decimal(12,2) NOT NULL,
  `fechaFactura` date NOT NULL DEFAULT (curdate()),
  PRIMARY KEY (`idFactura`),
  UNIQUE KEY `numero` (`numero`),
  UNIQUE KEY `idReserva` (`idReserva`),
  CONSTRAINT `fk_fact_res` FOREIGN KEY (`idReserva`) REFERENCES `Reserva` (`idReserva`),
  CONSTRAINT `chk_factura_total` CHECK ((`totalFacturado` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Factura`
--

LOCK TABLES `Factura` WRITE;
/*!40000 ALTER TABLE `Factura` DISABLE KEYS */;
INSERT INTO `Factura` VALUES (1,'A-0001-00000001',1,'Efectivo',478000.00,'2025-01-23'),(2,'B-0001-00000022',2,'Efectivo',838000.00,'2025-07-19'),(3,'B-0001-00000073',3,'Tarjeta',306000.00,'2025-02-07'),(4,'A-0001-00000094',5,'Tarjeta',1112001.00,'2025-03-11'),(5,'B-0001-00000125',7,'Efectivo',286000.00,'2024-04-20'),(6,'B-0001-00000156',9,'Efectivo',1441000.00,'2025-01-10');
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
  `numero` varchar(10) NOT NULL,
  `superficie` int DEFAULT NULL,
  `terraza` tinyint(1) NOT NULL DEFAULT '0',
  `limpia` tinyint(1) NOT NULL DEFAULT '1',
  `libre` tinyint(1) NOT NULL DEFAULT '1',
  `idTipoHabitacion` int NOT NULL,
  PRIMARY KEY (`idHabitacion`),
  UNIQUE KEY `numero` (`numero`),
  KEY `fk_hab_tipohab` (`idTipoHabitacion`),
  CONSTRAINT `fk_hab_tipohab` FOREIGN KEY (`idTipoHabitacion`) REFERENCES `TipoHabitacion` (`idTipoHabitacion`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Habitacion`
--

LOCK TABLES `Habitacion` WRITE;
/*!40000 ALTER TABLE `Habitacion` DISABLE KEYS */;
INSERT INTO `Habitacion` VALUES (1,'101',18,0,1,1,1),(2,'102',22,0,1,1,2),(3,'201',28,0,1,1,3),(4,'202',22,1,1,1,2),(5,'301',32,1,1,1,4),(6,'302',45,1,1,1,5);
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
  `fechaHora` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idReserva` int NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `tipo` enum('Seña','Parcial','Total') NOT NULL,
  PRIMARY KEY (`idPago`),
  KEY `fk_pago_res` (`idReserva`),
  CONSTRAINT `fk_pago_res` FOREIGN KEY (`idReserva`) REFERENCES `Reserva` (`idReserva`),
  CONSTRAINT `chk_pago_monto` CHECK ((`monto` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pago`
--

LOCK TABLES `Pago` WRITE;
/*!40000 ALTER TABLE `Pago` DISABLE KEYS */;
INSERT INTO `Pago` VALUES (1,'2025-01-10 12:00:00',1,80000.00,'Seña'),(2,'2025-01-21 10:00:00',1,60000.00,'Parcial'),(3,'2025-01-23 10:00:00',1,110000.00,'Total'),(4,'2025-07-05 11:30:00',2,120000.00,'Seña'),(5,'2025-07-17 19:00:00',4,90000.00,'Parcial'),(6,'2025-07-19 09:30:00',2,180000.00,'Total'),(7,'2025-01-25 16:00:00',3,90000.00,'Seña'),(8,'2025-02-06 09:00:00',3,70000.00,'Total'),(9,'2025-11-20 12:15:00',4,150000.00,'Seña'),(10,'2025-03-01 13:00:00',5,30000.00,'Seña'),(11,'2025-03-10 10:00:00',5,25000.00,'Total'),(12,'2025-11-05 12:00:00',6,60000.00,'Seña'),(13,'2025-04-05 09:10:00',7,70000.00,'Seña'),(14,'2025-04-19 09:30:00',7,50000.00,'Parcial'),(15,'2025-04-20 10:30:00',7,80000.00,'Total'),(16,'2025-09-15 09:00:00',8,50000.00,'Seña'),(17,'2024-12-20 11:00:00',9,220000.00,'Seña'),(18,'2025-01-07 10:00:00',9,160000.00,'Parcial'),(19,'2025-01-10 09:45:00',9,300000.00,'Total'),(20,'2025-06-15 12:20:00',10,25000.00,'Seña'),(21,'2025-06-30 10:10:00',10,45000.00,'Total');
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
  `fechaReserva` date NOT NULL,
  `estado` enum('pendiente','confirmada','cancelada','ocupada','finalizada') NOT NULL DEFAULT 'pendiente',
  `cantidadPasajeros` int NOT NULL,
  `fechaEntrada` date NOT NULL,
  `noches` int NOT NULL,
  `telefono` varchar(30) NOT NULL,
  `idHabitacion` int NOT NULL,
  `idCliente` int NOT NULL,
  PRIMARY KEY (`idReserva`),
  KEY `ix_fec` (`idHabitacion`,`fechaEntrada`),
  KEY `ix_cli` (`idCliente`),
  CONSTRAINT `fk_res_cli` FOREIGN KEY (`idCliente`) REFERENCES `Cliente` (`idCliente`),
  CONSTRAINT `fk_res_hab` FOREIGN KEY (`idHabitacion`) REFERENCES `Habitacion` (`idHabitacion`),
  CONSTRAINT `chk_reserva_noches` CHECK ((`noches` > 0)),
  CONSTRAINT `chk_reserva_pasajeros` CHECK ((`cantidadPasajeros` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reserva`
--

LOCK TABLES `Reserva` WRITE;
/*!40000 ALTER TABLE `Reserva` DISABLE KEYS */;
INSERT INTO `Reserva` VALUES (1,'2025-01-10','finalizada',2,'2025-01-20',3,'2984-555123',2,1),(2,'2025-07-05','finalizada',3,'2025-07-15',4,'2984-555123',3,1),(3,'2025-01-25','finalizada',2,'2025-02-05',2,'294-4412233',5,2),(4,'2025-09-20','pendiente',2,'2025-12-05',3,'294-4412233',6,2),(5,'2025-03-01','finalizada',1,'2025-03-10',1,'298-4432211',1,3),(6,'2025-11-05','pendiente',2,'2025-11-20',2,'298-4432211',4,3),(7,'2024-04-05','finalizada',2,'2024-04-18',2,'299-4589900',2,4),(8,'2025-09-15','cancelada',3,'2025-10-01',5,'299-4589900',3,4),(9,'2024-12-20','finalizada',4,'2025-01-05',5,'2934-423456',6,5),(10,'2025-06-15','ocupada',1,'2025-06-28',2,'2934-423456',1,5),(11,'2025-10-15','pendiente',2,'2025-10-24',1,'2984-555123',3,3),(12,'2024-08-15','cancelada',2,'2024-09-01',2,'299-4589900',2,2),(13,'2025-10-17','pendiente',2,'2025-10-20',1,'2984-555123',2,1);
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
  `codigoUnico` varchar(20) NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  PRIMARY KEY (`idServicio`),
  UNIQUE KEY `codigoUnico` (`codigoUnico`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Servicio`
--

LOCK TABLES `Servicio` WRITE;
/*!40000 ALTER TABLE `Servicio` DISABLE KEYS */;
INSERT INTO `Servicio` VALUES (1,'RES','Restaurante'),(2,'BAR','Bar'),(3,'SPA','Acceso a spa'),(4,'LAV','Servicio de lavandería'),(5,'TRI','Tintoreria'),(6,'MIN','Consumo de minibar'),(7,'EST','Estacionamiento diario'),(8,'FLO','Floristería');
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
  `cantidad` int NOT NULL DEFAULT '1',
  `importe` decimal(10,2) NOT NULL,
  PRIMARY KEY (`idServicioReserva`),
  UNIQUE KEY `uq_srvres` (`idReserva`,`idServicio`,`fecha`),
  KEY `ix_res` (`idReserva`),
  KEY `ix_srv` (`idServicio`),
  CONSTRAINT `fk_srvres_res` FOREIGN KEY (`idReserva`) REFERENCES `Reserva` (`idReserva`),
  CONSTRAINT `fk_srvres_srv` FOREIGN KEY (`idServicio`) REFERENCES `Servicio` (`idServicio`),
  CONSTRAINT `chk_srvres_cantidad` CHECK ((`cantidad` > 0)),
  CONSTRAINT `chk_srvres_importe` CHECK ((`importe` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ServicioReserva`
--

LOCK TABLES `ServicioReserva` WRITE;
/*!40000 ALTER TABLE `ServicioReserva` DISABLE KEYS */;
INSERT INTO `ServicioReserva` VALUES (1,1,1,'2025-01-21 08:30:00',2,120000.00),(2,1,1,'2025-01-22 08:35:00',2,120000.00),(3,7,1,'2025-01-20 20:00:00',1,7000.00),(4,2,1,'2025-01-21 21:00:00',2,36000.00),(5,1,2,'2025-07-16 08:20:00',3,180000.00),(6,1,2,'2025-07-17 08:25:00',3,180000.00),(7,3,2,'2025-07-17 18:00:00',2,30000.00),(8,4,2,'2025-07-18 10:15:00',1,8000.00),(9,5,3,'2025-02-05 12:00:00',1,25000.00),(10,6,3,'2025-02-05 22:10:00',1,5000.00),(11,2,3,'2025-02-06 21:15:00',2,36000.00),(12,1,5,'2025-03-10 08:30:00',1,60000.00),(13,7,5,'2025-03-10 09:00:00',1,7000.00),(14,1,7,'2025-04-19 08:25:00',2,120000.00),(15,2,7,'2025-04-19 21:10:00',2,36000.00),(16,5,9,'2025-01-05 12:15:00',1,25000.00),(17,1,9,'2025-01-06 08:20:00',4,240000.00),(18,1,9,'2025-01-07 08:25:00',4,240000.00),(19,3,9,'2025-01-07 17:45:00',2,30000.00),(20,6,9,'2025-01-08 22:30:00',1,6000.00),(21,7,10,'2025-06-28 20:05:00',1,7000.00),(22,1,10,'2025-06-29 08:40:00',1,60000.00),(23,1,5,'2025-03-10 08:40:00',1,1000001.00);
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
  `nombre` varchar(50) NOT NULL,
  `capacidad` int NOT NULL,
  PRIMARY KEY (`idTipoHabitacion`),
  UNIQUE KEY `nombre` (`nombre`),
  CONSTRAINT `chk_tipohab_capacidad` CHECK ((`capacidad` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TipoHabitacion`
--

LOCK TABLES `TipoHabitacion` WRITE;
/*!40000 ALTER TABLE `TipoHabitacion` DISABLE KEYS */;
INSERT INTO `TipoHabitacion` VALUES (1,'Single Estándar',1),(2,'Doble Superior',2),(3,'Triple Familiar',3),(4,'Suite Junior',2),(5,'Suite Presidencial vista al Rio Negro',4);
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
  `fechaDesde` date NOT NULL,
  `idTipoHabitacion` int NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  PRIMARY KEY (`idValorizacion`),
  UNIQUE KEY `uq_valorizacion_tipo_fecha` (`idTipoHabitacion`,`fechaDesde`),
  CONSTRAINT `fk_val_tipohab` FOREIGN KEY (`idTipoHabitacion`) REFERENCES `TipoHabitacion` (`idTipoHabitacion`),
  CONSTRAINT `chk_valorizacion_precio` CHECK ((`precio` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Valorizacion`
--

LOCK TABLES `Valorizacion` WRITE;
/*!40000 ALTER TABLE `Valorizacion` DISABLE KEYS */;
INSERT INTO `Valorizacion` VALUES (1,'2024-01-01',1,45000.00),(2,'2024-01-01',2,65000.00),(3,'2024-01-01',3,85000.00),(4,'2024-01-01',4,120000.00),(5,'2024-01-01',5,180000.00),(6,'2025-01-01',1,55000.00),(7,'2025-01-01',2,80000.00),(8,'2025-01-01',3,110000.00),(9,'2025-01-01',4,150000.00),(10,'2025-01-01',5,220000.00);
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

-- Dump completed on 2025-10-18 21:44:08
