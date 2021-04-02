# Oracle Forms
## instalação

### Inicializando o Weblogic
Para que o forms se inicialize o webforms precisa estar rodando, com posse do usuário *weblogic* e da senha configurado na instalação você deve iniciar-lo, o luncher dele deve ser **Iniciar Weblogic Admin Server**. A não inicialização deve dar o erro **FRM-10142**.

### Definindo navegador
Uma vez feito todo o processo de instalação e estiver com o listener do **Oracle Forms** devidamente configurado e se conectando, você irá precisar informar o browser que deseja utilizar, para isso segue os menus abaixo:

    EDITAR > PREFERENCIAS

Uma vez chegado lá, na aba **Runtime** no campo, localização do webBrowser, você deve informar o path do navegador a ser usado, caso você não tenha configurado isso, deve dar o erro `FRM18125`.

### Plugin no navegador
Para que seja exibido o conteúdo do canvas do *Oracle Form* no seu navegador, se faz necessário instalar um plugin chamado **JInitiator**, procure por esse plugin na loja do seu navegador, e instale-o, pois é requisito obrigatório para que seja exibido alguma coisa no navegador. Ele é difícil de encontrar, você pode tentar instalar o **Oracle EBS R12&11i Enablement for Chrome**, ou pesquise por **Oracle EBS** em qualquer navegador que tem um plugin que funciona como trial.

### Permitindo a execução no Navegador
Procure por *configure Java*, uma vez aberto você vai para a guia segurança, na guia segurança existe um campo aonde tem a Lista de exceções de sites, ali você coloca a url ao qual o Oracle forms vai executar, você deve autorizar a **URL DO SERVIDOR DE APLICAÇÕES** ali.

#### Descobrindo a URL DO SERVIDOR DE APLICAÇÕES
Com o oracle forms aberto vai em:

    EDITAR > PREFERENCIAS

ma vez chegado lá, na aba **Runtime** no campo *URL DO SERVIDOR DE APLICAÇÕES* copia a *url* ali e [adicione na permissão na configuração do JAVA](#permitindo-a-execução-no-navegador).

## Explicando
### Básico
![Navegador de Objetos](.img/navegador_de_objetos.png)
#### Bloco de dados
Essa parte se refere ou aos dados que devem ser processados, ou a(s) tabela(s) que tem ligação com o banco de dados, como no exemplo da imagem, seria a tabela **EMPLOYEES** ou **JOBS**. Dentro desse bloco tem o *triggers* que são *triggers* que podem ser anexados aos campos ou ao bloco, podendo esse ultimo se referir ou não a uma tabela no banco de dados, assim como os *itens* se referem ao campo de tabelas no banco de dados. Na parte de item tem os campos, que pode ou não ser relacionado ao campo de uma tabela no banco de dados, as relações entre os blocos também estão relacionados na parte de relações.
#### Canvas
Dentro de **Canvas** tem o sub-ítem de gráficos, ao qual todo o elemento deve estar ali dentro, caso queira que o mesmo seja exibido na aplicação, tudo que estiver dentro do canvas e do frame, será exibido ao usuário, já os campos e item que não estiverem ali, estarão ocultos.

### Criando um novo Bloco com base no banco de dados
![Novo Bloco de dados](.img/automatico_bloco_tabela.png)
Se você optar por clicar em *ok* na opção **Usar o Assistente de bloco de dados**, você pode criar um bloco de dados com ou sem o seu respectivo canvas,ao passo que a  se você marcar a opção abaixo, você pode criar um bloco em branco.







## Exemplos
### 1Basico
Aqui tem um exemplo de calculadora básica que executa as quatro operações principais, com um formulário feito no Oracle forms.

### 2Canvas
Aqui tem um exemplo básico envolvendo formulário no Oracle forms.

### 3Formulario
Aqui tem um exemplo de um formulario que se conecta com o banco de dados.

### 4TRIGGERS
Exemplo com um formulário customizável.

### 5Mestre_detalhes
Exemplo envolvendo o conceito de mestre detalhes no Oracle forms.