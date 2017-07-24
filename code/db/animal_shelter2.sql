DROP TABLE cat_details;
DROP TABLE animals;
DROP TABLE owners;

CREATE TABLE owners (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE animals (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  type VARCHAR(255),
  gender VARCHAR(255),
  age INT2,
  breed VARCHAR(255),
  admission_date VARCHAR(255),
  adoptable BOOLEAN NOT NULL,
  summary TEXT,
  owner_id INT8 DEFAULT 1,
  
  CONSTRAINT fk_owner_id
    FOREIGN KEY (owner_id)
    REFERENCES owners (id)
    ON DELETE SET DEFAULT
);

CREATE TABLE cat_details (
  id SERIAL8 PRIMARY KEY,
  colour VARCHAR(255),
  live_with_cats BOOLEAN NOT NULL,
  live_with_dogs BOOLEAN NOT NULL,
  live_with_family BOOLEAN NOT NULL,
  indoor_cat BOOLEAN NOT NULL,
  cat_id INT8,

  CONSTRAINT fk_cat_id
    FOREIGN KEY (cat_id)
    REFERENCES animals (id)
    ON DELETE CASCADE
);