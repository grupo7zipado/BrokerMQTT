
CREATE TABLE teste (
    inf_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL, 
    esp_id INT NOT NULL,
    inf_temperatura FLOAT NOT NULL, 
    inf_bpm INT NOT NULL,
    inf_oxigenacao INT NOT NULL,
    inf_generate_time VARCHAR(100) NOT NULL, 
    inf_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);