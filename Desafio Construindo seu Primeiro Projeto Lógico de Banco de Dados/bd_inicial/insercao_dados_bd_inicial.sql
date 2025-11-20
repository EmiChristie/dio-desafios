-- inserção de dados e queries seguindo os vídeos do desafio

use ecommerce;

show tables;

insert into Clients (fname, minit, lname, cpf, address) values
('João','A','Pereira',987654321,'Avenida Central 120, Centro - São Paulo'),
('Ana','C','Oliveira',456789123,'Rua das Flores 55, Jardim - Rio de Janeiro'),
('Carlos','J','Souza',741852963,'Travessa Azul 18, Bairro Novo - Belo Horizonte'),
('Fernanda','L','Costa',159357486,'Rua Primavera 300, Centro - Curitiba'),
('Paulo','R','Almeida',258369147,'Avenida do Sol 420, Zona Sul - Porto Alegre'),
('Juliana','B','Moraes',321654987,'Rua Bela Vista 77, Bairro Alto - Salvador'),
('Rafael','T','Gomes',654987321,'Rua das Palmeiras 90, Vila Nova - Recife'),
('Beatriz','E','Rocha',852741963,'Alameda Verde 12, Parque - Fortaleza'),
('Roberto','S','Barbosa',963258147,'Rua das Laranjeiras 201, Centro - Manaus'),
('Larissa','D','Martins',147963258,'Avenida Atlântica 500, Orla - Florianópolis');

insert into products (pname, classification_kids, category, review, size) values
('Caixa som', false, 'Eletrônicos', '5', '10x10x12'),
('Carregador', false, 'Eletrônicos', '4', null),
('Camiseta', false, 'Vestimentas', '4', 'G'),
('Calça inf.', true, 'Vestimentas', '5', 'P'),
('Ursinho', true, 'Brinquedos', '5', '25x20x15'),
('Jogo', true, 'Brinquedos', '4', '20x10x30'),
('Biscoitos', false, 'Alimentos', '4', null),
('Cereal', false, 'Alimentos', '5', '7x20x30'),
('Mesa', false, 'Móveis', '4', '45x60x120'),
('Cadeirinha', true, 'Móveis', '5', '30x35x60');

select * from clients;

select * from products;

insert into orders (idOrderClient, orderStatus, orderDescription, shippingCost, paymentCash) values
(1,default,'compra via app',null,1),
(2,default,'compra via app',50,0),
(3,'Confirmado',null,null,1),
(4,default,'compra via app',150,0);

insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus) values
(1,1,2,null),
(2,1,1,null),
(3,2,1,null);

insert into productStorage (storageLocation, quantity) values
('Rio de Janeiro', 1000),
('Rio de Janeiro', 500),
('São Paulo', 10),
('São Paulo', 100),
('São Paulo', 10),
('Brasília', 60);

insert into storageLocation (idLproduct, idLstorage, location) values
(1,2,'RJ'),
(2,6,'GO');

insert into supplier (socialName, cnpj, contact) values
('Almeida e filhos', 123456789012345,'21978451236'),
('Eletrônicos Silva', 123456789012344,'21912345678'),
('Eletrônicos Valma', 123456789012343,'21996857412');

insert into productSupplier (idPSsupplier, idPSproduct, quantity) values
(1,1,500),
(1,2,400),
(2,4,633),
(3,3,5),
(2,5,10);

insert into seller (socialName, abstName, cnpj, cpf, location, contact) values
('Tech eletronics',null,123456789909871,null,'RJ',21936251445),
('Botique Durgas',null,null,123456965,'RJ',21952528585),
('Kids World',null,09876543212345,null,'SP',11965322154);

insert into productSeller (idPseller, idProduct, prodQuantity) values
(4,6,80),
(5,7,10);




insert into orders (idOrderClient, orderStatus, orderDescription, shippingCost, paymentCash) values
(2,default,'compra via app',null,1);






