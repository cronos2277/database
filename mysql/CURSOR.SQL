CREATE DATABASE IF NOT EXISTS exemplo_cursor;
USE exemplo_cursor;
CREATE TABLE IF NOT EXISTS exemplo_cursor.exemplo (id INT PRIMARY KEY AUTO_INCREMENT, valor1 FLOAT(10,2),valor2 FLOAT(10,2),valor3 FLOAT(10,2));
CREATE TABLE IF NOT EXISTS exemplo_cursor.processo (id INT PRIMARY KEY AUTO_INCREMENT, soma FLOAT(10,2), media FLOAT(10,2), fk int);
ALTER TABLE processo ADD CONSTRAINT fk_exemplo_processo FOREIGN KEY (fk) REFERENCES exemplo(id);
