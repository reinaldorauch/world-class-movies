CREATE DATABASE wcf_example CHARSET utf8 COLLATION utf8_unicode_cs;

USE wcf_example;

CREATE TABLE director (
  director_id INTEGER PRIMARY KEY
) ENGINE=InnoDB;

CREATE TABLE actor (
  actor_id INTEGER PRIMARY KEY
) ENGINE=InnoDB;

CREATE TABLE employee (
  employee_id INTEGER PRIMARY KEY
) ENGINE=InnoDB;

CREATE TABLE distributor (
  distributor_id INTEGER PRIMARY KEY,
  region_id INTEGER
) ENGINE=InnoDB;

CREATE TABLE purchase_order (
  purchase_order_id INTEGER PRIMARY KEY,
  employee_id INTEGER,
  distributor_id INTEGER,
  FOREIGN KEY employee_id REFERENCES employee (employee_id),
  FOREIGN KEY distributor_id REFERENCES distributor (distributor_id)
) ENGINE=InnoDB;

CREATE TABLE job_description (
  job_description_id INTEGER PRIMARY KEY
) ENGINE=InnoDB;

CREATE TABLE dvd_release (
  dvd_release_id INTEGER PRIMARY KEY
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
  website_id INTEGER PRIMARY KEY
) ENGINE=InnoDB;

CREATE TABLE customer (
  customer_id INTEGER PRIMARY KEY,
  website_id INTEGER PRIMARY KEY,
  FOREIGN KEY website_id REFERENCES website (website_id)
) ENGINE=InnoDB;

CREATE TABLE promotion (
  promotion_id INTEGER PRIMARY KEY,
  website_id INTEGER NOT NULL,
  FOREIGN KEY website_id REFERENCES website (website_id)
) ENGINE=InnoDB;

CREATE TABLE customer_order (
  customer_order_id INTEGER PRIMARY KEY,
  customer_id INTEGER NOT NULL,
  promotion_id INTEGER NOT NULL,
  shipping_region_id INTEGER NOT NULL,
  FOREIGN KEY customer_id REFERENCES customer (customer_id),
  FOREIGN KEY promotion_id REFERENCES promotion (promotion_id)
) ENGINE=InnoDB;

CREATE TABLE warehouse (
  warehouse_id INTEGER PRIMARY KEY
) ENGINE=InnoDB;

CREATE TABLE employee_job (
  employee_job_description_id INTEGER PRIMARY KEY,
  employee_id INTEGER,
  job_description_id INTEGER,
  warehouse_id INTEGER,
  FOREIGN KEY employee_id REFERENCES employee (employee_id),
  FOREIGN KEY job_description_id REFERENCES job_description (job_description_id),
  FOREIGN KEY warehouse_id REFERENCES warehouse (warehouse_id)
) ENGINE=InnoDB;

CREATE TABLE purchase_order_line (
  purchase_order_line_id INTEGER PRIMARY KEY,
  purchase_order_id INTEGER,
  warehouse_id INTEGER,
  dvd_release_id INTEGER,
  FOREIGN KEY purchase_order_id REFERENCES purchase_order (purchase_order_id),
  FOREIGN KEY warehouse_id REFERENCES warehouse (warehouse_id),
  FOREIGN KEY dvd_release_id REFERENCES dvd_release (dvd_release_id)
) ENGINE=InnoDB;

CREATE TABLE dvd (
  dvd_id INTEGER PRIMARY KEY,
  dvd_release_id INTEGER,
  purchase_order_line_id INTEGER,
  FOREIGN KEY dvd_release_id REFERENCES dvd_release (dvd_release_id),
  FOREIGN KEY purchase_order_line_id REFERENCES purchase_order_line (purchase_order_line_id)
) ENGINE=InnoDB;

CREATE TABLE inventory (
  inventory_id INTEGER PRIMARY KEY,
  warehouse_id INTEGER,
  dvd_id INTEGER,
  customer_order_id INTEGER,
  employee_id INTEGER,
  FOREIGN KEY warehouse_id REFERENCES warehouse (warehouse_id),
  FOREIGN KEY dvd_id REFERENCES dvd (dvd_id),
  FOREIGN KEY customer_order_id REFERENCES customer_order (customer_order_id),
  FOREIGN KEY employee_id REFERENCES employee (employee_id)
) ENGINE=InnoDB;

CREATE TABLE promoted_dvd_release (
  promoted_dvd_release_id INTEGER PRIMARY KEY,
  promotion_id INTEGER,
  dvd_release_id INTEGER,
  FOREIGN KEY promotion_id REFERENCES promotion (promotion_id),
  FOREIGN KEY dvd_release_id REFERENCES dvd_release (dvd_release_id)
) ENGINE=InnoDB;

CREATE TABLE customer_order_line (
  customer_order_line_id INTEGER PRIMARY KEY,
  customer_order_id INTEGER,
  dvd_release_id INTEGER,
  FOREIGN KEY customer_order_id REFERENCES customer_order (customer_order_id),
  FOREIGN KEY dvd_release_id REFERENCES dvd_release (dvd_release_id)
) ENGINE= InnoDB;
