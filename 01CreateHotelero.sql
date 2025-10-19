-- MySQL dump 10.13  Distrib 8.0.43, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: hotelerov3
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-18 21:44:38
