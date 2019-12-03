//Metodos do DB
//Ajuda.
db.help()
//Criando colecao
db.createCollection('Estado');
//Apaga a colection criada, a mesma eh case sensetive.
db.Estados.drop();
//save atualiza ou reescreve
db.estados.save({nome:"Acre",sigla:"AC",regiao:"Norte"})
//mostra todos os valores
db.estados.find();
//mostra todos os valores de maneira formatada
db.estados.find().pretty();
//save atualiza ou reescreve
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