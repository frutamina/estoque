-- 1. Tabela de Marcas (Itaueira, Samba, Cosa, etc.)
CREATE TABLE marcas (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

-- 2. Tabela de Tipos de Fruta (Amarelo, Pele de Sapo, Cantaloupe, etc.)
CREATE TABLE variedades (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

-- 3. O Coração do Estoque: Tabela de Pallets
CREATE TABLE estoque_pallets (
    id_qrcode UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- ID único do QR Code
    marca_id INT REFERENCES marcas(id),
    variedade_id INT REFERENCES variedades(id),
    calibre VARCHAR(10) NOT NULL, -- 3, 4, 5, 6, M...
    qualidade CHAR(1) DEFAULT 'A', -- 'A' (Mercado) ou 'B' (Manchado/Feira)
    lote VARCHAR(50),
    qtd_caixas_inicial INT, -- Quantidade que chegou
    qtd_caixas_atual INT,   -- O que sobrou após as "quebras"
    data_chegada TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'disponivel' -- 'disponivel', 'esgotado', 'descartado'
);

-- 4. Histórico de Movimentação (Para você saber quem mexeu e quando)
CREATE TABLE movimentacoes (
    id SERIAL PRIMARY KEY,
    pallet_id UUID REFERENCES estoque_pallets(id_qrcode),
    tipo_movimentacao VARCHAR(20), -- 'ENTRADA', 'SAIDA_PARCIAL', 'RECLASSIFICACAO', 'SAIDA_TOTAL'
    quantidade INT,
    motivo TEXT,
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);