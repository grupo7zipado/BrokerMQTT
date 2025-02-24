
-- CREATE TABLE teste (
--     inf_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL, 
--     esp_id INT NOT NULL,
--     inf_temperatura FLOAT NOT NULL, 
--     inf_bpm INT NOT NULL,
--     inf_oxigenacao INT NOT NULL,
--     inf_generate_time VARCHAR(100) NOT NULL, 
--     inf_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
-- );


--Vantagens registro unitario dos dados 
DROP TABLE IF EXISTS dados;
CREATE TABLE dados(
    dados_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    esp_id INT NOT NULL,
    dados_tipo ENUM("temperatura", "oxigenacao", "bpm") NOT NULL,
    dados_valor SMALLINT NOT NULL,
    dados_generate TIMESTAMP NOT NULL,
    dados_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--Vantagens preguiça
DROP TABLE IF EXISTS dados;
CREATE TABLE dados(
    dados_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    esp_id INT NOT NULL,
    dados_temperatura SMALLINT NOT NULL,
    dados_bpm SMALLINT NOT NULL,
    dados_oxigenacao SMALLINT NOT NULL,
    dados_generate TIMESTAMP NOT NULL,
    dados_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);