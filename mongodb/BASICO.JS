//Metodos do DB
/* 
    A sintaxe do Mongo DB eh baseada no javascript, uma vez dentro
    do cliente do mongo DB, eh possivel usar os comandos abaixo.
    Lembrando que o Mongo DB eh case sensetive. no nosso exemplo 
    usamos o db.<sua colection>.metodo(). Ou seja db.estado.metodos()
    lebrando que estado eh diferente de Estado. 
*/

//ao usar o comando abaixo voce tem acesso a ajuda.
db.help()
//Criando colecao. O exemplo abaixo cria uma colecao chamado Estado. 
//Sintaxe: db.createCollection('O nome da sua collection');
db.createCollection('Estado');
//Apaga a colection criada. db.<sua collection>.drop();
db.Estados.drop();
//save atualiza ou reescreve a collection, exemplo:
//db.<sua colection>.save({Objeto java script}).
db.estados.save({nome:"Acre",sigla:"AC",regiao:"Norte"})
//mostra todos os valores, o find sem argumentos retorna tudo.
db.estados.find();
//O pretty() formata a saida de dados para ficar mais legivel.
db.estados.find().pretty();
//save atualiza ou reescreve a collection, exemplo:
//db.<sua colection>.insert({Objeto java script}).
/*
    Quando voce quer criar um id ao seu objeto, voce cria um 
    campo chamado _id e voce pode criar uma chave automaticamente
    usando a funcao ObjectId(). Tambem eh possivel criar um objeto
    usando json tambem, porem o json eh mais limitado, logo geralmente
    eh mais interessante usar a estrutura de um objeto javascript para isso.
*/
db.estados.insert({
    nome:"Sao Paulo", 
    sigla:"SP", 
    regiao:"sudeste",
    cidades:[
            {
                _id:ObjectId(),
                nome:"Campinas",
                area:795.7,
                prefeito: "Jonas Donizette",
                populacao: 1081000
            },
            {
                _id:ObjectId(),
                nome:"Garulhos",
                populacao: 1325000
            },
            {
                _id:ObjectId(),
                nome:"Sorocaba",
                distanciaCapital:87,
                populacao: 644919
            }
        ] 

})
/*
    Existe uma diferenca entre o metodo save() e o insert(),
    o save se voce passar o _id ele atualiza, caso nao ele
    ira inserir. O insert ele apenas cria algo novo na colection
    Outra coisa, o banco de dados nao precisa existir para voce
    criar a collection, voce escolhe o banco de dados que deseja
    usar mesmo que ele nao exista, e assim que voce criar a collection
    o Mongo ira criar a estrutura inteira, ou seja tanto a colection
    como o banco que voce selecionou anteriormente, esse eh o modo
    schemaless que o Mongo DB trabalha. 
*/