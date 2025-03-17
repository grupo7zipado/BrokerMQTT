
DROP TABLE dados;
-- DROP TABLE useStatus;
DROP TABLE usuariosEsp;
DROP TABLE esp;
DROP TABLE usuarios;
-- tabela sobre os esp
-- permite autentificaão do esp
CREATE TABLE esp(
	esp_id INT PRIMARY KEY AUTO_INCREMENT,
	esp_mac VARCHAR(17) NOT NULL,
	esp_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
	-- usar tls/ssl ou user/pass
);
-- tabela sobre os usuários
CREATE TABLE usuarios(
	usu_id INT PRIMARY KEY   AUTO_INCREMENT,
    usu_nome VARCHAR(128),
    usu_nascimento DATE NOT NULL,
	usu_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- tabela que relaciona os esp ao usuário
CREATE TABLE usuariosEsp(
	use_id INT PRIMARY KEY AUTO_INCREMENT,
    esp_id INT NOT NULL,
    usu_id INT NOT NULL,
    use_status BIT NOT NULL DEFAULT 0,
    use_lastStatus TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    use_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (esp_id) REFERENCES esp(esp_id),
	FOREIGN KEY (usu_id) REFERENCES usuarios(usu_id) 
);
-- guarda os dados do usuario
CREATE TABLE dados(
    dados_id INT PRIMARY KEY AUTO_INCREMENT ,
    use_id INT NOT NULL,
    dados_tipo ENUM("temperatura", "oxigenacao", "bpm") NOT NULL,
    dados_valor VARCHAR(32) NOT NULL,
    dados_generate TIMESTAMP NOT NULL,
    dados_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (use_id) REFERENCES usuariosEsp(use_id)
);


INSERT INTO 
	usuarios(usu_nome, usu_nascimento)
VALUES
	("José Manga", "2001-12-25"),
	("Arnaldo Miguel da Silva", "2000-04-01"),
    ("Bruno Henrique dos Santos", "1998-07-15"),
    ("Camila Fernanda Oliveira", "2001-12-03"),
    ("Diego Rafael Lima", "1995-09-27"),
    ("Eduarda Cristina Mendes", "1999-06-10"),
    ("Fernando Augusto Pereira", "2002-02-18"),
    ("Gabriela Nunes de Souza", "1997-11-22"),
    ("Henrique Matheus Rocha", "2000-08-05"),
    ("Isabela Vitória Cardoso", "1996-05-30")
;

INSERT INTO 
	esp(esp_mac)
VALUES
	("00:14:22:01:23:45"), 
	("A2:B4:C6:D8:E0:F2"),  
    ("1A:2B:3C:4D:5E:6F"),   
    ("3E:7F:9A:BC:DE:F0"),  
    ("10:32:54:76:98:BA"),  
    ("5C:AF:3E:8D:91:02"),  
    ("D0:57:92:1B:3C:4E"),  
    ("FA:CE:12:34:56:78"),  
    ("7B:3D:5F:8A:92:AC"),  
    ("C4:D2:E1:F0:3B:9A")  
;


INSERT INTO 
	usuariosEsp( usu_id, esp_id)
VALUES
	(1,1),
	(2,2),
	(3,3),
	(4,4),
	(5,5),
	(6,6),
	(7,7),
	(8,8),
	(9,9),
	(10,10),
    (3,4),
    (4,5),
    (4,4)
;

INSERT INTO dados( use_id, dados_tipo, dados_valor, dados_generate)
VALUES
    ( 1,"temperatura", "1", "2025-03-03 12:00:00"),
    ( 2,"temperatura", "2", "2025-03-03 12:00:00"),
    ( 3,"temperatura", "3", "2025-03-03 12:00:00"),
    ( 4,"temperatura", "4", "2025-03-03 12:00:00"),
    ( 5,"temperatura", "5", "2025-03-03 12:00:00"),
    ( 6,"temperatura", "6", "2025-03-03 12:00:00"),
    ( 7,"temperatura", "7", "2025-03-03 12:00:00"),
    ( 8,"temperatura", "8", "2025-03-03 12:00:00"),
    ( 9,"temperatura", "9", "2025-03-03 12:00:00"),
    ( 10,"temperatura", "10", "2025-03-03 12:00:00"),
    ( 11,"temperatura", "11", "2025-03-03 12:00:00"),
    ( 12,"temperatura", "12", "2025-03-03 12:00:00"),
    ( 13,"temperatura", "13", "2025-03-03 12:00:00"),
    ( 1, "bpm", "14", "2025-03-03 12:00:00"),
    ( 2, "bpm", "15", "2025-03-03 12:00:00"),
    ( 3, "bpm", "16", "2025-03-03 12:00:00"),
    ( 4, "bpm", "17", "2025-03-03 12:00:00"),
    ( 5, "bpm", "18", "2025-03-03 12:00:00"),
    ( 6, "bpm", "19", "2025-03-03 12:00:00"),
    ( 7, "bpm", "20", "2025-03-03 12:00:00"),
    ( 8, "bpm", "21", "2025-03-03 12:00:00"),
    ( 9, "bpm", "22", "2025-03-03 12:00:00"),
    ( 10, "bpm", "23", "2025-03-03 12:00:00"),
    ( 11, "bpm", "24", "2025-03-03 12:00:00"),
    ( 12, "bpm", "25", "2025-03-03 12:00:00"),
    ( 13, "bpm", "26", "2025-03-03 12:00:00"),
    ( 1, "oxigenacao", "27", "2025-03-03 12:00:00"),
    ( 2, "oxigenacao", "28", "2025-03-03 12:00:00"),
    ( 3, "oxigenacao", "29", "2025-03-03 12:00:00"),
    ( 4, "oxigenacao", "30", "2025-03-03 12:00:00"),
    ( 5, "oxigenacao", "31", "2025-03-03 12:00:00"),
    ( 6, "oxigenacao", "32", "2025-03-03 12:00:00"),
    ( 7, "oxigenacao", "33", "2025-03-03 12:00:00"),
    ( 8, "oxigenacao", "34", "2025-03-03 12:00:00"),
    ( 9, "oxigenacao", "35", "2025-03-03 12:00:00"),
    ( 10, "oxigenacao", "36", "2025-03-03 12:00:00"),
    ( 11, "oxigenacao", "37", "2025-03-03 12:00:00"),
    ( 12, "oxigenacao", "38", "2025-03-03 12:00:00"),
    ( 13, "oxigenacao", "39", "2025-03-03 12:00:00"),
    ( 1,"temperatura", "40", "2025-03-03 13:00:00"),
    ( 2,"temperatura", "41", "2025-03-03 13:00:00"),
    ( 3,"temperatura", "42", "2025-03-03 13:00:00"),
    ( 4,"temperatura", "43", "2025-03-03 13:00:00"),
    ( 5,"temperatura", "44", "2025-03-03 13:00:00"),
    ( 6,"temperatura", "45", "2025-03-03 13:00:00"),
    ( 7,"temperatura", "46", "2025-03-03 13:00:00"),
    ( 8,"temperatura", "47", "2025-03-03 13:00:00"),
    ( 9,"temperatura", "48", "2025-03-03 13:00:00"),
    ( 10,"temperatura", "49", "2025-03-03 13:00:00"),
    ( 11,"temperatura", "50", "2025-03-03 13:00:00"),
    ( 12,"temperatura", "51", "2025-03-03 13:00:00"),
    ( 13,"temperatura", "52", "2025-03-03 13:00:00"),
    ( 1, "bpm", "53", "2025-03-03 13:00:00"),
    ( 2, "bpm", "54", "2025-03-03 13:00:00"),
    ( 3, "bpm", "55", "2025-03-03 13:00:00"),
    ( 4, "bpm", "56", "2025-03-03 13:00:00"),
    ( 5, "bpm", "57", "2025-03-03 13:00:00"),
    ( 6, "bpm", "58", "2025-03-03 13:00:00"),
    ( 7, "bpm", "59", "2025-03-03 13:00:00"),
    ( 8, "bpm", "60", "2025-03-03 13:00:00"),
    ( 9, "bpm", "61", "2025-03-03 13:00:00"),
    ( 10, "bpm", "62", "2025-03-03 13:00:00"),
    ( 11, "bpm", "63", "2025-03-03 13:00:00"),
    ( 12, "bpm", "64", "2025-03-03 13:00:00"),
    ( 13, "bpm", "65", "2025-03-03 13:00:00"),    -- <=== Lembra de tirar  a virgula 
    
    ( 1,"temperatura", "66", "2025-03-03 14:00:00"),
    ( 2,"temperatura", "67", "2025-03-03 14:00:00"),
    ( 3,"temperatura", "68", "2025-03-03 14:00:00"),
    ( 4,"temperatura", "69", "2025-03-03 14:00:00"),
    ( 5,"temperatura", "70", "2025-03-03 14:00:00"),
    ( 6,"temperatura", "71", "2025-03-03 14:00:00"),
    ( 7,"temperatura", "72", "2025-03-03 14:00:00"),
    ( 8,"temperatura", "73", "2025-03-03 14:00:00"),
    ( 9,"temperatura", "74", "2025-03-03 14:00:00"),
    ( 10,"temperatura", "75", "2025-03-03 14:00:00"),
    ( 11,"temperatura", "76", "2025-03-03 14:00:00"),
    ( 12,"temperatura", "77", "2025-03-03 14:00:00"),
    ( 13,"temperatura", "78", "2025-03-03 14:00:00"), -- <=== Lembra de tirar  a virgula

    -- Corta aqui 
    ( 1, "bpm", "79", "2025-03-03 14:00:00"),
    ( 2, "bpm", "80", "2025-03-03 14:00:00"),
    ( 3, "bpm", "81", "2025-03-03 14:00:00"),
    ( 4, "bpm", "82", "2025-03-03 14:00:00"),
    ( 5, "bpm", "83", "2025-03-03 14:00:00"),
    ( 6, "bpm", "84", "2025-03-03 14:00:00"),
    ( 7, "bpm", "85", "2025-03-03 14:00:00"),
    ( 8, "bpm", "86", "2025-03-03 14:00:00"),
    ( 9, "bpm", "87", "2025-03-03 14:00:00"),
    ( 10, "bpm", "88", "2025-03-03 14:00:00"),
    ( 11, "bpm", "89", "2025-03-03 14:00:00"),
    ( 12, "bpm", "90", "2025-03-03 14:00:00"),
    ( 13, "bpm", "91", "2025-03-03 14:00:00")

