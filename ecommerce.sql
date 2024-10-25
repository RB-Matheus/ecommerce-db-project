
create table enderecos(
	id_endereco int primary key auto_increment,
    logradouro varchar(255) not null,
    numero varchar(30) not null,
    bairro varchar(255) not null,
    cidade varchar(255) not null,
    estado varchar(255) not null,
    cep varchar(100) not null,
    pais varchar(50) not null
);

create table telefones(
	id_telefone int primary key auto_increment,
    ddd_telefone varchar(2),
    numero_telefone varchar(9)
);

create table emails(
	id_email int primary key auto_increment,
    email varchar(255)
);

create table garantias_fornecedor(
	id_garantia int primary key auto_increment,
    id_fornecedor int,
    id_produto int,
    foreign key(id_fornecedor) references fornecedores(id_fornecedor),
    foreign key(id_produto) references produtos(id_produto)
);

create table contratos_fornecedor(
	id_contrato int primary key auto_increment,
    id_fornecedor int,
	data_inicio date not null,
	data_fim date not null,
    valor_contrato decimal(65,2)
);