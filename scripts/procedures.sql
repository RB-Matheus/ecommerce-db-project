delimiter $$
create procedure remover_wishlist(in p_id_cliente bigint, in p_id_produto bigint)
begin
	declare v_id_wishlist bigint;
	select id_wishlist into v_id_wishlist from wishlist where id_cliente = p_id_cliente;
	
    delete from wishlist_itens where id_wishlist = v_id_wishlist and id_produto = p_id_produto;

end $$
delimiter ;