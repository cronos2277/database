# Oracle Report

## Assistente de Inicio

![Assistente](.img/assistente.png)

Através desse assistente acima, é possível criar um relatório de maneira automática usando a opção `Usar o Assistente de Relatório`, também é possível abrir em **modo tutorial** usando a opção `conceitos básicos`, ou abrir ou até mesmo criar tudo manualmente.

### Assistente - Definição Básica
<div style="display:block;">
    <div style="display:inline-block">
        <img src="./.img/ar_1.png">     
        <p>Você pode criar um relatório destinado para WEB ou para impressão, ou até mesmo para os dois.</p>
    </div>
    <hr>
    <div style="display:inline-block">
        <img src="./.img/ar_2.png">    
        <p>Aqui você seleciona o layout do seu relatório, a primeira opção é tabulada, ao passo que a segunda e a terceira se assemelham a formulário, porem destingue entre si pela    posição título, esses três tipos de layout são os mais usuais, sendo o segundo e terceiro focado em <b>Mestre Detalhe</b>.</p>
    </div>
    <hr>
    <div style="display:inline-block">
        <img src="./.img/ar_3.png">
        <p>Aqui você seleciona a origem dos dados, no caso estamos pegando do banco de dados, logo a opção <b>SQL Query</b> é mais aplicável.</p>        
    </div>
</div>

### Com base no SQL Query
<div style="display:block;">
    <div style="display:inline-block">
        <img src="./.img/ar_4.png">     
        <p> No caso, aqui você pode informar a query, ou usar a ferramenta <b>Query Builder</b>, clicando no botão de mesmo nome.</p>
    </div>
    <hr>
    <div style="display:inline-block">
        <img src="./.img/ar_5.png">    
        <p>Aqui você define, quais campos você gostaria de incluir.</p>
    </div>
    <hr>
    <div style="display:inline-block">
        <img src="./.img/ar_6.png">
        <p>E aqui você pode aplicar funções em determinados campos, essa parte é interessante caso precisa somar ou fazer algo asism com um campo.</p>        
    </div>
</div>

### Definindo o visual
<div style="display:block;">
    <div style="display:inline-block">
        <img src="./.img/ar_7.png">     
        <p>Aqui você define a label dos campos, por exemplo, se você não quiser que os nomes originais dos campos sejam exibidos, você pode modificar aqui, muitos campos contem underscore ou hifem e aqui você pode resolver isso.</p>
    </div>
    <hr>
    <div style="display:inline-block">
        <img src="./.img/ar_8.png">    
        <p>Aqui você define o visual da tabela, você também pode carregar algum visual se for o caso.</p>
    </div>    
</div>

## Modo Papel

Conforme visto abaixo, é possível definir, para isso, clique com o botão direito em `Layout de Papel` **>** `editor de Relatório`.

![Papel 1](.img/papel_1.png)

### Modos de visialização

![Papel 2](.img/papel_modo_visualizacao.png)

Da esquerda a direita: `Modelo de dados`, `Fonte da Web`, `Layout de Papel`, `Projeto de Papel`, `Form com parametros de papel`

#### Os modos mais relevantes
`Fonte da Web` => permite a edição do documento através da linguagem **JSP**. Como no exemplo abaixo:

![JSP](.img/papel_jsp.png)

`Layout de papel` => Permite fazer a edição do título e dos dados, no caso aqui é possível arrumar a posição do título.

![Papel Layout view](.img/papel_layout_view.png)

`Projeto de Papel` => Parecido com o `Layout de Papel`, porém exibe os dados e permite ver como está ficando.

![Modo de Papel](.img/papel_projeto_de_papel.png)
### Flex

![Flex](.img/papel_modo_flex.png)

**Fique atento a isso, aqui você ativa ou desativa o modo flex, se ativado a movimentação de ítens pode ficar engessado, fazendo com que a movimentação ocorra sempre em grupo.**

### Visualização a esquerda

**Aqui você pode ver todos os elementos que compõe o layout acima e assim como no `form builder` você pode selecionar a propriedade apertando `F4` ou indo nas propriedades e editando-as.**

![Papel Layout](.img/papel_layout.png)