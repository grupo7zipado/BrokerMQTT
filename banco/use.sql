USE bd_tcc_des_222_sa3;  
SELECT d.use_id, esu.usu_id, esp_id, usu_nome, usu_nascimento,
    (SELECT dados_valor 
    FROM dados 
    WHERE dados.use_id = d.use_id AND dados_tipo = 'temperatura' 
    ORDER BY dados_generate DESC LIMIT 1) AS temp_valor,
    (SELECT dados_valor 
    FROM dados 
    WHERE dados.use_id = d.use_id AND dados_tipo = 'bpm' 
    ORDER BY dados_generate DESC LIMIT 1) AS bpm_valor,
    (SELECT dados_valor 
    FROM dados 
    WHERE dados.use_id = d.use_id AND dados_tipo = 'oxigenacao' 
    ORDER BY dados_generate DESC LIMIT 1) AS oxig_valor

FROM dados d
INNER JOIN usuariosEsp esu ON esu.use_id = d.use_id
INNER JOIN usuarios usu ON usu.usu_id = esu.usu_id
GROUP BY use_id;



SELECT d.use_id, esu.usu_id, esp_id, usu_nome, usu_nascimento,
    (SELECT dados_valor 
    FROM dados 
    WHERE dados.use_id = d.use_id AND dados_tipo = 'temperatura' 
    ORDER BY dados_generate DESC LIMIT 1) AS temp_valor,
    (SELECT dados_valor 
    FROM dados 
    WHERE dados.use_id = d.use_id AND dados_tipo = 'bpm' 
    ORDER BY dados_generate DESC LIMIT 1) AS bpm_valor,
    (SELECT dados_valor 
    FROM dados 
    WHERE dados.use_id = d.use_id AND dados_tipo = 'oxigenacao' 
    ORDER BY dados_generate DESC LIMIT 1) AS oxig_valor
FROM dados d
INNER JOIN usuariosEsp esu ON esu.use_id = d.use_id 
INNER JOIN usuarios usu ON usu.usu_id = esu.usu_id
GROUP BY usu_id;


SELECT das.use_id, esu.usu_id, esp_id, usu_nome, usu_nascimento
FROM usuariosEsp esu
INNER JOIN usuarios usu ON usu.usu_id = esu.usu_id
GROUP BY usu_id DESC



SELECT esu.use_id, esu.usu_id, esu.esp_id, usu.usu_nome, usu.usu_nascimento,
    (SELECT dados_valor 
    FROM dados 
    WHERE dados.use_id = d.use_id AND dados_tipo = 'temperatura' 
    ORDER BY dados_generate DESC LIMIT 1) AS temp_valor,
    (SELECT dados_valor 
    FROM dados 
    WHERE dados.use_id = d.use_id AND dados_tipo = 'bpm' 
    ORDER BY dados_generate DESC LIMIT 1) AS bpm_valor,
    (SELECT dados_valor 
    FROM dados 
    WHERE dados.use_id = d.use_id AND dados_tipo = 'oxigenacao' 
    ORDER BY dados_generate DESC LIMIT 1) AS oxig_valor
FROM usuariosEsp esu
INNER JOIN usuarios usu ON usu.usu_id = esu.usu_id
INNER JOIN dados d ON d.use_id = esu.use_id
WHERE esu.use_id = (
    SELECT MAX(use_id) 
    FROM usuariosEsp 
    WHERE usu_id = esu.usu_id
)
ORDER BY esu.use_id DESC;









-----------------------------------------------------------------------

-- VALIDADO MAS BUGADO
SELECT esu.use_id, esu.usu_id, esu.esp_id, usu.usu_nome, usu.usu_nascimento,
    (SELECT dados_valor 
    FROM dados dad
    WHERE dad.use_id = d.use_id AND dados_tipo = 'temperatura' 
    ORDER BY dados_generate DESC LIMIT 1) AS temp_valor,
    (SELECT dados_valor 
    FROM dados dad
    WHERE dad.use_id = d.use_id AND dados_tipo = 'bpm' 
    ORDER BY dados_generate DESC LIMIT 1) AS bpm_valor,
    (SELECT dados_valor 
    FROM dados dad 
    WHERE dad.use_id = d.use_id AND dados_tipo = 'oxigenacao' 
    ORDER BY dados_generate DESC LIMIT 1) AS oxig_valor
FROM usuariosEsp esu
INNER JOIN usuarios usu ON usu.usu_id = esu.usu_id
INNER JOIN dados d ON d.use_id = esu.use_id
WHERE esu.use_id = (
    SELECT MAX(use_id) 
    FROM usuariosEsp t
    WHERE t.usu_id = esu.usu_id
)
GROUP BY usu.usu_id;


SELECT *
FROM dados d
     INNER JOIN (SELECT esu.usu_id, MAX(d2.dados_id) dados_id
                 FROM usuariosEsp esu
                     INNER JOIN dados d2
                     ON d2.use_id = esu.use_id
                 GROUP BY esu.usu_id, d2.dados_tipo) t
     ON d.dados_id = t.dados_id
;



SELECT TOP 1 esu.use_id-- , esu.usu_id, esu.esp_id, usu.usu_nome, usu.usu_nascimento,
    -- (SELECT dados_valor 
    -- FROM dados 
    -- WHERE dados.use_id = d.use_id AND dados_tipo = 'temperatura' 
    -- ORDER BY dados_generate DESC LIMIT 1) AS temp_valor,
    -- (SELECT dados_valor 
    -- FROM dados 
    -- WHERE dados.use_id = d.use_id AND dados_tipo = 'bpm' 
    -- ORDER BY dados_generate DESC LIMIT 1) AS bpm_valor,
    -- (SELECT dados_valor 
    -- FROM dados 
    -- WHERE dados.use_id = d.use_id AND dados_tipo = 'oxigenacao' 
    -- ORDER BY dados_generate DESC LIMIT 1) AS oxig_valor
FROM usuariosEsp esu
-- INNER JOIN usuarios usu ON usu.usu_id = esu.usu_id
-- INNER JOIN dados d ON d.use_id = esu.use_id
-- WHERE esu.use_id = (
--     SELECT MAX(use_id) 
--     FROM usuariosEsp t
--     -- WHERE t.usu_id = esu.usu_id
-- )
ORDER BY esu.use_id DESC
-- GROUP BY usu.usu_id;

-- SELECT *
-- FROM usuarios usu,
--      LATERAL (SELECT *
--               FROM usuariosEsp esu
--                    INNER JOIN dados d
--                    ON d.use_id = esu.use_id
--               WHERE esu.usu_id = usu.usu_id
--               ORDER BY esu.use_id DESC
--               LIMIT 1) AS t

-- SELECT *
--       ,(SELECT *
--         FROM usuariosEsp esu
--              INNER JOIN dados d
--              ON d.use_id = esu.use_id
--         WHERE esu.usu_id = usu.usu_id
--         ORDER BY esu.use_id DESC
--         LIMIT 1)
-- FROM usuarios usu


-- SELECT esu.usu_id, MAX(d2.use_id)
-- FROM usuariosEsp esu
--      INNER JOIN dados d2
--      ON d2.use_id = esu.use_id
-- GROUP BY esu.usu_id



-- VALIDADO MAS BUGADO
SELECT esu.use_id, esu.usu_id, esu.esp_id, usu.usu_nome, usu.usu_nascimento,
    (SELECT dados_valor 
    FROM dados dad
    WHERE dad.use_id = d.use_id AND dados_tipo = 'temperatura' 
    ORDER BY dados_generate DESC LIMIT 1) AS temp_valor,
    (SELECT dados_valor 
    FROM dados dad
    WHERE dad.use_id = d.use_id AND dados_tipo = 'bpm' 
    ORDER BY dados_generate DESC LIMIT 1) AS bpm_valor,
    (SELECT dados_valor 
    FROM dados dad 
    WHERE dad.use_id = d.use_id AND dados_tipo = 'oxigenacao' 
    ORDER BY dados_generate DESC LIMIT 1) AS oxig_valor
FROM usuariosEsp esu
INNER JOIN usuarios usu ON usu.usu_id = esu.usu_id
INNER JOIN dados d ON d.use_id = esu.use_id
WHERE esu.use_id = (
    SELECT MAX(use_id) 
    FROM usuariosEsp t
    WHERE t.usu_id = esu.usu_id
)
GROUP BY usu.usu_id;















-- --  
SELECT *
FROM dados d
     INNER JOIN (SELECT esu.usu_id, MAX(d2.dados_id) dados_id
                 FROM usuariosEsp esu
                     INNER JOIN dados d2
                     ON d2.use_id = esu.use_id
                 GROUP BY esu.usu_id, d2.dados_tipo) t
     ON d.dados_id = t.dados_id


-- -- 
SELECT 
	esu.use_id, 
        esu.usu_id, 
        esu.esp_id, 
        usu.usu_nome, 
        usu.usu_nascimento
    FROM 
        usuariosEsp esu
    INNER JOIN 
        usuarios usu 
    ON 
        -- pega os dados do usuario
        usu.usu_id = esu.usu_id 
    INNER JOIN 
        dados d 
    ON 
        -- pega os dados dos dados
        d.use_id = esu.use_id 
    WHERE 
        -- pega o ultimo relacionamento esp <> usuario
        esu.use_id = ( 
            SELECT 
                MAX(use_id) 
            FROM 
                usuariosEsp t
            WHERE 
                t.usu_id = esu.usu_id
        )
    -- organiza pelos usuarios
    GROUP BY 
        usu.usu_id;