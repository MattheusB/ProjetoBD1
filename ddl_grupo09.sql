DROP TABLE IF EXISTS Telefones;
DROP TABLE IF EXISTS Dependente;
DROP TABLE IF EXISTS Nota_Fiscal;
DROP TABLE IF EXISTS Clientes;

CREATE TABLE IF NOT EXISTS Clientes (
	cpf char(11) PRIMARY KEY NOT NULL,
	nome varchar(200) NOT NULL,
    email varchar(200) NOT NULL,
	dataNascimento DATE NOT NULL,
	sexo char(1) NOT NULL,
	rua varchar(200) NOT NULL, 
	numero varchar(10) NOT NULL, 
	bairro varchar(30) NOT NULL,
	cep char(8) NOT NULL
) DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS Telefones (
	cpfCli char(11) NOT NULL,
	telefone varchar(9) NOT NULL,
	
    PRIMARY KEY (cpfCli, telefone),
    CONSTRAINT cpfUsr
		FOREIGN KEY (cpfCli) REFERENCES Clientes(cpf) ON DELETE CASCADE
) DEFAULT CHARSET=utf8;

CREATE TABLE Dependente(
    cpf varchar(11) NOT NULL,
    cpfCli varchar(11) NOT NULL,
	nome varchar(200) NOT NULL,
    dataNascimento DATE NOT NULL,
    
    PRIMARY KEY (cpf, cpfCli),
    CONSTRAINT cpfCliRef
		FOREIGN KEY (cpfCli) REFERENCES Clientes(cpf) ON DELETE CASCADE
) DEFAULT CHARSET=utf8;

CREATE TABLE Nota_Fiscal(
	id_nota INT NOT NULL,
    cpfCli varchar(11) NOT NULL,
    dt_in DATE NOT NULL,
    dt_out DATE NOT NULL,
    valor REAL NOT NULL,
    
    PRIMARY KEY (id_nota),
    CONSTRAINT cpfCliente
		FOREIGN KEY (cpfCli) REFERENCES Clientes(cpf) ON DELETE CASCADE
) DEFAULT CHARSET=utf8;
