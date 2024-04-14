-- criação do banco de dados para o cenário de E-commerce
drop database ecommerce;
use ecommerce;

-- show tables;
-- idCLient, Fname, Minit, Lname, CPF, Address
-- criar tabela cliente
	insert into client (Fname, Minit, Lname, CPF, Address)
	values('Maria','M','Silva',12346789, 'rua de prata 29, Carangola - Cidade das Flores'),
    ('Matheus','H','Pimentel', 98745631, 'rua alameda 289, Centro - Cidade das Flores'),
    ('Ricardo','O','Silva', 45678956, 'avenida alameda vinha 1009, Centro - Cidade das Flores'),
    ('Julia','F','França', 78564231, 'rua laranjeiras 861, Centro - Cidade das Flores'),
    ('Roberta','G', 'Assis', 98756214, 'avenida koller 19, Centro - Cidade das Flores'),
    ('Isabela','M', 'Cruz', 65412356, 'rua alameda das flores 28, Centro - Cidade das Flores');
    
    -- idProduct, Pname, classification_kids boolean, category('Eletronico','Vestimenta','Brinquedos','Alimentos','Moveis'), avaliação, size
    insert into product (Pname, classification_kids, category, avaliação, size) values
    ('Fone de ouvido',false,'Eletronico','4',null),
    ('Barbie Elsa', true,'Brinquedos','3',null),
    ('Body carters', true,'Vestimenta','5',null),
    ('Microfone Vedo - Youtuber',false,'Eletronico','4',null),
    ('Sofá retrátil',false,'Móveis','3','3x57x80'),
    ('Farinha de arroz',false,'Alimentos','2',null),
    ('Fire Stick Amazon',false,'Eletronico','3',null);
    
    select * from clients;
    -- idOrder, idOrderClient, orderStatus, orderDescription, sendValue, paymentCash
    insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values
    (1, default, 'compra via aplicativo', null, 1),
    (2, default, 'compra via aplicativo', 50, 0),
    (3, 'Confirmado', null, null,1),
    (4, default,'Compra via web site',150,0);
    
    -- idPOproduct, idPOorder, poQuantify, poStatus
    insert into productOrder(idPOproduct, idPOorder, poQuantify, poStatus) values
    (1,5,2, null),
    (2,5,1, null),
    (3,6,1, null);
    
	-- idstorageLocation, quantify
    insert into productStorage(storageLocation, quantify) values
    ('Rio de Janeiro',1000),
    ('Rio de Janeiro',500),
    ('São Paulo',10),
    ('São Paulo',100),
    ('São Paulo',10),
    ('Brasília',60);
    
    -- idLproduct, idLstorage, location
    insert into storageLocation(idLproduct, idLstorage, location) values
    (1,2,'RJ'),
    (2,6,'GO');
    
    -- idSupplier, SocialName, CNPJ, contact
    insert into supplier (SocialName, CNPJ, contact) values
    ('Almeida e filhos', 123456789123567, '21985474'),
    ('Elotronicos Silva', 123456708123567, '21985464'),
    ('Elotronicos Valma', 123456789123595, '21985482');
    
    -- idPsSupllier, idPsProduct, quantify
    insert into productSupllier (idPsSupllier, idPsProduct, quantify) values
    (1,1,500),
	(1,2,400),
	(2,4,633),
	(3,3,5),
	(2,5,10),
    
    -- idSeller, SocialName, AbstName, CNPJ, CPF, location, contact
insert into seller (SocialName, AbstName, CNPJ, CPF, location, contact) values
('Tech eletronics', null, 123456789456125, null, 'Rio de Janeiro', 21996287),
('Botique Burgas', null, null, 1234567893, 'Rio de janeiro', 21596285),
('Kids Word', null, 456789123456789, null, 'São Paulo', 119856555621);

-- idPseller, idPproduct, prodQuantify
insert into productSeller (idPseller, idPproduct, prodQuantify) values
	(1,6,80),
    (2,7,10);
    
select count(*) from clients;
select * from clients c, orders o where c.idClient = idOrderClient;
select Fname, Lname, idOrder, orderStatus from clients c, orders o where c.idClient = idOrderClient;
select concat(Fname, ' ',Lname) as Client, idOrder as Request, orderStatus from clients c, orders o where c.idClient = idOrderClient;

insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values
    (2, default, 'compra via aplicativo', null, 1),
    
select count(*) from clients c, orders o 
	where c.idClient = idOrderClient
    group by
    
select * from orders;
-- recuperar quantos pedidos foram realizados pelos clientes
select * from clients c inner join orders o ON c.idClient = o.idOrderClient
inner join productOrder p on p.idPOorder = idOrder;
group by idClient;
    
 create table client(
	idClient int auto_increment primary key,
	Fname varchar(10),
	Minit char(3),
	Lname varchar(20),
	CPF char(11) not null,
	Address varchar(30),
	constraint unique_cpf_client unique (CPF)
    
);     

alter table clients auto_increment=1;

-- desc client; 


-- criar tabela produto

-- size = dimensão do produto
 create table product(
	idProduct int auto_increment primary key,
	Pname varchar(10) not null,
	Classification_kids bool default false,
	category enum('Eletronico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis') not null,
	avaliação float default 0,
	size varchar(10)
    
);

-- criar tabela pagamentos
create table payments(
	idclient int primary key,
	id_payments int,
	typePayment enum('Boleto','Cartão','Dois Cartões'),
	limitAvailable float,
	primary key(idClient, id_payment)
);
 

-- criar tabela pedido
create table orders(
	idOrder int auto_increment primary key,
	idOrderClient int,
	orderStatus enum('Cancelado','Confirmado','Em processamento') default 'Em Processamento',
	ordersDescription varchar(255),
	sendValue float default 10,
	paymentCash bool default false, 
    constraint fk_orders_client foreign key(idOrderClient) references client(idClient)
);

-- criar tabela estoque
create table productStorage(
	idProdStorage int auto_increment primary key,
	storageLocation varchar(255),
	quantify int default 0
    
);	

-- criar tabela fornecedor
create table supplier(
	idSupplier int auto_increment primary key,
	SocialName varchar(255) not null,
	CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_supplier unique(CNPJ)
    
);
-- desc supplier;
-- criar tabela vendedor
create table seller(
	idSeller int auto_increment primary key,
	SocialName varchar(255) not null,
    AbstName varchar(255) not null,
	CNPJ char(15) not null,
    CPF char(9),
    location varchar(255),
    contact char(11) not null,
    constraint unique_cnpj_seller unique(CNPJ),
    constraint unique_cpf_seller unique(CPF)
    
);
-- desc seller;

create table productSeller(
	idPseller int,
	idPproduct int,
	prodQuantify int default 1,
	primary key (idPseller, idPproduct),
	constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
	constraint fk_product_product foreign key (idPproduct) references product(idProduct)

);
-- desc productSeller;

create table productOrder(
	idPOproduct int,
	idPOorder int,
	poQuantify int default 1,
	poStatus enum('Disponível','Sem estoque') default 'Disponível',
	primary key(idPOproduct, idPOorder),
	constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
	constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)

);

create table storageLocation(
	idLproduct int,
	idLstorage int,
	location varchar(255) not null,
	primary key (idLproduct, idLstorage),
	constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
	constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)

);

create table productSupplier(
	idPsSupplier int,
	idPsProduct int,
	quantify int not null,
	primary key (idPsSupplier, idPsProduct),
	constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
	constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)

);



    
    


