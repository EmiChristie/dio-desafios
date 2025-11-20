use oficina_desafio;

insert into cliente (nome, cpf, telefone, email)
values
('João Silva', '12345678901', '83999990001', 'joao@email.com'),
('Maria Oliveira', '98765432100', '83988885555', 'maria@email.com'),
('Carlos Souza', '11122233344', '83998887777', 'carlos@email.com');

insert into funcionario (nome, cargo, especialidade, telefone)
values
('Pedro Mecânico', 'Mecânico', 'Motor', '83991234567'),
('Ana Diagnóstico', 'Técnica', 'Injeção Eletrônica', '83994561234'),
('Lucas Eletricista', 'Eletricista', 'Sistema elétrico', '83993445566');

insert into fornecedor (nome, cnpj, telefone, email)
values
('AutoParts Ltda', '11223344000199', '11223344', 'contato@autoparts.com'),
('Rodas & Cia', '99887766000155', '22334455', 'vendas@rodascia.com'),
('Motor Peças BR', '55667788000111', '33445566', 'suporte@motorpecas.com');

insert into endereco (logradouro, numero, bairro, cidade, estado, cep, tipo_entidade, id_entidade)
values
('Rua A', '100', 'Centro', 'Campina Grande', 'PB', '58400123', 'CLIENTE', 1),
('Rua B', '200', 'Catolé', 'Campina Grande', 'PB', '58410222', 'CLIENTE', 2),
('Av Central', '500', 'Estação', 'Campina Grande', 'PB', '58400666', 'FUNCIONARIO', 1),
('Rua das Flores', '50', 'Mirante', 'CG', 'PB', '58400677', 'FORNECEDOR', 1),
('Travessa Sol', '77', 'Liberdade', 'CG', 'PB', '58400333', 'FORNECEDOR', 2);

insert into veiculo (id_cliente, placa, modelo, marca, ano)
values
(1, 'ABC1A23', 'Civic', 'Honda', 2018),
(1, 'XYZ9B88', 'Corolla', 'Toyota', 2020),
(2, 'QWE3C55', 'Gol', 'Volkswagen', 2015),
(3, 'RTY7D99', 'Fiesta', 'Ford', 2012);

insert into ordem_servico (id_veiculo, data_emissao, data_conclusao, status, descricao_problema, id_funcionario_responsavel)
values
(1, '2025-01-10', null, 'ABERTA', 'Barulho no motor', 1),
(2, '2025-01-12', '2025-01-15', 'CONCLUIDA', 'Revisão completa', 2),
(3, '2025-01-14', null, 'EM_ANDAMENTO', 'Falha elétrica', 3);

insert into servico (nome, valor_base)
values
('Troca de óleo', 80.00),
('Alinhamento e balanceamento', 120.00),
('Revisão geral', 250.00),
('Diagnóstico eletrônico', 150.00);

insert into peca (nome, preco, estoque_atual, estoque_minimo, id_fornecedor)
values
('Filtro de óleo', 25.00, 50, 5, 1),
('Pastilha de freio', 90.00, 30, 10, 1),
('Pneu Aro 15', 350.00, 12, 4, 2),
('Bateria 60Ah', 480.00, 8, 2, 3),
('Velas de ignição', 30.00, 60, 10, 3);

insert into os_servico (id_os, id_servico, qtde, valor_unit, id_funcionario)
values
(1, 1, 1, 80.00, 1),
(1, 4, 1, 150.00, 2),
(2, 3, 1, 250.00, 2),
(3, 4, 1, 150.00, 3);

insert into os_peca (id_os, id_peca, qtde, valor_unit)
values
(1, 1, 1, 25.00),
(2, 3, 4, 350.00),
(3, 4, 1, 480.00),
(3, 5, 4, 30.00);

insert into pagamento (id_os, valor_total, forma_pagamento, data_pagamento)
values
(2, 900.00, 'CREDITO', '2025-01-15'),
(1, 255.00, 'PIX', '2025-01-20');

insert into nota_entrada (id_fornecedor, data_emissao, valor_total)
values
(1, '2025-01-05', 1250.00),
(2, '2025-01-07', 2800.00),
(3, '2025-01-09', 1500.00);

insert into item_nota_entrada (id_nota, id_peca, qtde, valor_unit)
values
(1, 1, 20, 20.00),
(1, 2, 10, 80.00),
(2, 3, 8, 300.00),
(3, 4, 5, 450.00),
(3, 5, 40, 25.00);
