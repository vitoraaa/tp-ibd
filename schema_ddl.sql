use veiculos;
DROP TABLE IF EXISTS `telefone`;
DROP TABLE IF EXISTS `veiculo`; 
DROP TABLE IF EXISTS `condutor_infracao`;
DROP TABLE IF EXISTS `condutor`;
DROP TABLE IF EXISTS `infracao`; 
DROP TABLE IF EXISTS `cidade`; 


CREATE TABLE cidade(
	id INT,
    uf CHAR(2),
    nome_cidade VARCHAR(50),
    PRIMARY KEY (id),
    constraint UC_cidade unique (uf,nome_cidade)
);


CREATE TABLE condutor(
    id INT,
    nome VARCHAR(45),
    documento VARCHAR(11),
    data_emissao_documento DATE,
    id_cidade INT,
    CONSTRAINT `FK_CONDUTOR_CIDADE` FOREIGN KEY (`id_cidade`) REFERENCES `cidade`(`id`) ON DELETE RESTRICT,
    PRIMARY KEY (id)
);

CREATE TABLE telefone (
	id INT,
	id_condutor INT, 
    telefone VARCHAR(20),
	PRIMARY KEY (id),
	CONSTRAINT `FK_TELEFONE_CONDUTOR` FOREIGN KEY (`id_condutor`) REFERENCES `condutor`(`id`) ON DELETE CASCADE
);
   
CREATE TABLE veiculo(
	id INT,
    placa CHAR(7),
    marca VARCHAR(20),
    modelo VARCHAR(20),
    id_condutor INT,
    PRIMARY KEY (id),
	CONSTRAINT `FK_VEICULO_CONDUTOR` FOREIGN KEY (`id_condutor`) REFERENCES `condutor`(`id`) ON DELETE RESTRICT
);

CREATE TABLE infracao(
	id INT,
    codigo CHAR(4) UNIQUE,
    gravidade INT,
    descricao VARCHAR(240),
    PRIMARY KEY (id)    
);
    

CREATE TABLE condutor_infracao(
	id INT,
    id_infracao INT,
    id_condutor INT,
    data_ocorrencia DATE,
    id_cidade INT,
    PRIMARY KEY(id),
    CONSTRAINT `FK_CONDUTOR_INFRACAO_INFRACAO` FOREIGN KEY (`id_infracao`) REFERENCES `infracao`(`id`) ON DELETE CASCADE,
    CONSTRAINT `FK_CONDUTOR_INFRACAO_CONDUTOR` FOREIGN KEY (`id_condutor`) REFERENCES `condutor`(`id`) ON DELETE RESTRICT,
    CONSTRAINT `FK_CONDUTOR_INFRACAO_CIDADE` FOREIGN KEY (`id_cidade`) REFERENCES `cidade`(`id`) ON DELETE RESTRICT
);