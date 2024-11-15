create or replace view pedidos_mes as
select concat(c.nome+' ',c.sobrenome) as cliente, pr.nome as produto,quantidade, status_pedido
	from pedidos p
    join clientes c on c.id_cliente = p.id_cliente
    join itens_pedido ip on p.id_pedido = ip.id_pedido
    join produtos pr on pr.id_produto = ip.id_produto
    where month(p.data_pedido) = month(curdate());


select * from pedidos_mes;