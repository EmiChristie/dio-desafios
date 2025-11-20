-- criando o BD da oficina
-- drop database oficina_desafio;
create database oficina_desafio;
use oficina_desafio;


create table cliente (
    id_cliente int auto_increment,
    nome varchar(100) not null,
    cpf char(11),
    telefone varchar(20),
    email varchar(100),

    constraint pk_cliente primary key (id_cliente),
    constraint unq_cliente_cpf unique (cpf),
    constraint unq_cliente_email unique (email)
);

alter table cliente auto_increment = 1;


create table funcionario (
    id_funcionario int auto_increment,
    nome varchar(100) not null,
    cargo varchar(50) not null,
    especialidade varchar(100),
    telefone varchar(20),

    constraint pk_funcionario primary key (id_funcionario)
);

alter table funcionario auto_increment = 1;


create table fornecedor (
    id_fornecedor int auto_increment,
    nome varchar(120) not null,
    cnpj char(14),
    telefone varchar(20),
    email varchar(100),

    constraint pk_fornecedor primary key (id_fornecedor),
    constraint unq_fornecedor_cnpj unique (cnpj)
);

alter table fornecedor auto_increment = 1;


create table endereco (
    id_endereco int auto_increment,
    logradouro varchar(120) not null,
    numero varchar(10),
    bairro varchar(100) not null,
    cidade varchar(100) not null,
    estado char(2) not null,
    cep char(8),

    tipo_entidade enum('CLIENTE','FORNECEDOR','FUNCIONARIO') not null,
    id_entidade int not null,

    constraint pk_endereco primary key (id_endereco)
);

alter table endereco auto_increment = 1;


create table veiculo (
    id_veiculo int auto_increment,
    id_cliente int not null,
    placa varchar(10) unique,
    modelo varchar(50) not null,
    marca varchar(50) not null,
    ano int,

    constraint pk_veiculo primary key (id_veiculo),
    constraint fk_veiculo_cliente foreign key (id_cliente)
        references cliente(id_cliente)
);

alter table veiculo auto_increment = 1;


create table ordem_servico (
    id_os int auto_increment,
    id_veiculo int not null,
    data_emissao date not null,
    data_conclusao date,
    status enum('ABERTA','EM_ANDAMENTO','CONCLUIDA','CANCELADA') default 'ABERTA',
    descricao_problema text,
    id_funcionario_responsavel int,

    constraint pk_ordem_servico primary key (id_os),

    constraint fk_os_veiculo foreign key (id_veiculo)
        references veiculo(id_veiculo),

    constraint fk_os_funcionario foreign key (id_funcionario_responsavel)
        references funcionario(id_funcionario)
);

alter table ordem_servico auto_increment = 1;


create table servico (
    id_servico int auto_increment,
    nome varchar(100) not null,
    valor_base decimal(10,2) not null,

    constraint pk_servico primary key (id_servico),
    constraint chk_servico_valor check (valor_base >= 0)
);

alter table servico auto_increment = 1;


create table peca (
    id_peca int auto_increment,
    nome varchar(100) not null,
    preco decimal(10,2) not null,
    estoque_atual int not null,
    estoque_minimo int default 0,
    id_fornecedor int,

    constraint pk_peca primary key (id_peca),

    constraint fk_peca_fornecedor foreign key (id_fornecedor)
        references fornecedor(id_fornecedor),

    constraint chk_peca_estoque_atual check (estoque_atual >= 0),
    constraint chk_peca_estoque_min check (estoque_minimo >= 0)
);

alter table peca auto_increment = 1;


create table os_servico (
    id_os int,
    id_servico int,
    qtde int default 1,
    valor_unit decimal(10,2) not null,
    id_funcionario int,

    constraint pk_os_servico primary key (id_os, id_servico),

    constraint fk_osservico_os foreign key (id_os)
        references ordem_servico(id_os),

    constraint fk_osservico_servico foreign key (id_servico)
        references servico(id_servico),

    constraint fk_osservico_funcionario foreign key (id_funcionario)
        references funcionario(id_funcionario),

    constraint chk_os_servico_qtde check (qtde > 0),
    constraint chk_os_servico_valor check (valor_unit >= 0)
);


create table os_peca (
    id_os int,
    id_peca int,
    qtde int not null,
    valor_unit decimal(10,2) not null,

    constraint pk_os_peca primary key (id_os, id_peca),

    constraint fk_ospeca_os foreign key (id_os)
        references ordem_servico(id_os),

    constraint fk_ospeca_peca foreign key (id_peca)
        references peca(id_peca),

    constraint chk_ospeca_qtde check (qtde > 0),
    constraint chk_ospeca_valor check (valor_unit >= 0)
);


create table pagamento (
    id_pagamento int auto_increment,
    id_os int not null,
    valor_total decimal(10,2) not null,
    forma_pagamento enum('DINHEIRO','DEBITO','CREDITO','PIX','BOLETO') not null,
    data_pagamento date not null,

    constraint pk_pagamento primary key (id_pagamento),

    constraint fk_pagamento_os foreign key (id_os)
        references ordem_servico(id_os),

    constraint chk_pagamento_valor check (valor_total >= 0)
);

alter table pagamento auto_increment = 1;


create table nota_entrada (
    id_nota int auto_increment,
    id_fornecedor int not null,
    data_emissao date not null,
    valor_total decimal(10,2) not null,

    constraint pk_nota_entrada primary key (id_nota),

    constraint fk_nota_fornecedor foreign key (id_fornecedor)
        references fornecedor(id_fornecedor),

    constraint chk_nota_valor_total check (valor_total >= 0)
);

alter table nota_entrada auto_increment = 1;


create table item_nota_entrada (
    id_nota int,
    id_peca int,
    qtde int not null,
    valor_unit decimal(10,2) not null,

    constraint pk_item_nota_entrada primary key (id_nota, id_peca),

    constraint fk_itemnota_nota foreign key (id_nota)
        references nota_entrada(id_nota),

    constraint fk_itemnota_peca foreign key (id_peca)
        references peca(id_peca),

    constraint chk_item_nota_qtde check (qtde > 0),
    constraint chk_item_nota_valor check (valor_unit >= 0)
);
