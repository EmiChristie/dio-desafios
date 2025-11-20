-- realizando as consultas mostradas no vídeo

use ecommerce;

select count(*) from clients;

select * from clients c, orders o where c.idClient = idOrderClient;

select c.fname, c.lname, o.idOrder, o.orderStatus from clients c, orders o where c.idClient = idOrderClient;

select concat(fname,' ', lname) as clientName, idOrder, orderStatus from clients c, orders o where c.idClient = idOrderClient;

select concat(fname,' ', lname) as clientName, count(*) as qntOrders
from clients c, orders o
where c.idClient = idOrderClient
group by idClient;

select concat(fname,' ', lname) as clientName, count(*) as qntOrders 
from 	clients 
		inner join orders on idClient = idOrderClient 
		inner join productOrder on idPOorder = idOrder 
group by idClient;

select concat(fname,' ', lname) as clientName, count(*) as qntOrders 
from 	clients 
		inner join orders on idClient = idOrderClient 
group by idClient;