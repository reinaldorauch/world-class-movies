CREATE DATABASE wcf_example CHARSET utf8 COLLATION utf8_unicode_cs;

USE wcf_example;

CREATE TABLE director (
  director_id INTEGER PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  initials VARCHAR(10)
) ENGINE=InnoDB;

CREATE TABLE actor (
  actor_id INTEGER PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  initials VARCHAR(10)
) ENGINE=InnoDB;

CREATE TABLE employee (
  employee_id INTEGER PRIMARY KEY,
  first_name VARCHAR(30),
  middle_initial CHAR(1),
  last_name VARCHAR(30),
  date_of_birth DATE,
  gender_lookup INTEGER,
  region_id INTEGER,
  city_name VARCHAR(64),
  address1 VARCHAR(50),
  address2 VARCHAR(50),
  postal_code VARCHAR(10),
  email_address VARCHAR(64),
  FOREIGN KEY region_id REFERENCES region (region_id),
  FOREIGN KEY gender_lookup REFERENCES lookup_value (lookup_value_id)
) ENGINE=InnoDB;

CREATE TABLE distributor (
  distributor_id INTEGER PRIMARY KEY,
  region_id INTEGER,
  distributor_name VARCHAR(50),
  city_name VARCHAR(64),
  address1 VARCHAR(50),
  address2 VARCHAR(50),
  postal_code VARCHAR(10),
  email_address VARCHAR(64),
  telephone_number CHAR(12),
  FOREIGN KEY region_id REFERENCES region (region_id)
) ENGINE=InnoDB;

CREATE TABLE purchase_order (
  purchase_order_id INTEGER PRIMARY KEY,
  employee_id INTEGER,
  distributor_id INTEGER,
  order_date DATE,
  confirmation_date DATE,
  status_lookup INTEGER,
  FOREIGN KEY employee_id REFERENCES employee (employee_id),
  FOREIGN KEY distributor_id REFERENCES distributor (distributor_id)
  FOREIGN KEY status_lookup REFERENCES lookup_value (lookup_value_id)
) ENGINE=InnoDB;

CREATE TABLE job_description (
  job_description_id INTEGER PRIMARY KEY,
  job_title VARCHAR(30),
  job_description VARCHAR(64)
) ENGINE=InnoDB;

CREATE TABLE dvd_release (
  dvd_release_id INTEGER PRIMARY KEY,
  `title` VARCHAR(64),
  `studio` VARCHAR(50),
  `released` DATE,
  `status` VARCHAR(50),
  `sound` VARCHAR(20),
  `versions` VARCHAR(20),
  `price` DECIMAL(5, 2),
  `rating` VARCHAR(10),
  `year` YEAR,
  `genre` VARCHAR(20),
  `aspect` VARCHAR(10),
  `upc` CHAR(13),
  `release_date` DATE,
  `timestamp` DATETIME
) ENGINE=InnoDB;

CREATE TABLE dvd_release_director (
  dvd_release_director_id INTEGER PRIMARY KEY,
  director_id INTEGER NOT NULL,
  director_release_id INTEGER NOT NULL,
  FOREIGN KEY director_id REFERENCES director (director_id),
  FOREIGN KEY director_release_id REFERENCES dvd_release (dvd_release_id)
) ENGINE=InnoDB;

CREATE TABLE dvd_release_actor (
  dvd_release_actor_id INTEGER PRIMARY KEY,
  actor_id INTEGER NOT NULL,
  dvd_release_id INTEGER NOT NULL
  FOREIGN KEY actor_id REFERENCES actor (actor_id).
  FOREIGN KEY dvd_release_id REFERENCES dvd_release (dvd_release_id)
) ENGINE=InnoDB;

CREATE TABLE website (
  website_id INTEGER PRIMARY KEY,
  website_title VARCHAR(50),
  website_uri VARCHAR(60)
) ENGINE=InnoDB;

CREATE TABLE customer (
  customer_id INTEGER PRIMARY KEY,
  website_id INTEGER PRIMARY KEY,
  first_name VARCHAR(30),
  middle_initial CHAR(1),
  last_name VARCHAR(30),
  date_of_birth DATE,
  maiden_name_mother VARCHAR(30),
  gender_lookup INTEGER,
  city_name VARCHAR(64),
  address1 VARCHAR(50),
  address2 VARCHAR(50),
  region_id INTEGER,
  postal_code VARCHAR(10),
  email_address VARCHAR(64),
  telephone_number CHAR(12),
  password_hash VARCHAR(41),
  balance DECIMAL(6,2),
  date_registered DATE,
  date_unregistered DATE,
  `timestamp_changed` TIMESTAMP,
  FOREIGN KEY website_id REFERENCES website (website_id),
  FOREIGN KEY region_id REFERENCES region (region_id),
  FOREIGN KEY gender_lookup REFERENCES lookup_value (lookup_value_id)
) ENGINE=InnoDB;

CREATE TABLE promotion (
  promotion_id INTEGER PRIMARY KEY,
  website_id INTEGER NOT NULL,
  promotion_title VARCHAR(50),
  promotion_type_lookup INTEGER,
  promotion_start_date DATE,
  promotion_end_date DATE,
  FOREIGN KEY website_id REFERENCES website (website_id),
  FOREIGN KEY promotion_type_lookup REFERENCES lookup_value (lookup_value_id)
) ENGINE=InnoDB;

CREATE TABLE customer_order (
  customer_order_id INTEGER PRIMARY KEY,
  customer_id INTEGER NOT NULL,
  promotion_id INTEGER NOT NULL,
  shipping_region_id INTEGER NOT NULL,
  customer_first_name VARCHAR(30),
  customer_middle_initial CHAR(1),
  customer_last_name VARCHAR(30),
  shipping_country_name VARCHAR(50),
  shipping_city_name VARCHAR(64),
  shipping_address1 VARCHAR(50),
  shipping_address2 VARCHAR(50),
  shipping_state VARCHAR(30),
  shipping_postal_code VARCHAR(10),
  order_timestamp TIMESTAMP,
  status_lookup INTEGER,
  FOREIGN KEY customer_id REFERENCES customer (customer_id),
  FOREIGN KEY promotion_id REFERENCES promotion (promotion_id),
  FOREIGN KEY status_lookup REFERENCES lookup_value (lookup_value_id)
) ENGINE=InnoDB;

CREATE TABLE warehouse (
  warehouse_id INTEGER PRIMARY KEY,
  region_id INTEGER,
  city_name VARCHAR(64),
  address1 VARCHAR(50),
  address2 VARCHAR(50),
  postal_code VARCHAR(10),
  email_address VARCHAR(64),
  telephone_number CHAR(12),
  FOREIGN KEY region_id REFERENCES region (region_id)
) ENGINE=InnoDB;

CREATE TABLE employee_job (
  employee_job_id INTEGER PRIMARY KEY,
  job_description_id INTEGER,
  employee_id INTEGER,
  warehouse_id INTEGER,
  start_date DATE,
  end_date DATE,
  FOREIGN KEY employee_id REFERENCES employee (employee_id),
  FOREIGN KEY job_description_id REFERENCES job_description (job_description_id),
  FOREIGN KEY warehouse_id REFERENCES warehouse (warehouse_id)
) ENGINE=InnoDB;

CREATE TABLE purchase_order_line (
  purchase_order_line_id INTEGER PRIMARY KEY,
  purchase_order_id INTEGER,
  warehouse_id INTEGER,
  dvd_release_id INTEGER,
  line_number: INTEGER,
  quantity INTEGER,
  price DECIMAL(10,2),
  shipping_cost DECIMAL(10,2),
  shipping_date DATE,
  delivery_due_date DATE,
  delivery_date DATE,
  FOREIGN KEY purchase_order_id REFERENCES purchase_order (purchase_order_id),
  FOREIGN KEY warehouse_id REFERENCES warehouse (warehouse_id),
  FOREIGN KEY dvd_release_id REFERENCES dvd_release (dvd_release_id)
) ENGINE=InnoDB;

CREATE TABLE dvd (
  dvd_id INTEGER PRIMARY KEY,
  dvd_release_id INTEGER,
  purchase_order_line_id INTEGER,
  status_lookup SMALLINT,
  dvd_barcode INTEGER,
  FOREIGN KEY dvd_release_id REFERENCES dvd_release (dvd_release_id),
  FOREIGN KEY purchase_order_line_id REFERENCES purchase_order_line (purchase_order_line_id)
) ENGINE=InnoDB;

CREATE TABLE inventory (
  inventory_id INTEGER PRIMARY KEY,
  warehouse_id INTEGER,
  dvd_id INTEGER,
  customer_order_id INTEGER,
  employee_id INTEGER,
  `timestamp`: TIMESTAMP,
  status_lookup: INTEGER,
  FOREIGN KEY warehouse_id REFERENCES warehouse (warehouse_id),
  FOREIGN KEY dvd_id REFERENCES dvd (dvd_id),
  FOREIGN KEY customer_order_id REFERENCES customer_order (customer_order_id),
  FOREIGN KEY employee_id REFERENCES employee (employee_id),
) ENGINE=InnoDB;

CREATE TABLE promoted_dvd_release (
  promoted_dvd_release_id INTEGER PRIMARY KEY,
  promotion_id INTEGER,
  dvd_release_id INTEGER,
  promotion_rental_price DECIMAL(4,2),
  promotion_rental_duration INTEGER,
  promotion_purchase_price DECIMAL(4,2),
  FOREIGN KEY promotion_id REFERENCES promotion (promotion_id),
  FOREIGN KEY dvd_release_id REFERENCES dvd_release (dvd_release_id)
) ENGINE=InnoDB;

CREATE TABLE customer_order_line (
  customer_order_line_id INTEGER PRIMARY KEY,
  customer_order_id INTEGER,
  dvd_release_id INTEGER,
  line_number INTEGER,
  rental_price DECIMAL(10,2),
  purchase_price DECIMAL(10,2),
  shipping_cost DECIMAL(10,2),
  shipping_date DATE,
  delivery_date DATE,
  delivery_due_date DATE,
  return_due_date DATE,
  FOREIGN KEY customer_order_id REFERENCES customer_order (customer_order_id),
  FOREIGN KEY dvd_release_id REFERENCES dvd_release (dvd_release_id)
) ENGINE= InnoDB;

CREATE TABLE country (
  country_id INTEGER PRIMARY KEY,
  country_name VARCHAR(50),
  ISO3166_country_code CHAR(2)
) ENGINE=InnoDB;

CREATE TABLE region (
  region_id INTEGER PRIMARY KEY,
  region_name VARCHAR(35),
  country_id INTEGER,
  ISO3166_region_code CHAR(2),
  FOREIGN KEY country_id REFERENCES country (country_id)
) ENGINE=InnoDB;

CREATE TABLE lookup_value (
  lookup_value_id INTEGER PRIMARY KEY,
  lookup_type_id INTEGER,
  lookup_text VARCHAR(50)
) ENGINE=InnoDB;