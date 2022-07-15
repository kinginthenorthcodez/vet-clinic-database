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