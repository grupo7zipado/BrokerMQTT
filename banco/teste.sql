


SELECT d.use_id, usu_nome, usu_nascimento,
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
FROM dados d
INNER JOIN usuariosesp esu ON esu.use_id = d.use_id
INNER JOIN usuarios usu ON usu.usu_id = esu.usu_id
GROUP BY use_id;