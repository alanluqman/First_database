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


-- ------------------- day 4

-- Who was the last animal seen by William Tatcher?
SELECT animal_name, vets.name, v.visit_date 
FROM animals a JOIN visits v ON a.animal_id = v.animal_id 
JOIN vets ON vets.id = v.vet_id 
WHERE vets.id = 1 ORDER BY v.visit_date DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(a.animal_name), vets.name 
FROM animals a JOIN visits v ON a.animal_id = v.animal_id 
JOIN vets ON vets.id = v.vet_id 
WHERE vets.name = 'Stephanie Mendez' GROUP BY vets.name;

-- List all vets and their specialties, including vets with no specialties.
SELECT species.species_name, vets.name 
FROM vets FULL JOIN specializations ON specializations.vet_id = vets.id 
FULL JOIN species ON species.id = specializations.species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.animal_name, vets.name, visits.visit_date 
FROM vets FULL JOIN visits ON visits.vet_id = vets.id 
FULL JOIN animals ON animals.animal_id = visits.animal_id 
WHERE vets.name = 'Stephanie Mendez' AND visits.visit_date 
BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT COUNT(animals.animal_name), animals.animal_name
FROM vets JOIN visits ON visits.vet_id = vets.id 
JOIN animals ON animals.animal_id = visits.animal_id 
GROUP BY animals.animal_name ORDER BY count DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT vets.name, a.animal_name, visits.visit_date 
FROM vets JOIN visits ON visits.vet_id = vets.id 
JOIN animals a ON a.animal_id = visits.animal_id 
WHERE vets.name = 'Maisy Smith' ORDER BY visits.visit_date LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT a.animal_name AS animal,a.date_of_birth,a.escape_attempts,a.neutered,
a.weight_kg,species.species_name,vets.name AS vet, vets.age,vets.date_of_graduation,v.visit_date 
FROM vets JOIN visits v ON v.vet_id = vets.id JOIN animals a ON a.animal_id = v.animal_id 
JOIN species ON a.species_id = species.id ORDER BY v.visit_date DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT animals.animal_name as Animal, species.species_name AS species,
vets.name AS vet, vet_sp.species_name AS specialized
FROM vets JOIN visits ON vets.id = visits.vet_id
JOIN animals ON visits.animal_id = animals.animal_id
JOIN species ON species.id = animals.species_id
JOIN specializations ON specializations.vet_id = vets.id
JOIN species vet_sp ON vet_sp.id = specializations.species_id
WHERE species.id != vet_sp.id;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.species_name AS species
FROM vets JOIN visits ON vets.id = visits.vet_id
JOIN animals ON visits.animal_id = animals.animal_id
JOIN species ON species.id = animals.species_id
WHERE vets.name = 'Maisy Smith' GROUP BY species LIMIT 1;

