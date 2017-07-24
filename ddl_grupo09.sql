DROP TABLE IF EXISTS Avalia;
DROP TABLE IF EXISTS Hospeda;
DROP TABLE IF EXISTS Reserva;
DROP TABLE IF EXISTS Telefones;
DROP TABLE IF EXISTS Dependente;
DROP TABLE IF EXISTS Nota_Fiscal;
DROP TABLE IF EXISTS Clientes;
DROP TABLE IF EXISTS Equipamento;
DROP TABLE IF EXISTS Vende;
DROP TABLE IF EXISTS Quarto;
DROP TABLE IF EXISTS Prestados;
DROP TABLE IF EXISTS Funcionario;
DROP TABLE IF EXISTS Servico;
DROP TABLE IF EXISTS Produto;

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

CREATE TABLE IF NOT EXISTS Servico (
	id INT NOT NULL,
    valor real NOT NULL,
    
    PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS Prestados (
	cpfFunc varchar(11) NOT NULL,
    idServico INT NOT NULL,
    
    PRIMARY KEY(cpfFunc, idServico),
    CONSTRAINT cpfFunc
		FOREIGN KEY (cpfFunc) REFERENCES Funcionario(cpf) ON DELETE CASCADE,
	CONSTRAINT idServico
		FOREIGN KEY (idServico) REFERENCES Servico(id) ON DELETE CASCADE
) DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS Avalia (
	cpfCli varchar(11) NOT NULL,
    idServico INT NOT NULL,
    nota real NOT NULL,
    comentario varchar(255),
    
    PRIMARY KEY(cpfCli, idServico),
    CONSTRAINT cpf_cli
		FOREIGN KEY (cpfCli) REFERENCES Clientes(cpf) ON DELETE CASCADE,
	CONSTRAINT id_servico
		FOREIGN KEY (idServico) REFERENCES Servico(id) ON DELETE CASCADE
) DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS Produto (
	id INT NOT NULL,
    nome varchar(100) NOT NULL,
    descricao varchar(255) NOT NULL,
    valor real NOT NULL,
    
    PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS Vende (
	idProduto INT NOT NULL,
    idQuarto INT NOT NULL,
    dataVenda DATE NOT NULL,
    quantidade INT NOT NULL,
    
    PRIMARY KEY (idProduto, idQuarto),
    CONSTRAINT id_produto
		FOREIGN KEY (idProduto) REFERENCES Produto(id) ON DELETE CASCADE,
	CONSTRAINT id_quarto_ref
		FOREIGN KEY (idQuarto) REFERENCES Quarto(id) ON DELETE CASCADE
) DEFAULT CHARSET=utf8;
