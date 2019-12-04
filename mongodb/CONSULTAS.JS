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
    O metodo aggregate ele permite voce fazer buscas customizadas.
    O aggregate funciona no padrao pipe and filter, para mais informacoes:
    https://www.devmedia.com.br/padrao-pipe-and-filter/29319
    Resumidamente eh como funciona o grep no linux, basicamente voce pode
    pegar o resultado de um processo como a entrada de dados de outro 
    processo. Ou seja, voce faz uma busca e essa busca sera usada como base
    para uma outra busca encadeada. No exemplo abaixo temos o $match que
    vai retornar todos os registros que tem o atributo ordem com o valor 
    igual a 2, depois voce tem o project que pega esse mesmo valor e remove
    na busca o id. Ou seja quando esse registro aparecer na tela, a 
    tupla foi consequencia do $match e a formatacao, que nesse caso removeu
    o _id do resultado foi gracas ao $project. Voce pode conhecer melhor
    os estagios acessando esse link:
    https://docs.mongodb.com/manual/reference/operator/aggregation-pipeline/
    No caso estamos usando 2 estagios o $match e o $project, existe varios
    outros que pode ser acessado no link acima, podendo ou nao serem repetidos,
    alem disso todos os estagios tem o '$' na frente sintaxe:
    db.exemplo.aggregate(
        [ <-- deve ser dentro de chaves, pois o mesmo trabalha com array.
            { <-- dentro do array temos cada estagio organizado como objetos dentro de um array.
                $match:{ordem:2} <- Estagio recebe um objeto como parametro, nesse caso filtros.
            },
            {
                $project:{_id:0} <- no caso do project voce pode usar 1 para habilitar o campo.
            }
        ]
    )    
*/
db.exemplo.aggregate(
    [
        {
            $match:{ordem:2}
        },
        {
            $project:{_id:0}
        }
    ]
)