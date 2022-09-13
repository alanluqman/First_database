/* Database schema to keep the structure of entire database. */

CREATE TABLE public.animals (
    animal_id INT GENERATED ALWAYS AS IDENTITY,
    animal_name VARCHAR,
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg decimal
);
