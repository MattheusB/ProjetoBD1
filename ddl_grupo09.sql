USE bd1;

DROP TABLE IF EXISTS Hospeda;
DROP TABLE IF EXISTS Reserva;
DROP TABLE IF EXISTS Telefones;
DROP TABLE IF EXISTS Dependente;
DROP TABLE IF EXISTS Nota_Fiscal;
DROP TABLE IF EXISTS Clientes;
DROP TABLE IF EXISTS Equipamento;
DROP TABLE IF EXISTS Quarto;
DROP TABLE IF EXISTS Funcionario;
DROP TABLE IF EXISTS Servico;
DROP TABLE IF EXISTS Produto;
DROP TABLE IF EXISTS ServicoLavanderia;
DROP TABLE IF EXISTS ServicoPasseioTuristico;
DROP TABLE IF EXISTS ServicoFrigobar;
DROP TABLE IF EXISTS ServicoRestaurante;
DROP TABLE IF EXISTS ServicoEstacionamento;
DROP TABLE IF EXISTS ServicoBar;

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

CREATE TABLE IF NOT EXISTS Dependente(
    cpf varchar(11) NOT NULL,
    cpfCli varchar(11) NOT NULL,
	nome varchar(200) NOT NULL,
    dataNascimento DATE NOT NULL,
    
    PRIMARY KEY (cpf, cpfCli),
    CONSTRAINT cpfCliRef
		FOREIGN KEY (cpfCli) REFERENCES Clientes(cpf) ON DELETE CASCADE
) DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS Quarto (
	id INT NOT NULL,
    numero INT NOT NULL UNIQUE,
    tipo varchar(100) NOT NULL,
    vista boolean,
    
    PRIMARY KEY(id)
) DEFAULT CHARSET=utf8; 

CREATE TABLE IF NOT EXISTS Reserva (
	cpfCli varchar(11) NOT NULL,
    idQuarto INT NOT NULL,
    data_ini DATE NOT NULL,
    data_fim DATE NOT NULL,
    
    PRIMARY KEY(cpfCli, idQuarto),
    CONSTRAINT cliRef
		FOREIGN KEY (cpfCli) REFERENCES Clientes(cpf),
	CONSTRAINT id_quarto
		FOREIGN KEY (idQuarto) REFERENCES Quarto(id)
) DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS Hospeda (
	cpfCli varchar(11) NOT NULL,
    idQuarto INT NOT NULL,
    data_ini DATE NOT NULL,
    data_fim DATE NOT NULL,
    
    PRIMARY KEY(cpfCli, idQuarto),
    CONSTRAINT cli_ref
		FOREIGN KEY (cpfCli) REFERENCES Clientes(cpf),
	CONSTRAINT idQuarto
		FOREIGN KEY (idQuarto) REFERENCES Quarto(id)
) DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS Nota_Fiscal(
	id_nota INT NOT NULL,
    id_quarto INT NOT NULL,
    cpfCli varchar(11) NOT NULL,
    dt_in DATE NOT NULL,
    dt_out DATE NOT NULL,
    valor REAL NOT NULL,
    
    PRIMARY KEY (id_nota, cpfCli, id_quarto),
    CONSTRAINT cpfCliente
		FOREIGN KEY (cpfCli) REFERENCES Clientes(cpf) ON DELETE CASCADE,
	CONSTRAINT quartoRef
		FOREIGN KEY (id_quarto) REFERENCES Quarto(id) ON DELETE CASCADE
) DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS Equipamento(
	quarto_id INT NOT NULL,
    nome varchar(100) NOT NULL,
    
    PRIMARY KEY(quarto_id, nome),
    CONSTRAINT quarto_id
		FOREIGN KEY (quarto_id) REFERENCES Quarto(id) ON DELETE CASCADE
) DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS Funcionario (
	nome varchar(100) NOT NULL,
    cpf varchar(11) NOT NULL,
    salario real NOT NULL,
    data_de_nascimento DATE NOT NULL,
    
    PRIMARY KEY(cpf)
) DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS ServicoLavanderia (
	id INT NOT NULL,
    
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS ServicoPasseioTuristico (
	id INT NOT NULL,
    
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS ServicoFrigobar (
	id INT NOT NULL,
    
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS ServicoRestaurante (
	id INT NOT NULL,
    
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS ServicoEstacionamento (
	id INT NOT NULL,
    
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS ServicoBar (
	id INT NOT NULL,
    
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS Servico (
	id INT PRIMARY KEY NOT NULL,
    valor real NOT NULL,
    id_ser_lavanderia INT,
    id_ser_passeio_tur INT, 
    id_ser_frigobar INT, 
    id_ser_restaurante INT, 
    id_ser_estacionamento INT, 
    id_ser_bar INT,
    
    CONSTRAINT id_ser_lavanderia
		FOREIGN KEY (id_ser_lavanderia) REFERENCES ServicoLavanderia(id) ON DELETE CASCADE,
        
	CONSTRAINT id_ser_passeio_tur
		FOREIGN KEY (id_ser_passeio_tur) REFERENCES ServicoPasseioTuristico(id) ON DELETE CASCADE,
        
	CONSTRAINT id_ser_frigobar
		FOREIGN KEY (id_ser_frigobar) REFERENCES ServicoFrigobar(id) ON DELETE CASCADE,
        
	CONSTRAINT id_ser_restaurante
		FOREIGN KEY (id_ser_restaurante) REFERENCES ServicoRestaurante(id) ON DELETE CASCADE,
        
	CONSTRAINT id_ser_estacionamento
		FOREIGN KEY (id_ser_estacionamento) REFERENCES ServicoEstacionamento(id) ON DELETE CASCADE,
        
	CONSTRAINT id_ser_bar
		FOREIGN KEY (id_ser_bar) REFERENCES ServicoBar(id) ON DELETE CASCADE
) DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS Produto (
	id INT NOT NULL,
    nome varchar(100) NOT NULL,
    descricao varchar(255) NOT NULL,
    valor real NOT NULL,
    
    PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;
