
SELECT *
FROM dados d
     INNER JOIN (SELECT esu.usu_id, MAX(d2.dados_id) dados_id
                 FROM usuariosEsp esu
                     INNER JOIN dados d2
                     ON d2.use_id = esu.use_id
                 GROUP BY esu.usu_id, d2.dados_tipo) t
     ON d.dados_id = t.dados_id