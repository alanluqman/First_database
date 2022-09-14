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
