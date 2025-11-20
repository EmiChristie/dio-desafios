use ecommerce_desafio;

insert into address (street, number, complement, district, city, state, zip_code)
values
('Rua das Flores', '123', 'Apto 12', 'Centro', 'São Paulo', 'SP', '01001000'),
('Av. Brasil', '2000', null, 'Jardins', 'São Paulo', 'SP', '01415000'),
('Rua das Laranjeiras', '45', 'Galpão B', 'Industrial', 'Campinas', 'SP', '13010000'),
('Rua Borges', '500', null, 'Centro', 'Sorocaba', 'SP', '18010000'),
('Av. Paulista', '1500', 'Conj 1201', 'Bela Vista', 'São Paulo', 'SP', '01310000'),
('Rua do Comércio', '800', null, 'Centro', 'Rio de Janeiro', 'RJ', '20010000');

insert into client (full_name, email, phone, client_type, cpf, cnpj, corporate_name, id_address)
values
('João Silva', 'joao@email.com', '11980000000', 'pf', '12345678901', null, null, 1),
('Maria Souza', 'maria@email.com', '11970000000', 'pf', '98765432100', null, null, 2),
('Tech Corporations LTDA', 'contato@techcorp.com', '1133332222', 'pj', null, '11222333000190', 'Tech Corporations LTDA', 5);

insert into payment_method (id_client, type, credit_limit)
values
(1, 'credito', 2000.00),
(1, 'debito', null),
(2, 'boleto', null),
(3, 'credito', 50000.00);

insert into product (name, is_kids, category, review, size)
values
('Camiseta', false, 'vestimentas', 4.5, 'M'),
('Boneca', true, 'brinquedos', 4.9, 'P'),
('Notebook', false, 'eletronicos', 4.7, null),
('Mesa', false, 'moveis', 4.1, '180x90');

insert into storage (id_address, quantity)
values
(3, 500),
(4, 200);

insert into product_storage (id_product, id_storage)
values
(1, 1),
(2, 1),
(3, 2),
(4, 2);

insert into supplier (corporate_name, cnpj, contact, id_address)
values
('Fornecedor ABC', '55667788000121', '11999990000', 6),
('Moveis Reais Ltda', '33445566000189', '11888887777', 4);

insert into supplier_product (id_supplier, id_product, quantity)
values
(1, 1, 300),
(1, 2, 150),
(2, 4, 80),
(2, 3, 40);

insert into seller (corporate_name, fantasy_name, cnpj, cpf, contact, id_address)
values
('Loja da Ana', 'Ana Fashion', null, '22233344455', '11991112222', 2),
('SuperTech Distribuidora', 'SuperTech', '77889966000155', null, '1133332211', 5);

insert into seller_product (id_seller, id_product, quantity)
values
(1, 1, 20),
(1, 2, 10),
(2, 3, 50),
(2, 4, 15);

insert into orders (id_client, id_payment, status, description, shipping_cost)
values
(1, 1, 'confirmado', 'Pedido de roupas', 15.00),
(2, 3, 'em_processamento', 'Pedido infantil', 10.00),
(3, 4, 'confirmado', 'Compra empresarial', 25.00);

insert into shipping (id_order, tracking_code, status)
values
(1, 'BR123456789SP', 'enviado'),
(2, 'BR987654321SP', 'pendente'),
(3, 'BR111222333SP', 'em_transito');

insert into order_item (id_order, id_product, quantity, status)
values
(1, 1, 2, 'disponivel'),
(1, 2, 1, 'disponivel'),
(2, 2, 3, 'disponivel'),
(3, 3, 5, 'disponivel'),
(3, 4, 2, 'disponivel');
