-- Aula Roles

-- Cria um Role comum sem prazo para expirar.
CREATE ROLE joao LOGIN PASSWORD '123456' CREATEDB VALID UNTIL 'infinity';
-- cria um Role usuário que tem acesso até 01/01/2022
CREATE ROLE regina LOGIN PASSWORD '123456' SUPERUSER VALID UNTIL '2022-1-1 00:00';
-- Essa é a forma de apagar um Role.
DROP ROLE maria;
-- Aqui você cria um rule em cascata, todos os que tiverem nessa role terão os mesmo privilégios.
CREATE ROLE grupo1 INHERIT;
-- Adiciona a role acima a joao
GRANT grupo1 TO joao;
-- Adiciona a role acima a regina.
GRANT grupo1 TO regina;
