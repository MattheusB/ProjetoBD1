DROP TABLE IF EXISTS Clientes;
DROP TABLE IF EXISTS Telefones;

CREATE TABLE IF NOT EXISTS Clientes (
	cpf char(11) PRIMARY KEY NOT NULL,
	nome varchar(200) NOT NULL,
	dataNascimento DATE NOT NULL,
	sexo char(1) NOT NULL,
	rua varchar(200) NOT NULL, 
	numero varchar(10) NOT NULL, 
	bairro varchar(30) NOT NULL,
	cep char(8) NOT NULL
) DEFAULT CHARSET=utf8, ENGINE INNODB;

CREATE TABLE IF NOT EXISTS Telefones (
	cpf char(11) NOT NULL,
	ddd char(3) NOT NULL,
	telefone varchar(9) NOT NULL,
	
    PRIMARY KEY (ddd, telefone),
    CONSTRAINT cliente_telefone
		FOREIGN KEY (cpf) REFERENCES Clientes(cpf) ON DELETE CASCADE
) ENGINE INNODB;

-- INSERT INTO Clientes VALUES('11445733439', 
--                               'Lucas Henrique',
--                               '1997-04-04',
--                               'M', 
--                               'Rua 1', 
--                               '1400', 
--                               'Universitário',
--                               '55750000');
-- 
INSERT INTO Telefones VALUES(
	'11445733439', '081', '9999999'
);