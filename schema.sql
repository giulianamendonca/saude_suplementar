-- Lista de operadoras
CREATE TABLE IF NOT EXISTS operadoras (
    id_operadora INTEGER,
    nome_operadora TEXT NOT NULL,
    porte TEXT NOT NULL,
    regiao TEXT NOT NULL,
    status_operadora TEXT NOT NULL,
    PRIMARY KEY (id_operadora)
);

-- Número de beneficiários por operadora
CREATE TABLE IF NOT EXISTS beneficiarios (
    linha INTEGER,
    id_operadora INTEGER NOT NULL,
    benef_marco INTEGER,
    benef_junho INTEGER,
    PRIMARY KEY (linha),
    FOREIGN KEY (id_operadora) REFERENCES operadoras (id_operadora)
);

-- Número de reclamações por operadora
CREATE TABLE IF NOT EXISTS reclamacoes (
    id INTEGER,
    id_operadora INTEGER NOT NULL,
    jan INTEGER,
    fev INTEGER,
    mar INTEGER,
    abr INTEGER,
    mai INTEGER,
    jun INTEGER,
    PRIMARY KEY (id),
    FOREIGN KEY (id_operadora) REFERENCES operadoras(id_operadora)
);

-- View contendo todas as informações (para importação em Python)
CREATE VIEW visao_geral AS
SELECT
    o.id_operadora,
    o.nome_operadora,
    o.porte,
    o.regiao,
    o.status_operadora,
    b.benef_marco,
    b.benef_junho,
    r.jan,
    r.fev,
    r.mar,
    r.abr,
    r.mai,
    r.jun
FROM operadoras o
JOIN beneficiarios b ON o.id_operadora = b.id_operadora
JOIN reclamacoes r ON o.id_operadora = r.id_operadora;

-- Criar índices
CREATE INDEX index_operadoras ON operadoras (id_operadora, nome_operadora);
CREATE INDEX index_beneficiarios ON beneficiarios (id_operadora);
CREATE INDEX index_reclamacoes ON reclamacoes (id_operadora);
