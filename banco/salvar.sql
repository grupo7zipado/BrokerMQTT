
    SELECT esp_id, 
        (SELECT dados_valor 
        FROM dados 
        WHERE dados.esp_id = d.esp_id AND dados_tipo = 'temperatura' 
        ORDER BY dados_generate DESC LIMIT 1) AS temp_valor,
        (SELECT dados_generate
        FROM dados
        WHERE dados.esp_id = d.esp_id AND dados_tipo = 'temperatura' 
        ORDER BY dados_generate DESC LIMIT 1) AS temp_generate,
        (SELECT dados_valor 
        FROM dados 
        WHERE dados.esp_id = d.esp_id AND dados_tipo = 'bpm' 
        ORDER BY dados_generate DESC LIMIT 1) AS bpm_valor,
        (SELECT dados_generate
        FROM dados
        WHERE dados.esp_id = d.esp_id AND dados_tipo = 'bpm' 
        ORDER BY dados_generate DESC LIMIT 1) AS bpm_generate,
        (SELECT dados_valor 
        FROM dados 
        WHERE dados.esp_id = d.esp_id AND dados_tipo = 'oxigenacao' 
        ORDER BY dados_generate DESC LIMIT 1) AS oxig_valor,
        (SELECT dados_generate
        FROM dados
        WHERE dados.esp_id = d.esp_id AND dados_tipo = 'oxigenacao' 
        ORDER BY dados_generate DESC LIMIT 1) AS oxig_generate
    FROM dados d
    GROUP BY esp_id;


-- -- -- -- --

SELECT *
FROM dados d
     INNER JOIN (SELECT esu.usu_id, MAX(d2.dados_id) dados_id
                 FROM usuariosEsp esu
                     INNER JOIN dados d2
                     ON d2.use_id = esu.use_id
                 GROUP BY esu.usu_id, d2.dados_tipo) t
     ON d.dados_id = t.dados_id
-- -- -- -- -- -- -- -- --

SELECT 
        esu.use_id, 
        esu.usu_id, 
        esu.esp_id, 
        usu.usu_nome, 
        usu.usu_nascimento,
        (
            -- seleciona o valor do dado 
            SELECT 
                dados_valor 
            FROM 
                dados dad
            WHERE 
                -- o id do ultimo relacionamento do usuario com esp
                dad.use_id = d.use_id 
                AND 
                -- tipo temperatura
                dados_tipo = 'temperatura' 
            -- apenas o ultimo registro com base quando o dado foi gerado
            ORDER BY dados_generate DESC LIMIT 1
        ) AS temp_valor,
        (
            SELECT 
                dados_valor 
            FROM 
                dados dad
            WHERE 
                -- o id do ultimo relacionamento do usuario com esp
                dad.use_id = d.use_id  
                AND 
                -- tipo bpm
                dados_tipo = 'bpm' 
            -- apenas o ultimo registro com base quando o dado foi gerado
            ORDER BY dados_generate DESC LIMIT 1 
        ) AS bpm_valor,
        (
            SELECT 
                dados_valor 
            FROM 
                dados dad 
            WHERE 
                -- o id do ultimo relacionamento do usuario com esp
                dad.use_id = d.use_id  
                AND 
                -- tipo oxigenacao
                dados_tipo = 'oxigenacao' 
            -- apenas o ultimo registro com base quando o dado foi gerado
            ORDER BY dados_generate DESC LIMIT 1 
            ) AS oxig_valor
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
        usu.usu_id 
    ;


-- -- -- 
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







SELECT 
    -- talvez não precisa trazer por prop
    -- usu_id, 
    -- esu.use_id, 
    -- esp_id, 
    -- use_status,
    -- trazer 100%
    dados_id, 
    dados_tipo, 
    dados_valor, 
    dados_generate
FROM 
    usuariosEsp esu
INNER JOIN 
    dados dad 
ON 
    esu.use_id = dad.use_id
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
-- fitrar pro id
AND 
    usu_id = 1
ORDER BY dados_generate DESC
;