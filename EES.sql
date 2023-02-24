/*-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema EES
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema EES
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `EES` DEFAULT CHARACTER SET utf8 ;
USE `EES` ;

-- -----------------------------------------------------
-- Table `EES`.`Solar_Module_Tracking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EES`.`Solar_Module_Tracking` (
  `Doner` CHAR(30) NULL,
  `Serial #` CHAR(30) NULL,
  `Rated_watts` INT NULL,
  `Module_manufacturer` CHAR(30) NULL,
  `Module` CHAR(30) NULL,
  `Weight_kg` CHAR(30) NULL,
  `Panel_Dimensions_L` INT NULL,
  `Panel_Dimensions_W` INT NULL,
  `Panel_Dimensions_D` INT NULL,
  `Vmp` INT NULL,
  `Imp` INT NULL,
  `Voc` INT NULL,
  `Isc` INT NULL,
  `Pmp_Tempc_Coeff_%` INT NULL,
  `Year_of_Manufacture` INT NULL,
  `Location/Intended_Project` INT NULL,
  `Irradiance_(W/m2)` INT NULL,
  `Cell_Temp_C` INT NULL,
  `Measured_Pmp_Watts` INT NULL,
  `Pmp_Watts_Expected` INT NULL COMMENT 'Need to add Formula = (Irradiance / 1000) X Rated Watts + (Rated Watts x Temp Coeff X (Irradiance/1000) X (Cell Temp C -25))\nAlt Formula = Rated Watts x Temp Coeff X (Irradiance/1000) X (Cell Temp C -25) + Rated Watts X (Irradiance/1000)',
  `%_of_New_Pmp` VARCHAR(45) NULL COMMENT 'Formula not given',
  `Corrosion_#_of_cells` INT NULL,
  `Cell_Cracks_#_of_cells` INT NULL,
  `Id` INT NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EES`.`Legacy_data`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EES`.`Legacy_data` (
  `Voc` INT NULL,
  `Expected` VARCHAR(45) NULL,
  `Isc` VARCHAR(45) NULL,
  `Isc_Expected` VARCHAR(45) NULL,
  `Measured_Voc_x_Isc_Watts` VARCHAR(45) NULL,
  `Expected_Voc_x_Isc_Watts` VARCHAR(45) NULL,
  `Infrared` VARCHAR(45) NULL,
  `Id` INT NULL,
  INDEX `Id_idx` (`Id` ASC),/*had VISIBLE* keyword*//*
  CONSTRAINT `Legacy_Id`
    FOREIGN KEY (`Id`)
    REFERENCES `EES`.`Solar_Module_Tracking` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EES`.`Defect_Modes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EES`.`Defect_Modes` (
  `Corrosion_#_of_cells` INT NULL,
  `Cell_Cracks_#_of_cells` INT NULL,
  `EVA_Browning` VARCHAR(45) NULL CHECK (EVA_Browning IN ('None','Low','Medium','High','Extreme')) COMMENT 'None/Low/Medium/High/Extreme',
  `Pattern of Browning` VARCHAR(45) NULL CHECK(Pattern_of_Browning IN ('Center','Edge','Other','None')) COMMENT 'Center/Edge/Other/None', -- Renamed later to Pattern_of_Browning
  `Frame_Damage` CHAR(1) NULL CHECK(Frame_Damage IN ('0','1')) COMMENT '0/1 0=no damage',
  `Frame_Seal` CHAR(1) NULL CHECK(Frame_Seal IN ('0','1')),
  `Jbox_Damage` CHAR(1) NULL CHECK(Jbox_damage IN ('0','1')),
  `Jbox_Loose` CHAR(1) NULL CHECK(Jbox_Loose IN ('0','1')),
  `Nameplate_Faded/Missing` CHAR(1) NULL CHECK(Nameplate_Faded/Missing IN ('0','1')), -- Renamed later to Nameplate_Faded/Missing
  `Backside_Cracks` CHAR(1) NULL CHECK(JBackside_Cracks IN ('0','1')),
  `Backside_Bubbles` CHAR(1) NULL CHECK(Backside_Bubbles IN ('0','1')),
  `Backside_Tears/Scratches` CHAR(1) NULL CHECK(Backside_Tears/Scratches IN ('0','1')), -- Renamed later to Backside_Tears_Scratches
  `Backside_Chalking` CHAR(1) NULL CHECK(Backside_Chalking IN ('0','1')),
  `Frontside_Burn_Mark` CHAR(1) NULL CHECK(Frontside_Burn_Mark IN ('0','1')),
  `Backside_Burn_Mark` CHAR(1) NULL CHECK(Backside_Burn_Mark IN ('0','1')),
  `Scratch/Chip/Crack` CHAR(1) NULL CHECK(Scratch/Chip/Crack IN ('0','1')), -- Renamed later to Scratch_Chip_Crack
  `Delamination` INT NULL,
  `Milky_Discoloration` INT NULL,
  `Residual_Metal` INT NULL,
  `Snail_Tracks(No_Resid)` INT NULL,
  `Snail_Tracks(Metal_Resid)` INT NULL,
  `Future_Defect_1` INT NULL,
  `Future_Defect_2` INT NULL,
  `Future_Defect_3` INT NULL,
  `Infrared` CHAR(1) NULL  CHECK(Infrared IN ('0','1')),
  `Ultraviolet` CHAR(1) NULL  CHECK(UltravioletFuture_Defect_1 IN ('0','1')),
  `Id` INT NULL,
  INDEX `Id_idx` (`Id` ASC),/*had VISIBLE* keyword*//*
  CONSTRAINT `Defect_Id`
    FOREIGN KEY (`Id`)
    REFERENCES `EES`.`Solar_Module_Tracking` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EES`.`Final_Disposition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EES`.`Final_Disposition` (
  `Tier_1` VARCHAR(45) NULL,
  `Tier_2` VARCHAR(45) NULL,
  `Dispose` VARCHAR(45) NULL,
  `Recycle` VARCHAR(45) NULL,
  `Id` INT NULL,
  INDEX `Id_idx` (`Id` ASC),/*had VISIBLE* keyword*//*
  CONSTRAINT `Final_Id`
    FOREIGN KEY (`Id`)
    REFERENCES `EES`.`Solar_Module_Tracking` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `EES`.`User_Login` (
	Username VARCHAR(45) NOT NULL PRIMARY KEY,
	Pass VARCHAR(45) NOT NULL
);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- Coulmes that were renamed
ALTER TABLE defect_modes RENAME COLUMN `Pattern of Browning` TO Pattern_of_Browning;
ALTER TABLE defect_modes RENAME COLUMN `Nameplate_Faded/Missing` TO Nameplate_Faded_Missing;
ALTER TABLE defect_modes RENAME COLUMN ` Backside_Tears/Scratches` TO Backside_Tears_Scratches;
ALTER TABLE defect_modes RENAME COLUMN `Scratch/Chip/Crack` TO Scratch_Chip_Crack;



ALTER TABLE Defect_Modes ADD CONSTRAINT EVA_Browning CHECK (EVA_Browning IN ('None','Low','Medium','High','Extreme'));
ALTER TABLE Defect_Modes ADD CONSTRAINT Pattern_of_Browning CHECK(Pattern_of_Browning IN ('Center','Edge','Other','None'));
ALTER TABLE Defect_Modes ADD CONSTRAINT Frame_Damage CHECK(Frame_Damage IN ('0','1'));
ALTER TABLE Defect_Modes ADD CONSTRAINT Frame_Seal CHECK(Frame_Seal IN ('0','1'));
ALTER TABLE Defect_Modes ADD CONSTRAINT Jbox_Damage CHECK(Jbox_Damage IN ('0','1'));
ALTER TABLE Defect_Modes ADD CONSTRAINT Jbox_Loose CHECK(Jbox_Loose IN ('0','1'));
ALTER TABLE Defect_Modes ADD CONSTRAINT Nameplate_Faded_Missing CHECK(Nameplate_Faded_Missing IN ('0','1'));
ALTER TABLE Defect_Modes ADD CONSTRAINT Backside_Cracks CHECK(Backside_Cracks IN ('0','1'));
ALTER TABLE Defect_Modes ADD CONSTRAINT Backside_Bubbles CHECK(Backside_Bubbles IN ('0','1'));
ALTER TABLE Defect_Modes ADD CONSTRAINT Backside_Tears_Scratches CHECK(Backside_Tears_Scratches IN ('0','1'));
ALTER TABLE Defect_Modes ADD CONSTRAINT Backside_Chalking CHECK(Backside_Chalking IN ('0','1'));
ALTER TABLE Defect_Modes ADD CONSTRAINT Frontside_Burn_Mark CHECK(Frontside_Burn_Mark IN ('0','1'));
ALTER TABLE Defect_Modes ADD CONSTRAINT Backside_Burn_Mark CHECK(Backside_Burn_Mark IN ('0','1'));
ALTER TABLE Defect_Modes ADD CONSTRAINT Scratch_Chip_Crack CHECK(Scratch_Chip_Crack IN ('0','1'));
ALTER TABLE Defect_Modes ADD CONSTRAINT Infrared CHECK(Infrared IN ('0','1'));
ALTER TABLE Defect_Modes ADD CONSTRAINT  CHECK(Ultraviolet IN ('0','1'));*/