/* Populate database with sample data. */

INSERT INTO animals (animal_name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Agumon', '2020-02-03',0,true,10.23);

INSERT INTO animals (animal_name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Gabumon', '2018-11-15',2,true,8);

INSERT INTO animals (animal_name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Pikachu', '2021-01-07',1,false,15.04);

INSERT INTO animals (animal_name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Devimon', '2017-05-12',5,true,11);

-- -------------------------- day 2

INSERT INTO animals (animal_name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Charmander', '2020-02-08',0,false,-11),
       ('Plantmon', '2021-11-15',2,true,-5.7),
       ('Squirtle', '1993-04-02',3,false,-12.13),
       ('Angemon', '2005-06-12',1,true,-45),
       ('Boarmon', '2005-06-07',7,true,20.4),
       ('Blossom', '1998-10-13',3,true,17),
       ('Ditto', '2022-05-14',4,true,22);

-- ------------------------- day 3

-- Insert these data into the owners table:
INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34),
       ('Jennifer Orwell', 19),
       ('Bob ', 45),
       ('Melody Pond', 77),
       ('Dean Winchester', 14),
       ('Jodie Whittaker', 38);

--  nsert these data into the species table
INSERT INTO species (species_name)
VALUES ('Pokemon'),
       ('Digimon');

-- If the name ends in "mon" it will be Digimon
UPDATE animals SET species_id = 2 WHERE animal_name LIKE '%mon'; 

-- All other animals are Pokemon
UPDATE animals SET species_id = 1 WHERE species_id IS NULL;

-- Sam Smith owns Agumon.
UPDATE animals SET owner_id = 1 WHERE animal_name = 'Agumon'; 

-- Jennifer Orwell owns Gabumon and Pikachu.
UPDATE animals SET owner_id = 2 WHERE animal_name IN ('Gabumon', 'Pikachu');

-- Bob owns Devimon and Plantmon.
UPDATE animals SET owner_id = 3 WHERE animal_name IN ('Devimon', 'Plantmon'); 

-- Melody Pond owns Charmander, Squirtle, and Blossom.
UPDATE animals SET owner_id = 4 WHERE animal_name IN ('Charmander', 'Squirtle', 'Blossom'); 

-- Dean Winchester owns Angemon and Boarmon.
UPDATE animals SET owner_id = 5 WHERE animal_name IN ('Angemon', 'Boarmon');


-- ---------------------- day 4

-- Insert the following data for vets
INSERT INTO vets (name , age , date_of_graduation)
VALUES  ('William Tatcher', 45, '2000-04-23'),
		('Maisy Smith', 26, '2019-01-17'),
		('Stephanie Mendez', 64, '1981-05-04'),
		('Jack Harkness', 38, '2008-06-08');

-- Insert the following data for specialties
INSERT INTO specializations (vet_id,species_id)
VALUES (1,1), (3,1), (3,2), (4,2);

-- Insert the following data for visits:

-- INSERT INTO visits (vet_id,animal_id,visit_date)
INSERT INTO visits (vet_id,animal_id,visit_date)
VALUES  (1, 1, '2020-05-24'),(3, 1, '2020-07-22'),(4, 2, '2021-02-02'),
		(2, 3, '2020-01-05'),(2, 3, '2020-03-08'),(2, 3, '2020-05-14'),
		(3, 4, '2021-05-04'),(4, 10, '2021-02-24'),(2, 11, '2019-12-21'),
		(1, 11, '2020-08-10'),(2, 11, '2021-04-07'),(3, 12, '2019-09-29'),
		(4, 13, '2020-10-03'),(4, 13, '2020-11-04'),(2, 15, '2019-01-24'),
		(2, 15, '2019-05-15'),(2, 15, '2020-02-27'),(2, 15, '2020-08-03'),
		(3, 15, '2020-05-24'),(1, 15, '2021-01-11');