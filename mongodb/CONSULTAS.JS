db.createCollection('exemplo')
db.exemplo.insert({valor:"meu valor 1",ordem:1})
db.exemplo.insert({valor:"meu valor 2",ordem:2})
db.exemplo.insert({valor:"meu valor 3",ordem:3})
db.exemplo.insert({valor:"meu valor 4",ordem:4})
/*
    Aqui sao abordados os principais metodos de busca do Mongo DB.
    find(), quando nao tem parametros, ele retorna tudo.    
 */

/*
    Voce pode passar parametros na sintaxe chave-valor como parametro do find,
    assim sendo, voce pode fazer busca customizada
    Ex: db.exemplo.find({valor:"meu valor 4",ordem:4}), nesse caso seria 
    retornado todas as tuplas que contemple aqueles atributos.    
*/
db.exemplo.find({ordem:3})

/*
    existe tambem o metodo findOne(), quando sem parametro ele apenas retorna
    o primeiro valor registrado no Collection. Quando passado algum parametro,
    ele retorna apenas o primeiro resultado.
    Ex: db.<exemplo>.findOne({valor:"meu valor 4",ordem:4})
*/
db.exemplo.findOne({ordem:4})
/*
        o Skip() ele nao retorna o filtro estipulado dentro do metodo.
    db.<exemplo>.skip(A quantidade de resultados iniciais a serem ignorados)
    se por exemplo for passado 1 ali, o primeiro resultado sera ignorado.
*/
db.exemplo.find().skip(3)
/*
    O limit eh o contrario do skip(), o skip pula os primeiros o limit os 
    ultimos, o limit ele exibe apenas a quantidade de resultado informado,
    por exemplo se o limit for 3 ele so vai exibir os 3 primeiros resultados.
    db.<exemplo>.limit(O numero maximo de resultados a ser retornado)
*/
db.exemplo.find().limit(3)
/*
    Voce pode usar a clausura 'or' dentro do metodo find, sendo:
    db.exemplo.find(
        {
            $or ou $and:[{condicao1},{condicao2},{etc...}]
        }
    )
    Por condicoes, entenda-se um objeto contendo uma chave com
    o valor que voce deseja localizar.
*/
db.exemplo.find(
    {
        $or:[
                {ordem:2},
                {ordem:4}
            ]
    }
)

db.exemplo.find(
    {
        $and:[
            {valor:"meu valor 4"},
            {ordem:4}
        ]
    }
)
/*
    Agreggate
*/