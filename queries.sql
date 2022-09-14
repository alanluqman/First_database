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