# Лабораторна робота 2

## SQL скрипти
```sql
CREATE TYPE Language AS ENUM ('English', 'Ukrainian', 'French');

CREATE TABLE client (
    client_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    surname VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE book (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    language Language NOT NULL,
    publisher VARCHAR(255) NOT NULL
);

CREATE TABLE author (
    author_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    surname VARCHAR(255),
    country VARCHAR(255) NOT NULL
);

CREATE TABLE genre (
    genre_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE genre_book (
    book_id INTEGER NOT NULL,
    genre_id INTEGER NOT NULL,
    PRIMARY KEY (book_id, genre_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genre(genre_id) ON DELETE CASCADE
);

CREATE TABLE author_book (
    book_id INTEGER NOT NULL,
    author_id INTEGER NOT NULL,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES author(author_id) ON DELETE CASCADE
);

CREATE TABLE checkout (
    checkout_id SERIAL PRIMARY KEY,
    client_id INTEGER NOT NULL,
    book_id INTEGER NOT NULL,
    date_taken DATE NOT NULL,
    deadline DATE NOT NULL,
    date_returned DATE,
    FOREIGN KEY (client_id) REFERENCES client(client_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES book(book_id) ON DELETE CASCADE
);
```
2. Скріншоти результатів запиту (більше у queries.sql)
<img width="684" height="397" alt="image_2025-09-22_19-19-35" src="https://github.com/user-attachments/assets/8838c395-2e4b-4ee0-aeb4-91374b9d633f" />
<img width="475" height="397" alt="image_2025-09-22_19-19-59" src="https://github.com/user-attachments/assets/6ee9b646-bcdc-4c9b-accf-ea55f592fdcb" />
<img width="474" height="420" alt="image_2025-09-22_19-20-15" src="https://github.com/user-attachments/assets/3b039b6d-61a5-4661-9b28-d13b1b0f1892" />


