create or replace view pedidos_mes as
select concat(c.nome+' ',c.sobrenome) as cliente, pr.nome as produto,quantidade, status_pedido
	from pedidos p
    join clientes c on c.id_cliente = p.id_cliente
    join itens_pedido ip on p.id_pedido = ip.id_pedido
    join produtos pr on pr.id_produto = ip.id_produto
    where month(p.data_pedido) = month(curdate());

-- select * from pedidos_mes;

create view vw_tickets_abertos as
select
    t.id_ticket,
    t.assunto,
    t.descricao,
    c.nome as cliente_nome,
    c.sobrenome as cliente_sobrenome,
    f.nome as funcionario_nome,
    f.sobrenome as funcionario_sobrenome
from tickets t
join clientes c on t.id_cliente = c.id_cliente
join funcionarios f on t.id_funcionario = f.id_funcionario
where t.status_ticket = 'aberto';


create or replace view compradores_mes as
select sum(ip.quantidade * p.preco) as total, c.nome as cliente
	from itens_pedido ip
    join pedidos pe on pe.id_pedido = ip.id_pedido
	join produtos p on p.id_produto = ip.id_produto
    join clientes c on c.id_cliente = pe.id_cliente
    group by pe.id_pedido
    order by total desc 
    limit 10;
-- select * from compradores_mes;

create or replace view produtos_promocao as
select nome, (preco - desconto) as preco_final, data_fim
	from produtos p
    join promocoes d on p.id_produto = p.id_produto;
    
select * from produtos_promocao;