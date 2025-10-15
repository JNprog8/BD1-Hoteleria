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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-15 11:41:25
