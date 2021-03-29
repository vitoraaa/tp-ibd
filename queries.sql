SELECT 
	(SELECT COUNT(*) FROM cidade) AS cidade_count,
	(SELECT COUNT(*) FROM condutor AS condutor_count) AS condutor_count,
	(SELECT COUNT(*) FROM condutor_infracao) AS condutor_infracao_count,
	(SELECT COUNT(*) FROM infracao) AS infracao_count,
    (SELECT COUNT(*) FROM telefone) AS telefone_count,
    (SELECT COUNT(*) FROM veiculo) AS veiculo_count;


-- Selecionar o nome de todos os condutores que tiveram o documento emitido antes 
-- da data atual - 5 anos (ou seja, condutores que estão com o documento vencido).

select 
	c.nome
from condutor c
where data_emissao_documento <= DATE_SUB(now(), INTERVAL 5 YEAR);

-- 1749091 row(s) returned	
-- 0,00056 sec / 0,538 sec
-- 0,00061 sec / 0,538 sec
-- 0,00063 sec / 0,539 sec
-- 0,00062 sec / 0,536 sec
-- 0,00062 sec / 0,540 sec


SELECT 
 	nome 
FROM veiculos.condutor c2 
WHERE id IN (
	select 
		c.id
	from condutor c
	where data_emissao_documento <= DATE_SUB(now(), INTERVAL 5 YEAR)
);

-- 1749091 row(s) returned	
-- 0,0014 sec / 7,167 sec
-- 0,0011 sec / 10,483 sec
-- 0,0011 sec / 10,515 sec
-- 0,0012 sec / 10,299 sec
-- 0,0011 sec / 10,483 sec


-- Selecionar o código de todas as infrações que possuem gravidade 7.

SELECT 
	codigo 
FROM veiculos.infracao i 
WHERE gravidade = 7;

-- 18 row(s) returned	
-- 0,00035 sec / 0,0000050 sec
-- 0,0010 sec / 0,000023 sec
-- 0,0011 sec / 0,000022 sec
-- 0,00035 sec / 0,0000050 sec
-- 0,0010 sec / 0,000022 sec


SELECT 
	codigo 
FROM veiculos.infracao i 
WHERE id IN (
	SELECT 
		id 
	FROM veiculos.infracao i 
	WHERE gravidade = 7
);

-- 18 row(s) returned	
-- 0,0012 sec / 0,000021 sec
-- 0,00056 sec / 0,0000091 sec
-- 0,00041 sec / 0,0000050 sec
-- 0,00094 sec / 0,000017 sec
-- 0,0012 sec / 0,000023 sec


# Buscar o nome e os telefones de todos os condutores 
# cadastrados com documento válido do banco 
# (ou seja, que tiveram o documento emitido a partir da data atual - 5 anos).

SELECT
	c.nome,
	t.telefone 
FROM veiculos.condutor c 
JOIN veiculos.telefone t ON t.id_condutor = c.id
where c.data_emissao_documento >=  DATE_SUB(now(), INTERVAL 5 YEAR)
order BY c.nome;

-- 263721 row(s) returned
-- 1,559 sec / 4,684 sec
-- 0,613 sec / 4,873 sec
-- 0,621 sec / 5,024 sec
-- 0,619 sec / 4,825 sec
-- 0,611 sec / 4,847 sec


SELECT 
	c.nome,
	t.telefone
FROM veiculos.telefone t
JOIN veiculos.condutor c ON c.id = t.id_condutor 
where c.data_emissao_documento >=  DATE_SUB(now(), INTERVAL 5 YEAR)
ORDER BY c.nome;

-- 263721 row(s) returned
-- 0,615 sec / 4,952 sec
-- 0,606 sec / 4,715 sec
-- 0,633 sec / 4,627 sec
-- 0,604 sec / 4,631 sec
-- 0,660 sec / 4,854 sec


-- Buscar a placa e o condutor cadastrado dos veículos do banco.
SELECT 
	v.placa,
	c.nome
FROM veiculos.veiculo v 
JOIN veiculos.condutor c ON c.id = v.id_condutor;

-- 2099999 row(s) returned	
-- 0,0058 sec / 13,292 sec
-- 0,0043 sec / 12,282 sec
-- 0,0038 sec / 11,696 sec
-- 0,0066 sec / 11,049 sec
-- 0,0031 sec / 10,785 sec


SELECT 
	v.placa,
	c.nome
FROM veiculos.condutor c
JOIN veiculos.veiculo v ON v.id_condutor = c.id;

-- 2099999 row(s) returned	
-- 0,0032 sec / 11,102 sec
-- 0,0044 sec / 11,175 sec
-- 0,0029 sec / 11,209 sec
-- 0,0030 sec / 11,296 sec
-- 0,0030 sec / 11,160 sec


-- Buscar o nome e a cidade dos condutores com documento válido 
# do banco (ou seja, que tiveram o documento emitido a partir da data atual - 5 anos)

SELECT 
	cond.nome,
	cid.nome_cidade 
FROM veiculos.condutor cond 
JOIN veiculos.cidade cid ON cid.id = cond.id_cidade 
where cond.data_emissao_documento >= DATE_SUB(now(), INTERVAL 5 YEAR);

-- 250717 row(s) returned	
-- 0,0018 sec / 1,003 sec
-- 0,0040 sec / 0,786 sec
-- 0,0019 sec / 0,623 sec
-- 0,0016 sec / 0,622 sec
-- 0,0018 sec / 0,638 sec


SELECT 
	cond.nome,
	cid.nome_cidade 
FROM veiculos.cidade cid
JOIN veiculos.condutor cond ON cond.id_cidade = cid.id 
where cond.data_emissao_documento >= DATE_SUB(now(), INTERVAL 5 YEAR);

-- 250717 row(s) returned	
-- 0,0017 sec / 0,637 sec
-- 0,0017 sec / 0,636 sec
-- 0,0016 sec / 0,620 sec
-- 0,0016 sec / 0,624 sec
-- 0,0017 sec / 0,637 sec



# Retornar o nome, a cidade e os telefones de todos os condutores com documento válido do banco 
# (ou seja, que tiveram o documento emitido a partir da data atual - 5 anos)

SELECT 
	cond.nome,
	cid.nome_cidade,
	t.telefone 
FROM veiculos.cidade cid
JOIN veiculos.condutor cond ON cond.id_cidade = cid.id 
JOIN veiculos.telefone t ON t.id_condutor = cond.id 
where cond.data_emissao_documento >= DATE_SUB(now(), INTERVAL 5 YEAR);

-- 263526 row(s) returned	
-- 0,013 sec / 12,129 sec
-- 0,012 sec / 11,602 sec
-- 0,012 sec / 11,065 sec
-- 0,012 sec / 11,109 sec
-- 0,012 sec / 11,121 sec




SELECT
	cond.nome,
	cid.nome_cidade,
	t.telefone 
FROM veiculos.telefone t 
JOIN (
	SELECT 
		c.id,
        c.nome,
        c.id_cidade
	from condutor c where data_emissao_documento >=  DATE_SUB(now(), INTERVAL 5 YEAR)
) as cond on cond.id = t.id_condutor
JOIN veiculos.cidade cid ON cid.id = cond.id_cidade;

-- 263526 row(s) returned
-- 0,030 sec / 10,972 sec
-- 0,0097 sec / 10,618 sec
-- 0,011 sec / 10,938 sec
-- 0,011 sec / 10,776 sec
-- 0,012 sec / 11,282 sec



-- Buscar o nome dos condutores e os códigos das infrações cometidas para casos 
-- em que os condutores cometeram infrações com o documento vencido.


SELECT 
	cond.nome,
	infr.codigo 
FROM veiculos.condutor_infracao ci 
JOIN veiculos.condutor cond ON cond.id  = ci.id_condutor 
JOIN veiculos.infracao infr ON infr.id = ci.id_infracao 
WHERE DATE_SUB(ci.data_ocorrencia, INTERVAL 5 YEAR) >= cond.data_emissao_documento;
	
-- 753473 row(s) returned
-- 0,0097 sec / 12,465 sec
-- 0,0095 sec / 13,248 sec
-- 0,0098 sec / 12,887 sec
-- 0,0100 sec / 12,723 sec
-- 0,011 sec / 12,744 sec


SELECT 
	cond.nome,
	infr.codigo
FROM veiculos.condutor cond
JOIN veiculos.condutor_infracao ci ON ci.id_cidade = cond.id 
JOIN veiculos.infracao infr ON infr.id  = ci.id_infracao 
WHERE ci.data_ocorrencia >= DATE_ADD(cond.data_emissao_documento, INTERVAL 5 YEAR);

-- 753473 row(s) returned
-- 0,0060 sec / 4,554 sec
-- 0,0054 sec / 4,675 sec
-- 0,0059 sec / 4,781 sec
-- 0,0057 sec / 4,492 sec
-- 0,0055 sec / 4,357 sec


-- Buscar o nome dos condutores que cometeram infrações com gravidade igual a 7.

SELECT 
	cond.nome 
FROM veiculos.condutor cond 
JOIN veiculos.condutor_infracao ci ON ci.id_condutor = cond.id 
JOIN veiculos.infracao infr ON infr.id  = ci.id_infracao
WHERE infr.gravidade = 7;

-- 381543 row(s) returned	
-- 0,012 sec / 4,044 sec
-- 0,0094 sec / 4,484 sec
-- 0,0094 sec / 3,995 sec
-- 0,010 sec / 3,928 sec
-- 0,0094 sec / 3,972 sec


SELECT 
	cond.nome 
FROM veiculos.condutor_infracao ci
JOIN veiculos.condutor cond ON cond.id = ci.id_condutor 
JOIN (
	SELECT 
		id 
	FROM veiculos.infracao i 
	WHERE i.gravidade  = 7
) AS infr 
ON infr.id = ci.id_infracao;

-- 381543 row(s) returned	
-- 0,010 sec / 3,932 sec
-- 0,0099 sec / 3,979 sec
-- 0,0095 sec / 4,044 sec
-- 0,011 sec / 4,036 sec
-- 0,0100 sec / 4,114 sec



-- Buscar o nome dos condutores que possuem mais de um telefone cadastrado no banco.


SELECT 
	cond.nome
FROM veiculos.condutor cond
JOIN veiculos.telefone t ON t.id_condutor  = cond.id 
GROUP BY cond.id 
HAVING count(cond.id) > 1;

-- 565053 row(s) returned	11,828 sec / 0,272 sec
-- 10,220 sec / 0,272 sec
-- 11,828 sec / 0,272 sec
-- 11,909 sec / 0,270 sec
-- 11,634 sec / 0,265 sec
-- 11,514 sec / 0,262 sec


SELECT 
	cond.nome
FROM veiculos.condutor cond
JOIN (
	SELECT 
		id_condutor,
	count(*) AS tel_count
	FROM veiculos.telefone t 
	GROUP BY id_condutor 
) AS tel_cond
ON cond.id  = tel_cond.id_condutor AND tel_cond.tel_count > 1;

-- 565053 row(s) returned	11,828 sec / 0,272 sec
-- 2,079 sec / 6,322 sec
-- 2,835 sec / 7,156 sec
-- 2,922 sec / 7,176 sec
-- 2,875 sec / 6,933 sec
-- 2,764 sec / 6,914 sec


-- Buscar o nome dos condutores que cometeram mais de uma infração a partir de 2013.

SELECT 
	cond.nome
FROM veiculos.condutor_infracao ci
JOIN veiculos.condutor cond ON cond.id = ci.id_condutor
WHERE YEAR (ci.data_ocorrencia) > 2013
GROUP BY ci.id_condutor
HAVING count(*) > 1;


-- 40633 row(s) returned	
-- 6,000 sec / 0,069 sec
-- 4,252 sec / 0,070 sec
-- 3,944 sec / 0,069 sec
-- 3,812 sec / 0,069 sec
-- 3,727 sec / 0,070 sec



SELECT cond.nome 
FROM veiculos.condutor cond
WHERE cond.id IN (
	SELECT 
		ci.id_condutor 
	FROM veiculos.condutor_infracao ci
	JOIN veiculos.condutor cond ON cond.id = ci.id_condutor
	WHERE YEAR (ci.data_ocorrencia) > 2013
	GROUP BY ci.id_condutor
	HAVING count(*) > 1
);

-- 40633 row(s) returned	
-- 9,233 sec / ?
-- 10,259 sec / ?
-- 9,566 sec / ?
-- 18,702 sec / ?
-- 22,691 sec / ?






