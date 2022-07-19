/* create database*/
DROP DATABASE IF EXISTS clinicdb;
CREATE DATABASE clinicdb;

/*create tables */

CREATE TABLE patients(
  id INT PRIMARY KEY,
  name VARCHAR(100),
  data_of_birth DATE
);

CREATE TABLE medical_histories(
  id INT PRIMARY KEY,
  admitted_at TIMESTAMP,
  patient_id INT,
  status VARCHAR(100),
  CONSTRAINT patient_id_fkey FOREIGN KEY(patient_id) REFERENCES patients(id)
);


CREATE TABLE invoices(
  id INT PRIMARY KEY,
  total_amount DECIMAL,
  generated_at TIMESTAMP,
  payed_at TIMESTAMP,
  medical_history_id INT,
  CONSTRAINT medical_history_id_fkey FOREIGN KEY(medical_history_id) REFERENCES medical_histories(id)
);


CREATE TABLE treatments(
  id INT PRIMARY KEY,
  type VARCHAR(100),
  name VARCHAR(100)
);

CREATE TABLE invoice_items(
  id INT PRIMARY KEY,
  unit_price DECIMAL,
  quantity INT,
  total_price DECIMAL,
  invoice_id INT,
  treatment_id INT,
  CONSTRAINT invoice_id_fkey FOREIGN KEY(invoice_id) REFERENCES invoices(id),
  CONSTRAINT treatment_id_fkey FOREIGN KEY(treatment_id) REFERENCES treatments(id)
);


CREATE TABLE medical_treatment_histries(
  medical_id INT,
  treatment_id INT,
  CONSTRAINT medical_id_fkey FOREIGN KEY(medical_id) REFERENCES medical_histories(id),
  CONSTRAINT treatment_id_fkey FOREIGN KEY(treatment_id) REFERENCES treatments(id)
);


/* TABLE INDEX FOR FKEYS */
CREATE INDEX patient_id_index on medical_histories(patient_id);
CREATE INDEX medical_history_id on invoices(medical_history_id);
CREATE INDEX invoice_id on invoice_items(invoice_id);
CREATE INDEX treatment_id on invoice_items(treatment_id);
CREATE INDEX medical_id on medical_treatment_histries(medical_id);
CREATE INDEX treatment_id_md_index on medical_treatment_histries(treatment_id);
