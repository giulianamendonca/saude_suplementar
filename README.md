# Reclamações por Beneficiário na Saúde Suplementar (Brasil)
Análise da proporção de reclamações por beneficiário nas operadoras de saúde suplementar.

## Descrição
### Panorama Geral
A saúde suplementar atende milhões de beneficiários no Brasil e representa uma parcela significativa do acesso à saúde no país. Reclamações recorrentes e desproporcionais podem indicar riscos à qualidade assistencial, à sustentabilidade do sistema e à proteção do consumidor, tornando essencial uma análise orientada por dados para apoiar ações regulatórias mais eficientes.

### Objetivos
Este projeto tem como objetivo oferecer suporte à tomada de decisão regulatória, por meio da análise do volume de reclamações registradas contra operadoras de planos de saúde, em proporção com o tamanho de sua base de beneficiários, ao longo do primeiro semestre de 2025.

## Dados
### Fonte de Dados
Os dados foram obtidos pela plataforma [Tabnet/ANS](https://www.ans.gov.br/anstabnet/index.htm). Foram gerados relatórios das opções:
* Beneficiários -> Operadora (`Extração 1`)
* Demandas dos Consumidores e Fiscalização -> Reclamações de Beneficiários (`Extração 2`)
* Operadoras -> Operadoras com Registro Ativo (`Extração 3`)

### Extração dos Dados
Os relatórios foram gerados conforme os parâmetros descritos abaixo. A extração foi realizada manualmente na plataforma TabNet/ANS, devido à ausência de uma API pública ou opção de download direto dos relatórios configurados.
A consulta à base de dados foi realizada em dezembro de 2025.

#### Extração 1
Dado que o número de beneficiários por operadora é um dado disponibilizado trimestralmente, optou-se pela utilização dos relatórios referentes a março e junho de 2025.
A tabela foi configurada para apresentar os valores por operadora (Linha -> Operadora), e os demais filtros e configurações foram mantidos com os valores pré-definidos pelo sistema.

Durante o processo de carga dos dados, identificou-se a existência de operadoras com registros de reclamações e beneficiários no período analisado que não constavam como ativas. Para preservar a integridade referencial e manter a rastreabilidade histórica dos dados, essas operadoras foram mantidas na base com status “inativo”, sendo posteriormente excluídas das análises finais.

#### Extração 2
Foram obtidos os relatórios referentes aos meses de janeiro a junho de 2025.
Não houve alteração de nenhum outro filtro ou configuração pré-definidos pelo sistema.

#### Extração 3
O período selecionado foi outubro de 2025, correspondente ao arquivo mais recente disponível no momento da consulta. Para os fins desta análise, assumiu-se estabilidade cadastral das operadoras ao longo do período analisado.
Nesta extração, foram realizadas duas consultas:
* Região da sede de cada operadora (Coluna -> Região da Sede)
* Porte da operadora (Coluna -> Faixa de Benef.)
Os demais filtros e configurações foram mantidos com os valores pré-definidos pelo sistema.

### Arquivos
As tabelas geradas pelo sistema Tabnet/ANS foram copiados para arquivos CSV, usando o Microsoft Excel. Durante esta etapa, foi atribuído o valor 0 aos resultados nulos das `extrações 1 e 2`, de modo a viabilizar a consolidação dos dados em formato tabular.
A versão destes arquivos que foi utilizada para a realização das análises está disponível na pasta `/data`, juntamente com o script para sua leitura no banco de dados (`import.txt`).
Por favor, notar que `import.txt` contém um comando para a leitura de `schema.sql`.

**Importante:** Os arquivos representam um recorte temporal específico e têm caráter reprodutível apenas para fins acadêmicos e demonstrativos.

## Conteúdo da análise
A análise dos dados foi realizada em um Jupyter Notebook, `analise.ipynb`, para permitir o seguimento de um pipeline de análise:
* **Etapa 1**: Importação dos dados para um dataframe
* **Etapa 2**: Análise exploratória
* **Etapa 3**: Cálculo das métricas
* **Etapa 4**: Apresentação dos resultados obtidos

## Arquivos Disponibilizados
```
analise.ipynb       # Análise dos dados
beneficiarios.csv   # Tabela de beneficiários por operadora (Extração 1)
reclamacoes.csv     # Tabela de reclamações por operadora (Extração 2)
operadoras.csv      # Tabela de operadoras ativas (Extração 3)
import.txt          # Script SQL de importação de dados para o banco
schema.sql          # Schema do banco de dados
README.md           # Documentação
```

## Requerimentos
* SQLite
* Python 3.11+
  * Bibliotecas padrão:
    * sqlite3
  * Bibliotecas adicionais:
    * pandas

# Limitações
* Esta análise considera apenas o primeiro semestre de 2025 e utiliza dados públicos agregados, não permitindo inferências individuais sobre beneficiários ou atendimentos específicos.
* As análises comparativas realizadas em `analise_exploratoria.ipynb` não consideram operadoras com menos de 5000 beneficiários. Sugere-se a realização de uma análise cautelosa, especificamente voltada para estes casos.

## Conclusões obtidas
A análise exploratória dos dados evidencia que a avaliação do desempenho das operadoras de saúde suplementar com base exclusivamente no número absoluto de reclamações pode conduzir a interpretações distorcidas, uma vez que esse indicador apresenta forte correlação com o tamanho da base de beneficiários. A normalização das reclamações por usuário permite comparações mais equitativas entre operadoras de diferentes portes, revelando que aquelas com maior volume absoluto de reclamações não são, necessariamente, as que apresentam pior desempenho relativo.
Adicionalmente, a análise da variação do número de reclamações por beneficiário entre o primeiro e o segundo trimestre de 2025 indica comportamentos heterogêneos entre as operadoras. Observam-se tanto casos de deterioração do desempenho — especialmente em operadoras de menor porte, mais suscetíveis a variações abruptas — quanto reduções relevantes no indicador per capita, inclusive em operadoras que ainda mantêm níveis elevados de reclamações. Esses resultados reforçam a importância de uma abordagem regulatória orientada por indicadores normalizados e análise temporal, permitindo a identificação de tendências, priorização de ações de fiscalização e direcionamento de auditorias específicas de forma mais eficiente e baseada em evidências.

## Próximos passos
* Análise do número de reclamações (absoluto e por beneficiário) por região da sede da operadora e por porte, conforme classificação da ANS

## Créditos
Este projeto foi realizado como parte do curso de Análise de Dados da [EBAC - Escola Britânica de Artes Criativas e Tecnologia](https://ebaconline.com.br/analista-de-dados).

## Contato
* **Email:** giulianamendonca@outlook.com
* **GitHub:** [giulianamendonca](https://github.com/giulianamendonca)
