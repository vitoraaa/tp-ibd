DROP TABLE IF EXISTS `condutor_veiculo`;
DROP TABLE IF EXISTS `condutor`;
DROP TABLE IF EXISTS `veiculo`; 

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
    id_veiculo INT,
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

