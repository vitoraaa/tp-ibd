use veiculos;
DROP TABLE IF EXISTS `condutor_veiculo`;
DROP TABLE IF EXISTS `condutor_infracao`;
DROP TABLE IF EXISTS `condutor_cidade`;
DROP TABLE IF EXISTS `condutor`;
DROP TABLE IF EXISTS `veiculo`; 
DROP TABLE IF EXISTS `infracao`; 
DROP TABLE IF EXISTS `cidade`; 

CREATE TABLE condutor(
    id INT,
    nome VARCHAR(45),
    documento VARCHAR(11),
    PRIMARY KEY (id)
);

INSERT INTO condutor VALUES
(1, "Graça Charneca Piteira", 75889855000),
(2, "Alvin Poças Trindade", 31309676054),
(3, "Oséias Carneiro Travassos", 27576485000),
(4, "Amélie Valadim Brião", 53746293014),
(5, "Victória Guimarães Veleda", 89079326038),
(6, "Élson Pimenta Granja", 36737339077),
(7, "Piedade Nunes Fartaria", 35058690071),
(8, "Zhen Ferro Sobreira", 22435728000),
(9, "Brianna Taborda Grangeia", 27175173083),
(10, "Alexandro Natal Quental", 32898192058),
(11, "Willian Paula Bouças", 61642214043);
    

   
CREATE TABLE veiculo(
	id INT,
    placa CHAR(7),
    marca VARCHAR(20),
    modelo VARCHAR(20),
    PRIMARY KEY (id)
);

INSERT INTO veiculo VALUES 
    (1, "HJL1138", "Ford", "Ka"),
    (2, "JHI4420", "Ford", "Focus"),
    (3, "NEN5197", "Chevrolet", "Monza"),
    (4, "NEO5048", "Chevrolet", "Onix"),
    (5, "HMY1486", "Chevrolet", "Cruze"),
    (6, "IZH3159", "Chevrolet", "Classic"),
    (7, "KJI9126", "Fiat", "Uno"),
    (8, "MXG4210", "Fiat", "Palio"),
    (9, "IMS9501", "Volkswagen", "Jetta"),
    (10, "HPY6693", "Volkswagen", "Voyage"),
    (11, "KAO0756", "Volkswagen", "Fox"),
    (12, "GTU9570", "Chevrolet", "Classic"),
    (13, "NCZ8903", "Chevrolet", "Cruze"),
    (14, "NFB1565", "Fiat", "Palio"),
    (15, "HUA4468", "Fiat", "Palio"),
    (16, "JUS9433", "Volkswagen", "Jetta"),
    (17, "KFW3884", "Volkswagen", "Voyage"),
    (18, "KGS6205", "Volkswagen", "Fox");


  
CREATE TABLE condutor_veiculo(
	id INT,
    id_veiculo INT UNIQUE,
    id_condutor INT,
    PRIMARY KEY(id),
    CONSTRAINT `FK_CONDUTOR_VEICULO_VEICULO` FOREIGN KEY (`id_veiculo`) REFERENCES `veiculo`(`id`) ON DELETE CASCADE,
    CONSTRAINT `FK_CONDUTOR_VEICULO_CONDUTOR` FOREIGN KEY (`id_condutor`) REFERENCES `condutor`(`id`) ON DELETE CASCADE
);

INSERT INTO condutor_veiculo VALUES
    (1, 1, 1),
    (2, 2, 2),
    (3, 3, 3),
    (4, 4, 4),
    (5, 5, 5),
    (6, 6, 6),
    (7, 7, 7),
    (8, 8, 8),
    (9, 9, 9),
    (10, 10, 10),
    (11, 11, 11),
    (12, 12, 5),
    (13, 13, 6),
    (14, 14, 5),
    (15, 15, 1),
    (16, 16, 3),
    (17, 17, 3),
    (18, 18, 3);


CREATE TABLE infracao(
	id INT,
    codigo CHAR(4) UNIQUE,
    gravidade INT,
    descricao VARCHAR(240),
    PRIMARY KEY (id)    
);

INSERT INTO infracao VALUES
    (1, "4561", 1, "Deixar de prestar socorro à vítima de acidente quando solicitado pelas autoridades"),
    (2, "5462", 4, "Usar a buzina desrespeitando os padrões e as frequências estabelecidas por lei"),
    (3, "1458", 4, "Conduzir veículo sem os documentos obrigatórios (CNH e CRLV)"),
    (4, "7554", 1, "Estacionar veículos em viadutos, pontes ou túneis"),
    (5, "7466", 1, "Estacionar ao lado de outro veículo, formando fila dupla"),
    (6, "1647", 2, "Dirigir com o braço para o lado de fora da janela"),
    (7, "7561", 5, "Ultrapassar pela direita"),
    (8, "7645", 5, "Parar o veículo na contramão de direção"),
    (9, "1354", 2, "Dirigir veículo segurando ou manuseando celular"),
    (10, "4564", 2, "Estacionar no passeio"),
    (11, "7986", 1, "Deixar de usar o cinto de segurança"),
    (12, "3584", 3, "Avançar o sinal vermelho"),
    (13, "7486", 3, "Excesso de velocidade");

    
CREATE TABLE cidade(
	id INT,
    uf CHAR(2),
    nome_cidade VARCHAR(50),
    PRIMARY KEY (id),
    constraint UC_cidade unique (uf,nome_cidade)
);

INSERT INTO cidade VALUES
    (1, "MG", "Belo Horizonte"),
    (2, "MG", "Alfenas"),
    (3, "MG", "Divinópolis"),
    (4, "MG", "Curvelo"),
    (5, "MG", "Uba"),
    (6, "MG", "Viçosa"),
    (7, "MG", "Pouso Alegre"),
    (8, "MG", "Sete Lagoas"),
    (9, "MG", "Betim"),
    (10, "MG", "Ibirité");
    


CREATE TABLE condutor_infracao(
	id INT,
    id_infracao INT,
    id_condutor INT,
    data_ocorrencia DATE,
    id_cidade INT,
    PRIMARY KEY(id),
    CONSTRAINT `FK_CONDUTOR_INFRACAO_INFRACAO` FOREIGN KEY (`id_infracao`) REFERENCES `infracao`(`id`) ON DELETE CASCADE,
    CONSTRAINT `FK_CONDUTOR_INFRACAO_CONDUTOR` FOREIGN KEY (`id_condutor`) REFERENCES `condutor`(`id`) ON DELETE CASCADE,
    CONSTRAINT `FK_CONDUTOR_INFRACAO_CIDADE` FOREIGN KEY (`id_cidade`) REFERENCES `cidade`(`id`) ON DELETE CASCADE
);

INSERT INTO condutor_infracao VALUES
    (1,1,1, "2021-01-20", 1),
    (2,2,2, "2021-01-20", 2),
    (3,3,3, "2021-01-20", 3),
    (4,4,4, "2021-01-20", 4),
    (5,5,5, "2021-01-20", 5),
    (6,6,6, "2021-01-20", 6),
    (7,7,7, "2021-01-20", 7),
    (8,8,8, "2021-01-20", 8),
    (9,9,9, "2021-01-20", 9),
    (10,10,10, "2021-01-20", 10),
    (11,11,11, "2021-01-20", 1),
    (12,12,10, "2021-01-20", 1),
    (13,13,10, "2021-01-20", 3),
    (14,2,4, "2021-01-20", 2),
    (15,2,4, "2021-01-20", 2),
    (16,9,2, "2021-01-20", 2),
    (17,9,2, "2021-01-20", 2);


CREATE TABLE condutor_cidade(
    id INT,
    id_condutor INT UNIQUE,
    id_cidade INT,
    PRIMARY KEY (id),
    CONSTRAINT `FK_CONDUTOR_CIDADE_CONDUTOR` FOREIGN KEY (`id_condutor`) REFERENCES `condutor`(`id`) ON DELETE CASCADE,
    CONSTRAINT `FK_CONDUTOR_CIDADE_CIDADE` FOREIGN KEY (`id_cidade`) REFERENCES `cidade`(`id`) ON DELETE CASCADE
);

INSERT INTO condutor_cidade VALUES
    (1, 1, 1),
    (2, 2, 2),
    (3, 3, 2),
    (4, 4, 4),
    (5, 5, 5),
    (6, 6, 5),
    (7, 7, 5),
    (8, 8, 8),
    (9, 9, 9),
    (10, 10, 10),
    (11, 11, 10);