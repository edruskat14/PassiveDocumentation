CREATE TABLE nicknames (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  owner_id INTEGER,

  FOREIGN KEY(owner_id) REFERENCES character(id)
);

CREATE TABLE characters (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255),
  house_id INTEGER,

  FOREIGN KEY(house_id) REFERENCES character(id)
);

CREATE TABLE houses (
  id INTEGER PRIMARY KEY,
  address VARCHAR(255) NOT NULL
);

INSERT INTO
  houses (id, address)
VALUES
  (1, "26th and Guerrero"),
  (2, "Dolores and Market"),
  (3, "129 W 81st Apt 5A"),
  (4, "The World"),
  (5, "Queens"),
  (6, "Apartment 5E"),
  (7, "Unknown"),
  (8, "Unknown"),
  (9, "Moving"),
  (10, "Del Boca Vista"),
  (11, "Not Jail"),
  (12, "Downtown");

INSERT INTO
  characters (id, fname, lname, house_id)
VALUES
  (1, "Rus", "El", 1),
  (2, "Carl", "Towns", 1),
  (3, "Eddy", "Brown", 2),
  (4, "Human", "Being", 4),
  (5, "Jerry", "Seinfeld", 3),
  (6, "George", "Costanza", 5),
  (7, "Elaine", "Benes", 12),
  (8, "Kramer", NULL, 3),
  (9, "Newman", NULL, 6),
  (10, "Bob", "Sacamano", 7),
  (11, "Lomez", NULL, 8),
  (12, "Keith", "Hernandez", 9),
  (13, "Jack", "Klompus", 10),
  (14, "Joel", "Rifkin", 11),
  (15, "Remi", "Rifkin", 11);

INSERT INTO
  nicknames (id, name, owner_id)
VALUES
  (1, "Rae", 1),
  (2, "Earl", 2),
  (3, "Hank", 3),
  (4, "Jeen", 4),
  (5, "Thing1", 15),
  (6, "Carlor", 7),
  (7, "Pablo", 8),
  (8, "Cat", 9),
  (9, "Steve-o", 10),
  (10, "Paws",12),
  (11, "Dog-e", 11),
  (12, "Layla", 13),
  (13, "Groko", 15),
  (14, "Charlie", 14),
  (15, "Yarn-o", 5),
  (16, "Grover", 11),
  (17, "Carrington", 14),
  (18, "Broccoli-rob", 1),
  (19, "Rex", 15),
  (20, "Birdman", 4);
