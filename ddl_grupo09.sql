DROP TABLE IF EXISTS Quartos;
DROP TABLE IF EXISTS Dependentes;
DROP TABLE IF EXISTS Telefones;
DROP TABLE IF EXISTS Clientes;


CREATE TABLE IF NOT EXISTS Clientes (
	nome varchar(200) NOT NULL,
    cpf char(11) PRIMARY KEY NOT NULL,
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
    
    PRIMARY KEY (ddd, telefone)
) DEFAULT CHARSET=utf8, ENGINE INNODB;

alter table Telefones add constraint cpf 
	foreign key (cpf) references Clientes (cpf) on delete cascade;

create table if not exists Dependentes (
	nome varchar(200) not null,
    cpf_cliente char(11) not null,
    dataNascimento Date not null,
    
    primary key (nome, dataNascimento)
) DEFAULT CHARSET=utf8, ENGINE INNODB;

alter table Dependentes add constraint cpf_cliente
	foreign key (cpf_cliente) references Clientes (cpf) on delete cascade;
    
create table if not exists Quartos (
	id int not null primary key,
    numero char(3) unique,
    tipo varchar(100),
    vista boolean,
    diaria real
) default charset=utf8, engine innodb;