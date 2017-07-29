USE bd1;

DROP TABLE Hospeda CASCADE CONSTRAINTS;
DROP TABLE Reserva CASCADE CONSTRAINTS;
DROP TABLE Telefones;
DROP TABLE Dependente CASCADE CONSTRAINTS;
DROP TABLE Nota_Fiscal CASCADE CONSTRAINTS;
DROP TABLE Clientes CASCADE CONSTRAINTS;
DROP TABLE Equipamento CASCADE CONSTRAINTS;
DROP TABLE Quarto CASCADE CONSTRAINTS;
DROP TABLE Funcionario CASCADE CONSTRAINTS;
DROP TABLE Servico CASCADE CONSTRAINTS;
DROP TABLE Produto CASCADE CONSTRAINTS;
DROP TABLE ServicoLavanderia;
DROP TABLE ServicoPasseioTuristico;
DROP TABLE ServicoFrigobar;
DROP TABLE ServicoRestaurante;
DROP TABLE ServicoEstacionamento;
DROP TABLE ServicoBar;
DROP TABLE Prestados CASCADE CONSTRAINTS;
DROP TABLE Avalia;
DROP TABLE Vende CASCADE CONSTRAINTS;



CREATE TABLE  Clientes (
	cpf char(11) PRIMARY KEY NOT NULL,
	nome varchar(200) NOT NULL,
    email varchar(200) NOT NULL,
	dataNascimento DATE NOT NULL,
	sexo char(1) NOT NULL,
	rua varchar(200) NOT NULL, 
	numero varchar(10) NOT NULL, 
	bairro varchar(30) NOT NULL,
	cep char(8) NOT NULL
);

CREATE TABLE  Telefones (
	cpfCli char(11) NOT NULL,
	telefone varchar(9) NOT NULL,
	
    PRIMARY KEY (cpfCli, telefone),
    CONSTRAINT cpfUsr
		FOREIGN KEY (cpfCli) REFERENCES Clientes(cpf) ON DELETE CASCADE
);

CREATE TABLE Dependente(
    cpf char(11) NOT NULL,
    cpfCli char(11) NOT NULL,
	nome varchar(200) NOT NULL,
    dataNascimento DATE NOT NULL,
    
    PRIMARY KEY (cpf, cpfCli),
    CONSTRAINT cpfCliRef
		FOREIGN KEY (cpfCli) REFERENCES Clientes(cpf) ON DELETE CASCADE
); 

CREATE TABLE Quarto (
	id INT NOT NULL,
    numero integer NOT NULL UNIQUE,
    tipo varchar(100) NOT NULL,
    com_vista char(1),    
    
    PRIMARY KEY(id)
);

CREATE TABLE Reserva (
	cpfCli char(11) NOT NULL,
    idQuarto INT NOT NULL,
    data_ini DATE NOT NULL,
    data_fim DATE NOT NULL,
    
    PRIMARY KEY(cpfCli, idQuarto),
    CONSTRAINT cliRef
		FOREIGN KEY (cpfCli) REFERENCES Clientes(cpf),
	CONSTRAINT id_quarto
		FOREIGN KEY (idQuarto) REFERENCES Quarto(id),
    CONSTRAINT check_data_reserva
        CHECK(data_ini < data_fim)
);

CREATE TABLE Hospeda (
	cpfCli char(11) NOT NULL,
    idQuarto INT NOT NULL,
    data_ini DATE NOT NULL,
    data_fim DATE NOT NULL,
    
    PRIMARY KEY(cpfCli, idQuarto),
    CONSTRAINT cli_ref
		FOREIGN KEY (cpfCli) REFERENCES Clientes(cpf),
	CONSTRAINT idQuarto
		FOREIGN KEY (idQuarto) REFERENCES Quarto(id),
    CONSTRAINT check_data_hospedagem 
        CHECK(data_ini < data_fim)
);

CREATE TABLE Nota_Fiscal(
	id_nota INT NOT NULL,
    id_quarto INT NOT NULL,
    cpfCli char(11) NOT NULL,
    dt_in DATE NOT NULL,
    dt_out DATE NOT NULL,
    valor REAL NOT NULL,
    
    PRIMARY KEY (id_nota, cpfCli, id_quarto),
    CONSTRAINT cpfCliente
		FOREIGN KEY (cpfCli) REFERENCES Clientes(cpf) ON DELETE CASCADE,
	CONSTRAINT quartoRef
		FOREIGN KEY (id_quarto) REFERENCES Quarto(id) ON DELETE CASCADE,
    CONSTRAINT check_duracao 
        CHECK(dt_in < dt_out),
    CONSTRAINT check_valor 
        CHECK(valor >= 0)
);

CREATE TABLE Equipamento(
	quarto_id INT NOT NULL,
    nome varchar(100) NOT NULL,
    
    PRIMARY KEY(quarto_id, nome),
    CONSTRAINT quarto_id
		FOREIGN KEY (quarto_id) REFERENCES Quarto(id) ON DELETE CASCADE
);

CREATE TABLE Funcionario (
	nome varchar(100) NOT NULL,
    cpf char(11) NOT NULL,
    salario real NOT NULL,
    data_de_nascimento DATE NOT NULL,
    
    PRIMARY KEY(cpf),
    CONSTRAINT check_salario
        CHECK(salario > 0)
);


CREATE TABLE ServicoLavanderia (
	id INT NOT NULL,
    
    PRIMARY KEY (id)
);

CREATE TABLE ServicoPasseioTuristico (
	id INT NOT NULL,
    
    PRIMARY KEY (id)
);

CREATE TABLE ServicoFrigobar (
	id INT NOT NULL,
    
    PRIMARY KEY (id)
);

CREATE TABLE ServicoRestaurante (
	id INT NOT NULL,
    
    PRIMARY KEY (id)
);

CREATE TABLE ServicoEstacionamento (
	id INT NOT NULL,
    
    PRIMARY KEY (id)
);

CREATE TABLE ServicoBar (
	id INT NOT NULL,
    
    PRIMARY KEY (id)
);


CREATE TABLE Servico (
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
		FOREIGN KEY (id_ser_bar) REFERENCES ServicoBar(id) ON DELETE CASCADE,
    CONSTRAINT check_valor_servico
        CHECK (valor >= 0)
);



CREATE TABLE Produto (
	id INT NOT NULL,
    nome varchar(100) NOT NULL,
    descricao varchar(255) NOT NULL,
    valor real NOT NULL,
    
    PRIMARY KEY(id),
    CONSTRAINT check_valor_produto
        CHECK (valor >= 0)
);

CREATE TABLE Avalia (
	cpfCli char(11) NOT NULL,
    idServico INT NOT NULL,
    nota real NOT NULL,
    comentario varchar(255),
    
    PRIMARY KEY(cpfCli, idServico),
    CONSTRAINT cpf_cli
		FOREIGN KEY (cpfCli) REFERENCES Clientes(cpf) ON DELETE CASCADE,
	CONSTRAINT id_servico
		FOREIGN KEY (idServico) REFERENCES Servico(id) ON DELETE CASCADE,
    CONSTRAINT check_nota
        CHECK (nota >= 0)
);


CREATE TABLE Prestados (
	cpfFunc char(11) NOT NULL,
    idServico INT NOT NULL,
    
    PRIMARY KEY(cpfFunc, idServico),
    CONSTRAINT cpfFunc
		FOREIGN KEY (cpfFunc) REFERENCES Funcionario(cpf) ON DELETE CASCADE,
	CONSTRAINT idServico
		FOREIGN KEY (idServico) REFERENCES Servico(id) ON DELETE CASCADE
);

CREATE TABLE Vende (
	idProduto INT NOT NULL,
    idQuarto INT NOT NULL,
    dataVenda DATE NOT NULL,
    quantidade INT NOT NULL,
    
    PRIMARY KEY (idProduto, idQuarto),
    CONSTRAINT id_produto
		FOREIGN KEY (idProduto) REFERENCES Produto(id) ON DELETE CASCADE,
	CONSTRAINT id_quarto_ref
		FOREIGN KEY (idQuarto) REFERENCES Quarto(id) ON DELETE CASCADE,
    CONSTRAINT check_quantidade
        CHECK(quantidade >= 0)
);
