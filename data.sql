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
 
