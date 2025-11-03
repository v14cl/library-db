--SELECT
SELECT * FROM client WHERE client_id = 1;
SELECT * FROM client WHERE full_name = 'Diana Prince';
SELECT * FROM client WHERE phone_number LIKE '345%';

SELECT * FROM book WHERE language = 'English';
SELECT * FROM book WHERE publisher = 'Gallimard';
SELECT * FROM book WHERE title LIKE '%Sherlock%';

SELECT * FROM author WHERE author_id = 1;
SELECT * FROM author WHERE full_name = 'Taras Shevchenko';
SELECT * FROM author WHERE full_name LIKE '%Victor%';

SELECT * FROM genre WHERE genre_id = 1;
SELECT * FROM genre WHERE name = 'Drama';
SELECT * FROM genre WHERE name LIKE '%His%';

SELECT * FROM checkout WHERE client_id = 3;
SELECT * FROM checkout WHERE date_returned IS NULL;
SELECT * FROM checkout WHERE deadline > '2025-09-20';

--INSERT
INSERT INTO client (client_id, full_name, phone_number)
VALUES (6, 'Fiona Gallagher', '678-901-2345');

INSERT INTO book (book_id, title, language, publisher)
VALUES (6, 'Crime and Punishment', 'English', 'Penguin Classics');

INSERT INTO author (author_id, full_name)
VALUES (5, 'Fyodor Dostoevsky');

INSERT INTO genre (genre_id, name)
VALUES (6, 'Science Fiction');

INSERT INTO checkout (checkout_id, client_id, book_id, date_taken, deadline, date_returned)
VALUES (6, 6, 6, '2025-10-01', '2025-10-15', NULL);

--UPDATE
UPDATE client
SET phone_number = '999-888-7777'
WHERE client_id = 2;

UPDATE book
SET publisher = 'Oxford University Press'
WHERE book_id = 3;

UPDATE author
SET full_name = 'Victor Hugo Jr.'
WHERE author_id = 1;

UPDATE genre
SET name = 'Romantic Novel'
WHERE genre_id = 1;

UPDATE checkout
SET date_returned = '2025-09-12'
WHERE checkout_id = 2;

--DELETE
DELETE FROM client
WHERE client_id = 5;

DELETE FROM book
WHERE book_id = 5;

DELETE FROM author
WHERE author_id = 4;

DELETE FROM genre
WHERE genre_id = 5;

DELETE FROM checkout
WHERE checkout_id = 5;
