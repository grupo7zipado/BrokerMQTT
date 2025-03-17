
/*
    
    SELECT VIA GENERATE

*/
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

/*
    
    SELECT VIA ID

*/
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
            -- apenas o ultimo registro com base no ultimo id
            ORDER BY dados_id DESC LIMIT 1
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
            -- apenas o ultimo registro com base no ultimo id
            ORDER BY dados_id DESC LIMIT 1 
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
            -- apenas o ultimo registro com base no ultimo id
            ORDER BY dados_id DESC LIMIT 1 
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