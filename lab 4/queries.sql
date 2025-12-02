-- Підрахувати кількість книг у базі.
SELECT COUNT(*) AS total_books
FROM book;

-- Знайти кількість книг для кожної мови.
SELECT language, COUNT(*) AS books_count
FROM book
GROUP BY language;

-- Показати лише ті мови, у яких більше ніж 2 книги.
SELECT language, COUNT(*) AS books_count
FROM book
GROUP BY language
HAVING COUNT(*) > 2;

-- Показати книги та їхніх видавців
SELECT b.title, p.name AS publisher
FROM book b
INNER JOIN publisher p ON p.publisher_id = b.publisher_id;

-- Показати всіх авторів і книги, навіть якщо автор не написав жодної
SELECT a.full_name, b.title
FROM author a
LEFT JOIN author_book ab ON ab.author_id = a.author_id
LEFT JOIN book b ON b.book_id = ab.book_id;

-- Знайти, скільки книг взяв кожний клієнт.
SELECT c.full_name, COUNT(ch.book_id) AS books_taken
FROM client c
JOIN checkout ch ON ch.client_id = c.client_id
GROUP BY c.full_name;
