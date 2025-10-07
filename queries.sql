-- Check tables
SELECT * FROM client;
SELECT * FROM book;
SELECT * FROM author;
SELECT * FROM genre;
SELECT * FROM genre_book;
SELECT * FROM author_book;
SELECT * FROM checkout;

-- clients with the books they have checked out
SELECT 
    concat(c.name, ' ', c.surname) AS full_name,
    b.title,
    ch.date_taken,
    ch.deadline,
    ch.date_returned
FROM checkout ch
JOIN client c ON ch.client_id = c.client_id
JOIN book b ON ch.book_id = b.book_id;

-- books with authors
SELECT 
    b.title,
    concat(a.name, ' ', a.surname) AS full_name
FROM book b
JOIN author_book ab ON b.book_id = ab.book_id
JOIN author a ON ab.author_id = a.author_id;

-- books with genres
SELECT 
    b.title,
    g.name AS genre_name
FROM book b
JOIN genre_book gb ON b.book_id = gb.book_id
JOIN genre g ON gb.genre_id = g.genre_id;

-- books that are currently not returned
SELECT 
    concat(c.name, ' ', c.surname) AS full_name,
    b.title,
    ch.deadline
FROM checkout ch
JOIN client c ON ch.client_id = c.client_id
JOIN book b ON ch.book_id = b.book_id
WHERE ch.date_returned IS NULL;
