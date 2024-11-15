create user 'estagiario'@'localhost' identified by '123';
GRANT select ON ecommerce.* TO 'estagiario'@'localhost';

create user 'funcionario'@'localhost' identified by '123';
GRANT select,insert,update ON ecommerce.* TO 'funcionario'@'localhost';
-- talvez segmentar os funcionarios de acordo com o cargo e com a tabela que ele usa

create user 'lider'@'localhost' identified by '321';
GRANT all ON ecommerce.* TO 'lider'@'localhost';

create user 'dono'@'localhost' identified by '321';
GRANT all ON *.* TO 'dono'@'localhost';
FLUSH PRIVILEGES;