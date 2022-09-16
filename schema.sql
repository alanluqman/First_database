/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    animal_id INT GENERATED ALWAYS AS IDENTITY,
    animal_name VARCHAR,
    date_of_birth date,
    escape_attempts INT,
    neutered boolean,
    weight_kg decimal,
    PRIMARY KEY (animal_id)
);

-- ----------------- day 2

-- Add new column named : species
ALTER TABLE animals ADD species VARCHAR;

-- ----------------- day 3

-- Create a table named owners
CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR,
    age INT,
    PRIMARY KEY (id)
);

-- Create a table named species
CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    species_name VARCHAR,
    PRIMARY KEY (id)
);

-- Remove column species
ALTER TABLE animals drop species;

-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals add species_id INT;

ALTER TABLE animals 
ADD CONSTRAINT fk_species
FOREIGN KEY (species_id) 
REFERENCES species (id);

-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals add owner_id INT;

ALTER TABLE animals 
ADD CONSTRAINT fk_owner
FOREIGN KEY (owner_id) 
REFERENCES owners (id);
