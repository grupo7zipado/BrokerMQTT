USE bd_tcc_des_222_sa3;  
-- SELECT
-- usu.usu_id, 
-- usu_nome, 
-- usu_nascimento, 
-- (
--     SELECT esu.esp_id
--     FROM usuariosEsp  esu
--     WHERE usu.usu_id = esu.usu_id
--     ORDER BY use_id DESC
--     LIMIT 1
-- ) AS esp_id,
-- (
--     SELECT esu.use_id
--     FROM usuariosEsp  esu
--     WHERE usu.usu_id = esu.usu_id
--     ORDER BY use_id DESC
--     LIMIT 1
-- ) AS use_id,
-- (
--     SELECT dados_valor 
--     FROM dados 
--     WHERE dados.use_id = use_id AND dados_tipo = 'temperatura' 
--     ORDER BY dados_generate DESC LIMIT 1
-- ) AS temp_valor
                
-- FROM 
-- 	usuarios usu
-- ;
   
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