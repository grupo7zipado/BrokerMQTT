SELECT esp_id, 
       (SELECT dados_valor 
        FROM dados 
        WHERE dados.esp_id = d.esp_id AND dados_tipo = 'temperatura' 
        ORDER BY dados_generate DESC LIMIT 1) AS temp_valor
FROM dados d
GROUP BY esp_id;


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



SELECT 
    d.esp_id,
    MAX(CASE WHEN d.dados_tipo = 'temperatura' THEN d.dados_valor END) AS temp_valor,
    MAX(CASE WHEN d.dados_tipo = 'temperatura' THEN d.dados_generate END) AS temp_generate,
    MAX(CASE WHEN d.dados_tipo = 'bpm' THEN d.dados_valor END) AS bpm_valor,
    MAX(CASE WHEN d.dados_tipo = 'bpm' THEN d.dados_generate END) AS bpm_generate,
    MAX(CASE WHEN d.dados_tipo = 'oxigenacao' THEN d.dados_valor END) AS oxig_valor,
    MAX(CASE WHEN d.dados_tipo = 'oxigenacao' THEN d.dados_generate END) AS oxig_generate
FROM dados d
WHERE (d.esp_id, d.dados_generate) IN (
    SELECT esp_id, MAX(dados_generate) 
    FROM dados 
    GROUP BY esp_id, dados_tipo
)
GROUP BY d.esp_id;




	1	355
	2	355
	3	356
	4	340
	5	355
	6	359
	7	343
	8	341
	9	356
	10	341
	11	342
	12	347
	13	358
	14	350
	15	341
	16	342
	17	355