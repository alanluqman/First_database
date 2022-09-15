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

