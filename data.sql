/* Populate database with sample data. */

INSERT INTO animals (name) VALUES ('Luna');
INSERT INTO animals (name) VALUES ('Daisy');
INSERT INTO animals (name) VALUES ('Charlie');
INSERT INTO animals(id,name,date_of_birth,escape_attempts,neutered,weight_kg) values(1,'Agumon','2020-02-03
',0,false,10.23),(2,'Gabumon','2018-11-15',2,true,8),(3,'Pikachu','2021-01-07',1,false,15.04),(4,'Devimon','2017-05-12',
5,true,11);

INSERT INTO animals(id,name,date_of_birth,escape_attempts,neutered,weight_kg) values(5,'Charmander'
,'2020-02-08',0,false,-11),(6,'Plantmon','2021-11-15',2,true,-5.7),(7,'Squirtle','1993-04-02',3,false,-12.13),(8,'An
gemon','2005-06-12',1,true,-45),(9,'Boarmon','2005-06-07',7,true,20.4),(10,'Blossom','1998-10-13',3,true,17),(11,'
Ditto','2022-05-14',4,true,22);

/*Inside a transaction update the animals table by setting the species column to unspecified */
BEGIN;
 UPDATE animals SET species = 'unspecified';

select id,name,species from animals;
rollback;

/* Update the animals table by setting the species column to digimon for all animals that have a name ending in mon. */
/* Update the animals table by setting the species column to pokemon for all animals that don't have species already set.*/
BEGIN;
 UPDATE animals SET species='digimon' WHERE name LIKE '%mon';
 UPDATE animals SET species='pokemon' WHERE species IS NULL;
 commit;

 /* Inside a transaction delete all records in the animals table, then roll back the transaction*/
 /* After the rollback verify if all records in the animals table still exists. */

 BEGIN;
  DELETE FROM animals;
  rollback;
 
/* Inside a transaction
Delete all animals born after Jan 1st, 2022. 
Create a savepoint for the transaction.
Update all animals' weight to be their weight multiplied by -1.
Rollback to the savepoint
Update all animals' weights that are negative to be their weight multiplied by -1.
Commit transaction
 */

BEGIN;
 DELETE FROM animals WHERE date_of_birth > '2022-01-01';
 savepoint sp1;
 UPDATE animals SET weight_kg= weight_kg * -1;
  UPDATE animals SET weight_kg= weight_kg * -1 WHERE weight_kg < 0;
  commit;
 
/* 
Insert the following data into the owners table:
Sam Smith 34 years old.
Jennifer Orwell 19 years old.
Bob 45 years old.
Melody Pond 77 years old.
Dean Winchester 14 years old.
Jodie Whittaker 38 years old.
*/

INSERT INTO owners(full_name,age) values('Sam Smith',34),('Jennifer Orwell',19),('Bob',45),('Melody Pond',77),('Dean Winchester',14),('Jodie Whittaker',38);
/* 
Insert the following data into the species table:
Pokemon
Digimon
*/
INSERT INTO species(name) values('Pokemon'),('Digimon');

/* 
Modify your inserted animals so it includes the species_id value:
If the name ends in "mon" it will be Digimon
All other animals are Pokemon
*/

BEGIN;
UPDATE animals SET species_id=(SELECT id FROM species WHERE name='Digimon') WHERE name LIKE '%mon';
UPDATE animals SET species_id=(SELECT id FROM species WHERE name='Pokemon') WHERE species_id IS NULL;
commit;

/*
Modify your inserted animals to include owner information (owner_id):
Sam Smith owns Agumon.
Jennifer Orwell owns Gabumon and Pikachu.
Bob owns Devimon and Plantmon.
Melody Pond owns Charmander, Squirtle, and Blossom.
Dean Winchester owns Angemon and Boarmon.
*/

BEGIN;
UPDATE animals SET owner_id= (SELECT id FROM owners WHERE full_name='Sam Smith') WHERE name='Agumon';
UPDATE animals SET owner_id= (SELECT id FROM owners WHERE full_name='Jennifer Orwell') WHERE name='Gabumon' OR name='Pikachu';
UPDATE animals SET owner_id= (SELECT id FROM owners WHERE full_name='Bob') WHERE name='Devimon' OR name='Plantmon';
UPDATE animals SET owner_id= (SELECT id FROM owners WHERE full_name='Melody Pond') WHERE name='Charmander' OR name='Squirtle' OR name='Blossom';
UPDATE animals SET owner_id= (SELECT id FROM owners WHERE full_name='Dean Winchester') WHERE name='Angemon' OR name='Boarmon';
commit;


/*
Insert the following data for vets:
Vet William Tatcher is 45 years old and graduated Apr 23rd, 2000.
Vet Maisy Smith is 26 years old and graduated Jan 17th, 2019.
Vet Stephanie Mendez is 64 years old and graduated May 4th, 1981.
Vet Jack Harkness is 38 years old and graduated Jun 8th, 2008
*/

INSERT INTO vets(name,age,date_of_graduation) values('Vet William Tatcher',45,'2000-04-23'),('Vet Maisy Smith',26,'2019-01-17'),('V
et Stephanie Mendez',64,'1981-05-04'),('Vet Jack Harkness',38,'2008-06-08');

/*
Insert the following data for specialties:
Vet William Tatcher is specialized in Pokemon.
Vet Stephanie Mendez is specialized in Digimon and Pokemon.
Vet Jack Harkness is specialized in Digimon.
*/

INSERT INTO specializations (species_id,vets_id) values(1,13),(1,15),(2,16);
TRUNCATE TABLE vets
RESTART IDENTITY
CASCADE;

/* Some Wild Ways */
INSERT INTO specializations (species_id) SELECT id FROM species WHERE name='Pokemon';
INSERT INTO specializations (vets_id)SELECT id FROM vets WHERE name='Vet William Tatcher';
INSERT INSERT INTO specializations(species_id,vets_id) SELECT
SELECT id as spId FROM species  WHERE name='Pokemon'
UNION
SELECT id as vId FROM vets WHERE name='Vet William Tatcher';
