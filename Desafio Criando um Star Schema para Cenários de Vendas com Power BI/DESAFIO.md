# Desafio Criando um Star Schema para Cenários de Vendas com Power BI

### O Desafio
As instruções do desafio consistiam na criação de um modelo dimensional do tipo estrela, com foco nos dados sobre professores de uma universidade. Foi dada uma imagem de referência e instruções bem livres acerca de como abordar o problema, mas deixando claro que a tabela fato deveria ter seu enfoque nos professores, enquanto as tabelas dimensão entrariam em detalhes sobre os cursos ministrados por eles, seu departamento, etc... com uma tabela de datas também associada ao esquema.

### O que foi feito
Foi criado um modelo dimensional completo no formato estrela, estruturado para análise dos dados relacionados aos professores. A tabela fato foi construída com foco nos eventos acadêmicos envolvendo cada docente, enquanto as tabelas dimensão foram elaboradas para descrever os contextos necessários, como informações do professor, disciplinas ministradas, cursos associados, departamentos e dados de calendário.

### Como foi feito
Usando SQL, comecei pela definição da granularidade da tabela fato e dos atributos relevantes das dimensões. Em seguida, foram criadas todas as tabelas com suas chaves primárias, relacionamentos e constraints de integridade, formando o esquema estrela completo (disponível na imagem "star_schema.png"). O diagrama final foi gerado a partir dessas estruturas e o script pode ser encontrado no arquivo “script.sql”.