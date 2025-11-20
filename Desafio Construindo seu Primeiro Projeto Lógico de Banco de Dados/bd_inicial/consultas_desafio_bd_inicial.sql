-- parte 1 do desafio: realizando mais queries no BD inicial, mostrado nos vídeos
use ecommerce;

-- Quantos pedidos cada cliente fez e quanto gastou no total em frete?
select 
    concat(c.fname, ' ', c.lname) as cliente,
    count(o.idOrder) as totalPedidos,
    sum(o.shippingCost) as totalFrete
from clients c
left join orders o on c.idClient = o.idOrderClient
group by c.idClient
order by totalPedidos desc;

-- Quais produtos foram vendidos, em quais pedidos e em que quantidade?
select 
    o.idOrder,
    p.pname,
    po.poQuantity as quantidade,
    o.orderStatus
from orders o
inner join productOrder po on o.idOrder = po.idPOorder
inner join products p on p.idProduct = po.idPOproduct
order by o.idOrder, p.pname;


-- Quais produtos infantis foram vendidos e em que quantidade total?
select 
    p.pname,
    p.category,
    sum(po.poQuantity) as totalVendido
from products p
inner join productOrder po on p.idProduct = po.idPOproduct
where p.classification_kids = true
group by p.idProduct
order by totalVendido desc;
-- nesse caso, nenhuma linha se aplica!


-- Relação dos fornecedores e os produtos que fornecem, com quantidades fornecidas.
select 
    s.socialName as fornecedor,
    p.pname as produto,
    ps.quantity as quantidadeFornecida
from supplier s
inner join productSupplier ps on s.idSupplier = ps.idPSsupplier
inner join products p on p.idProduct = ps.idPSproduct
order by fornecedor, produto;


-- Algum vendedor também é fornecedor? (comparação por CNPJ)
select 
    sel.socialName as vendedor,
    sup.socialName as fornecedor,
    sel.cnpj
from seller sel
inner join supplier sup 
    on sel.cnpj is not null 
   and sel.cnpj = sup.cnpj;
-- com os dados de exemplo, não!

-- Quais produtos estão em estoque, em quais depósitos e em qual quantidade?
select 
    p.pname,
    st.storageLocation as deposito,
    st.quantity as quantidadeEstoque
from productStorage st
inner join storageLocation sl on st.idProdStorage = sl.idLstorage
inner join products p on p.idProduct = sl.idLproduct
order by p.pname, deposito;


-- Quais produtos nunca foram vendidos?
select 
    p.pname,
    p.category
from products p
left join productOrder po on p.idProduct = po.idPOproduct
where po.idPOproduct is null;


-- Média de avaliação dos produtos por categoria (somente categorias com média >= 4.5)
select 
    category,
    avg(review) as mediaAvaliacoes,
    count(*) as totalProdutos
from products
group by category
having avg(review) >= 4.5
order by mediaAvaliacoes desc;


-- Quais vendedores vendem quais produtos e em que quantidade?
select 
    s.socialName as vendedor,
    p.pname as produto,
    ps.prodQuantity as quantidade
from seller s
inner join productSeller ps on s.idSeller = ps.idPseller
inner join products p on p.idProduct = ps.idProduct
order by vendedor;


-- Quais clientes gastaram mais, somando frete e a quantidade total de itens?
select 
    concat(c.fname, ' ', c.lname) as cliente,
    sum(o.shippingCost) as totalFrete,
    sum(po.poQuantity) as totalItens,
    (sum(o.shippingCost) + sum(po.poQuantity)) as scoreDeGasto
from clients c
inner join orders o on c.idClient = o.idOrderClient
inner join productOrder po on o.idOrder = po.idPOorder
group by c.idClient
order by scoreDeGasto desc;