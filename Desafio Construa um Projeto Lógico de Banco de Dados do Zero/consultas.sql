-- fazendo consultas
use oficina_desafio;

-- quais são os nomes e telefones de todos os clientes?
select nome, telefone
from cliente;

-- quais veículos são do ano acima de 2018?
select id_veiculo, marca, modelo, ano
from veiculo
where ano > 2018;

-- qual o tempo de execução (em dias) para ordens já concluídas?
select id_os,
       data_emissao,
       data_conclusao,
       timestampdiff(day, data_emissao, data_conclusao) as dias_execucao
from ordem_servico
where data_conclusao is not null;

-- listar os serviços ordenados do mais caro para o mais barato
select id_servico, nome as descricao, valor_base as valor_mao_obra
from servico
order by valor_base desc;

-- quais clientes têm mais de 2 ordens de serviço registradas?
select c.id_cliente, c.nome, count(*) as total_os
from cliente c
inner join veiculo v on v.id_cliente = c.id_cliente
inner join ordem_servico os on os.id_veiculo = v.id_veiculo
group by c.id_cliente, c.nome
having count(*) > 2;
-- no caso, nenhum.

-- quais ordens de serviço incluem o nome do cliente e os dados do veículo?
select os.id_os,
       cl.nome as cliente,
       concat(v.marca, ' ', v.modelo) as veiculo,
       os.data_emissao,
       os.status
from ordem_servico os
inner join veiculo v on v.id_veiculo = os.id_veiculo
inner join cliente cl on cl.id_cliente = v.id_cliente;

-- quais fornecedores possuem endereço cadastrado?
select f.id_fornecedor, f.nome, e.logradouro, e.cidade, e.estado
from fornecedor f
inner join endereco e
  on e.tipo_entidade = 'FORNECEDOR'
 and e.id_entidade = f.id_fornecedor;

-- quais ordens de serviço têm valor total de peças (soma) acima de 1000?
select os.id_os,
       sum(osp.qtde * osp.valor_unit) as total_pecas
from ordem_servico os
inner join os_peca osp on osp.id_os = os.id_os
group by os.id_os
having sum(osp.qtde * osp.valor_unit) > 1000;

-- quais funcionários trabalharam (foram atribuídos como responsáveis) em quais ordens e para quais clientes?
select f.nome as funcionario,
       os.id_os,
       cl.nome as cliente,
       os.data_emissao
from funcionario f
inner join ordem_servico os on os.id_funcionario_responsavel = f.id_funcionario
inner join veiculo v on v.id_veiculo = os.id_veiculo
inner join cliente cl on cl.id_cliente = v.id_cliente
order by f.nome, os.data_emissao;

-- quais clientes possuem veículos cadastrados?
select distinct c.id_cliente, c.nome
from cliente c
inner join veiculo v on v.id_cliente = c.id_cliente;

-- quantas peças existem por fornecedor?
select p.id_fornecedor, f.nome as fornecedor, count(*) as total_pecas
from peca p
left join fornecedor f on f.id_fornecedor = p.id_fornecedor
group by p.id_fornecedor, f.nome;

-- qual o estoque total (soma de estoque_atual) de todas as peças?
select sum(estoque_atual) as estoque_total
from peca;

-- quais são as peças com preço acima da média?
select id_peca, nome, preco
from peca
where preco > (select avg(preco) from peca);

-- quantas ordens foram concluídas por cada funcionário responsável?
select f.id_funcionario, f.nome, count(*) as total_concluidas
from funcionario f
inner join ordem_servico os on os.id_funcionario_responsavel = f.id_funcionario
where os.status = 'CONCLUIDA'
group by f.id_funcionario, f.nome
order by total_concluidas desc;

-- listar as peças mais usadas em ordens (top 5) — soma de qtde em os_peca
select p.id_peca, p.nome, sum(osp.qtde) as total_usos
from os_peca osp
inner join peca p on p.id_peca = osp.id_peca
group by p.id_peca, p.nome
order by total_usos desc
limit 5;

-- quais cidades possuem mais clientes cadastrados (endereco.tipo_entidade = 'CLIENTE')?
select e.cidade, count(*) as total_clientes
from endereco e
where e.tipo_entidade = 'CLIENTE'
group by e.cidade
having count(*) > 1
order by total_clientes desc;

-- quais fornecedores têm peças com estoque_atual abaixo de 10 unidades?
select f.id_fornecedor, f.nome as fornecedor, p.id_peca, p.nome as peca, p.estoque_atual
from peca p
inner join fornecedor f on f.id_fornecedor = p.id_fornecedor
where p.estoque_atual < 10
order by p.estoque_atual asc;

-- qual é a média de valor_base dos serviços (mão de obra) por faixa (ex.: agrupar por valor_base arredondado)?
select floor(valor_base/50)*50 as faixa_valor, avg(valor_base) as media_valor, count(*) as qtd_servicos
from servico
group by floor(valor_base/50)*50
order by media_valor desc;
