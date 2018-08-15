DROP DATABASE IF EXISTS AMORE;
CREATE DATABASE AMORE;
USE AMORE
 CREATE TABLE  PROVEEDORES(
    ID_PROVEEDOR INT PRIMARY KEY AUTO_INCREMENT ,
    NOMBRE_PROVEEDOR VARCHAR(20) NOT NULL,
    CALLE       VARCHAR(20) NOT NULL,
    NUMERO      VARCHAR(4) NOT NULL  UNIQUE,
    COLONIA     VARCHAR(20) NOT NULL,
    CODIGO_POSTAL VARCHAR(6)   NOT NULL,
    TELEFONO    VARCHAR(15) NOT NULL);

INSERT INTO PROVEEDORES(ID_PROVEEDOR,NOMBRE_PROVEEDOR,CALLE,NUMERO,COLONIA,CODIGO_POSTAL,TELEFONO) VALUES
    (NOT NULL,"AZOR","ENRIQUE PONCE",1589,"INDUSTRIAL",43633,7752017276),
    (NOT NULL,"MATE","TULA",1305,"GUADALUPE",43650,7712980559);

CREATE TABLE PRODUCTOS(
     ID_PRODUCTOS   INT PRIMARY KEY AUTO_INCREMENT,
     NOMBRE_PRODUCTO VARCHAR(25) NOT NULL,
     MARCA_PRODUCTO  VARCHAR(25) NOT NULL,
     CONTENIDO      VARCHAR(10)  NULL,
     COLOR          VARCHAR(15) NULL,
     TALLA          VARCHAR(8)  NULL,
     EXISTENCIAS     INT(4)   NOT NULL,
     LOTE           VARCHAR(10)   NULL,
     FECHA_INGRESO  TIMESTAMP DEFAULT  NOW(),
     PRECIO_COMPRA  FLOAT(5)  NOT NULL,
     PRECIO_VENTA  FLOAT(5) NOT NULL,
     ID_PROVEEDOR   VARCHAR(10) NOT NULL);
     
ALTER TABLE PRODUCTOS 
ADD FOREIGN KEY(ID_PROVEEDOR)
REFERENCES PROVEEDORES(ID_PROVEEDOR);

INSERT INTO  PRODUCTOS(ID_PRODUCTOS,NOMBRE_PRODUCTO,MARCA_PRODUCTO,CONTENIDO,COLOR,TALLA,EXISTENCIAS,LOTE,FECHA_INGRESO,PRECIO_COMPRA,PRECIO_VENTA,ID_PROVEEDOR)VALUES
(NOT NULL,"BLUSAS","ABERCROMBIE","","BLANCA","CH",8,"EST1892",DEFAULT,180,200,1),
(NOT NULL,"OSO_DE_LEON","ART_PLUSH","","CAFE","",10,"STEE95",DEFAULT,230,250,2);
  
CREATE TABLE VENTAS(
    NO_VENTAS INT NOT NULL AUTO_INCREMENT,
    ID_PRODUCTOS VARCHAR(13) NOT NULL,
    NOMBRE_PRODUCTO VARCHAR(20) NOT NULL,
    CANTIDAD_PRODUCTO  INT  NOT NULL,
    COSTO_PRODUCTO   FLOAT(5) NOT NULL,
    FECHA_VENTA  TIMESTAMP DEFAULT  NOW(),
    TOTAL_VENTA   FLOAT(5) NOT NULL,
    PRIMARY KEY (NO_VENTAS));
    


INSERT INTO VENTAS(NO_VENTAS,ID_PRODUCTOS,NOMBRE_PRODUCTO,CANTIDAD_PRODUCTO,COSTO_PRODUCTO,FECHA_VENTA,TOTAL_VENTA)VALUES
(NOT NULL,1502478,"PANTALON", 5,250,DEFAULT,180),
(NOT NULL,8324301,"BARNIS", 3,70,DEFAULT,70);
  
CREATE PROCEDURE VENTAS()
SELECT CANTIDAD_PRODUCTO * COSTO_PRODUCTO FROM VENTAS;

SELECT CANTIDAD_PRODUCTO * COSTO_PRODUCTO AS TOTAL_VENTA FROM VENTAS;

USE AMORE;

CALL VENTAS();

CREATE TABLE VENTA_LINEA(
    NO_TARJETA  CHAR(16) NOT NULL UNIQUE,
    NOMBRE VARCHAR(15) NOT NULL,
    APELLIDO_PATERNO VARCHAR(15) NOT NULL,
    APELLIDO_MATERNO VARCHAR(15) NOT NULL,
    CALLE   VARCHAR(20)     NOT NULL,
    COLONIA VARCHAR(20)     NOT NULL,
    NUMERO_EXTERIOR     INT     NOT NULL,
    ESTADO      VARCHAR(20)     NOT NULL,
    EMAIL      VARCHAR(21) NOT NULL,
    TELEFONO    CHAR(10)     NOT NULL);
 
 INSERT INTO VENTA_LINEA(NO_TARJETA,NOMBRE,APELLIDO_PATERNO,APELLIDO_MATERNO,CALLE,COLONIA,NUMERO_EXTERIOR,ESTADO,EMAIL,TELEFONO)VALUES
(2510959206032625,"JOCELYN","FLORES", "BADILLO", "MIGUEL NEGRETE" ,"SAN JOSE",1104, "HIDALGO","CHAPARRA@HOTMAIL.COM", 7712950559),
(0306050692952558,"SARAHI","TREJO", "ESPINDOLA", "CERRADA LIRIOS" ,"GUADALUPE",1305, "MEXICO","ETSS36@YAHOO.COM", 7757551900);


CREATE TABLE usuarios_login(
usuario varchar(30) PRIMARY KEY,
contrasena enum('texto', 'sha1', 'md5') UNIQUE,
Nombre_usuario  varchar(30) not null);

SELECT CANTIDAD_PRODUCTO * COSTO_PRODUCTO FROM VENTAS;

SELECT CANTIDAD_PRODUCTO * COSTO_PRODUCTO AS TOTAL_VENTA FROM VENTAS;


CREATE VIEW
VW_TIENDA AS
SELECT NOMBRE_EMPLEADO , NO_VENTAS
FROM VENTAS;

SELECT * FROM VW_TIENDA;


CREATE VIEW
VW_CANTIDAD AS
SELECT ID_PRODUCTOS, EXISTENCIAS
FROM PRODUCTOS;

SELECT* FROM VW_CANTIDAD;

CREATE VIEW
VW_MARCAS AS
SELECT MARCA_PRODUCTO, CONTENIDO
FROM PRODUCTOS;

SELECT* FROM VW_MARCAS;

CREATE VIEW
VW_CUENTA AS
SELECT NO_VENTAS, FECHA_VENTA
FROM VENTAS;

SELECT* FROM VW_CUENTA;

 delimiter//
CREATE TRIGGER inserproductos AFTER INSERT ON productos
FOR EACH ROW BEGIN
UPDATE productos SET productosCount = productosCount + 1 WHERE id_productos = NEW.id_productos;
  END;
//

delimiter;

delimiter //
CREATE TRIGGER deleteproductos AFTER DELETE ON productos
FOR EACH ROW BEGIN 
UPDATE productos SET productosCount = productosCount - 1 WHERE id_productos = OLD.id_productos;
  END;
//

delimiter ;


 
 
 -- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Proveedores` (
  `idProveedores` VARCHAR(10) NOT NULL,
  `Nombre` VARCHAR(30) NOT NULL,
  `Dirección` VARCHAR(45) NOT NULL,
  `Telefono` INT NOT NULL,
  PRIMARY KEY (`idProveedores`),
  UNIQUE INDEX `Dirección_UNIQUE` (`Dirección` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Ventas` (
  `No_Ventas` INT NOT NULL,
  `idProveedores` VARCHAR(10) NOT NULL,
  `idProductos` VARCHAR(10) NOT NULL,
  `Nombre_Producto` VARCHAR(20) NOT NULL,
  `Cantidad` INT NOT NULL,
  `Precio_producto` FLOAT NOT NULL,
  `Total` FLOAT NULL,
  `Nombre_empleado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`No_Ventas`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`taVentas_Línea`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`taVentas_Línea` (
  `No_tarjeta` INT NOT NULL,
  `Nombre_comprador` VARCHAR(45) NOT NULL,
  `Dirección` VARCHAR(45) NOT NULL,
  `Telefono` INT NOT NULL,
  `E-mail` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`No_tarjeta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Productos` (
  `idProductos` VARCHAR(10) NULL,
  `Nombre` VARCHAR(20) NOT NULL,
  `Marca` VARCHAR(20) NOT NULL,
  `Lote` VARCHAR(10) NOT NULL,
  `Existencia` INT NOT NULL,
  `Precio_compra` FLOAT NOT NULL,
  `Precio_venta` FLOAT NOT NULL,
  `Fecha_compra` DATE NOT NULL,
  `Contenido` VARCHAR(15) NOT NULL,
  `Color` VARCHAR(10) NULL,
  `Talla` VARCHAR(3) NULL,
  `Tipo` VARCHAR(15) NULL,
  `idProveedores` VARCHAR(10) NOT NULL,
  `Proveedores_idProveedores` VARCHAR(10) NOT NULL,
  `Ventas_No_Ventas` INT NOT NULL,
  `taVentas_Línea_No_tarjeta` INT NOT NULL,
  PRIMARY KEY (`idProductos`),
  INDEX `fk_Productos_Proveedores_idx` (`Proveedores_idProveedores` ASC),
  INDEX `fk_Productos_Ventas1_idx` (`Ventas_No_Ventas` ASC),
  INDEX `fk_Productos_taVentas_Línea1_idx` (`taVentas_Línea_No_tarjeta` ASC),
  CONSTRAINT `fk_Productos_Proveedores`
    FOREIGN KEY (`Proveedores_idProveedores`)
    REFERENCES `mydb`.`Proveedores` (`idProveedores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Productos_Ventas1`
    FOREIGN KEY (`Ventas_No_Ventas`)
    REFERENCES `mydb`.`Ventas` (`No_Ventas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Productos_taVentas_Línea1`
    FOREIGN KEY (`taVentas_Línea_No_tarjeta`)
    REFERENCES `mydb`.`taVentas_Línea` (`No_tarjeta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

CREATE USER 'Joce'@'localhost' IDENTIFIED BY 'Joce.FB';
GRANT ALL PRIVILEGES ON AMORE.* TO 'Joce'@'localhost';
FLUSH PRIVILEGES;