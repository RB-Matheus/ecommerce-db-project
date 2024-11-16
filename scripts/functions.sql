-- valida as movimentações de produto no estoque
delimiter $$
create function validar_movimentacao_produto(p_id_categoria bigint, p_preco bigint, p_quantidade bigint)
returns boolean
deterministic
begin

	declare categoria_existe boolean;
    
    select exists (	select 1
		    		from categorias_produto
		    		where id_categoria = p_id_categoria ) 
	into categoria_existe;

    if  categoria_existe and
		p_preco > 0.00 and
        p_quantidade > 0
	then
        return true;
    end if;
    
	return false;

end $$
delimiter ;