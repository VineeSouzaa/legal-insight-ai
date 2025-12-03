-- Inicializar extensão pgvector para embeddings
CREATE EXTENSION IF NOT EXISTS vector;

-- Tabela para documentos legais
CREATE TABLE IF NOT EXISTS documents (
    id SERIAL PRIMARY KEY,
    filename VARCHAR(255) NOT NULL,
    file_type VARCHAR(50) NOT NULL,
    document_type VARCHAR(100), -- contrato, lei, petição, sentença, parecer
    text_content TEXT NOT NULL,
    summary TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela para embeddings dos documentos
CREATE TABLE IF NOT EXISTS document_embeddings (
    id SERIAL PRIMARY KEY,
    document_id INTEGER REFERENCES documents(id) ON DELETE CASCADE,
    chunk_text TEXT NOT NULL,
    embedding vector(384), -- dimensão do embedding (ajustar conforme modelo)
    chunk_index INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Índice para busca semântica
CREATE INDEX IF NOT EXISTS document_embeddings_vector_idx 
ON document_embeddings 
USING ivfflat (embedding vector_cosine_ops)
WITH (lists = 100);

-- Índice para busca por documento
CREATE INDEX IF NOT EXISTS document_embeddings_document_id_idx 
ON document_embeddings(document_id);

-- Tabela para análise de riscos e inconsistências
CREATE TABLE IF NOT EXISTS document_risks (
    id SERIAL PRIMARY KEY,
    document_id INTEGER REFERENCES documents(id) ON DELETE CASCADE,
    risk_type VARCHAR(100) NOT NULL, -- cláusula_ambígua, termo_contraditório, etc
    description TEXT NOT NULL,
    severity VARCHAR(20), -- low, medium, high
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela para tópicos jurídicos identificados
CREATE TABLE IF NOT EXISTS document_topics (
    id SERIAL PRIMARY KEY,
    document_id INTEGER REFERENCES documents(id) ON DELETE CASCADE,
    topic_type VARCHAR(50) NOT NULL, -- obrigação, penalidade, direito, risco, prazo, referência_legal
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela para perguntas jurídicas automatizadas
CREATE TABLE IF NOT EXISTS document_questions (
    id SERIAL PRIMARY KEY,
    document_id INTEGER REFERENCES documents(id) ON DELETE CASCADE,
    question TEXT NOT NULL,
    answer TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela para conexões entre documentos e artigos relacionados
CREATE TABLE IF NOT EXISTS document_references (
    id SERIAL PRIMARY KEY,
    document_id INTEGER REFERENCES documents(id) ON DELETE CASCADE,
    reference_type VARCHAR(50), -- código_civil, código_penal, etc
    reference_text TEXT NOT NULL,
    similarity_score FLOAT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

