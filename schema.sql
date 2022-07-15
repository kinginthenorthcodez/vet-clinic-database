/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
id INT,
name TEXT,
date_of_birth DATE,
escape_attempts INT,
neutered BOOLEAN,
weight_kg DECIMAL
);

ALTER TABLE  animals ADD COLUMN species VARCHAR(50);

/* Create a table named owners with the following columns:*/
CREATE TABLE owners(
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(255),
    age INT,
    PRIMARY KEY(id)
);

/* Create a table named species with the following columns */
CREATE TABLE species(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    PRIMARY KEY(id)
);

/*
Modify animals table:
Make sure that id is set as autoincremented PRIMARY KEY
Remove column species
Add column species_id which is a foreign key referencing species table
Add column owner_id which is a foreign key referencing the owners table
*/

ALTER TABLE animals
ALTER COLUMN id SET NOT NULL;

ALTER TABLE animals
ALTER COLUMN id
ADD GENERATED ALWAYS AS IDENTITY;

ALTER TABLE animals
ADD PRIMARY KEY(id);

ALTER TABLE animals
DROP COLUMN IF EXISTS species;

ALTER TABLE animals
ADD COLUMN species_id INT;

ALTER TABLE animals
ADD CONSTRAINT species_fkey
FOREIGN KEY (species_id)
REFERENCES species(id);

ALTER TABLE animals
ADD COLUMN owner_id INT;

ALTER TABLE animals
ADD CONSTRAINT owners_fkey
FOREIGN KEY (owner_id)
REFERENCES owners(id);

/*
Create a table named vets with the following columns:
id: integer (set it as autoincremented PRIMARY KEY)
name: string
age: integer
date_of_graduation: date 
*/
CREATE TABLE vets(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY(id)
);

/*
There is a many-to-many relationship between the tables species and vets: 
a vet can specialize in multiple species, and a species can have multiple vets specialized in it.
 Create a "join table" called specializations to handle this relationship.
*/
CREATE TABLE specializations(
    species_id INT,
    vets_id INT,
    CONSTRAINT species_sp_key
    FOREIGN KEY(species_id)
    REFERENCES species(id),
    CONSTRAINT vets_sp_key
    FOREIGN KEY(vets_id)
    REFERENCES vets(id)
);

/*
There is a many-to-many relationship between the tables animals and vets: 
an animal can visit multiple vets and one vet can be visited by multiple animals. Create a "join table" called visits to handle this relationship,
 it should also keep track of the date of the visit.
*/

CREATE TABLE visits(
    animal_id INT,
    vets_id INT,
    date_of_visit DATE,
    CONSTRAINT animal_vkey
    FOREIGN KEY(animal_id)
    REFERENCES animals(id),
    CONSTRAINT vets_vkey
    FOREIGN KEY(vets_id)
    REFERENCES vets(id)
);

