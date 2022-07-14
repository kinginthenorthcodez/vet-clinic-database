/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name = 'Luna';

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth  BETWEEN '2016-01-01' AND '2019-12-31'
;
SELECT name FROM animals WHERE neutered=true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name='Agumon' OR name='Pikachu';
SELECT name,escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE NOT name ='Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

/* Write queries to answer the following questions:
How many animals are there?
How many animals have never tried to escape?
What is the average weight of animals?
Who escapes the most, neutered or not neutered animals?
What is the minimum and maximum weight of each type of animal?
What is the average number of escape attempts per animal type of those born between 1990 and 2000? */

SELECT COUNT(name) FROM animals;
SELECT COUNT(name) as never_escaped  FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) as Avarage_weight  FROM animals
SELECT name, MAX(escape_attempts) as Max_escapes FROM animals WHERE neutered=true OR  neutered = false group by name;
SELECT  species, MIN(weight_kg) as Mix_weight,MAX(weight_kg) as Max_weight FROM animals  group by species;
SELECT species, AVG(escape_attempts) as Avg_escapes FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' group by 
species;
