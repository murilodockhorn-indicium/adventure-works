# 🚴‍♂️ Adventure Works - Modern Data Stack & Analytics Engineering

Repositório oficial do projeto de Engenharia de Analytics desenvolvido para a **Adventure Works**, aplicando os conceitos de Modern Data Stack (MDS), Modelagem Dimensional e Governança de Dados com dbt e Databricks.

---

## 🎯 Sobre o Projeto
Este projeto tem como objetivo estruturar uma plataforma analítica moderna para a Adventure Works, garantindo alta confiabilidade nos dados financeiros e fornecendo suporte para decisões estratégicas da diretoria (incluindo o CEO Carlos Silveira e a Diretora Comercial Silvana Teixeira).

A arquitetura foi desenhada seguindo as melhores práticas de mercado (*Medallion Architecture* / *Kimball Dimensional Modeling*), separando os dados em camadas de Staging e Marts.

---

## 🛠️ Tecnologias Utilizadas
* **Cloud Data Warehouse:** Databricks (Workspace)
* **Transformação & Orquestração:** dbt Cloud
* **Versionamento:** Git & GitHub
* **Qualidade de Dados:** dbt Tests (Unique, Not Null e Testes Customizados de Auditoria)

---

## 📂 Arquitetura do Projeto (dbt)

O projeto está estruturado em camadas bem definidas dentro da pasta `models/`:

1. **Staging (`models/staging/`):** 
   * Camada responsável por limpar, renomear e padronizar as tabelas brutas vindas do banco transacional da Adventure Works (PostgreSQL).
   * Contém 11 tabelas limpas (ex: `stg_salesorderheader`, `stg_salesorderdetail`, `stg_customer`, `stg_product`, etc.).

2. **Marts (`models/marts/`):**
   * Camada de negócios modelada em **Star Schema** (Modelo Dimensional).
   * **Tabela Fato:** `fact_sales` (Granularidade na linha do item do pedido, contendo métricas de quantidade, faturamento bruto e líquido).
   * **Tabelas Dimensão:** 
     * `dim_product` (Catálogo de produtos)
     * `dim_customer` (Dados e nomes dos clientes)
     * `dim_location` (Geografia: cidade, estado e país)
     * `dim_creditcard` (Tipos de cartões de crédito)
     * `dim_salesreason` (Motivos de venda)

---

## 🔍 Qualidade de Dados e Auditoria (Data Quality)

Para atender à exigência do CEO Carlos Silveira de garantir que os dados batam com a auditoria contábil, implementamos uma série de testes automatizados:
* **Testes de Chaves Primárias:** Garantia de unicidade (`unique`) e não-nulidade (`not_null`) em todas as dimensões e fatos.
* **Teste de Faturamento do CEO (2011):** Criamos um teste de auditoria singular (`tests/test_soma_faturamento.sql`) que valida matematicamente se o faturamento bruto do ano de 2011 bate exatamente com o valor auditado de **$12,646,112.16**.

---

## 📊 Como Visualizar a Documentação Automática

O dbt gera um catálogo de dados e um grafo de linhagem (*Lineage Graph*) automáticos com base nas descrições e testes mapeados no arquivo `marts_models.yml`.

Para visualizar a documentação localmente:
1. Clone este repositório.
2. Configure o seu arquivo `profiles.yml` com as credenciais do Databricks.
3. No terminal, execute os comandos:
   ```bash
   dbt docs generate
   dbt docs serve

---

## 🗺️ Modelagem Conceitual

Antes do desenvolvimento no dbt, a arquitetura de dados foi desenhada em um Diagrama Conceitual, mapeando a linhagem das tabelas transacionais (PostgreSQL) até o modelo dimensional (Star Schema). 
* O arquivo PDF detalhando as chaves (PK/FK) e as colunas calculadas está disponível na raiz do projeto.

---

## 📈 Análise Exploratória e BI (Em Desenvolvimento)

Além da infraestrutura de dados, este projeto contempla a entrega de valor direto para a área de negócios:
1. **Análise Exploratória de Dados (EDA):** Identificação de padrões, anomalias e insights preliminares.
2. **Dashboard Gerencial:** Desenvolvimento de um painel interativo (Power BI / Databricks AI/BI) para responder às perguntas de negócio da Diretoria Comercial, focado em métricas de faturamento, ticket médio e performance de produtos/regiões.
