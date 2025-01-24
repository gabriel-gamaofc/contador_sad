-- Criação da tabela unidades
CREATE TABLE unidades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL UNIQUE
);

-- Criação da tabela orgãos
CREATE TABLE orgaos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL
    
  
);

-- Criação da tabela serviços
CREATE TABLE servicos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    orgao_id INT,
    unidade_id int,
    FOREIGN KEY (orgao_id) REFERENCES orgaos(id) ON DELETE CASCADE,
      FOREIGN KEY (unidade_id) REFERENCES unidades(id) ON DELETE CASCADE
);

CREATE TABLE resultados_detalhados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    servico_nome VARCHAR(255),
    orgao_nome VARCHAR(255),
    unidade_nome VARCHAR(255),
    quantidade INT,
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    assinado BOOLEAN DEFAULT FALSE,
    coordenador_id INT,
    FOREIGN KEY (coordenador_id) REFERENCES usuarios(id)
);

create view orgao_detalhado as(
SELECT 
    unidade_nome,
    orgao_nome,
    DATE(data_hora) AS data,
    COUNT(*) AS total_servicos
FROM 
    resultados_detalhados
GROUP BY 
    unidade_nome, orgao_nome, DATE(data_hora)
HAVING 
    total_servicos > 0
ORDER BY 
    unidade_nome, orgao_nome, data
    );
    create  view unidade_detalhada as(
    SELECT 
    unidade_nome,
    DATE(data_hora) AS data,
    COUNT(*) AS total_servicos
FROM 
    resultados_detalhados
GROUP BY 
    unidade_nome, DATE(data_hora)
ORDER BY 
    unidade_nome, data
    );


create  view   tabela_protocalda_Servicos as (
SELECT 
    s.nome AS servico, 
    o.nome AS orgao, 
    u.nome AS unidade,
    s.id as id_serv,
    o.id as id_orgao,
    u.id as id_unidade
FROM 
    servicos s
JOIN 
    orgaos o ON s.orgao_id = o.id
JOIN 
    unidades u ON s.unidade_id = u.id
ORDER BY 
    u.nome, o.nome, s.nome
    );
    
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    perfil ENUM('atendente', 'coordenador') NOT NULL,
    unidade_id INT,
    FOREIGN KEY (unidade_id) REFERENCES unidades(id)
);
ALTER TABLE resultados_detalhados
ADD COLUMN 
insert into usuarios (username,password,perfil,unidade_id) values('adm','123','coordenador',1);
insert into usuarios (username,password,perfil,unidade_id) values('user','123','atendente',1);
    CREATE TABLE assinaturas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    resultado_id INT,
    coordenador_id INT,
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (resultado_id) REFERENCES resultados_detalhados(id),
    FOREIGN KEY (coordenador_id) REFERENCES usuarios(id)
);

    
CREATE VIEW view_boa_vista AS(
SELECT 
    unidade_nome,
    orgao_nome,
    servico_nome,
    DATE(data_hora) AS data,
    COUNT(*) AS total_servicos
FROM 
    resultados_detalhados
WHERE 
    unidade_nome = 'BOA VISTA'
GROUP BY 
    unidade_nome, orgao_nome, servico_nome, DATE(data_hora)
ORDER BY 
    unidade_nome, orgao_nome, servico_nome, data
    );
    
CREATE VIEW view_caruaru AS(
SELECT 
    unidade_nome,
    orgao_nome,
    servico_nome,
    DATE(data_hora) AS data,
    COUNT(*) AS total_servicos
FROM 
    resultados_detalhados
WHERE 
    unidade_nome = 'CARUARU'
GROUP BY 
    unidade_nome, orgao_nome, servico_nome, DATE(data_hora)
ORDER BY 
    unidade_nome, orgao_nome, servico_nome, data
    );

CREATE VIEW view_garanhuns AS(
SELECT 
    unidade_nome,
    orgao_nome,
    servico_nome,
    DATE(data_hora) AS data,
    COUNT(*) AS total_servicos
FROM 
    resultados_detalhados
WHERE 
    unidade_nome = 'GARANHUNS'
GROUP BY 
    unidade_nome, orgao_nome, servico_nome, DATE(data_hora)
ORDER BY 
    unidade_nome, orgao_nome, servico_nome, data
    );

CREATE VIEW view_olinda AS(
SELECT 
    unidade_nome,
    orgao_nome,
    servico_nome,
    DATE(data_hora) AS data,
    COUNT(*) AS total_servicos
FROM 
    resultados_detalhados
WHERE 
    unidade_nome = 'OLINDA'
GROUP BY 
    unidade_nome, orgao_nome, servico_nome, DATE(data_hora)
ORDER BY 
    unidade_nome, orgao_nome, servico_nome, data
    );

CREATE VIEW view_petrolina AS(
SELECT 
    unidade_nome,
    orgao_nome,
    servico_nome,
    DATE(data_hora) AS data,
    COUNT(*) AS total_servicos
FROM 
    resultados_detalhados
WHERE 
    unidade_nome = 'PETROLINA'
GROUP BY 
    unidade_nome, orgao_nome, servico_nome, DATE(data_hora)
ORDER BY 
    unidade_nome, orgao_nome, servico_nome, data
    );

CREATE VIEW view_pina AS(
SELECT 
    unidade_nome,
    orgao_nome,
    servico_nome,
    DATE(data_hora) AS data,
    COUNT(*) AS total_servicos
FROM 
    resultados_detalhados
WHERE 
    unidade_nome = 'PINA'
GROUP BY 
    unidade_nome, orgao_nome, servico_nome, DATE(data_hora)
ORDER BY 
    unidade_nome, orgao_nome, servico_nome, data
    );

CREATE VIEW view_salgueiro AS(
SELECT 
    unidade_nome,
    orgao_nome,
    servico_nome,
    DATE(data_hora) AS data,
    COUNT(*) AS total_servicos
FROM 
    resultados_detalhados
WHERE 
    unidade_nome = 'SALGUEIRO'
GROUP BY 
    unidade_nome, orgao_nome, servico_nome, DATE(data_hora)
ORDER BY 
    unidade_nome, orgao_nome, servico_nome, data
    );

CREATE VIEW view_vitoria AS(
SELECT 
    unidade_nome,
    orgao_nome,
    servico_nome,
    DATE(data_hora) AS data,
    COUNT(*) AS total_servicos
FROM 
    resultados_detalhados
WHERE 
    unidade_nome = 'VITORIA'
GROUP BY 
    unidade_nome, orgao_nome, servico_nome, DATE(data_hora)
ORDER BY 
    unidade_nome, orgao_nome, servico_nome, data
);

INSERT INTO unidades (nome) VALUES 
('BOA VISTA'), 
('CARUARU'), 
('GARANHUNS'), 
('OLINDA'), 
('PETROLINA'), 
('PINA'), 
('SALGUEIRO'), 
('VITORIA');

select * from resultados_detalhados
;

INSERT INTO orgaos (nome) VALUES
('DETRAN'), 
('SDS-IITB'), 
('FUNAPE'), 
('COMPESA'), 
('INSS'), 
('RECEITA FEDERAL'), 
('PROCON'), 
('LAFEPE'), 
('AGÊNCIA DO TRABALHO'), 
('CAS'), 
('PREFEITURA DE GARANHUNS'), 
('JUCEPE'), 
('CBM-PE'), 
('CIEE'), 
('PE-CONSIG'), 
('AGENDAMENTO/DAE/CPF'), 
('CAPITANIA DOS PORTOS'), 
('TRE/PE'), 
('CPF'), 
('CDL'), 
('AMMPLA'), 
('POLICIA FEDERAL'), 
('EXPRESSO EMPREENDEDOR'), 
('RECEITA');



SELECT * FROM SERVICOS;
-- SDS-IITB (unidade: BOA VISTA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('EMISSÃO DE RG 1° VIA', 2, 1), 
('EMISSÃO DE RG 2° VIA',2,1),
('EXIGÊNCIA',2,1),
('ENTREGA DE RG', 2, 1), 
('ATENDIMENTO WHATSAPP', 2, 1), 
('OUTROS', 2, 1);
-- DETRAN (unidade: BOA VISTA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('SERVIÇOS DE HABILITAÇÃO', 1,1), ('SERVIÇOS DE VEÍCULOS',  1,1), ('ENTREGAS DE DOCUMENTOS',  1,1), ('OUTROS',  1,1);

-- FUNAPE (unidade: BOA VISTA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('ATENDIMENTO DE ASSUNTOS DIVERSOS', 3,1), ('SOLICITAÇÃO DE PENSÃO POR MORTE/DIVERSOS PENSÃO', 3,1), ('COMUNICAÇÃO DE ÓBITO', 3,1), ('PROBLEMAS DE RECADASTRAMENTO/CÓPIA DE DOCUMENTOS', 3,1), ('ATENDIMENTO DE ASSUNTOS DE CTC/IR/INCLUSÃO DE CONTA CORRENTE', 3,1), ('EMISSÃO DE DECLARAÇÕES', 3,1), ('PROCESSOS DE PAGAMENTO A HERDEIROS/PAGAMENTO LICENÇA PRÊMIO/FICHA FINANCEIRA', 3,1), ('OUTROS', 3,1);

-- COMPESA (unidade: BOA VISTA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('ARRECADAÇÃO', 4,1), ('CADASTRO', 4,1), ('COBRANÇA', 4,1), ('DIAGNÓSTICOS', 4,1), ('DOCUMENTOS', 4,1), ('FATURAMENTO', 4,1), ('FISCALIZAÇÃO', 4,1), ('INFORMAÇÃO COMERCIAL ESGOTO', 4,1), ('INFORMAÇÃO OPERACIONAL ÁGUA', 4,1), ('INFORMAÇÃO OPERACIONAL ESGOTO', 4,1), ('MACROMEDIÇÃO', 4,1), ('MICROMEDIÇÃO', 4,1), ('OBRAS-ÁGUA', 4,1), ('OBRAS-ESGOTO', 4,1), ('OPERACIONAL ÁGUA', 4,1), ('OPERACIONAL ESGOTO', 4,1), ('OUTROS', 4,1);

-- INSS (unidade: BOA VISTA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('BPC', 5, 1),
('CONSULTA DE BENEFÍCIOS', 5, 1),
('CONSULTA IDADE APOSENTADORIA', 5, 1),
('CONSULTA TEMPO DE CONTRIBUIÇÃO', 5, 1),
('INFORMAÇÕES APOSENTADORIA', 5, 1),
('REAGENDAR AVALIAÇÃO SOCIAL', 5, 1),
('TRANSFERIR BENEFÍCIO DE BANCO', 5, 1),
('OUTROS', 5, 1);

-- RECEITA FEDERAL (unidade: BOA VISTA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('CONTA GOV.BR', 6, 1),
('CAEPF', 6, 1),
('CAFIR', 6, 1),
('CNO', 6, 1),
('CONSULTA PENDÊNCIA FÍSICA E CADASTRAL', 6, 1),
('CONSULTA MALHA FISCAL', 6, 1),
('CÓPIA DE PROCESSO', 6, 1),
('CÓPIA DE DEC. E COMPR. DE RENDIMENTO', 6, 1),
('CPF', 6, 1),
('EMISSÃO DE DOCUMENTO DE ARRECADAÇÃO', 6, 1),
('PROCURAÇÃO PFB', 6, 1),
('PROTOCOLO DE DOCUMENTOS', 6, 1),
('PROTOCOLO DE DOCUMENTOS - CNPJ', 6, 1),
('PROTOCOLO DE DOC. - REDARF/RETGPS', 6, 1),
('OUTROS', 6, 1);


-- PROCON (unidade: BOA VISTA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('CIP', 7, 1),
('REALIZAÇÃO DE AUDIÊNCIA DE CONCILIAÇÃO/RECLAMAÇÕES', 7, 1),
('INFORMAÇÃO/ORIENTAÇÃO AO CONSUMIDOR', 7, 1),
('OUTROS', 7, 1);

-- COMPESA (unidade: CARUARU)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('ARRECADAÇÃO', 4,2), ('CADASTRO', 4,2), ('COBRANÇA', 4,2), ('DIAGNÓSTICOS', 4,2), ('DOCUMENTOS', 4,2), ('FATURAMENTO', 4,2), ('FISCALIZAÇÃO', 4,2), ('INFORMAÇÃO COMERCIAL ESGOTO', 4,2), ('INFORMAÇÃO OPERACIONAL ÁGUA', 4,2), ('INFORMAÇÃO OPERACIONAL ESGOTO', 4,2), ('MACROMEDIÇÃO', 4,2), ('MICROMEDIÇÃO', 4,2), ('OBRAS-ÁGUA', 4,2), ('OBRAS-ESGOTO', 4,2), ('OPERACIONAL ÁGUA', 4,2), 
('OPERACIONAL ESGOTO', 4,2), ('OUTROS', 4,2);

-- SDS-IITB (unidade: CARUARU)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('EMISSÃO DE RG 1° VIA', 2, 2), 
('EMISSÃO DE RG 2° VIA',2,2),
('EXIGÊNCIA',2,2),
('ENTREGA DE RG', 2, 2), 
('ATENDIMENTO WHATSAPP', 2, 2), 
('OUTROS', 2, 2);

-- LAFEPE (unidade: CARUARU)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('OBTER MEDICAMENTOS', 8, 2),
('OBTER ARMAÇÕES DE ÓCULOS DE GRAU E LENTES', 8, 2),
('OUTROS', 8, 2);

-- FUNAPE (unidade: caruaru)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('ATENDIMENTO DE ASSUNTOS DIVERSOS', 3,2), ('SOLICITAÇÃO DE PENSÃO POR MORTE/DIVERSOS PENSÃO', 3,2), ('COMUNICAÇÃO DE ÓBITO', 3,2), ('PROBLEMAS DE RECADASTRAMENTO/CÓPIA DE DOCUMENTOS', 3,2), ('ATENDIMENTO DE ASSUNTOS DE CTC/IR/INCLUSÃO DE CONTA CORRENTE', 3,2), ('EMISSÃO DE DECLARAÇÕES', 3,2), ('PROCESSOS DE PAGAMENTO A HERDEIROS/PAGAMENTO LICENÇA PRÊMIO/FICHA FINANCEIRA', 3,2), ('OUTROS', 3,2);

-- AGÊNCIA DO TRABALHO (unidade: CARUARU)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('SEGURO DESEMPREGO', 9, 2),
('INTERMEDIAÇÃO DE MÃO DE OBRA', 9, 2),
('ORIENTAÇÃO CTPS DIGITAL/SEGURO DESEMPREGO DIGITAL', 9, 2),
('ACERTOS', 9, 2),
('INFORMAÇÕES/DIVERSOS', 9, 2),
('OUTROS', 9, 2);

-- CAS (unidade: CARUARU)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('EMISSÃO DE CONTRACHEQUES', 10, 2),
('SOLICITAÇÕES DIVERSAS/EMAIL/PERÍCIAS', 10, 2),
('EMISSÃO DO INFORME DE RENDIMENTO', 10, 2),
('CADASTRO DE SENHA DO SERVIDOR DO ESTADO', 10, 2),
('RECADASTRAMENTO DO SERVIDOR', 10, 2),
('SOLICITAÇÃO DE ALTERAÇÃO DE DADOS CADASTRAIS', 10, 2),
('SIMULAÇÃO DE APOSENTADORIA', 10, 2),
('SOLICITAÇÃO DA FICHA FINANCEIRA', 10, 2),
('PERICIA MÉDICA', 10, 2),
('INFORMAÇÕES DIVERSAS/ TELEFONE', 10, 2),
('OUTROS', 10, 2);

-- RECEITA FEDERAL (unidade: CARUARU)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('CONTA GOV.BR', 6, 2),
('CAEPF', 6, 2),
('CAFIR', 6, 2),
('CNO', 6, 2),
('CONSULTA PENDÊNCIA FÍSICA E CADASTRAL', 6, 2),
('CONSULTA MALHA FISCAL', 6, 2),
('CÓPIA DE PROCESSO', 6, 2),
('CÓPIA DE DEC. E COMPR. DE RENDIMENTO', 6, 2),
('CPF', 6, 2),
('EMISSÃO DE DOCUMENTO DE ARRECADAÇÃO', 6, 2),
('PROCURAÇÃO PFB', 6, 2),
('PROTOCOLO DE DOCUMENTOS', 6, 2),
('PROTOCOLO DE DOCUMENTOS - CNPJ', 6, 2),
('PROTOCOLO DE DOC. - REDARF/RETGPS', 6, 2),
('OUTROS', 6, 2);

-- INSS (unidade: CARUARU)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('BPC', 5, 2),
('CONSULTA DE BENEFÍCIOS', 5, 2),
('CONSULTA IDADE APOSENTADORIA', 5, 2),
('CONSULTA TEMPO DE CONTRIBUIÇÃO', 5, 2),
('INFORMAÇÕES APOSENTADORIA', 5, 2),
('REAGENDAR AVALIAÇÃO SOCIAL', 5, 2),
('TRANSFERIR BENEFÍCIO DE BANCO', 5, 2),
('OUTROS', 5, 2);

-- AGÊNCIA DO TRABALHO (unidade: GARANHUNS)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('SEGURO DESEMPREGO', 9, 3), 
('INTERMEDIAÇÃO DE MÃO DE OBRA', 9, 3), 
('ORIENTAÇÃO CTPS DIGITAL/SEGURO DESEMPREGO DIGITAL', 9, 3), 
('ACERTOS', 9, 3), 
('INFORMAÇÕES/DIVERSOS', 9, 3), 
('OUTROS', 9, 3);

-- FUNAPE (unidade: GARANHUNS)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('ATENDIMENTO DE ASSUNTOS DIVERSOS', 3, 3), 
('SOLICITAÇÃO DE PENSÃO POR MORTE/DIVERSOS PENSÃO', 3, 3), 
('COMUNICAÇÃO DE ÓBITO', 3, 3), 
('PROBLEMAS DE RECADASTRAMENTO/CÓPIA DE DOCUMENTOS', 3, 3), 
('ATENDIMENTO DE ASSUNTOS DE CTC/IR/INCLUSÃO DE CONTA CORRENTE', 3, 3), 
('EMISSÃO DE DECLARAÇÕES', 3, 3), 
('PROCESSOS DE PAGAMENTO A HERDEIROS/PAGAMENTO LICENÇA PRÊMIO/FICHA FINANCEIRA', 3, 3), 
('OUTROS', 3, 3);

-- CAS (unidade: GARANHUNS)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('EMISSÃO DE CONTRACHEQUES', 10, 3), 
('SOLICITAÇÕES DIVERSAS/EMAIL/PERÍCIAS', 10, 3), 
('EMISSÃO DO INFORME DE RENDIMENTO', 10, 3), 
('CADASTRO DE SENHA DO SERVIDOR DO ESTADO', 10, 3), 
('RECADASTRAMENTO DO SERVIDOR', 10, 3), 
('SOLICITAÇÃO DE ALTERAÇÃO DE DADOS CADASTRAIS', 10, 3), 
('SIMULAÇÃO DE APOSENTADORIA', 10, 3), 
('SOLICITAÇÃO DA FICHA FINANCEIRA', 10, 3), 
('PERICIA MÉDICA', 10, 3), 
('INFORMAÇÕES DIVERSAS/ TELEFONE', 10, 3), 
('OUTROS', 10, 3);

-- LAFEPE (unidade: GARANHUNS)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('OBTER MEDICAMENTOS', 8, 3), 
('OBTER ARMAÇÕES DE ÓCULOS DE GRAU E LENTES', 8, 3), 
('OUTROS', 8, 3);

-- PROCON (unidade: GARANHUNS)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('CIP', 7, 3), 
('REALIZAÇÃO DE AUDIÊNCIA DE CONCILIAÇÃO/RECLAMAÇÕES', 7, 3), 
('INFORMAÇÃO/ORIENTAÇÃO AO CONSUMIDOR', 7, 3), 
('OUTROS', 7, 3);

-- DETRAN (unidade: GARANHUNS)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('SERVIÇOS DE HABILITAÇÃO', 1, 3), 
('SERVIÇOS DE VEÍCULOS', 1, 3), 
('ENTREGAS DE DOCUMENTOS', 1, 3), 
('OUTROS', 1, 3);

-- PREFEITURA DE GARANHUNS (unidade: GARANHUNS)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('ATENDIMENTO GERAL', 11, 3), 
('EMISSÃO DE DOCUMENTOS', 11, 3), 
('OUTROS', 11, 3);

-- COMPESA (unidade: GARANHUNS)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('ARRECADAÇÃO', 4, 3), 
('CADASTRO', 4, 3), 
('COBRANÇA', 4, 3), 
('DIAGNÓSTICOS', 4, 3), 
('DOCUMENTOS', 4, 3), 
('FATURAMENTO', 4, 3), 
('FISCALIZAÇÃO', 4, 3), 
('INFORMAÇÃO COMERCIAL ESGOTO', 4, 3), 
('INFORMAÇÃO OPERACIONAL ÁGUA', 4, 3), 
('INFORMAÇÃO OPERACIONAL ESGOTO', 4, 3), 
('MACROMEDIÇÃO', 4, 3), 
('MICROMEDIÇÃO', 4, 3), 
('OBRAS-ÁGUA', 4, 3), 
('OBRAS-ESGOTO', 4, 3), 
('OPERACIONAL ÁGUA', 4, 3), 
('OPERACIONAL ESGOTO', 4, 3), 
('OUTROS', 4, 3);

-- JUCEPE (unidade: GARANHUNS)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('ABERTURA', 12, 3), 
('ALTERAÇÃO DE EMPRESA', 12, 3), 
('BAIXA DE EMPRESA', 12, 3), 
('CERTIDÕES', 12, 3), 
('OUTROS', 12, 3);

-- SDS-IITB (unidade: GARANHUNS)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('EMISSÃO DE RG 1° VIA', 2, 3), 
('EMISSÃO DE RG 2° VIA',2,3),
('EXIGÊNCIA',2,3),
('ENTREGA DE RG', 2, 3), 
('ATENDIMENTO WHATSAPP', 2, 3), 
('OUTROS', 2, 3);
-- CBM-PE (unidade: GARANHUNS)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('Entrada para Aquisição de Atestado de Regularidade', 13, 3), 
('Emissão de Atestado de Regularidade', 13, 3), 
('Renovação de Atestado de Regularidade', 13, 3), 
('Requerimento de Certidão (Seguro DPVAT/Cartório)', 13, 3), 
('TPEI (Taxa de Prevenção e Extinção de Incêndio)', 13, 3), 
('OUTROS', 13, 3);

-- CIEE (unidade: GARANHUNS)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('CADASTRO ATUALIZADOS', 14, 3), 
('ENCAMINHADOS', 14, 3), 
('CONTRATOS EMITIDOS', 14, 3), 
('RENOVAÇÕES EMITIDAS', 14, 3), 
('RELATÓRIOS RA ENTREGUES', 14, 3), 
('APRENDIZES ENCAMINHADOS', 14, 3), 
('APRENDIZES MATRICULADOS', 14, 3), 
('OUTROS', 14, 3);

-- PE-CONSIG (unidade: GARANHUNS)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('AUXÍLIO NO ACESSO À PLATAFORMA DO PECONSIG', 15, 3);

-- AGENDAMENTO/DAE/CPF (unidade: GARANHUNS)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('AGENDAMENTO', 16, 3);

-- RECEITA FEDERAL (unidade: GARANHUNS)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('CONTA GOV.BR', 6, 3), 
('CAEPF', 6, 3), 
('CAFIR', 6, 3), 
('CNO', 6, 3), 
('CONSULTA PENDÊNCIA FÍSICA E CADASTRAL', 6, 3), 
('CONSULTA MALHA FISCAL', 6, 3), 
('CÓPIA DE PROCESSO', 6, 3), 
('CÓPIA DE DEC. E COMPR. DE RENDIMENTO', 6, 3), 
('CPF', 6, 3), 
('EMISSÃO DE DOCUMENTO DE ARRECADAÇÃO', 6, 3), 
('PROCURAÇÃO PFB', 6, 3), 
('PROTOCOLO DE DOCUMENTOS', 6, 3), 
('PROTOCOLO DE DOCUMENTOS - CNPJ', 6, 3), 
('PROTOCOLO DE DOC. - REDARF/RETGPS', 6, 3), 
('OUTROS', 6, 3);

-- INSS (unidade: GARANHUNS)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('BPC', 5, 3), 
('CONSULTA DE BENEFÍCIOS', 5, 3), 
('CONSULTA IDADE APOSENTADORIA', 5, 3), 
('CONSULTA TEMPO DE CONTRIBUIÇÃO', 5, 3), 
('INFORMAÇÕES APOSENTADORIA', 5, 3), 
('REAGENDAR AVALIAÇÃO SOCIAL', 5, 3), 
('TRANSFERIR BENEFÍCIO DE BANCO', 5, 3), 
('OUTROS', 5, 3);


-- SDS-IITB (unidade: OLINDA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('EMISSÃO DE RG 1° VIA', 2, 4), 
('EMISSÃO DE RG 2° VIA',2,4),
('EXIGÊNCIA',2,4),
('ENTREGA DE RG', 2, 4), 
('ATENDIMENTO WHATSAPP', 2, 4), 
('OUTROS', 2, 4);
-- COMPESA (unidade: OLINDA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('ARRECADAÇÃO', 4, 4), 
('CADASTRO', 4, 4), 
('COBRANÇA', 4, 4), 
('DIAGNÓSTICOS', 4, 4), 
('DOCUMENTOS', 4, 4), 
('FATURAMENTO', 4, 4), 
('FISCALIZAÇÃO', 4, 4), 
('INFORMAÇÃO COMERCIAL ESGOTO', 4, 4), 
('INFORMAÇÃO OPERACIONAL ÁGUA', 4, 4), 
('INFORMAÇÃO OPERACIONAL ESGOTO', 4, 4), 
('MACROMEDIÇÃO', 4, 4), 
('MICROMEDIÇÃO', 4, 4), 
('OBRAS-ÁGUA', 4, 4), 
('OBRAS-ESGOTO', 4, 4), 
('OPERACIONAL ÁGUA', 4, 4), 
('OPERACIONAL ESGOTO', 4, 4), 
('OUTROS', 4, 4);

-- AGÊNCIA DO TRABALHO (unidade: OLINDA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('SEGURO DESEMPREGO', 9, 4), 
('INTERMEDIAÇÃO DE MÃO DE OBRA', 9, 4), 
('ORIENTAÇÃO CTPS DIGITAL/SEGURO DESEMPREGO DIGITAL', 9, 4), 
('ACERTOS', 9, 4), 
('INFORMAÇÕES/DIVERSOS', 9, 4), 
('OUTROS', 9, 4);

-- PROCON (unidade: OLINDA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('CIP', 7, 4), 
('REALIZAÇÃO DE AUDIÊNCIA DE CONCILIAÇÃO/RECLAMAÇÕES', 7, 4), 
('INFORMAÇÃO/ORIENTAÇÃO AO CONSUMIDOR', 7, 4), 
('OUTROS', 7, 4);

-- DETRAN (unidade: OLINDA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('SERVIÇOS DE HABILITAÇÃO', 1, 4), 
('SERVIÇOS DE VEÍCULOS', 1, 4), 
('ENTREGAS DE DOCUMENTOS', 1, 4), 
('OUTROS', 1, 4);

-- INSS (unidade: OLINDA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('BPC', 5, 4), 
('CONSULTA DE BENEFÍCIOS', 5, 4), 
('CONSULTA IDADE APOSENTADORIA', 5, 4), 
('CONSULTA TEMPO DE CONTRIBUIÇÃO', 5, 4), 
('INFORMAÇÕES APOSENTADORIA', 5, 4), 
('REAGENDAR AVALIAÇÃO SOCIAL', 5, 4), 
('TRANSFERIR BENEFÍCIO DE BANCO', 5, 4), 
('OUTROS', 5, 4);

-- RECEITA FEDERAL (unidade: OLINDA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('CONTA GOV.BR', 6, 4), 
('CAEPF', 6, 4), 
('CAFIR', 6, 4), 
('CNO', 6, 4), 
('CONSULTA PENDÊNCIA FÍSICA E CADASTRAL', 6, 4), 
('CONSULTA MALHA FISCAL', 6, 4), 
('CÓPIA DE PROCESSO', 6, 4), 
('CÓPIA DE DEC. E COMPR. DE RENDIMENTO', 6, 4), 
('CPF', 6, 4), 
('EMISSÃO DE DOCUMENTO DE ARRECADAÇÃO', 6, 4), 
('PROCURAÇÃO PFB', 6, 4), 
('PROTOCOLO DE DOCUMENTOS', 6, 4), 
('PROTOCOLO DE DOCUMENTOS - CNPJ', 6, 4), 
('PROTOCOLO DE DOC. - REDARF/RETGPS', 6, 4), 
('OUTROS', 6, 4);

-- CAPITANIA DOS PORTOS (unidade: OLINDA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('Aquaviários e embarcações', 17, 4), 
('Veteranos e pensionistas', 17, 4), 
('OUTROS', 17, 4);

-- TRE/PE (unidade: OLINDA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('ALISTAMENTO (1ª VIA DO TÍTULO)', 18, 4), 
('TRANSFERÊNCIA ELEITORAL', 18, 4), 
('REVISÃO ELEITORAL', 18, 4), 
('OUTROS', 18, 4);

-- FUNAPE (unidade: OLINDA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('ATENDIMENTO DE ASSUNTOS DIVERSOS', 3, 4), 
('SOLICITAÇÃO DE PENSÃO POR MORTE/DIVERSOS PENSÃO', 3, 4), 
('COMUNICAÇÃO DE ÓBITO', 3, 4), 
('PROBLEMAS DE RECADASTRAMENTO/CÓPIA DE DOCUMENTOS', 3, 4), 
('ATENDIMENTO DE ASSUNTOS DE CTC/IR/INCLUSÃO DE CONTA CORRENTE', 3, 4), 
('EMISSÃO DE DECLARAÇÕES', 3, 4), 
('PROCESSOS DE PAGAMENTO A HERDEIROS/PAGAMENTO LICENÇA PRÊMIO/FICHA FINANCEIRA', 3, 4), 
('OUTROS', 3, 4);

-- CIEE (unidade: OLINDA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('CADASTRO ATUALIZADOS', 14, 4), 
('ENCAMINHADOS', 14, 4), 
('CONTRATOS EMITIDOS', 14, 4), 
('RENOVAÇÕES EMITIDAS', 14, 4), 
('RELATÓRIOS RA ENTREGUES', 14, 4), 
('APRENDIZES ENCAMINHADOS', 14, 4), 
('APRENDIZES MATRICULADOS', 14, 4), 
('OUTROS', 14, 4);


-- COMPESA (unidade: PETROLINA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('ARRECADAÇÃO', 4, 5), 
('CADASTRO', 4, 5), 
('COBRANÇA', 4, 5), 
('DIAGNÓSTICOS', 4, 5), 
('DOCUMENTOS', 4, 5), 
('FATURAMENTO', 4, 5), 
('FISCALIZAÇÃO', 4, 5), 
('INFORMAÇÃO COMERCIAL ESGOTO', 4, 5), 
('INFORMAÇÃO OPERACIONAL ÁGUA', 4, 5), 
('INFORMAÇÃO OPERACIONAL ESGOTO', 4, 5), 
('MACROMEDIÇÃO', 4, 5), 
('MICROMEDIÇÃO', 4, 5), 
('OBRAS-ÁGUA', 4, 5), 
('OBRAS-ESGOTO', 4, 5), 
('OPERACIONAL ÁGUA', 4, 5), 
('OPERACIONAL ESGOTO', 4, 5), 
('OUTROS', 4, 5);

-- DETRAN (unidade: PETROLINA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('SERVIÇOS DE HABILITAÇÃO', 1, 5), 
('SERVIÇOS DE VEÍCULOS', 1, 5), 
('ENTREGAS DE DOCUMENTOS', 1, 5), 
('OUTROS', 1, 5);

-- SDS-IITB (unidade: PETROLINA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('EMISSÃO DE RG 1° VIA', 2, 5), 
('EMISSÃO DE RG 2° VIA',2,5),
('EXIGÊNCIA',2,5),
('ENTREGA DE RG', 2, 5), 
('ATENDIMENTO WHATSAPP', 2, 5), 
('OUTROS', 2, 5);

-- FUNAPE (unidade: PETROLINA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('ATENDIMENTO DE ASSUNTOS DIVERSOS', 3, 5), 
('SOLICITAÇÃO DE PENSÃO POR MORTE/DIVERSOS PENSÃO', 3, 5), 
('COMUNICAÇÃO DE ÓBITO', 3, 5), 
('PROBLEMAS DE RECADASTRAMENTO/CÓPIA DE DOCUMENTOS', 3, 5), 
('ATENDIMENTO DE ASSUNTOS DE CTC/IR/INCLUSÃO DE CONTA CORRENTE', 3, 5), 
('EMISSÃO DE DECLARAÇÕES', 3, 5), 
('PROCESSOS DE PAGAMENTO A HERDEIROS/PAGAMENTO LICENÇA PRÊMIO/FICHA FINANCEIRA', 3, 5), 
('OUTROS', 3, 5);

-- CPF (unidade: PETROLINA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('CONSULTA CPF', 19, 5), 
('EMISSÃO DE CPF', 19, 5), 
('OUTROS', 19, 5);

-- CAS (unidade: PETROLINA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('EMISSÃO DE CONTRACHEQUES', 10, 5), 
('SOLICITAÇÕES DIVERSAS/EMAIL/PERÍCIAS', 10, 5), 
('EMISSÃO DO INFORME DE RENDIMENTO', 10, 5), 
('CADASTRO DE SENHA DO SERVIDOR DO ESTADO', 10, 5), 
('RECADASTRAMENTO DO SERVIDOR', 10, 5), 
('SOLICITAÇÃO DE ALTERAÇÃO DE DADOS CADASTRAIS', 10, 5), 
('SIMULAÇÃO DE APOSENTADORIA', 10, 5), 
('SOLICITAÇÃO DA FICHA FINANCEIRA', 10, 5), 
('PERICIA MÉDICA', 10, 5), 
('INFORMAÇÕES DIVERSAS/ TELEFONE', 10, 5), 
('OUTROS', 10, 5);

-- CBM-PE (unidade: PETROLINA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('Entrada para Aquisição de Atestado de Regularidade', 13, 5), 
('Emissão de Atestado de Regularidade', 13, 5), 
('Renovação de Atestado de Regularidade', 13, 5), 
('Requerimento de Certidão (Seguro DPVAT/Cartório)', 13, 5), 
('TPEI (Taxa de Prevenção e Extinção de Incêndio)', 13, 5), 
('OUTROS', 13, 5);

-- CDL (unidade: PETROLINA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('CONSULTAS SPC E SERASA', 20, 5), 
('CERTIFICADO DIGITAL (PF E PJ)', 20, 5), 
('BOLETO MEI (MICRO EMPREENDEDOR INDIVIDUAL)', 20, 5), 
('CADASTRO POSITIVO', 20, 5), 
('SPC AVISA', 20, 5), 
('ALERTA DE DOCUMENTOS', 20, 5), 
('OUTROS', 20, 5);

-- AMMPLA (unidade: PETROLINA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('ATENDIMENTO GERAL', 21, 5), 
('REAL INFRATOR', 21, 5), 
('DEFESA PRÉVIA', 21, 5), 
('RECURSOS', 21, 5), 
('CREDENCIAL IDOSO', 21, 5), 
('CREDENCIAL ESPECIAL', 21, 5), 
('CREDENCIAL GESTANTE', 21, 5), 
('BOLETIM DE OCORRÊNCIA', 21, 5), 
('DAM - BO', 21, 5), 
('CREDENCIAL ZONA AZUL', 21, 5), 
('CREDENCIAL +15 METROS', 21, 5), 
('OUTROS', 21, 5);

-- INSS (unidade: PETROLINA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('BPC', 5, 5), 
('CONSULTA DE BENEFÍCIOS', 5, 5), 
('CONSULTA IDADE APOSENTADORIA', 5, 5), 
('CONSULTA TEMPO DE CONTRIBUIÇÃO', 5, 5), 
('INFORMAÇÕES APOSENTADORIA', 5, 5), 
('REAGENDAR AVALIAÇÃO SOCIAL', 5, 5), 
('TRANSFERIR BENEFÍCIO DE BANCO', 5, 5), 
('OUTROS', 5, 5);

-- POLICIA FEDERAL (unidade: PETROLINA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('EMISSÃO DE PASSAPORTE', 22, 5), 
('OUTROS', 22, 5);

-- PROCON (unidade: PINA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('CIP', 7, 6), 
('REALIZAÇÃO DE AUDIÊNCIA DE CONCILIAÇÃO/RECLAMAÇÕES', 7, 6), 
('INFORMAÇÃO/ORIENTAÇÃO AO CONSUMIDOR', 7, 6), 
('OUTROS', 7, 6);

-- FUNAPE (unidade: PINA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('ATENDIMENTO DE ASSUNTOS DIVERSOS', 3, 6), 
('SOLICITAÇÃO DE PENSÃO POR MORTE/DIVERSOS PENSÃO', 3, 6), 
('COMUNICAÇÃO DE ÓBITO', 3, 6), 
('PROBLEMAS DE RECADASTRAMENTO/CÓPIA DE DOCUMENTOS', 3, 6), 
('ATENDIMENTO DE ASSUNTOS DE CTC/IR/INCLUSÃO DE CONTA CORRENTE', 3, 6), 
('EMISSÃO DE DECLARAÇÕES', 3, 6), 
('PROCESSOS DE PAGAMENTO A HERDEIROS/PAGAMENTO LICENÇA PRÊMIO/FICHA FINANCEIRA', 3, 6), 
('OUTROS', 3, 6);



-- AGÊNCIA DO TRABALHO (unidade: PINA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('SEGURO DESEMPREGO', 9, 6), 
('INTERMEDIAÇÃO DE MÃO DE OBRA', 9, 6), 
('ORIENTAÇÃO CTPS DIGITAL/SEGURO DESEMPREGO DIGITAL', 9, 6), 
('ACERTOS', 9, 6), 
('INFORMAÇÕES/DIVERSOS', 9, 6), 
('OUTROS', 9, 6);

-- DETRAN (unidade: PINA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('SERVIÇOS DE HABILITAÇÃO', 1, 6), 
('SERVIÇOS DE VEÍCULOS', 1, 6), 
('ENTREGAS DE DOCUMENTOS', 1, 6), 
('OUTROS', 1, 6);

-- COMPESA (unidade: PINA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('ARRECADAÇÃO', 4, 6), 
('CADASTRO', 4, 6), 
('COBRANÇA', 4, 6), 
('DIAGNÓSTICOS', 4, 6), 
('DOCUMENTOS', 4, 6), 
('FATURAMENTO', 4, 6), 
('FISCALIZAÇÃO', 4, 6), 
('INFORMAÇÃO COMERCIAL ESGOTO', 4, 6), 
('INFORMAÇÃO OPERACIONAL ÁGUA', 4, 6), 
('INFORMAÇÃO OPERACIONAL ESGOTO', 4, 6), 
('MACROMEDIÇÃO', 4, 6), 
('MICROMEDIÇÃO', 4, 6), 
('OBRAS-ÁGUA', 4, 6), 
('OBRAS-ESGOTO', 4, 6), 
('OPERACIONAL ÁGUA', 4, 6), 
('OPERACIONAL ESGOTO', 4, 6), 
('OUTROS', 4, 6);

-- SDS-IITB (unidade: PINA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('EMISSÃO DE RG 1° VIA', 2, 6), 
('EMISSÃO DE RG 2° VIA',2,6),
('EXIGÊNCIA',2,6),
('ENTREGA DE RG', 2, 6), 
('ATENDIMENTO WHATSAPP', 2, 6), 
('OUTROS', 2, 6);
-- TRE/PE (unidade: PINA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('ALISTAMENTO (1ª VIA DO TÍTULO)', 18, 6), 
('TRANSFERÊNCIA ELEITORAL', 18, 6), 
('REVISÃO ELEITORAL', 18, 6), 
('OUTROS', 18, 6);

-- CAPITANIA DOS PORTOS (unidade: PINA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('Aquaviários e embarcações', 17, 6), 
('Veteranos e pensionistas', 17, 6), 
('OUTROS', 17, 6);

-- RECEITA FEDERAL (unidade: PINA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('CONTA GOV.BR', 6, 6), 
('CAEPF', 6, 6), 
('CAFIR', 6, 6), 
('CNO', 6, 6), 
('CONSULTA PENDÊNCIA FÍSICA E CADASTRAL', 6, 6), 
('CONSULTA MALHA FISCAL', 6, 6), 
('CÓPIA DE PROCESSO', 6, 6), 
('CÓPIA DE DEC. E COMPR. DE RENDIMENTO', 6, 6), 
('CPF', 6, 6), 
('EMISSÃO DE DOCUMENTO DE ARRECADAÇÃO', 6, 6), 
('PROCURAÇÃO PFB', 6, 6), 
('PROTOCOLO DE DOCUMENTOS', 6, 6), 
('PROTOCOLO DE DOCUMENTOS - CNPJ', 6, 6), 
('PROTOCOLO DE DOC. - REDARF/RETGPS', 6, 6), 
('OUTROS', 6, 6);

-- INSS (unidade: PINA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('BPC', 5, 6), 
('CONSULTA DE BENEFÍCIOS', 5, 6), 
('CONSULTA IDADE APOSENTADORIA', 5, 6), 
('CONSULTA TEMPO DE CONTRIBUIÇÃO', 5, 6), 
('INFORMAÇÕES APOSENTADORIA', 5, 6), 
('REAGENDAR AVALIAÇÃO SOCIAL', 5, 6), 
('TRANSFERIR BENEFÍCIO DE BANCO', 5, 6), 
('OUTROS', 5, 6);

-- AGÊNCIA DO TRABALHO (unidade: SALGUEIRO)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('SEGURO DESEMPREGO', 9, 7), 
('INTERMEDIAÇÃO DE MÃO DE OBRA', 9, 7), 
('ORIENTAÇÃO CTPS DIGITAL/SEGURO DESEMPREGO DIGITAL', 9, 7), 
('ACERTOS', 9, 7), 
('INFORMAÇÕES/DIVERSOS', 9, 7), 
('OUTROS', 9, 7);

-- EXPRESSO EMPREENDEDOR (unidade: SALGUEIRO)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('INFORMAÇÕES GERAIS', 23, 7), 
('ORIENTAÇÃO PARA ABERTURA DE EMPRESA', 23, 7), 
('ORIENTAÇÃO PARA ALTERAÇÃO DE EMPRESA', 23, 7), 
('ORIENTAÇÃO PARA BAIXA DE EMPRESA', 23, 7), 
('OUTROS', 23, 7);

-- SDS-IITB (unidade: SALGUEIRO)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('EMISSÃO DE RG 1° VIA', 2, 7), 
('EMISSÃO DE RG 2° VIA',2,7),
('EXIGÊNCIA',2,7),
('ENTREGA DE RG', 2, 7), 
('ATENDIMENTO WHATSAPP', 2, 7), 
('OUTROS', 2, 7);
-- COMPESA (unidade: SALGUEIRO)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('ARRECADAÇÃO', 4, 7), 
('CADASTRO', 4, 7), 
('COBRANÇA', 4, 7), 
('DIAGNÓSTICOS', 4, 7), 
('DOCUMENTOS', 4, 7), 
('FATURAMENTO', 4, 7), 
('FISCALIZAÇÃO', 4, 7), 
('INFORMAÇÃO COMERCIAL ESGOTO', 4, 7), 
('INFORMAÇÃO OPERACIONAL ÁGUA', 4, 7), 
('INFORMAÇÃO OPERACIONAL ESGOTO', 4, 7), 
('MACROMEDIÇÃO', 4, 7), 
('MICROMEDIÇÃO', 4, 7), 
('OBRAS-ÁGUA', 4, 7), 
('OBRAS-ESGOTO', 4, 7), 
('OPERACIONAL ÁGUA', 4, 7), 
('OPERACIONAL ESGOTO', 4, 7), 
('OUTROS', 4, 7);

-- FUNAPE (unidade: SALGUEIRO)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('ATENDIMENTO DE ASSUNTOS DIVERSOS', 3, 7), 
('SOLICITAÇÃO DE PENSÃO POR MORTE/DIVERSOS PENSÃO', 3, 7), 
('COMUNICAÇÃO DE ÓBITO', 3, 7), 
('PROBLEMAS DE RECADASTRAMENTO/CÓPIA DE DOCUMENTOS', 3, 7), 
('ATENDIMENTO DE ASSUNTOS DE CTC/IR/INCLUSÃO DE CONTA CORRENTE', 3, 7), 
('EMISSÃO DE DECLARAÇÕES', 3, 7), 
('PROCESSOS DE PAGAMENTO A HERDEIROS/PAGAMENTO LICENÇA PRÊMIO/FICHA FINANCEIRA', 3, 7), 
('OUTROS', 3, 7);

-- JUCEPE (unidade: SALGUEIRO)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('ABERTURA', 12, 7), 
('ALTERAÇÃO DE EMPRESA', 12, 7), 
('BAIXA DE EMPRESA', 12, 7), 
('CERTIDÕES', 12, 7), 
('OUTROS', 12, 7);




-- CPF (unidade: SALGUEIRO)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('CONSULTA CPF', 19, 7), 
('EMISSÃO DE CPF', 19, 7), 
('OUTROS', 19, 7);

-- DETRAN (unidade: SALGUEIRO)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('SERVIÇOS DE HABILITAÇÃO', 1, 7), 
('SERVIÇOS DE VEÍCULOS', 1, 7), 
('ENTREGAS DE DOCUMENTOS', 1, 7), 
('OUTROS', 1, 7);

-- RECEITA FEDERAL (unidade: SALGUEIRO)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('CONTA GOV.BR', 6, 7), 
('CAEPF', 6, 7), 
('CAFIR', 6, 7), 
('CNO', 6, 7), 
('CONSULTA PENDÊNCIA FÍSICA E CADASTRAL', 6, 7), 
('CONSULTA MALHA FISCAL', 6, 7), 
('CÓPIA DE PROCESSO', 6, 7), 
('CÓPIA DE DEC. E COMPR. DE RENDIMENTO', 6, 7), 
('CPF', 6, 7), 
('EMISSÃO DE DOCUMENTO DE ARRECADAÇÃO', 6, 7), 
('PROCURAÇÃO PFB', 6, 7), 
('PROTOCOLO DE DOCUMENTOS', 6, 7), 
('PROTOCOLO DE DOCUMENTOS - CNPJ', 6, 7), 
('PROTOCOLO DE DOC. - REDARF/RETGPS', 6, 7), 
('OUTROS', 6, 7);

-- INSS (unidade: SALGUEIRO)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('BPC', 5, 7), 
('CONSULTA DE BENEFÍCIOS', 5, 7), 
('CONSULTA IDADE APOSENTADORIA', 5, 7), 
('CONSULTA TEMPO DE CONTRIBUIÇÃO', 5, 7), 
('INFORMAÇÕES APOSENTADORIA', 5, 7), 
('REAGENDAR AVALIAÇÃO SOCIAL', 5, 7), 
('TRANSFERIR BENEFÍCIO DE BANCO', 5, 7), 
('OUTROS', 5, 7);

-- SDS-IITB (unidade: VITÓRIA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('EMISSÃO DE RG 1° VIA', 2, 8), 
('EMISSÃO DE RG 2° VIA',2,8),
('EXIGÊNCIA',2,8),
('ENTREGA DE RG', 2, 8), 
('ATENDIMENTO WHATSAPP', 2, 8), 
('OUTROS', 2, 8);
-- FUNAPE (unidade: VITÓRIA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('ATENDIMENTO DE ASSUNTOS DIVERSOS', 3, 8), 
('SOLICITAÇÃO DE PENSÃO POR MORTE/DIVERSOS PENSÃO', 3, 8), 
('COMUNICAÇÃO DE ÓBITO', 3, 8), 
('PROBLEMAS DE RECADASTRAMENTO/CÓPIA DE DOCUMENTOS', 3, 8), 
('ATENDIMENTO DE ASSUNTOS DE CTC/IR/INCLUSÃO DE CONTA CORRENTE', 3, 8), 
('EMISSÃO DE DECLARAÇÕES', 3, 8), 
('PROCESSOS DE PAGAMENTO A HERDEIROS/PAGAMENTO LICENÇA PRÊMIO/FICHA FINANCEIRA', 3, 8), 
('OUTROS', 3, 8);

-- PROCON (unidade: VITÓRIA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('CIP', 7, 8), 
('REALIZAÇÃO DE AUDIÊNCIA DE CONCILIAÇÃO/RECLAMAÇÕES', 7, 8), 
('INFORMAÇÃO/ORIENTAÇÃO AO CONSUMIDOR', 7, 8), 
('OUTROS', 7, 8);

-- COMPESA (unidade: VITÓRIA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('ARRECADAÇÃO', 4, 8), 
('CADASTRO', 4, 8), 
('COBRANÇA', 4, 8), 
('DIAGNÓSTICOS', 4, 8), 
('DOCUMENTOS', 4, 8), 
('FATURAMENTO', 4, 8), 
('FISCALIZAÇÃO', 4, 8), 
('INFORMAÇÃO COMERCIAL ESGOTO', 4, 8), 
('INFORMAÇÃO OPERACIONAL ÁGUA', 4, 8), 
('INFORMAÇÃO OPERACIONAL ESGOTO', 4, 8), 
('MACROMEDIÇÃO', 4, 8), 
('MICROMEDIÇÃO', 4, 8), 
('OBRAS-ÁGUA', 4, 8), 
('OBRAS-ESGOTO', 4, 8), 
('OPERACIONAL ÁGUA', 4, 8), 
('OPERACIONAL ESGOTO', 4, 8), 
('OUTROS', 4, 8);

-- RECEITA FEDERAL (unidade: VITÓRIA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('CONTA GOV.BR', 6, 8), 
('CAEPF', 6, 8), 
('CAFIR', 6, 8), 
('CNO', 6, 8), 
('CONSULTA PENDÊNCIA FÍSICA E CADASTRAL', 6, 8), 
('CONSULTA MALHA FISCAL', 6, 8), 
('CÓPIA DE PROCESSO', 6, 8), 
('CÓPIA DE DEC. E COMPR. DE RENDIMENTO', 6, 8), 
('CPF', 6, 8), 
('EMISSÃO DE DOCUMENTO DE ARRECADAÇÃO', 6, 8), 
('PROCURAÇÃO PFB', 6, 8), 
('PROTOCOLO DE DOCUMENTOS', 6, 8), 
('PROTOCOLO DE DOCUMENTOS - CNPJ', 6, 8), 
('PROTOCOLO DE DOC. - REDARF/RETGPS', 6, 8), 
('OUTROS', 6, 8);

-- INSS (unidade: VITÓRIA)
INSERT INTO servicos (nome, orgao_id, unidade_id) VALUES
('BPC', 5, 8), 
('CONSULTA DE BENEFÍCIOS', 5, 8), 
('CONSULTA IDADE APOSENTADORIA', 5, 8), 
('CONSULTA TEMPO DE CONTRIBUIÇÃO', 5, 8), 
('INFORMAÇÕES APOSENTADORIA', 5, 8), 
('REAGENDAR AVALIAÇÃO SOCIAL', 5, 8), 
('TRANSFERIR BENEFÍCIO DE BANCO', 5, 8), 
('OUTROS', 5, 8);

    
    SELECT * FROM unidade_detalhada;
   