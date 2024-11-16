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

-- audita aumentos de salários da empresa
delimiter $$
create trigger auditar_salario
after update on funcionarios
for each row
begin
    if (new.salario > old.salario) then
        insert into auditoria_salarios (id_funcionario, salario_antigo, salario_novo)
        values (old.id_funcionario, old.salario, new.salario);
    end if;
end $$
delimiter ;

-- audita movimentações de cadastro de produtos
delimiter $$
create trigger auditar_cadastro_produto
after insert on produtos
for each row
begin

	if validar_cadastro_produto(new.id_categoria, new.preco, new.quantidade) THEN
		insert into movimentacoes_estoque (id_produto, preco_antes, preco_depois, qtd_antes, qtd_depois, data_movimentacao) values 
		(new.id_produto, 0.00, new.preco, 0, new.quantidade, current_timestamp());
    else 
        signal sqlstate '45000' set message_text = 'Produto com especificações inválidas. Certifique-se de revisar os campos informados.';
    end if;
    
end $$
delimiter ;

-- audita movimentações de atualizações de produtos
delimiter $$
create trigger auditar_movimentacao_produto
after update on produtos
for each row
begin

	if validar_movimentacao_produto(new.id_categoria, new.preco, new.quantidade) THEN
		insert into movimentacoes_estoque (id_produto, preco_antes, preco_depois, qtd_antes, qtd_depois, data_movimentacao) values 
		(new.id_produto, old.preco, new.preco, old.quantidade, new.quantidade, current_timestamp());
    else 
        signal sqlstate '45000' set message_text = 'Produto com especificações inválidas. Certifique-se de revisar os campos informados.';
    end if;
    
end $$
delimiter ;