# 🚴‍♂️ Adventure Works - Modern Data Stack & Analytics Engineering

Repositório oficial do projeto de Engenharia de Analytics desenvolvido para a **Adventure Works**, aplicando os conceitos de Modern Data Stack (MDS), Modelagem Dimensional e Governança de Dados com dbt e Databricks.

---

## 🎯 Sobre o Projeto
Este projeto tem como objetivo estruturar uma plataforma analítica moderna para a Adventure Works, garantindo alta confiabilidade nos dados financeiros e fornecendo suporte para decisões estratégicas da diretoria (incluindo o CEO Carlos Silveira e a Diretora Comercial Silvana Teixeira).

A arquitetura foi desenhada seguindo as melhores práticas de mercado (*Medallion Architecture* / *Kimball Dimensional Modeling*), separando os dados em camadas de Staging e Marts, focando sempre em performance, qualidade e documentação orientada ao negócio.

---

## 🛠️ Tecnologias Utilizadas
* **Cloud Data Warehouse:** Databricks (Workspace)
* **Transformação & Orquestração:** dbt Cloud
* **Análise Exploratória (EDA):** Databricks SQL (Notebooks)
* **Prototipação visual (UI/UX):** Figma
* **Versionamento:** Git & GitHub
* **Qualidade de Dados:** dbt Tests (Unique, Not Null e Testes Customizados de Auditoria)

---

## 📂 Arquitetura do Projeto (dbt)

O projeto está estruturado em camadas bem definidas dentro da pasta `models/`, com forte preocupação em performance e desduplicação de dados logo na importação:

1. **Staging (`models/staging/`):** 
   * Camada responsável por limpar, renomear e padronizar as tabelas brutas vindas do banco transacional da Adventure Works (PostgreSQL).
   * Uso de funções de janela (`qualify row_number()`) para garantir a desduplicação e manter apenas os registros mais recentes.
   * Contém 11 tabelas limpas (ex: `stg_salesorderheader`, `stg_salesorderdetail`, `stg_customer`, `stg_product`, etc.).

2. **Marts (`models/marts/`):**
   * Camada de negócios modelada em **Star Schema** (Modelo Dimensional).
   * **Tabela Fato:** `fact_sales` (Granularidade na linha do item do pedido, contendo métricas de quantidade, faturamento bruto e faturamento líquido).
   * **Tabelas Dimensão:** 
     * `dim_product` (Catálogo de produtos)
     * `dim_customer` (Dados e chaves de clientes)
     * `dim_location` (Geografia: cidade, estado e país)
     * `dim_creditcard` (Tipos de cartões de crédito)
     * `dim_salesreason` (Motivos de venda)

---

## 🔍 Qualidade de Dados e Auditoria (Data Quality)

Para atender à exigência do CEO Carlos Silveira de garantir que os dados batam com a auditoria contábil, implementamos uma série de testes automatizados:
* **Testes de Chaves e Relacionamentos:** Garantia de unicidade (`unique`), não-nulidade (`not_null`) e integridade referencial (`relationships`) em todas as dimensões e fatos.
* **Teste de Faturamento do CEO (2011):** Criamos um teste de auditoria singular (`tests/test_soma_faturamento.sql`) que valida matematicamente se o faturamento bruto do ano de 2011 bate exatamente com o valor auditado de **$12,646,112.16**.

---

## 📈 Análise Exploratória de Dados (EDA)

Utilizando **Databricks SQL**, foi conduzida uma Análise Exploratória focada em responder diretamente às dores da Diretoria Comercial, aplicando regras de negócio essenciais (como a remoção de *outliers* na análise de ticket médio). 

Os insights extraídos incluem:
* **Evolução Temporal:** Análise de faturamento e volume de pedidos mês a mês.
* **Curva ABC de Clientes e Regiões:** Identificação dos Top 10 clientes e Top 5 cidades que mais geram receita.
* **Efetividade de Campanhas:** Mapeamento do produto campeão de vendas sob o motivo "Promotion".
* **Rentabilidade (AOV):** Identificação dos produtos com maior Ticket Médio (filtrando itens com volume histórico inferior a 10 pedidos para evitar distorções estatísticas).

---

## 🎨 Prototipação do Dashboard (Wireframe)

Antes do desenvolvimento na ferramenta de BI, foi desenhado um Mockup executivo no **Figma** focado em usabilidade e redução de carga cognitiva. 
O *wireframe* segue o padrão de leitura em Z:
1. **Cabeçalho:** Identificação e barra completa de filtros dinâmicos (Data, Cliente, País, Estado, Cidade, Produto, Motivo, Cartão e Status).
2. **Big Numbers (KPIs):** Destaque imediato para Faturamento Líquido, Volume de Pedidos, Quantidade de Itens e Ticket Médio.
3. **Visões Analíticas:** Gráficos adaptados para a melhor leitura (ex: uso de barras horizontais para ranqueamento de textos longos de produtos e clientes), cobrindo 100% dos requisitos do edital de negócios.

---

## 📊 Como Visualizar a Documentação Automática

O dbt gera um catálogo de dados e um grafo de linhagem (*Lineage Graph*) automáticos com base nas descrições técnicas e de negócio mapeadas no arquivo `marts_models.yml`.

Para visualizar a documentação localmente:
1. Clone este repositório.
2. Configure o seu arquivo `profiles.yml` com as credenciais do Databricks.
3. No terminal, execute os comandos:
   ```bash
   dbt docs generate
   dbt docs serve
