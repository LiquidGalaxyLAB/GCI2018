CREATE DATABASE `liquidgalaxy`;

CREATE TABLE `Countries` (
    `idCountry` int NOT NULL AUTO_INCREMENT,
    `name` varchar(255),
    PRIMARY KEY (`idCountry`)
);

CREATE TABLE `Touristic_places` (
    `idTouristicP` int NOT NULL AUTO_INCREMENT,
    `idCountry` int,
    `name` VARCHAR(255),
  PRIMARY KEY(`idTouristicP`),
  FOREIGN KEY(`idCountry`)
  REFERENCES Countries(`idCountry`)
);


CREATE TABLE `POI_data` (
    `idPOI` int NOT NULL AUTO_INCREMENT,
    `idTouristicP` int,
    `latitude` DECIMAL(30,28),
    `longtitude` DECIMAL(30,28),
    `altitude` int,
    `range` int,
    `heading` int,
    `tilt` int,
    `altitudeMode` VARCHAR(255),
    PRIMARY KEY (`idPOI`),
    FOREIGN KEY (`idTouristicP`)
    REFERENCES Touristic_places(`idTouristicP`)
);

INSERT INTO `Countries` (`name`) VALUES ('India'), ('USA'), ('South Korea'), ('England'), ('Japan');
INSERT INTO `Touristic_places`(`idCountry`, `name`)
VALUES (1, 'Kolkata'), (2,'New York'), (3, 'Seoul'), (4, 'London'), (5, 'Tokyo');
INSERT INTO `POI_data` (`idTouristicP`, `latitude`, `longtitude`, `altitude`, `range`, `heading`, `tilt`, `altitudeMode`)
VALUES (1, '22.57208293510867', '88.36469648134329', '0', '141984', '6.482895791194329e-005', '0', 'relativeToSeaFloor'),
(2,'40.68433485837519', '-73.97642015541204', '0', '28808', '0', '0', 'relativeToSeaFloor'),
(3, '37.56652898721421', '126.9780101393946', '0', '60191', '8', '0', 'relativeToSeaFloor'),
(4, '51.50735168572077', '-0.1277515159519915', '0', '47108', '-4', '0', 'relativeToSeaFloor'),
(5,'35.66757170514725', '139.6713882517034', '0', '15328', '-1', '0', 'relativeToSeaFloor');

SELECT t1.name, t2.name,  t3.latitude, t3.longtitude FROM Countries as t1, Touristic_places as t2, POI_data as t3 WHERE t1.idCountry = t2.idCountry AND t2.idTouristicP = t3.idTouristicP;
SELECT t1.idCountry, t2.idTouristicP,  t3.tilt, t3.range FROM Countries as t1, Touristic_places as t2, POI_data as t3 WHERE t1.idCountry = t2.idCountry AND t2.idTouristicP = t3.idTouristicP;
SELECT t2.name, t3.latitude, t3.longtitude FROM Touristic_places as t2, POI_data as t3 WHERE t2.idTouristicP = t3.idTouristicP;
SELECT t2.name, t3.latitude, t3.longtitude, t3.altitude, t3.`range`, t3.heading, t3.tilt, t3.altitudeMode FROM Touristic_places as t2, POI_data as t3 WHERE t2.idTouristicP = t3.idTouristicP;
SELECT t2.name, t3.altitude, t3.altitudeMode FROM Touristic_places as t2, POI_data as t3 WHERE t2.idTouristicP = t3.idTouristicP;
