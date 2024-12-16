CREATE TYPE payment AS ENUM('По карте', 'Перевод', 'Наличные');
CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE Clients (
    id INT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    passport_data BYTEA  NOT NULL
);


CREATE TABLE Payments (
    id INT PRIMARY KEY,
    payment_method payment NOT NULL,
    summa_transfer DOUBLE PRECISION NOT NULL,
    data_transfer DATE NOT NULL,
    client_id INT,
    FOREIGN KEY (client_id) REFERENCES Clients(id)
);

CREATE TABLE Cars (
    id SERIAL PRIMARY KEY,
    car_brand VARCHAR(40) NOT NULL,
    car_model VARCHAR(40) NOT NULL,
    car_color VARCHAR(40) NOT NULL,
    year INT NOT NULL,
    state_number BYTEA  NOT NULL,
    insurance_cost DOUBLE PRECISION NOT NULL,
    day_price DOUBLE PRECISION NOT NULL
);

CREATE TABLE Rentals (
    id SERIAL PRIMARY KEY,
    start_date DATE NOT NULL,
    rent_days INT NOT NULL,
    is_complete BOOLEAN NOT NULL,
    client_id INT,
    car_id INT,
    FOREIGN KEY (client_id) REFERENCES Clients(id),
    FOREIGN KEY (car_id) REFERENCES Cars(id)
);

INSERT INTO Clients (id, full_name, passport_data) VALUES
(1, 'Иван Иванов', pgp_sym_encrypt('1234 5678 9012', 'your_secret_password')),
(2, 'Петр Петров', pgp_sym_encrypt('9876 5432 1098', 'your_secret_password')),
(3, 'Светлана Светлова', pgp_sym_encrypt('1111 2222 3333', 'your_secret_password'));

INSERT INTO Payments (id, payment_method, summa_transfer, data_transfer, client_id) VALUES
(1, 'По карте', 1500.00, '2023-10-01', 1),
(2, 'Наличные', 2000.00, '2023-10-02', 2),
(3, 'Перевод', 2500.00, '2023-10-03', 3);

INSERT INTO Cars (id, car_brand, car_model, car_color, year, state_number, insurance_cost, day_price) VALUES
(1, 'Toyota', 'Camry', 'Синий', 2020, 'A123BC', 5000.00, 1500.00),
(2, 'Honda', 'Civic', 'Красный', 2019, 'B456CD', 4500.00, 1200.00),
(3, 'Ford', 'Focus', 'Черный', 2021, 'C789EF', 5500.00, 1800.00);

INSERT INTO Rentals (id, start_date, rent_days, is_complete, client_id, car_id) VALUES
(1, '2023-10-01', 5, FALSE, 1, 1),
(2, '2023-10-02', 3, TRUE, 2, 2),
(3, '2023-10-03', 7, FALSE, 3, 3);

