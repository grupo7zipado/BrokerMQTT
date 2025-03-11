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
	(10,10)
;

