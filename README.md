# library-db
Here are my labs for database course
# Лабораторна робота 1

## 1. Вимоги для системи

### Вимоги до функціональності для клієнта (читача)

1. Система повинна надавати можливість реєстрації клієнта з обов’язковим зазначенням імені та номера телефону.  
2. Система повинна забезпечувати перегляд каталогу доступних книг з можливістю фільтрації за назвою, жанром або автором.  
3. Система повинна дозволяти клієнту брати книгу, якщо кількість одночасно взятих ним книг менше 5 і обрана книга доступна.  
4. Система повинна забезпечувати можливість повернення книги клієнтом, після чого книга має знову ставати доступною для видачі.  
5. Система повинна надавати клієнту можливість перегляду історії власних видач книг.

---

### Вимоги до функціональності для бібліотекаря

1. Система повинна забезпечувати можливість реєстрації нового клієнта.  
2. Система повинна дозволяти видачу книги клієнту з автоматичною перевіркою ліміту взятих книг та статусу доступності книги.  
3. Система повинна надавати можливість приймати повернення книги та фіксувати дату її повернення.  
4. Система повинна дозволяти перегляд списку книг, строк повернення яких минув.  
5. Система повинна забезпечувати можливість редагування даних клієнта (наприклад, зміни номера телефону).  
6. Система повинна дозволяти видалення книги лише у випадку, якщо вона не перебуває на видачі в жодного клієнта.  
7. Система повинна надавати функціонал формування звітів, включаючи списки найактивніших клієнтів та найпопулярніших книг.

---

### Вимоги до функціональності для адміністрації

1. Система повинна надавати доступ до всіх даних бібліотеки, включно з клієнтами, книгами, авторами, жанрами та історією видач.  
2. Система повинна здійснювати контроль за дотриманням правил користування бібліотекою, зокрема за лімітом книг та строками повернення.  
3. Система повинна надавати адміністрації можливість отримувати узагальнені аналітичні звіти про роботу бібліотеки.


---

## 2. Дані для зберігання

### 2.1 Сутності та їх атрибути

**Клієнт (Client)**
- ID (client_id)
- Ім’я (name)
- Прізвище (surname)
- Телефон (phone_number)

**Книга (Book)**
- ID (book_id)
- Назва (title)
- Мова (language)
- Видавництво (publisher)

**Автор (Author)**
- ID (author_id)
- Ім’я (name)
- Прізвище (surname)
- Країна (country)

**Жанр (Genre)**
- ID (genre_id)
- Назва (name)

**Видачі книг (Checkout)**
- ID (checkout_id)
- Клієнт (client_id)
- Книга (book_id)
- Дата видачі (date_taken)
- Кінцевий строк повернення (deadline)
- Дата фактичного повернення (date_returned)

**Мови (Language)**
- English
- Ukrainian
- French

---

### 2.2 Таблиці з описом ключів та основних атрибутів

**Client (Читач)**
- client_id — первинний ключ (PK)
- name — ім’я, не null
- surname — прізвище, не null
- phone_number — унікальний, не null (щоб дві людини не мали один і той самий номер)

**Book (Книга)**
- book_id — первинний ключ (PK)
- title — назва книги, не unique (може бути декілька екземплярів однієї книги, різні id)
- language — мова, не null (ENUM Language)
- publisher — видавництво, не null

**Author (Автор)**
- author_id — первинний ключ (PK)
- name — ім’я, не null
- surname — прізвище, може бути null (у випадку якщо псевдонім автора з одного слова)
- country — країна, не null

**Genre (Жанр)**
- genre_id — первинний ключ (PK)
- name — назва, унікальна, не null
- Окрема таблиця для нормалізації даних і щоб книга могла мати декілька жанрів одночасно

**Genre_Book**
- book_id, genre_id — складений первинний ключ (PK)
- Зовнішні ключі: book_id → Book, genre_id → Genre

**Author_Book**
- book_id, author_id — складений первинний ключ (PK)
- Зовнішні ключі: book_id → Book, author_id → Author

**Checkout (Видачі книг)**
- checkout_id — первинний ключ (PK)
- client_id — зовнішній ключ → Client
- book_id — зовнішній ключ → Book
- date_taken — дата видачі, не null
- deadline — кінцевий строк повернення, не null
- date_returned — дата фактичного повернення - може бути null поки книгу не повернуто

**Language (Мови)**
- ENUM: English, Ukrainian, French
- Я зробив ENUM, бо список дуже короткий і з ймовірністю майже 100% ніколи не буде змінюватися

---

### 2.3 Зв’язки
- client – checkout – book  - many <> many (Один клієнт може брати багато книг, і одна книга може бути видана багатьом клієнтам (але одночасно лише одному))
- book – author_book – author  - many <> many (Книга може мати кількох авторів, а автор може писати кілька книг)
- book – genre_book – genre  - many <> many (Книга може належати до кількох жанрів, а жанр може містити кілька книг)

---

## 3. Бізнес-правила, припущення
- Один клієнт може одночасно мати не більше 5 активних книг.
- Кожна книга може бути видана тільки одному клієнту одночасно.
- Тривалість користування книгою — 30 днів з дати видачі
- Якщо книга не повернена до дедлайну → вважається простроченою.
- Телефон клієнта має бути унікальним і відповідати формату (наприклад, +380xxxxxxxxx).
- Неможливо видалити книгу, яка знаходиться у клієнта на руках.
- У кожної книги має бути хоча б один автор та хоча б один жанр.
- Усі операції з клієнтами, книгами та видачами фіксуються для історії.
- Якщо в бібліотеці наявні декілька екземплярів однієї книги, вони будуть унікальні і розрізнятися за ідентифікатором
- Бібліотека невелика, мова книг обмежується наперед визначеним списком (English, Ukrainian, French), але за потреби перелік можна розширити

![CrowDiagram](https://github.com/user-attachments/assets/46491d63-bb15-4008-9f5d-3e7ddb8e039c)



---

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


