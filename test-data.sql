INSERT INTO client (name, surname, phone_number) VALUES
('John', 'Smith', '+1234567890'),
('Anna', 'Koval', '+380991112233'),
('Pierre', 'Dupont', '+33123456789'),
('Olga', 'Ivanova', '+380501234567'),
('Michael', 'Brown', '+19876543210');

INSERT INTO book (title, language, publisher) VALUES
('Pride and Prejudice', 'English', 'Penguin Classics'),
('To Kill a Mockingbird', 'English', 'HarperCollins'),
('Лісова пісня', 'Ukrainian', 'Дніпро'),
('Кобзар', 'Ukrainian', 'Веселка'),
('Le Petit Prince', 'French', 'Gallimard');

INSERT INTO author (name, surname, country) VALUES
('Jane', 'Austen', 'United Kingdom'),
('Harper', 'Lee', 'United States'),
('Lesya', 'Ukrainka', 'Ukraine'),
('Taras', 'Shevchenko', 'Ukraine'),
('Antoine', 'de Saint-Exupéry', 'France');

INSERT INTO genre (name) VALUES
('Novel'),
('Classic'),
('Drama'),
('Poetry'),
('Children');

INSERT INTO genre_book (book_id, genre_id) VALUES
(1, 1),
(2, 1),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO author_book (book_id, author_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO checkout (client_id, book_id, date_taken, deadline, date_returned) VALUES
(1, 1, '2025-09-01', '2025-09-30', '2025-09-20'),
(2, 2, '2025-09-05', '2025-10-05', NULL),
(3, 3, '2025-09-10', '2025-10-10', '2025-10-01'),
(4, 4, '2025-09-15', '2025-10-15', NULL),
(5, 5, '2025-09-20', '2025-10-20', NULL);
