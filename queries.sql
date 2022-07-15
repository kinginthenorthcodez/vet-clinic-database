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


/*
Write queries (using JOIN) to answer the following questions:
What animals belong to Melody Pond?
List of all animals that are pokemon (their type is Pokemon).
List all owners and their animals, remember to include those that don't own any animal.
How many animals are there per species?
List all Digimon owned by Jennifer Orwell.
List all animals owned by Dean Winchester that haven't tried to escape.
Who owns the most animals?
*/

SELECT name,full_name
FROM owners O
JOIN animals A ON O.id = A.owner_id
WHERE full_name ='Melody Pond';

SELECT A.name as animal,S.name as species_type
FROM species S
JOIN animals A ON S.id = A.species_id
WHERE S.name='Pokemon';

SELECT name,full_name
FROM owners O
FULL JOIN animals A ON O.id = A.owner_id;

SELECT count(A.name) as animal_count,S.name as species_type
FROM species S
JOIN animals A ON S.id = A.species_id
group by S.name;

SELECT A.name as animal,S.name as species_type, owner_id
FROM species S
JOIN animals A ON S.id = A.species_id
WHERE A.species_id=(SELECT id FROM species WHERE name='Digimon') AND owner_id=(SELECT id FROM owners WHERE full_name='Jennifer Orwell');

SELECT A.name as animal,full_name as ownerd_by
FROM owners O
JOIN animals A ON O.id = A.owner_id
WHERE full_name='Dean Winchester' AND escape_attempts = 0;

SELECT full_name as ownerd_by,
COUNT(full_name) as total_count
FROM animals A
JOIN owners O ON O.id = A.owner_id
group by full_name
ORDER by total_count DESC
LIMIT 1;

