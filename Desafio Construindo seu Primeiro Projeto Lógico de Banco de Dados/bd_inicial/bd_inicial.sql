-- criação do BD do desafio, seguindo os vídeos

-- drop database ecommerce;
create database ecommerce;
use ecommerce;

-- criação das tabelas

create table clients(
	idClient int auto_increment primary key,
	fname varchar(10),
	minit varchar(3),
	lname varchar(20),
	cpf char(11) not null,
	address varchar(255),
	constraint unique_cpf_client unique (CPF)
);

alter table clients auto_increment = 1;

-- size = dimensão do produto
create table products(
	idProduct int auto_increment primary key,
	pname varchar(10) not null,
	classification_kids bool default false,
	category enum('Eletrônicos', 'Vestimentas', 'Brinquedos', 'Alimentos', 'Móveis') not null,
	review float default 0,
	Size varchar(10)
);

alter table products auto_increment = 1;

-- continuar no desafio, terminar a tabela, deixando-a adequada e conectar com as tabelas necessárias
-- criar constraints relacionadas ao pagamento
create table payments(
	idPayment int,
	idClient int,
	paymentType enum ('Débito', 'Crédito', 'Boleto'),
	limitAvailable float,
	primary key (idPayment, idClient)
);

create table orders(
	idOrder int auto_increment primary key,
	idOrderClient int,
	orderStatus enum ('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
	orderDescription varchar(255),
	shippingCost float default 10,
	paymentCash bool default false,
	-- linkar com o pagamento
	constraint fk_order_client foreign key (idOrderClient) references clients(idClient)
);

alter table orders auto_increment = 1;

create table productStorage(
	idProdStorage int auto_increment primary key,
	storageLocation varchar(255),
	quantity int default 0
);

alter table productStorage auto_increment = 1;

create table supplier(
	idSupplier int auto_increment primary key,
	socialName varchar(255) not null,
	cnpj char(15) not null,
	contact char(11) not null,
	constraint unique_supplier unique (cnpj)
);

alter table supplier auto_increment = 1;

create table seller(
	idSeller int auto_increment primary key,
	socialName varchar(255) not null,
	abstName varchar(255),
	cnpj char(15),
	cpf char(9),
	contact char(11) not null,
	location varchar(255),
	constraint unique_cnpj_seller unique (cnpj),
	constraint unique_cpf_seller unique (cpf)
);

alter table seller auto_increment = 1;

create table productSeller( 
	idPseller int,
	idProduct int,
	prodQuantity int default 1,
	primary key (idPseller, idProduct),
	constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
	constraint fk_product_product foreign key (idProduct) references products(idProduct)
);
	
create table productOrder(
	idPOproduct int,
	idPOorder int,
	poQuantity int default 1,
	poStatus enum ('Disponível', 'Sem estoque') default 'Disponível',
	primary key (idPOproduct, idPOorder),
	constraint fk_po_product foreign key (idPOproduct) references products(idProduct),
	constraint fk_po_order foreign key (idPOorder) references orders(idOrder)
);	
	
create table storageLocation(
	idLproduct int,
	idLstorage int,
	location varchar(255) not null,
	primary key (idLproduct, idLstorage),
	constraint fk_sl_product foreign key (idLproduct) references products(idProduct),
	constraint fk_sl_storage foreign key (idLstorage) references productStorage(idProdStorage)
);	
	
create table productSupplier(
	idPSsupplier int,
	idPSproduct int,
	quantity int not null,
	primary key (idPSsupplier, idPSproduct),
	constraint fk_ps_product foreign key (idPSproduct) references products(idProduct),
	constraint fk_ps_supplier foreign key (idPSsupplier) references supplier(idSupplier)
);	
	
	
	
	
	
	
	
	
	
	
	
