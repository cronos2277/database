/* Selecionar todos os funcionarios que estao no departamento filmes ou roupas. */
SELECT * FROM `funcionarios` WHERE departamento = 'roupas' or departamento = 'filmes' order by `idFuncionario`;

/* Selecionar nome e email dos funcionarios do departamento de filmes e lar, organizando-os por nome */
SELECT nome,email FROM `funcionarios` WHERE departamento = 'filmes' or departamento = 'lar' ORDER BY nome;

/* Selecionar funcionario do sexo masculino OU do departamento Jardim*/
SELECT * FROM `funcionarios` WHERE departamento = 'Jardim' or sexo = 'Masculino'  ORDER BY nome;

/* Selecionar funcionario do sexo masculino E do departamento Jardim*/
SELECT * FROM `funcionarios` WHERE sexo = 'Masculino' and departamento = 'Jardim' ORDER BY nome;

/*
	Quando houver o AND, voce ganha desempenho se colocar a comparacao com a maior probabilidade de dar falso na frente,
    assim o banco de dados nem precisa se dar o trabalho de verificar se a outra parte eh verdadeira, uma vez
    que os dois necessitam ser verdadeiro para uma condicao com o AND passar.
    Ja o OR funciona de maneira oposta, eh possivel voce ganhar mais desempenho com o or, caso voce coloque a comparacao
    com maior probabilidade de ser verdadeiro na frente, uma vez que os dois precisam ser falso para o todo ser falso,
    com esse macete voce evita de fazer com que o BD faca uma segunda verificacao e com isso voce ganha mais desempenho.
*/