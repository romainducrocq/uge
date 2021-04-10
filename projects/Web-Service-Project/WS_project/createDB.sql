CREATE DATABASE bankDB;
USE bankDB;
CREATE TABLE bank (
id INT AUTO_INCREMENT PRIMARY KEY,
card_number varchar(20),
cvv varchar(20),
expiracy_date varchar(20),
balance FLOAT,
currency varchar(20),
name varchar(255)
);

insert into bank(card_number, cvv, expiracy_date, balance, currency, name) values("0000111122223333", "4444", "May;2025", 30000.0, "USD", "Janis;Joplin");
insert into bank(card_number, cvv, expiracy_date, balance, currency, name) values("0123012301230123", "0123", "January;2021", 500000.0, "PLN", "Kurt;Cobain");
insert into bank(card_number, cvv, expiracy_date, balance, currency, name) values("0123456789101112", "1314", "December;2023", 60000.0, "EUR", "Jimi;Hendrix");

CREATE DATABASE employeeDB;
USE employeeDB;
CREATE TABLE employee (
id INT AUTO_INCREMENT PRIMARY KEY,
first_name varchar(20),
last_name varchar(20),
username varchar(20),
password varchar(20),
email varchar(30)
);


insert into employee(first_name, last_name, username, password, email) values('Natacha', 'GRUMBACH', 'ngrumbach','password','ngrumbach@gmail.com');
insert into employee(first_name, last_name, username, password, email) values('Romain', 'DUCROCQ', 'rducrocq','password','romain.g.ducrocq@gmail.com');
insert into employee(first_name, last_name, username, password, email) values('Alexandre', 'THEROND', 'atherond','password','alexandre.therond@efrei.net');


CREATE DATABASE vehiclesDB;
USE vehiclesDB;
CREATE TABLE vehicle (
id INT AUTO_INCREMENT PRIMARY KEY,
make varchar(20),
model varchar(20),
year INT,
seating_capacity INT,
fuel_type varchar(20),
transmission varchar(20),
price_euros FLOAT,
all_notes varchar(255),
last_message varchar(1000),
img_url varchar(1000),
available_for_sale TINYINT
);


insert into vehicle(make, model, year, seating_capacity, fuel_type, transmission, price_euros, all_notes, last_message, img_url, available_for_sale) values(
  'Renault',
  'Clio',
  2019,
  5,
  'Diesel',
  'Manual',
  16000,
  '',
  '',
  '',
  0
);
insert into vehicle(make, model, year, seating_capacity, fuel_type, transmission, price_euros, all_notes, last_message, img_url, available_for_sale) values(
  'Renault',
  'Clio',
  2020,
  5,
  'Gasoline',
  'Manual',
  18000,
  '',
  '',
  '',
  0
);
insert into vehicle(make, model, year, seating_capacity, fuel_type, transmission, price_euros, all_notes, last_message, img_url, available_for_sale) values(
  'Peugeot',
  '208',
  2019,
  5,
  'Diesel',
  'Manual',
  17000,
  '',
  '',
  '',
  0
);
insert into vehicle(make, model, year, seating_capacity, fuel_type, transmission, price_euros, all_notes, last_message, img_url, available_for_sale) values(
  'Peugeot',
  '308',
  2019,
  5,
  'Diesel',
  'Manual',
  22000,
  '',
  '',
  '',
  0
);
insert into vehicle(make, model, year, seating_capacity, fuel_type, transmission, price_euros, all_notes, last_message, img_url, available_for_sale) values(
  'Peugeot',
  '5008',
  2020,
  7,
  'Diesel',
  'Manual',
  26000,
  '45535',
  'The engine is silent like a Tesla, we drove all summer around Europe! What a ride!',
  'https://images.unsplash.com/photo-1562178235-7ba56b202338?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
  1
);
insert into vehicle(make, model, year, seating_capacity, fuel_type, transmission, price_euros, all_notes, last_message, img_url, available_for_sale) values(
  'Ford',
  'Mustang',
  1964,
  5,
  'Gasoline',
  'Manual',
  35000,
  '5333',
  'Real murica feeling here, ready for an adventure?',
  'https://images.unsplash.com/photo-1584345604476-8ec5e12e42dd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
  1
);
insert into vehicle(make, model, year, seating_capacity, fuel_type, transmission, price_euros, all_notes, last_message, img_url, available_for_sale) values(
  'Renault',
  '4L',
  1959,
  4,
  'Diesel',
  'Manual',
  6000,
  '232',
  'A great car, but the suspensions are tired and can get a bit bumpy.',
  'https://images.unsplash.com/photo-1489824904134-891ab64532f1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1489&q=80',
  1
);
