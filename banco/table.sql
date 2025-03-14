
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









-- --------------------------

-- (SELECT dados_valor 
--                 FROM dados 
--                 WHERE dados.esp_id = d.esp_id AND dados_tipo = 'temperatura' 
--                 ORDER BY dados_generate DESC LIMIT 1) AS temp_valor,
--                 (SELECT dados_generate
--                 FROM dados
--                 WHERE dados.esp_id = d.esp_id AND dados_tipo = 'temperatura' 
--                 ORDER BY dados_generate DESC LIMIT 1) AS temp_generate,
--                 (SELECT dados_valor 
--                 FROM dados 
--                 WHERE dados.esp_id = d.esp_id AND dados_tipo = 'bpm' 
--                 ORDER BY dados_generate DESC LIMIT 1) AS bpm_valor,
--                 (SELECT dados_generate
--                 FROM dados
--                 WHERE dados.esp_id = d.esp_id AND dados_tipo = 'bpm' 
--                 ORDER BY dados_generate DESC LIMIT 1) AS bpm_generate,
--                 (SELECT dados_valor 
--                 FROM dados 
--                 WHERE dados.esp_id = d.esp_id AND dados_tipo = 'oxigenacao' 
--                 ORDER BY dados_generate DESC LIMIT 1) AS oxig_valor,
--                 (SELECT dados_generate
--                 FROM dados
--                 WHERE dados.esp_id = d.esp_id AND dados_tipo = 'oxigenacao' 
--                 ORDER BY dados_generate DESC LIMIT 1) AS oxig_generate






SELECT
	usu.usu_id, 
    usu_nome, 
    usu_nascimento, 
    (
        SELECT esu.esp_id
        FROM usuariosEsp  esu
        WHERE usu.usu_id = esu.usu_id
        ORDER BY use_id DESC
        LIMIT 1
 	) AS esp_id,
    (SELECT esu.use_id
    FROM usuariosEsp  esu
        WHERE usu.usu_id = esu.usu_id
        ORDER BY use_id DESC
        LIMIT 1
    ) AS use_id,
    (SELECT dados_valor 
                FROM dados 
                WHERE dados.use_id = d.use_id AND dados_tipo = 'temperatura' 
                ORDER BY dados_generate DESC LIMIT 1) AS temp_valor,
                (SELECT dados_generate
                FROM dados
                WHERE dados.use_id = d.use_id AND dados_tipo = 'temperatura' 
                ORDER BY dados_generate DESC LIMIT 1) AS temp_generate,
                (SELECT dados_valor 
                FROM dados 
                WHERE dados.use_id = d.use_id AND dados_tipo = 'bpm' 
                ORDER BY dados_generate DESC LIMIT 1) AS bpm_valor,
                (SELECT dados_generate
                FROM dados
                WHERE dados.use_id = d.use_id AND dados_tipo = 'bpm' 
                ORDER BY dados_generate DESC LIMIT 1) AS bpm_generate,
                (SELECT dados_valor 
                FROM dados 
                WHERE dados.use_id = d.use_id AND dados_tipo = 'oxigenacao' 
                ORDER BY dados_generate DESC LIMIT 1) AS oxig_valor,
                (SELECT dados_generate
                FROM dados
                WHERE dados.use_id = d.use_id AND dados_tipo = 'oxigenacao' 
                ORDER BY dados_generate DESC LIMIT 1) AS oxig_generate
FROM 
	usuarios usu
;
   

SELECT
usu.usu_id, 
usu_nome, 
usu_nascimento, 
(
    SELECT esu.esp_id
    FROM usuariosEsp  esu
    WHERE usu.usu_id = esu.usu_id
    ORDER BY use_id DESC
    LIMIT 1
) AS esp_id,
(
    SELECT esu.use_id
    FROM usuariosEsp  esu
    WHERE usu.usu_id = esu.usu_id
    ORDER BY use_id DESC
    LIMIT 1
) AS use_id,
(
    SELECT dados_valor 
    FROM dados 
    WHERE dados.use_id = use_id AND dados_tipo = 'temperatura' 
    ORDER BY dados_generate DESC LIMIT 1) AS temp_valor
                
FROM 
	usuarios usu
;
   




   INSERT INTO `dados`(`use_id`, `dados_tipo`, `dados_valor`, `dados_generate`) VALUES (11,'temperatura','321','2024-10-10')





SELECT
usu.usu_id, 
usu_nome, 
usu_nascimento, 
(
    SELECT esu.esp_id
    FROM usuariosEsp  esu
    WHERE usu.usu_id = esu.usu_id
    ORDER BY use_id DESC
    LIMIT 1
) AS esp_id,
(
    SELECT esu.use_id
    FROM usuariosEsp  esu
    WHERE usu.usu_id = esu.usu_id
    ORDER BY use_id DESC
    LIMIT 1
) AS use_id,
(
    SELECT dados_valor 
    FROM dados 
    WHERE dados.use_id = use_id AND dados_tipo = 'temperatura' 
    ORDER BY dados_generate DESC LIMIT 1) AS temp_valor
                
FROM 
	usuarios usu
;
   