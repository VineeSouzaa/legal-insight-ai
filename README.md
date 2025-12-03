# Legal Insight AI 🏛️

Sistema de análise inteligente de documentos legais usando IA (h2oGPT) para extrair, classificar e analisar contratos, legislações e petições.

## 🚀 Funcionalidades

📘 **1) Receber documentos legais (PDF, DOCX, TXT)**

Você envia um contrato, legislação ou petição.

🧠 **2) Extrair texto e limpar conteúdo**

Usa:
- pdf-parse
- mammoth (para docx)
- normalização de acentos
- separação por seções

📌 **3) Classificar tipo do documento**

IA responde:
- contrato?
- lei?
- petição?
- sentença?
- parecer?

🔍 **4) Identificar tópicos jurídicos importantes**

Como:
- obrigações
- penalidades
- direitos
- riscos
- prazos
- referências legais

📑 **5) Criar um resumo profissional**

Resumo jurídico em linguagem clara ou técnica.

🧬 **6) Criar embeddings do texto**

Armazena no Postgres pgvector.

Isso serve para:
- buscas semânticas
- comparação entre documentos
- "onde este contrato contradiz o anterior?"

⚠️ **7) Identificar riscos e inconsistências (não julgamento!)**

Tipo:
- cláusulas ambíguas
- termos contraditórios
- falta de especificação
- obrigações unilaterais

📚 **8) Conectar artigos semelhantes**

Ex.:
"Este contrato trata de responsabilidade civil → veja artigos relacionados do Código Civil."

📎 **9) Criar perguntas jurídicas automatizadas**

Ex.:
- Existe cláusula de rescisão?
- Há previsão de multas por descumprimento?

Isso é ouro para advogados.

## 🐳 Executando com Docker

### Pré-requisitos
- Docker e Docker Compose instalados
- Pelo menos 8GB de RAM disponível (para h2oGPT)

### Iniciar todos os serviços

```bash
# Produção
docker-compose up -d

# Desenvolvimento (com hot reload)
docker-compose -f docker-compose.dev.yml up -d
```

### Serviços disponíveis

- **API NestJS**: http://localhost:3000
- **h2oGPT Interface Web**: http://localhost:7860
- **h2oGPT API**: http://localhost:7861
- **PostgreSQL**: localhost:5432
  - User: `legal_user`
  - Password: `legal_pass`
  - Database: `legal_db`

### Parar os serviços

```bash
docker-compose down

# Remover volumes também
docker-compose down -v
```

### Ver logs

```bash
# Todos os serviços
docker-compose logs -f

# Apenas API
docker-compose logs -f app

# Apenas h2oGPT
docker-compose logs -f h2ogpt
```

## 📦 Estrutura Docker

- `Dockerfile` - Imagem da aplicação NestJS
- `Dockerfile.h2ogpt` - Imagem do h2oGPT para análise de IA
- `docker-compose.yml` - Orquestração para produção
- `docker-compose.dev.yml` - Orquestração para desenvolvimento
- `init-db.sql` - Script de inicialização do PostgreSQL com pgvector

## 🔧 Desenvolvimento Local (sem Docker)

```bash
# Instalar dependências
yarn install

# Rodar em modo desenvolvimento
yarn start:dev

# Build
yarn build

# Produção
yarn start:prod
```

## 📡 Integração com h2oGPT

A API do h2oGPT está disponível em `http://h2ogpt:7861` dentro da rede Docker.

Exemplo de uso na aplicação NestJS:

```typescript
const response = await fetch('http://h2ogpt:7861/api/v1/chat', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    instruction: 'Classifique este documento legal...',
    text: extractedText
  })
});
```

## 🗄️ Banco de Dados

O PostgreSQL com pgvector está configurado automaticamente com as seguintes tabelas:

- `documents` - Documentos legais
- `document_embeddings` - Embeddings para busca semântica
- `document_risks` - Riscos identificados
- `document_topics` - Tópicos jurídicos
- `document_questions` - Perguntas automatizadas
- `document_references` - Referências legais relacionadas