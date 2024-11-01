CREATE DATABASE gtech; 

USE gtech;

CREATE TABLE admin (
  id int NOT NULL AUTO_INCREMENT,
  usuario varchar(255) NOT NULL,
  senha varchar(255) NOT NULL,
  cargo varchar(50) DEFAULT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE gastos (
  id int NOT NULL AUTO_INCREMENT,
  servico varchar(255) NOT NULL,
  data date NOT NULL,
  valor decimal(10,2) NOT NULL,
  forma_pagamento varchar(100) NOT NULL,
  detalhes varchar(255) DEFAULT NULL,
  categoria varchar(100) NOT NULL,
  fornecedor varchar(255) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE vendas (
  id int NOT NULL AUTO_INCREMENT,
  loja varchar(255) DEFAULT NULL,
  servico varchar(255) DEFAULT NULL,
  data date DEFAULT NULL,
  valor decimal(10,2) DEFAULT NULL,
  forma_pagamento varchar(50) DEFAULT NULL,
  detalhes varchar(255) DEFAULT NULL,
  PRIMARY KEY (id),
  KEY fk_servico (servico),
  CONSTRAINT fk_servico FOREIGN KEY (servico) REFERENCES servicos (nome)
);

CREATE TABLE servicos (
  id int NOT NULL AUTO_INCREMENT,
  nome varchar(255) NOT NULL,
  valor decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY nome (nome)
);
