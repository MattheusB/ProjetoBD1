DROP TABLE IF EXISTS Nota_Fiscal;
DROP TABLE IF EXISTS Produto;
DROP TABLE IF EXISTS Servico;
DROP TABLE IF EXISTS Funcionario;
DROP TABLE IF EXISTS Equipamento;
DROP TABLE IF EXISTS Quarto;
DROP TABLE IF EXISTS Dependente;
DROP TABLE IF EXISTS Telefone;
DROP TABLE IF EXISTS Cliente;


CREATE TABLE IF NOT EXISTS Cliente (
	nome varchar(200) NOT NULL,
    cpf char(11) PRIMARY KEY NOT NULL,
	dataNascimento date NOT NULL,
	sexo char(1) NOT NULL,
	rua varchar(200) NOT NULL, 
	numero varchar(10) NOT NULL, 
	bairro varchar(30) NOT NULL,
	cep char(8) NOT NULL,
	email varchar(200) NOT NULL
) DEFAULT CHARSET=utf8, ENGINE INNODB;

CREATE TABLE IF NOT EXISTS Telefone (
	cpfCli char(11) NOT NULL,
	ddd char(3) NOT NULL,
	telefone varchar(9) NOT NULL,	
    
    PRIMARY KEY (ddd, telefone),
    CONSTRAINT cpfCli
		FOREIGN KEY (cpfCli) REFERENCES Cliente(cpf) ON DELETE CASCADE
) DEFAULT CHARSET=utf8, ENGINE INNODB;

CREATE TABLE IF NOT EXISTS Dependente (
	nome varchar(200) NOT NULL,
    cliente char(11) NOT NULL,
    dataNascimento Date NOT NULL,
    
    PRIMARY KEY (nome, dataNascimento),
    CONSTRAINT cliente
		FOREIGN KEY (cliente) REFERENCES Cliente(cpf) ON DELETE CASCADE
) DEFAULT CHARSET=utf8, ENGINE INNODB;

CREATE TABLE IF NOT EXISTS Quarto (
	id int PRIMARY KEY NOT NULL,
    numero char(3) UNIQUE,
    tipo varchar(100) NOT NULL,
    vista boolean,
    diaria real NOT NULL
) DEFAULT CHARSET=utf8, ENGINE INNODB;

CREATE TABLE IF NOT EXISTS Equipamento (
	quarto_id int NOT NULL,
    nome varchar(100) NOT NULL,
    
    PRIMARY KEY(quarto_id, nome),
    CONSTRAINT quarto_id
		FOREIGN KEY (quarto_id) REFERENCES Quarto(id) ON DELETE CASCADE
) DEFAULT CHARSET=utf8, ENGINE INNODB;

CREATE TABLE IF NOT EXISTS Funcionario (
	nome varchar(200) NOT NULL,
    cpf char(11) PRIMARY KEY NOT NULL,
    salario real NOT NULL,
    dataNascimento DATE NOT NULL,
    funcao varchar(100) NOT NULL
) DEFAULT CHARSET=utf8, ENGINE INNODB;

CREATE TABLE IF NOT EXISTS Servico (
	id int PRIMARY KEY NOT NULL,
    valor real NOT NULL
) DEFAULT CHARSET=utf8, ENGINE INNODB;

CREATE TABLE IF NOT EXISTS Produto (
	id int PRIMARY KEY NOT NULL,
    nome varchar(200) NOT NULL,
    descricao text NOT NULL,
    valor real NOT NULL
) DEFAULT CHARSET=utf8, ENGINE INNODB;

CREATE TABLE Nota_Fiscal(
	id_nota int PRIMARY KEY NOT NULL,
    cpfCli varchar(11) NOT NULL,
    dt_in date NOT NULL,
    dt_out date NOT NULL,
    valor real NOT NULL,
    
    CONSTRAINT cpfCliente
		FOREIGN KEY (cpfCli) REFERENCES Cliente(cpf) ON DELETE CASCADE
) DEFAULT CHARSET=utf8;





