# library-db
Here are my labs for database course
# Лабораторна робота 1

## 1. Вимоги для бд (use кейси)

### Клієнт (читач):
- Реєструється у бібліотеці, вказуючи ім’я та телефон.
- Переглядає доступні книги (за назвою, жанром, автором).
- Бере книгу (якщо ліміт < 5 і книга вільна).
- Повертає книгу, після чого вона знову стає доступною.
- Переглядає історію своїх видач.

### Бібліотекар:
- Реєструє нового клієнта.
- Видає книгу клієнту (з перевіркою ліміту та статусу книги).
- Приймає повернення книги, відмічаючи дату повернення.
- Переглядає список прострочених книг.
- Редагує дані клієнта (наприклад, телефон).
- Видаляє книгу, якщо вона не видана жодному клієнту.
- Формує звіти (найактивніші клієнти, найпопулярніші книги).

### Адміністрація:
- Переглядає всі дані (клієнти, книги, автори, жанри, історія).
- Контролює дотримання правил (ліміт книг, строки повернення).
- Отримує узагальнені звіти (аналітика по бібліотеці).

---

## 2. Дані для зберігання

### 2.1 Сутності та їх атрибути

**Читач (Client)**
- ID
- Ім’я (full_name)
- Телефон (phone_number)

**Книга (Book)**
- ID
- Назва (title)
- Мова (language)
- Видавництво (publisher)

**Автор (Author)**
- ID
- Ім’я (full_name)

**Жанр (Genre)**
- ID
- Назва (name)

**Видачі книг (Checkout)**
- ID
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

### 2.2 Таблиці з описом ключів та атрибутів

**Client (Читач)**
- client_id — первинний ключ (PK)
- full_name — ім’я, не null
- phone_number — унікальний, не null (перевірка, бо важливо щоб дві людини не мали в базі один і той самий номер)

**Book (Книга)**
- book_id — первинний ключ (PK)
- title — назва книги, не unique (бо може бути декілька екземплярів однієї книги, але в базі ми зможемо їх вирізняти за id)
- language — мова, не null (ENUM Language)
- publisher — видавництво, не null

**Author (Автор)**
- author_id — первинний ключ (PK)
- full_name — ім’я, не null

**Genre (Жанр)**
- genre_id — первинний ключ (PK)
- name — назва, унікальна, не null
- Окрема таблиця для нормалізації даних, також це дає книзі важливу змогу мати декілька жанрів одночасно

**Genre_Book**
- book_id, genre_id — складений первинний ключ (PK)
- Зовнішні ключі: book_id → Book, genre_id → Genre

**Author_Book**
- book_id, author_id — складений первинний ключ (PK)
- Зовнішні ключі: book_id → Book, author_id → Author

**Checkout (Видачі книг)**
- checkout_id — первинний ключ (PK, є окремим, а не складеним, бо якщо людина бере якусь книгу вдруге, то у ключі клієнт і книга вже не будуть унікальними)
- client_id — зовнішній ключ → Client
- book_id — зовнішній ключ → Book
- date_taken — дата видачі, не null
- deadline — кінцевий строк повернення, не null
- date_returned — дата фактичного повернення

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

<img width="1280" height="428" alt="image" src="https://github.com/user-attachments/assets/471da825-1bfc-43bd-9968-58d425ecc91c" />


---

# Лабораторна робота 2

## SQL скрипти
```sql
CREATE TYPE "Language" AS ENUM (
  'English',
  'Ukrainian',
  'French'
);

CREATE TABLE "client" (
  "client_id" integer PRIMARY KEY,
  "full_name" varchar NOT NULL,
  "phone_number" varchar UNIQUE NOT NULL
);

CREATE TABLE "checkout" (
  "checkout_id" integer PRIMARY KEY,
  "client_id" integer,
  "book_id" integer,
  "date_taken" date NOT NULL,
  "deadline" date NOT NULL,
  "date_returned" date
);

CREATE TABLE "book" (
  "book_id" integer PRIMARY KEY,
  "title" varchar NOT NULL,
  "language" "Language" NOT NULL,
  "publisher" varchar NOT NULL
);

CREATE TABLE "author" (
  "author_id" integer PRIMARY KEY,
  "full_name" varchar NOT NULL
);

CREATE TABLE "genre" (
  "genre_id" integer PRIMARY KEY,
  "name" varchar UNIQUE NOT NULL
);

CREATE TABLE "genre_book" (
  "book_id" integer,
  "genre_id" integer,
  PRIMARY KEY ("book_id", "genre_id")
);

CREATE TABLE "author_book" (
  "book_id" integer,
  "author_id" integer,
  PRIMARY KEY ("book_id", "author_id")
);

ALTER TABLE "checkout" ADD FOREIGN KEY ("client_id") REFERENCES "client" ("client_id");

ALTER TABLE "checkout" ADD FOREIGN KEY ("book_id") REFERENCES "book" ("book_id");

ALTER TABLE "genre_book" ADD FOREIGN KEY ("book_id") REFERENCES "book" ("book_id");

ALTER TABLE "genre_book" ADD FOREIGN KEY ("genre_id") REFERENCES "genre" ("genre_id");

ALTER TABLE "author_book" ADD FOREIGN KEY ("book_id") REFERENCES "book" ("book_id");

ALTER TABLE "author_book" ADD FOREIGN KEY ("author_id") REFERENCES "author" ("author_id");
```

2. Таблиці з описом ключів та атрибутів

Client (Читач)

client_id — первинний ключ (PK)

full_name — ім’я, не null

phone_number — унікальний, не null (перевірка, бо важливо щоб дві людини не мали в базі один і той самий номер)

Book (Книга)

book_id — первинний ключ (PK)

title — назва книги, не unique (бо може бути декілька екземплярів однієї книги, але в базі ми зможемо їх вирізняти за id)

language — мова, не null (ENUM Language)

publisher — видавництво, не null

Author (Автор)

author_id — первинний ключ (PK)

full_name — ім’я, не null

Genre (Жанр)

genre_id — первинний ключ (PK)

name — назва, унікальна, не null

Окрема таблиця для нормалізації даних, також це дає книзі важливу змогу мати декілька жанрів одночасно

Genre_Book

book_id, genre_id — складений первинний ключ (PK)

Зовнішні ключі: book_id → Book, genre_id → Genre

Author_Book

book_id, author_id — складений первинний ключ (PK)

Зовнішні ключі: book_id → Book, author_id → Author

Checkout (Видачі книг)

checkout_id — первинний ключ (PK, є окремим, а не складеним, бо якщо людина бере якусь книгу вдруге, то у ключі клієнт і книга вже не будуть унікальними)

client_id — зовнішній ключ → Client

book_id — зовнішній ключ → Book

date_taken — дата видачі, не null

deadline — кінцевий строк повернення, не null

date_returned — дата фактичного повернення

Language (Мови)

ENUM: English, Ukrainian, French

Я зробив ENUM, бо список дуже короткий і з ймовірністю майже 100% ніколи не буде змінюватися

3. Скріншоти результатів запиту (більше у queries.sql)
<img width="684" height="397" alt="image_2025-09-22_19-19-35" src="https://github.com/user-attachments/assets/8838c395-2e4b-4ee0-aeb4-91374b9d633f" />
<img width="475" height="397" alt="image_2025-09-22_19-19-59" src="https://github.com/user-attachments/assets/6ee9b646-bcdc-4c9b-accf-ea55f592fdcb" />
<img width="474" height="420" alt="image_2025-09-22_19-20-15" src="https://github.com/user-attachments/assets/3b039b6d-61a5-4661-9b28-d13b1b0f1892" />


