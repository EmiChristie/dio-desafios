-- criando o BD refinado

-- drop database if exists ecommerce_desafio;
create database ecommerce_desafio;
use ecommerce_desafio;

-- address
create table address (
    id_address int auto_increment,
    street varchar(255) not null,
    number varchar(20),
    complement varchar(255),
    district varchar(120),
    city varchar(120) not null,
    state char(2) not null,
    zip_code char(8),

    constraint pk_address primary key (id_address)
);

alter table address auto_increment = 1;

-- client
create table client (
    id_client int auto_increment,
    full_name varchar(120) not null,
    email varchar(120) not null,
    phone char(11),

    client_type enum('pf','pj') not null,

    cpf char(11),
    cnpj char(14),
    corporate_name varchar(255),

    id_address int,

    constraint pk_client primary key (id_client),
    constraint unq_client_email unique (email),
    constraint unq_client_cpf unique (cpf),
    constraint unq_client_cnpj unique (cnpj),

    constraint fk_client_address foreign key (id_address)
        references address(id_address),

    constraint chk_client_type check (
        (client_type = 'pf' and cpf is not null and cnpj is null)
        or
        (client_type = 'pj' and cnpj is not null and cpf is null)
    )
);

alter table client auto_increment = 1;

-- product
create table product (
    id_product int auto_increment,
    name varchar(120) not null,
    is_kids boolean default false,
    category enum('eletronicos','vestimentas','brinquedos','alimentos','moveis') not null,
    review decimal(3,2) default 0,
    size varchar(20),

    constraint pk_product primary key (id_product),
    constraint chk_product_review check (review >= 0 and review <= 5)
);

alter table product auto_increment = 1;

-- payment_method
create table payment_method (
    id_payment int auto_increment,
    id_client int not null,
    type enum('debito','credito','boleto') not null,
    credit_limit decimal(10,2),

    constraint pk_payment_method primary key (id_payment),

    constraint fk_payment_client foreign key (id_client)
        references client(id_client)
);

alter table payment_method auto_increment = 1;

-- orders
create table orders (
    id_order int auto_increment,
    id_client int not null,
    id_payment int,
    status enum('cancelado','confirmado','em_processamento') default 'em_processamento',
    description varchar(255),
    shipping_cost decimal(10,2) default 10,
    created_at timestamp default current_timestamp,

    constraint pk_orders primary key (id_order),

    constraint fk_orders_client foreign key (id_client)
        references client(id_client),

    constraint fk_orders_payment foreign key (id_payment)
        references payment_method(id_payment)
);

alter table orders auto_increment = 1;

-- shipping
create table shipping (
    id_shipping int auto_increment,
    id_order int not null,
    tracking_code varchar(40),
    status enum('pendente','enviado','em_transito','entregue','devolvido') default 'pendente',

    constraint pk_shipping primary key (id_shipping),
    constraint unq_shipping_order unique (id_order),

    constraint fk_shipping_order foreign key (id_order)
        references orders(id_order)
);

alter table shipping auto_increment = 1;

-- storage
create table storage (
    id_storage int auto_increment,
    id_address int not null,
    quantity int default 0,

    constraint pk_storage primary key (id_storage),
    constraint chk_storage_quantity check (quantity >= 0),

    constraint fk_storage_address foreign key (id_address)
        references address(id_address)
);

alter table storage auto_increment = 1;

-- product_storage
create table product_storage (
    id_product int,
    id_storage int,

    constraint pk_product_storage primary key (id_product, id_storage),

    constraint fk_product_storage_product foreign key (id_product)
        references product(id_product),

    constraint fk_product_storage_storage foreign key (id_storage)
        references storage(id_storage)
);

-- supplier
create table supplier (
    id_supplier int auto_increment,
    corporate_name varchar(255) not null,
    cnpj char(14) not null,
    contact char(11) not null,

    id_address int,

    constraint pk_supplier primary key (id_supplier),
    constraint unq_supplier_cnpj unique (cnpj),

    constraint fk_supplier_address foreign key (id_address)
        references address(id_address)
);

alter table supplier auto_increment = 1;

-- supplier_product
create table supplier_product (
    id_supplier int,
    id_product int,
    quantity int not null,

    constraint pk_supplier_product primary key (id_supplier, id_product),

    constraint chk_supplier_product_qty check (quantity > 0),

    constraint fk_supplier_product_supplier foreign key (id_supplier)
        references supplier(id_supplier),

    constraint fk_supplier_product_product foreign key (id_product)
        references product(id_product)
);

-- seller
create table seller (
    id_seller int auto_increment,
    corporate_name varchar(255) not null,
    fantasy_name varchar(255),
    cnpj char(14),
    cpf char(11),
    contact char(11) not null,

    id_address int,

    constraint pk_seller primary key (id_seller),
    constraint unq_seller_cnpj unique (cnpj),
    constraint unq_seller_cpf unique (cpf),

    constraint fk_seller_address foreign key (id_address)
        references address(id_address),

    constraint chk_seller_type check (
        (cpf is not null and cnpj is null)
        or
        (cnpj is not null and cpf is null)
    )
);

alter table seller auto_increment = 1;

-- seller_product
create table seller_product (
    id_seller int,
    id_product int,
    quantity int default 1,

    constraint pk_seller_product primary key (id_seller, id_product),
    constraint chk_seller_product_qty check (quantity >= 0),

    constraint fk_sellerproduct_seller foreign key (id_seller)
        references seller(id_seller),

    constraint fk_sellerproduct_product foreign key (id_product)
        references product(id_product)
);

-- order_item
create table order_item (
    id_order int,
    id_product int,
    quantity int default 1,
    status enum('disponivel','sem_estoque') default 'disponivel',

    constraint pk_order_item primary key (id_order, id_product),

    constraint chk_order_item_quantity check (quantity > 0),

    constraint fk_orderitem_order foreign key (id_order)
        references orders(id_order),

    constraint fk_orderitem_product foreign key (id_product)
        references product(id_product)
);
