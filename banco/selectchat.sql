WITH ultimo_relacionamento AS (
    SELECT MAX(use_id) AS use_id
    FROM usuariosEsp
    WHERE usu_id = 2
)

SELECT 
    dad.dados_id, 
    dad.dados_tipo, 
    dad.dados_valor, 
    DATE_FORMAT(dad.dados_generate, '%d/%m/%Y') AS dados_generate
FROM 
    dados dad
INNER JOIN 
    ultimo_relacionamento ur ON ur.use_id = dad.use_id
ORDER BY 
    dad.dados_generate;

-- -- -- -- -- -- -- -- -- -- -- -- -- --
WITH ultimo_relacionamento AS (
    SELECT MAX(use_id) AS use_id
    FROM usuariosEsp
    WHERE usu_id = 2
)

SELECT 
    dad.dados_id, 
    dad.dados_tipo, 
    dad.dados_valor, 
    DATE_FORMAT(dad.dados_generate, '%d/%m/%Y') AS dados_generate
FROM 
    dados dad
INNER JOIN 
    ultimo_relacionamento ur ON ur.use_id = dad.use_id
ORDER BY 
    dad.dados_generate;


-- -- -- -- -- -- -- -- -- -- -- -- -- -- --

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
    DATE_FORMAT(dados_generate,'%d/%m/%Y %H:%i:%s') AS dados_generate
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
    usu_id = ?
ORDER BY 
    dados_generate
;


-- -- -- -- -- -- -- -- -- -- -- --

SELECT 
    esu.use_id, 
    esu.usu_id, 
    esu.esp_id, 
    usu.usu_nome, 
    DATE_FORMAT(usu.usu_nascimento,'%d/%m/%Y') AS usu_nascimento,
    
    temp.dados_valor AS temp_valor,
    bpm.dados_valor AS bpm_valor,
    oxig.dados_valor AS oxig_valor

FROM
    usuariosEsp esu

INNER JOIN 
    usuarios usu ON usu.usu_id = esu.usu_id

-- Último dado de temperatura por use_id
LEFT JOIN (
    SELECT d1.use_id, d1.dados_valor
    FROM dados d1
    INNER JOIN (
        SELECT use_id, MAX(dados_id) AS max_id
        FROM dados
        WHERE dados_tipo = 'temperatura'
        GROUP BY use_id
    ) d2 ON d1.use_id = d2.use_id AND d1.dados_id = d2.max_id
) AS temp ON temp.use_id = esu.use_id

-- Último dado de bpm por use_id
LEFT JOIN (
    SELECT d1.use_id, d1.dados_valor
    FROM dados d1
    INNER JOIN (
        SELECT use_id, MAX(dados_id) AS max_id
        FROM dados
        WHERE dados_tipo = 'bpm'
        GROUP BY use_id
    ) d2 ON d1.use_id = d2.use_id AND d1.dados_id = d2.max_id
) AS bpm ON bpm.use_id = esu.use_id

-- Último dado de oxigenação por use_id
LEFT JOIN (
    SELECT d1.use_id, d1.dados_valor
    FROM dados d1
    INNER JOIN (
        SELECT use_id, MAX(dados_id) AS max_id
        FROM dados
        WHERE dados_tipo = 'oxigenacao'
        GROUP BY use_id
    ) d2 ON d1.use_id = d2.use_id AND d1.dados_id = d2.max_id
) AS oxig ON oxig.use_id = esu.use_id

-- Último relacionamento do usuário com o ESP
WHERE 
    esu.use_id = (
        SELECT MAX(t.use_id)
        FROM usuariosEsp t
        WHERE t.usu_id = esu.usu_id
    )

GROUP BY 
    usu.usu_id;