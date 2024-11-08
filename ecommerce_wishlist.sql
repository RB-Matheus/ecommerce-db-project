
-- notificando os clientes que possuem o produto na wishlist
delimiter $$
create trigger notificar_promocao after insert
on promocoes
for each row
begin
	declare v_cliente int;
	declare v_done int default 0;

    declare cursor_promocoes cursor for 
		select id_cliente into v_cliente 
        from wishlist_itens wi 
        join wishlist w on wi.id_wishlist = w.id_wishlist 
        where new.id_produto = wi.id_produto;
    
    declare continue handler for not found set v_done=1;
    
	open cursor_promocoes;
    read_cursor:loop
		select * from clientes where id_cliente = v_cliente; -- aqui seria a notificação pro cliente
        
	end loop;
    close cursor_promocoes;
end $$
delimiter ;


