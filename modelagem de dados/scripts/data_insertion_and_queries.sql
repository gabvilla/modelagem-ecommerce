-- Inserir dados na tabela clients
insert into clients (fName, mInit, lName, address) 
values 
('Carlos', 'A', 'Santos', 'Rua das Flores, 123'),
('Maria', 'B', 'Oliveira', 'Av. Paulista, 456'),
('João', 'C', 'Silva', 'Rua dos Três Irmãos, 789');

select * from clients;

-- Inserir dados na tabela PF_client
insert into PF_client (clientIdPF, CPF) 
values 
(1, '12345678901'),
(2, '98765432100');

select * from PF_client;

-- Inserir dados na tabela PJ_client
insert into PJ_client (clientIdPJ, CNPJ) 
values 
(3, '12345678000195');

select * from PJ_client;

-- Inserir dados na tabela product
insert into product (pName, family, category) 
values 
('Smartphone', 'Eletrônicos', 'eletrônico'),
('Camiseta', 'Vestimenta', 'vestimenta'),
('Boneca', 'Brinquedo', 'brinquedo'),
('Chocolate', 'Alimento', 'alimento');

select * from product;

-- Inserir dados na tabela payment
insert into payment (idClient, id_payment, paymentType) 
values 
(1, 1, 'Boleto'),
(2, 2, 'Cartão'),
(3, 3, 'Dois cartões');

insert into payment (idClient, id_payment, paymentType) 
values 
(3, 1, 'Boleto');

select * from payment;

-- Inserir dados na tabela purchase_order
insert into purchase_order (clientIdOrder, orderDescription, freight, paymentId) 
values 
(1, 'Pedido de smartphone', 10.0, 1),
(2, 'Pedido de camiseta', 5.0, 2),
(3, 'Pedido de boneca e chocolate', 15.0, 3);

insert into purchase_order (clientIdOrder, orderDescription, freight, paymentId) 
values
(3, 'Pedido de boneca', 5, 1);

select * from purchase_order;

-- Inserir dados na tabela productStorage
insert into productStorage (location, quantity) 
values 
('Armazém A', 100),
('Armazém B', 50);

select * from productStorage;

-- Inserir dados na tabela supplier
insert into supplier (supName, CNPJ, contact) 
values 
('Fornecedor A', '12345678000195', '11123456789'),
('Fornecedor B', '98765432000180', '11987654321');

select * from supplier;

-- Inserir dados na tabela seller
insert into seller (sellerName, location, CNPJ, contact) 
values 
('Vendedor A', 'Rio de Janeiro', '12345678000195', '21987654321'),
('Vendedor B', 'São Paulo', '98765432000180', '21976543210');

select * from seller;

-- Inserir dados na tabela productSeller
insert into productSeller (idPSeller, idProduct, prodQuantity) 
values 
(1, 1, 20), -- Vendedor A vende 20 smartphones
(2, 2, 30); -- Vendedor B vende 30 camisetas

select * from productSeller;

-- Inserir dados na tabela productOrder
insert into productOrder (idPOProduct, idPOOrder, poQuantity) 
values 
(1, 7, 2), -- Pedido de 2 smartphones
(2, 8, 5); -- Pedido de 5 camisetas

insert into productOrder (idPOProduct, idPOOrder, poQuantity) 
values 
(1, 7, 2), -- Pedido de 2 smartphones
(2, 8, 5); -- Pedido de 5 camisetas

select * from productOrder;

-- Inserir dados na tabela storageLocation
insert into storageLocation (idLProduct, idLStorage, location) 
values 
(1, 1, 'Prateleira 1'), -- Smartphone na prateleira 1
(2, 2, 'Prateleira 2'); -- Camiseta na prateleira 2

-- Inserir dados na tabela productSupplier
insert into productSupplier (idPsSupplier, idPsProduct, quantity) 
values 
(1, 1, 100), -- Fornecedor A fornece 100 smartphones
(2, 2, 150); -- Fornecedor B fornece 150 camisetas

-- recuperar informações de pedidos de clientes e seus status
select concat(fName, ' ', lName) as Client, orderId as Purchase_Order, orderStatus as Status 
	from clients c, purchase_order po 
	where c.idClient = po.clientIdOrder;
    
-- recuperar informações completa de cada pedido
select * from clients c, purchase_order po 
	where c.idClient = po.clientIdOrder
    group by orderId;
    
-- recuperar informações de quantidade de pedidos por cliente
select c.idClient, Fname, count(*) as Number_of_orders from clients c
	inner join purchase_order o on c.idClient = o.clientIdOrder
    group by idClient;
    
    
