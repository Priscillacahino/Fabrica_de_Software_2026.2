
CREATE TABLE REGIOES (
    id_regiao INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    estado VARCHAR(2) NOT NULL,
    populacao INT NOT NULL,
    potencial_energetico DECIMAL(10,2) NOT NULL
);



CREATE TABLE USINAS (
    id_usina INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    capacidade_mw DECIMAL(10,2) NOT NULL,
    ano_inicio INT NOT NULL,
    id_regiao INT NOT NULL,

    CONSTRAINT fk_usina_regiao
        FOREIGN KEY (id_regiao)
        REFERENCES REGIOES(id_regiao)
);



CREATE TABLE GERACAO (
    id_geracao INT PRIMARY KEY AUTO_INCREMENT,
    id_usina INT NOT NULL,
    data_geracao DATE NOT NULL,
    energia_mwh DECIMAL(12,2) NOT NULL,
    horas_operacao DECIMAL(8,2) NOT NULL,

    CONSTRAINT fk_geracao_usina
        FOREIGN KEY (id_usina)
        REFERENCES USINAS(id_usina)
);




INSERT INTO REGIOES
(nome, estado, populacao, potencial_energetico)
VALUES
('Vale do Sol', 'BA', 850000, 9200.50),
('Serra Verde', 'MG', 1200000, 7800.30),
('Costa Azul', 'CE', 670000, 11500.80),
('Planalto Norte', 'GO', 950000, 8400.70),
('Campos Dourados', 'PR', 1100000, 6900.40),
('Rio Claro', 'RJ', 1450000, 5200.60),
('Chapada Azul', 'PI', 480000, 12800.90),
('Vale das Águas', 'SP', 2100000, 6100.20),
('Serra do Vento', 'RN', 390000, 13200.75),
('Horizonte Sul', 'SC', 730000, 5700.35);




INSERT INTO USINAS
(nome, tipo, capacidade_mw, ano_inicio, id_regiao)
VALUES
('Usina Solar Aurora', 'Solar', 180.50, 2020, 1),
('Parque Eolico Brisa', 'Eolica', 250.00, 2019, 2),
('Usina Solar Nordeste', 'Solar', 320.75, 2021, 3),
('Parque Ventos do Cerrado', 'Eolica', 410.30, 2018, 4),
('Usina Hidreletrica Dourada', 'Hidreletrica', 520.00, 2015, 5),
('Usina Solar Carioca', 'Solar', 150.25, 2022, 6),
('Parque Solar Chapada', 'Solar', 380.80, 2020, 7),
('Usina Hidreletrica Paulista', 'Hidreletrica', 610.40, 2014, 8),
('Parque Eolico Potiguar', 'Eolica', 450.60, 2017, 9),
('Usina Solar Catarinense', 'Solar', 210.90, 2021, 10);



INSERT INTO GERACAO
(id_usina, data_geracao, energia_mwh, horas_operacao)
VALUES
(1, '2026-01-10', 820.50, 10.50),
(2, '2026-01-10', 1150.75, 18.00),
(3, '2026-01-11', 1480.30, 11.20),
(4, '2026-01-11', 1980.90, 20.50),
(5, '2026-01-12', 2750.40, 22.00),
(6, '2026-01-12', 710.25, 9.80),
(7, '2026-01-13', 1690.80, 12.00),
(8, '2026-01-13', 3100.60, 23.00),
(9, '2026-01-14', 2250.45, 21.50),
(10, '2026-01-14', 980.70, 10.80);



UPDATE USINAS
SET capacidade_mw = 275.00
WHERE id_usina = 2;


INSERT INTO REGIOES
(nome, estado, populacao, potencial_energetico)
VALUES
('Regiao Experimental', 'ES', 250000, 4500.00);


DELETE FROM REGIOES
WHERE id_regiao = 11;

SELECT *
FROM REGIOES;

SELECT *
FROM USINAS;


SELECT *
FROM GERACAO;


SELECT
    SUM(energia_mwh) AS energia_total_mwh
FROM GERACAO;


SELECT
    AVG(energia_mwh) AS media_energia_mwh
FROM GERACAO;




SELECT
    MAX(energia_mwh) AS maior_geracao_mwh
FROM GERACAO;



SELECT
    id_usina,
    SUM(energia_mwh) AS energia_total_mwh
FROM GERACAO
GROUP BY id_usina;


SELECT
    id_usina,
    SUM(energia_mwh) AS energia_total_mwh
FROM GERACAO
GROUP BY id_usina
HAVING SUM(energia_mwh) > 1500;


SELECT
    U.nome AS usina,
    U.tipo,
    R.nome AS regiao,
    R.estado,
    G.data_geracao,
    G.energia_mwh
FROM GERACAO G
INNER JOIN USINAS U
    ON G.id_usina = U.id_usina
INNER JOIN REGIOES R
    ON U.id_regiao = R.id_regiao;

SELECT
    R.nome AS regiao,
    R.estado,
    SUM(G.energia_mwh) AS energia_total_mwh
FROM REGIOES R
INNER JOIN USINAS U
    ON R.id_regiao = U.id_regiao
INNER JOIN GERACAO G
    ON U.id_usina = G.id_usina
GROUP BY
    R.id_regiao,
    R.nome,
    R.estado;

SELECT
    R.nome AS regiao,
    SUM(G.energia_mwh) AS energia_total_mwh
FROM REGIOES R
INNER JOIN USINAS U
    ON R.id_regiao = U.id_regiao
INNER JOIN GERACAO G
    ON U.id_usina = G.id_usina
GROUP BY
    R.id_regiao,
    R.nome
HAVING SUM(G.energia_mwh) > 2000;

SELECT
    R.nome AS regiao,
    R.estado,
    SUM(G.energia_mwh) AS energia_total_mwh
FROM REGIOES R
INNER JOIN USINAS U
    ON R.id_regiao = U.id_regiao
INNER JOIN GERACAO G
    ON U.id_usina = G.id_usina
GROUP BY
    R.id_regiao,
    R.nome,
    R.estado
ORDER BY energia_total_mwh DESC
LIMIT 1;

SELECT
    R.nome AS regiao,
    R.estado,
    U.nome AS usina,
    U.tipo,
    U.capacidade_mw,
    G.data_geracao,
    G.energia_mwh,
    G.horas_operacao
FROM REGIOES R
INNER JOIN USINAS U
    ON R.id_regiao = U.id_regiao
INNER JOIN GERACAO G
    ON U.id_usina = G.id_usina
ORDER BY R.nome, U.nome;

