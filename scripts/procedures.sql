delimiter $$
create procedure remover_wishlist(in p_id_cliente bigint, in p_id_produto bigint)
begin
	declare v_id_wishlist bigint;
	select id_wishlist into v_id_wishlist from wishlist where id_cliente = p_id_cliente;
	
    delete from wishlist_itens where id_wishlist = v_id_wishlist and id_produto = p_id_produto;

end $$
delimiter ;

delimiter $$
create procedure aumentar_estoque(in p_id_produto bigint, in p_quantidade bigint)
begin
	update estoque set quantidade = quantidade + quantidade where id_produto = p_id_produto;
end $$
delimiter ;

delimiter $$
create procedure ajustar_preco(in p_id_produto bigint, in p_preco bigint)
begin
	update produtos set preco = p_preco where id_produto = p_id_produto;
end $$
delimiter ;

-- daria pra fazer outras procedures neste modelo ai
