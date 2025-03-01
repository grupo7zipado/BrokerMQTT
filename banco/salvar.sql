SELECT esp_id, 
       (SELECT dados_valor 
        FROM dados 
        WHERE dados.esp_id = d.esp_id AND dados_tipo = 'temperatura' 
        ORDER BY dados_generate DESC LIMIT 1) AS temperatura 
FROM dados d
GROUP BY esp_id;


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