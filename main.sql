-- veículos aula
-- auditorias
-- triggers e chamar arquivo

create table contas(
    id_conta bigint primary key auto_increment,
    id_usuario bigint,
    data_criacao timestamp default current_timestamp(),
    foreign key(id_usuario) references usuarios(id_usuario)
);

-- Vai generalizar funcionários, fornecedores e clientes
create table usuarios(
    id_usuario bigint primary key auto_increment,
    apelido varchar(50) unique,
    status_usuario enum('online', 'offline') default 'offline'
);

create table funcionarios(
    id_funcionario bigint primary key auto_increment,
    cpf varchar(11) not null unique,
    nome varchar(50) not null,
    sobrenome varchar(100) not null,
    idade int not null,
    id_cargo bigint,
    id_departamento bigint,
    foreign key(id_cargo) references cargos(id_cargo),
    foreign key(id_departamento) references departamentos(id_departamento),
    foreign key(id_funcionario) references usuarios(id_usuario)
);

create table fornecedores(
    id_fornecedor bigint primary key auto_increment,
    cnpj varchar(14) unique not null,
    razao_social varchar(255) not null,
    foreign key(id_fornecedor) references usuarios(id_usuario)
);

create table clientes(
    id_cliente bigint primary key auto_increment,
    nome varchar(50) not null,
    sobrenome varchar(100) not null,
    id_wishlist bigint,
    foreign key(id_wishlist) references wishlists(id_wishlist),
    foreign key(id_cliente) references usuarios(id_usuario)
);

create table departamentos(
    id_departamento bigint primary key auto_increment,
    nome varchar(255) not null,
    sigla varchar(10) not null
);

create table cargos(
    id_cargo bigint primary key auto_increment,
    nome varchar(100) not null,
    salario decimal(20,2) not null,
    atribuicoes varchar(255) not null
);

create table emails(
	id_email bigint primary key auto_increment,
    id_usuario bigint,
    email varchar(100),
    foreign key(id_usuario) references usuarios(id_usuario)
);


create table vendas(
	id_venda int primary key auto_increment,
    id_cliente int,
    id_produto int,
    quantidade int,
    data_venda timestamp default now(),
    status_pagamento varchar(50),
    foreign key(id_cliente) references clientes(id_cliente),
    foreign key(id_produto) references produtos(id_produto)
);

create table pedidos(
	id_pedido int primary key auto_increment,
    id_cliente int,
    data_pedido timestamp default now(), 
    status_pedido varchar(50),
    id_frete int,
    foreign key(id_cliente) references clientes(id_cliente),
    foreign key(id_frete) references fretes(id_frete)
);
create table itens_pedido(
    id_pedido int,
    id_produto int,
    quantidade int not null,
    foreign key(id_pedido) references pedidos(id_pedido),
    foreign key(id_produto) references produtos(id_produto)
);

create table fretes(
	id_frete int primary key auto_increment,
    cidade_partida varchar(100),
    cidade_destino varchar(100),
    previsao_dias int,
    tipo_veiculo varchar(100),
    id_pedido int,
    foreign key(id_pedido) references pedidos(id_pedido)
);

create table estoque(
	id_estoque int primary key auto_increment,
    id_produto int,
    quantidade int not null,
    foreign key(id_produto) references produtos(id_produto)
);

create table produtos(
	id_produto int primary key auto_increment,
    nome varchar(200) not null,
	id_categoria int,
    preco decimal(20,2),
    descricao varchar(255),
    peso float not null,
    volume varchar(100),
    foreign key(id_categoria) references categorias_produto(id_categoria)
);

create table categorias_produto(
	id_categoria int primary key auto_increment,
    nome varchar(255)
);
create table promocoes(
	id_promocao bigint primary key auto_increment,
	id_produto int,
    desconto float,
    data_inicio date not null,
    data_fim date,
    foreign key(id_produto) references produtos(id_produto)
);
create table carrinhos(
	id_carrinho bigint primary key auto_increment,
    id_cliente bigint,
    foreign key(id_cliente) references clientes(id_cliente)
);
create table carrinho_itens( -- pendente
    id_carrinho bigint,
    id_produto bigint,
    quantidade bigint not null,
    foreign key(id_carrinho) references carrinhos(id_carrinho),
    foreign key(id_produto) references produtos(id_produto)
);

create table wishlist(
	id_wishlist bigint primary key auto_increment,
    id_cliente bigint,
    foreign key(id_cliente) references clientes(id_cliente)
);

create table wishlist_itens( -- pendente
	id_wishlist bigint,
	id_produto bigint,
    foreign key(id_wishlist) references wishlist(id_wishlist),
    foreign key(id_produto) references produtos(id_produto)
);

create table enderecos(
	id_endereco bigint primary key auto_increment,
    logradouro varchar(255) not null,
    numero varchar(30) not null,
    bairro varchar(255) not null,
    cidade varchar(255) not null,
    estado varchar(255) not null,
    cep varchar(100) not null,
    pais varchar(50) not null
);

create table telefones(
	id_telefone bigint primary key auto_increment,
    ddd_telefone varchar(2),
    numero_telefone varchar(9)
);

create table tickets(
	id_ticket bigint auto_increment primary key,
    id_cliente bigint,
    id_funcionario bigint,
    assunto varchar(255),
    descricao varchar(255),
    foreign key(id_pedido) references pedidos(id_pedido),
    foreign key(id_funcionario) references funcionarios(id_funcionario)
);

create table pagamentos(
	id_pagamento bigint auto_increment primary key,
    id_pedido bigint,
    id_funcionario bigint,
    id_fornecedor bigint,
    valor decimal(30,2) not null,
	data_pagamento timestamp default now(),
    foreign key(id_pedido) references pedidos(id_pedido),
    foreign key(id_funcionario) references funcionarios(id_funcionario),
    foreign key(id_fornecedor) references fornecedores(id_fornecedor)
);

create table compras(
	id_compra bigint auto_increment primary key,
    id_produto bigint,
    id_fornecedor bigint,
    quantidade bigint not null,
	preco_aquisicao decimal(20,2) not null,
    foreign key(id_produto) references produtos(id_produto),
    foreign key(id_fornecedor) references fornecedores(id_fornecedor)
);

create table historico_atividades(
	id_atividade bigint auto_increment primary key,
    tipo_atividade varchar(255),
	data_atividade timestamp default now()
);

create table historico_compras(
	id_historico bigint auto_increment primary key,
    id_cliente bigint,
    id_pedido bigint,
    data_comentario timestamp default now(),
    foreign key(id_cliente) references clientes(id_cliente),
    foreign key(id_pedido) references pedidos(id_pedidos)
);

create table comentarios(
	id_comentario bigint auto_increment primary key,
    id_cliente bigint,
    id_produto bigint,
    comentario varchar(255) not null,
    data_comentario timestamp default now(),
    foreign key(id_cliente) references clientes(id_cliente),
    foreign key(id_produto) references produtos(id_produto)
);

create table avaliacoes(
	id_avaliacao bigint auto_increment primary key,
    id_cliente bigint,
    id_produto bigint,
	nota float not null,
    data_avaliacao timestamp default now(),
    foreign key(id_cliente) references clientes(id_cliente),
    foreign key(id_produto) references produtos(id_produto)
);

create table garantias(
	id_garantia bigint auto_increment primary key,
    id_produto bigint,
    periodo_garantia date not null,
    tipo_garantia varchar(50),
	foreign key(id_produto) references produtos(id_produto)
);

create table garantias_cliente(
	id_garantia bigint auto_increment primary key,
	id_cliente bigint,
    id_produto bigint,
    foreign key(id_cliente) references clientes(id_cliente),
    foreign key(id_produto) references produtos(id_produto)
);

create table garantias_fornecedor(
	id_garantia bigint primary key auto_increment,
    id_fornecedor bigint,
    id_produto bigint,
    foreign key(id_fornecedor) references fornecedores(id_fornecedor),
    foreign key(id_produto) references produtos(id_produto)
);

create table contratos_fornecedor(
	id_contrato bigint primary key auto_increment,
    id_fornecedor bigint,
	data_inicio date not null,
	data_fim date not null,
    valor_contrato decimal(65,2)
);