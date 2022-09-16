/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon"
SELECT * from animals where animal_name::text like '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT animal_name from animals where date_of_birth BETWEEN '2016-01-01'::date and '2019-12-31'::date; 

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT animal_name from animals where neutered = true and escape_attempts < 3; 

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth from animals where animal_name = 'Pikachu' or animal_name = 'Agumon';

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT animal_name, escape_attempts from animals where weight_kg > 10.5;

-- Find all animals that are neutered
SELECT * from animals where neutered = true;

-- Find all animals not named Gabumon.
SELECT * from animals where animal_name not like 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * from animals where (weight_kg >= 10.40 and weight_kg <= 17.30);

-- ------------------------- day 2

-- Inside a transaction update the animals table by setting the species column to unspecified. 
-- Verify that change was made. Then roll back the change and verify that the species columns
--  went back to the state before the transaction.
START TRANSACTION;
UPDATE animals SET species = 'unspecified';
select * from animals;
ROLLBACK;
select * from animals;

-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
-- Commit the transaction.
-- Verify that change was made and persists after commit.
START TRANSACTION;
UPDATE animals SET species = 'digimon' WHERE animal_name::TEXT like '%mon';
UPDATE animals SET species = 'pokemon' WHERE species is NULL;
COMMIT;
select * from animals;

--  delete all records then roll back
START TRANSACTION;
DELETE FROM animals;
ROLLBACK
select * from animals;

-- Delete all animals born after Jan 1st, 2022. and remove negative sign
START TRANSACTION;
DELETE FROM animals WHERE date_of_birth::date > '2022-01-01';
SAVEPOINT older_2022;
UPDATE animals SET weight_kg = (weight_kg * -1);
ROLLBACK TO SAVEPOINT older_2022;
UPDATE animals SET weight_kg = (weight_kg * -1) WHERE weight_kg < 0;
COMMIT;
select * from animals;

-- How many animals are there?
select count(animal_name) from animals;

-- How many animals have never tried to escape?
select count(*) from animals where escape_attempts = 0;

-- What is the average weight of animals?
select avg(weight_kg) from animals;

-- Who escapes the most, neutered or not neutered animals?
select max(escape_attempts), neutered from animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT min(weight_kg), max(weight_kg), species from animals GROUP by species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000? 
select avg(escape_attempts) , species from animals where date_of_birth between '1990-01-01' and '2000-12-31' GROUP BY species;



-- ----------------- day 3


-- What animals belong to Melody Pond?
SELECT animal_name, full_name FROM animals 
JOIN owners ON animals.owner_id = owners.id WHERE owners.id = 4;

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animal_name, species_name FROM animals 
JOIN species ON animals.species_id = species.id WHERE species.id = 1;

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT animal_name, full_name FROM animals FULL 
JOIN owners ON animals.owner_id = owners.id;

-- How many animals are there per species?
SELECT COUNT(*), species_name FROM animals, species 
WHERE animals.species_id = species.id GROUP BY species_name; 

-- List all Digimon owned by Jennifer Orwell.
SELECT animal_name, full_name FROM animals 
JOIN owners ON animals.owner_id = owners.id 
WHERE full_name = 'Jennifer Orwell' and species_id = 2;

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animal_name, full_name 
FROM animals JOIN owners ON animals.owner_id = owners.id 
WHERE full_name = 'Dean Winchester' and escape_attempts = 0;

-- Who owns the most animals?
SELECT owners.full_name , COUNT(animal_name) AS total_animals 
FROM owners JOIN animals ON animals.owner_id=owners.id 
GROUP BY owners.full_name ORDER BY total_animals DESC LIMIT 1;
