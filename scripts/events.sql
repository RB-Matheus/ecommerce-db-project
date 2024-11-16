-- Pressuposto: Todos os produtos vão entrar na blackfriday
delimiter $$
create event comecar_blackfriday
on schedule every 1 year -- depois rever isso daqui para ficar mais dinâmico e corresponder sempre à data precisa nos próximos anos
starts '2024-11-29 00:00:00'
do
begin
	declare erro_sql tinyint default false;
    declare continue handler for sqlexception set erro_sql = true;
    
	start transaction;
    
    delete from promocoes; -- vai evitar de duplicar ou sobrepor promoções de um mesmo produto
    
    -- usa a categoria como base para definir o preço durante o evento
    insert into promocoes (id_produto, desconto, data_inicio, data_fim)
    select 
        p.id_produto,
        case 
            when cp.nome = 'Eletrônicos' then 0.40
            when cp.nome = 'Moda' then 0.35
            when cp.nome = 'Livros' then 0.60
            when cp.nome = 'Móveis' then 0.50
            else 0.25
        end as desconto,
        current_date() as data_inicio,
        current_date() + interval 1 day as data_fim
    from produtos p
    inner join categorias_produto cp on p.id_categoria = cp.id_categoria;
    
    if erro_sql = false then
		insert into historico_atividades (tipo_atividade)
		values ('Início da Black Friday - Todas promoções adicionadas.');
		
        commit;
	else
		rollback;
	end if;
end $$
delimiter ;


delimiter $$
create event encerrar_blackfriday
on schedule every 1 year
starts '2024-11-30 00:00:00'
do
begin
    declare erro_sql tinyint default false;
    declare continue handler for sqlexception set erro_sql = true;
    
    start transaction;
    
    delete from promocoes;
    
    if erro_sql = false then
        insert into historico_atividades (tipo_atividade)
		values ('Encerramento da Black Friday - Todas promoções removidas.');
        
        commit;
    else
        rollback;
    end if;
end $$
DELIMITER ;