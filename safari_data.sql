DROP TABLE IF EXISTS assignments;
DROP TABLE IF EXISTS animals;
DROP TABLE IF EXISTS enclosures;
DROP TABLE IF EXISTS staff;

CREATE TABLE staff (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    employee_number INT
);

CREATE TABLE enclosures (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    capacity INT,
    closedForMaintenance BOOLEAN
);

CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    type VARCHAR(255),
    age INT,
    enclosure_id INTEGER REFERENCES enclosures(id) NOT NULL
);

CREATE TABLE assignments (
    id SERIAL PRIMARY KEY,
    employeeId INTEGER REFERENCES staff(id) NOT NULL,
    enclosureId INTEGER REFERENCES enclosures(id) NOT NULL,
    day VARCHAR(255)
);

INSERT INTO staff (name, employee_number) VALUES ('Captain Rik', 12345);
INSERT INTO staff (name, employee_number) VALUES ('Princess Kate', 21795);
INSERT INTO staff (name, employee_number) VALUES ('Dr Maria', 18043);

INSERT INTO enclosures (name, capacity, closedForMaintenance) VALUES ('big cat field', 20, false);
INSERT INTO enclosures (name, capacity, closedForMaintenance) VALUES ('patterened animal park', 5, false);
INSERT INTO enclosures (name, capacity, closedForMaintenance) VALUES ('elephant pond', 1, true);

INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Tony', 'Tiger', 59, 1);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ('George', 'Lion', 59, 1);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Marty', 'Zebra', 23, 2);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Melman', 'Giraffe', 40 ,2);

INSERT INTO assignments (employeeId, enclosureId, day) VALUES (3, 2, 'Monday');
INSERT INTO assignments (employeeId, enclosureId, day) VALUES (1, 1, 'Tuesday');
INSERT INTO assignments (employeeId, enclosureId, day) VALUES (2, 2, 'Wednesday');
INSERT INTO assignments (employeeId, enclosureId, day) VALUES (3, 1, 'Thursday');
INSERT INTO assignments (employeeId, enclosureId, day) VALUES (1, 3, 'Friday');
INSERT INTO assignments (employeeId, enclosureId, day) VALUES (2, 1, 'Saturday');
INSERT INTO assignments (employeeId, enclosureId, day) VALUES (3, 3, 'Sunday');


-- QUERIES
-- 1. Find the names of the animals in a given enclosure

SELECT animals.name FROM animals
INNER JOIN enclosures
ON enclosures.id = animals.enclosure_id
WHERE enclosures.id = 1;

-- 2. Find the names of the staff working in a given enclosure
SELECT DISTINCT staff.name FROM staff
INNER JOIN assignments
ON staff.id = assignments.employeeId
INNER JOIN enclosures
ON assignments.enclosureId = enclosures.id
WHERE enclosures.id = 1;

-- 3. Find the names of staff working in enclosures which are closed for maintenance
SELECT DISTINCT staff.name FROM staff
INNER JOIN assignments
ON staff.id = assignments.employeeId
INNER JOIN enclosures
ON assignments.enclosureId = enclosures.id
WHERE enclosures.closedForMaintenance = true;

-- 4. Find the name of the enclosure where the oldest animal lives. If there are two animals who are the same age choose the first one alphabetically.
SELECT enclosures.name FROM enclosures
INNER JOIN animals
ON enclosures.id = animals.enclosure_id
ORDER BY animals.age DESC, animals.name ASC LIMIT 1;