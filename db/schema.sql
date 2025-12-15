CREATE TABLE IF NOT EXISTS books (
id SERIAL PRIMARY KEY,
title TEXT NOT NULL,
author TEXT,
isbn TEXT UNIQUE,
published_year INT,
created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

CREATE TABLE IF NOT EXISTS members (
id SERIAL PRIMARY KEY,
name TEXT NOT NULL,
email TEXT UNIQUE,
phone TEXT,
address TEXT,
created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

CREATE TABLE IF NOT EXISTS borrow (
id SERIAL PRIMARY KEY,
book_id INT NOT NULL REFERENCES books(id),
member_id INT NOT NULL REFERENCES members(id),
borrowed_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
due_at TIMESTAMP WITH TIME ZONE,
returned_at TIMESTAMP WITH TIME ZONE,
CONSTRAINT unique_active_loan_per_book UNIQUE (book_id) WHERE returned_at IS NULL # makesure single book cant borrowed by 2 persion same time
);
CREATE INDEX IF NOT EXISTS idx_loans_member ON loans(member_id);
CREATE INDEX IF NOT EXISTS idx_loans_book ON loans(book_id);