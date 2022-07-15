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


/*
Write queries to answer the following:
Who was the last animal seen by William Tatcher?
How many different animals did Stephanie Mendez see?
List all vets and their specialties, including vets with no specialties.
List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
What animal has the most visits to vets?
Who was Maisy Smith's first visit?
Details for most recent visit: animal information, vet information, and date of visit.
How many visits were with a vet that did not specialize in that animal's species?
What specialty should Maisy Smith consider getting? Look for the species she gets the most.
*/

SELECT a.name,date_of_visit FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets ON v.vets_id = vets.id
WHERE vets.name ='Vet William Tatcher'
ORDER by v.date_of_visit DESC
LIMIT 1;

SELECT DISTINCT COUNT(a.name) FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets ON v.vets_id = vets.id
WHERE vets.name ='Vet Stephanie Mendez';

SELECT vets.name, species.name FROM vets
FULL JOIN specializations s ON vets.id = s.vets_id
FULL JOIN species ON s.species_id = species.id;


SELECT a.name,date_of_visit FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets ON v.vets_id = vets.id
WHERE vets.name ='Vet Stephanie Mendez' AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';


SELECT a.name,
COUNT(a.name) as total_count
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets ON v.vets_id = vets.id
GROUP by a.name
ORDER by total_count DESC
LIMIT 1;

SELECT a.name,date_of_visit FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets ON v.vets_id = vets.id
WHERE vets.name ='Vet Maisy Smith'
ORDER by v.date_of_visit ASC
LIMIT 1;

SELECT * FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets ON v.vets_id = vets.id
ORDER by v.date_of_visit ASC
LIMIT 1;

SELECT COUNT(visits.date_of_visit) FROM vets
JOIN visits  ON visits.vets_id = vets.id
JOIN animals ON visits.animal_id = animals.id
JOIN specializations ON specializations.vets_id = vets.id
JOIN species ON specializations.species_id = species.id
WHERE animals.species_id <> specializations.species_id;

SELECT species.name, COUNT(*) FROM animals
JOIN visits ON visits.animal_id = animals.id
JOIN vets ON vets.id = visits.vets_id
JOIN species ON species.id = animals.species_id
WHERE vets.name = 'Vet Maisy Smith'
GROUP BY species.name 
ORDER BY count DESC LIMIT 1;


