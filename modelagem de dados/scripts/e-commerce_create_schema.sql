-- criação do banco de dados para o cenário de e-commerce

create database ecommerce;

use ecommerce;

-- criar tabela cliente
create table clients(
	idClient int auto_increment primary key,
    fName varchar(10),
    mInit char(3),
    lName varchar(20),
    address varchar(45)
);

alter table clients auto_increment = 1;
alter table PF_client auto_increment = 1;
alter table PJ_client auto_increment = 1;
alter table product auto_increment = 1;
alter table purchase_order auto_increment = 1;
alter table productStorage auto_increment = 1;
alter table supplier auto_increment = 1;
alter table seller auto_increment = 1;

desc clients;

create table PF_client(
	clientIdPF int auto_increment primary key,
    CPF char(11) not null,
	constraint fk_client_person foreign key (clientIdPF) references clients(idClient)    
);

create table PJ_client(
	clientIdPJ int,
    CNPJ char(14) not null,
	constraint fk_client_company foreign key (clientIdPJ) references clients(idClient)    
);

-- criar tabela produto
create table product(
	idProduct int auto_increment primary key,
    pName varchar(10) not null,
    family varchar(15) not null,
    category enum ('eletrônico', 'vestimenta', 'brinquedo', 'alimento')
);

-- criar tabela pagamento
create table payment(
	idClient int,
    id_payment int,
    paymentType enum('Boleto', 'Cartão', 'Dois cartões'),
    constraint pk_payment primary key(idClient, id_payment),
    constraint fk_client_payment foreign key (idClient) references clients(idClient)
);

-- criar tabela pedido
create table purchase_order(
	orderId int auto_increment primary key,
    clientIdOrder int,
    orderStatus enum('Em andamento', 'Processando', 'Enviado', 'Entregue') default 'Processando',
    orderDescription varchar(255),
	freight float,
    paymentId int,
    constraint fk_client_payment_order foreign key (clientIdOrder, paymentId) references payment(idClient, id_payment),
    constraint fk_client_order foreign key (clientIdOrder) references clients(idClient)
);

desc purchase_order;

-- criar tabela estoque
create table productStorage(
	idProdStorage int auto_increment primary key,
    location varchar(25),
    quantity float default 0
);

-- criar tabela fornecedor
create table supplier(
	idSupplier int auto_increment primary key,
    supName varchar(25),
    CNPJ char (14) not null,
    contact char(11),
    constraint unique_supplier unique(CNPJ)
);

desc supplier;

-- criar tabela vendedor
create table seller(
	idSeller int auto_increment primary key,
    sellerName varchar(25),
    location varchar(25),
    CNPJ char(14) not null,
    contact char(11),
    constraint unique_seller unique(CNPJ)
);

create table productSeller(
	idPSeller int,
    idProduct int,
    prodQuantity float not null,
    primary key (idPSeller, idProduct),
    constraint fk_product_seller foreign key (idPSeller) references seller(idSeller),
    constraint fk_product_product foreign key (idProduct) references product(idProduct)
);

desc productSeller;

create table productOrder(
	idPOProduct int,
    idPOOrder int,
    poQuantity float not null,
    poStatus enum('Disponível', 'Sem estoque') default 'Disponível',
    primary key (idPOProduct, idPOOrder),
    constraint fk_product_order foreign key (idPOOrder) references purchase_order(orderId),
    constraint fk_productorder_product foreign key (idPOProduct) references product(idProduct)
);

create table storageLocation(
	idLProduct int,
    idLStorage int,
    location varchar(255) not null,
    primary key (idLProduct, idLStorage),
    constraint fk_product_storage foreign key (idLStorage) references productStorage(idProdStorage),
    constraint fk_productstorage_product foreign key (idLProduct) references product(idProduct)
);

create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);

show tables;

use information_schema;
show tables;
desc referential_constraints;
select * from referential_constraints where constraint_schema = 'ecommerce';
