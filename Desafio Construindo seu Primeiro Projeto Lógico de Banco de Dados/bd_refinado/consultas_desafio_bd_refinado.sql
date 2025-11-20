use ecommerce_desafio;

-- Quais são os clientes cadastrados no sistema?
select 
    id_client,
    full_name,
    email
from client;

-- Quais produtos têm avaliação maior que 4.5?
select 
    id_product,
    name,
    review
from product
where review > 4.5;

-- Qual o nome do cliente e quantos pedidos ele já realizou?
select
    c.full_name,
    count(o.id_order) as total_pedidos
from client c
left join orders o on o.id_client = c.id_client
group by c.id_client
order by total_pedidos desc;

-- Quais clientes do tipo PF têm CPF terminando em 01?
select
    full_name,
    cpf
from client
where client_type = 'pf'
  and cpf like '%01';

-- Quantos itens existem em cada pedido?
select
    o.id_order,
    sum(oi.quantity) as total_itens
from orders o
join order_item oi on oi.id_order = o.id_order
group by o.id_order
order by total_itens desc;

-- Quais vendedores possuem mais de 1 produto anunciado?
select
    s.corporate_name,
    count(sp.id_product) as produtos_anunciados
from seller s
join seller_product sp on sp.id_seller = s.id_seller
group by s.id_seller
having produtos_anunciados > 1;

-- Listar pedidos com cliente, forma de pagamento e status da entrega.
select
    o.id_order,
    c.full_name,
    pm.type as forma_pagamento,
    s.status as status_entrega,
    s.tracking_code
from orders o
join client c on c.id_client = o.id_client
left join payment_method pm on pm.id_payment = o.id_payment
left join shipping s on s.id_order = o.id_order
order by o.id_order;

-- Quais produtos são vendidos por mais de um vendedor?
select
    p.name,
    count(sp.id_seller) as qtd_vendedores
from product p
join seller_product sp on sp.id_product = p.id_product
group by p.id_product
having qtd_vendedores > 1;
-- nesse caso, nenhum.

-- Endereços completos de clientes que já fizeram ao menos um pedido.
select
    c.full_name,
    a.street,
    a.number,
    a.city,
    a.state
from client c
join address a on a.id_address = c.id_address
join orders o on o.id_client = c.id_client
group by c.id_client;

-- Qual a quantidade total armazenada por depósito e sua cidade?
select
    s.id_storage,
    a.city,
    sum(s.quantity) as total_estoque
from storage s
join address a on a.id_address = s.id_address
group by s.id_storage, a.city
order by total_estoque desc;

-- Quais fornecedores fornecem mais de 100 unidades de algum produto?
select
    sup.corporate_name,
    p.name,
    sp.quantity
from supplier_product sp
join supplier sup on sup.id_supplier = sp.id_supplier
join product p on p.id_product = sp.id_product
where sp.quantity > 100;

-- Quais produtos tiveram vendas e a quantidade total vendida?
select
    p.name,
    sum(oi.quantity) as total_vendido
from order_item oi
join product p on p.id_product = oi.id_product
group by p.id_product
order by total_vendido desc;

-- Quais pedidos já foram entregues?
select
    o.id_order,
    c.full_name,
    s.tracking_code
from orders o
join shipping s on s.id_order = o.id_order
join client c on c.id_client = o.id_client
where s.status = 'entregue';
-- nesse caso, nenhum.

-- Produtos em estoque com a cidade do depósito.
select
    p.name,
    st.quantity,
    a.city,
    a.state
from product_storage ps
join product p on p.id_product = ps.id_product
join storage st on st.id_storage = ps.id_storage
join address a on a.id_address = st.id_address;

-- Clientes com mais de um método de pagamento.
select
    c.full_name,
    count(pm.id_payment) as metodos_pagamento
from client c
join payment_method pm on pm.id_client = c.id_client
group by c.id_client
having metodos_pagamento > 1;
