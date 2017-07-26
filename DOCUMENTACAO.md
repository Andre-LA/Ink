# Sumário
* Funções
    * Ink
        * new
        * call
    * Entidades
        * createEntity
        * removeEntity
        * getEntity
    * Componentes
        * addComponent
        * removeComponent
    * Sistemas
        * addSystem
        * getSystem
        * removeSystem
        * addEntityToSystem
        * removeEntityFromSystem

# Funções
## Ink
### `Ink.new(devMode, transformComponent, executionOrder, drawOrder)`  
ou  
`Ink(devMode, transformComponent, executionOrder, drawOrder)`  

Cria uma nova instância ink (ou seja, é um construtor)

* devMode: **booleano**, serve para indicar aos _componentes_ se está em fase de desenvolvimento ou lançamento.  
Use **true** quando estiver em desenvolvimento e **false** para lançamento.

* transformComponent: **string**, indica ao ink qual é o _componente_ usado como transform.  
É necessário que o _componente_ transform tenha a chave position, que por sua vez deverá ter a chave z, que será do tipo **número**.

* executionOrder: **tabela**, indica ao ink qual é a ordem de _componentes_, ou seja, as funções dos _componentes_ será feita nessa ordem, a exceção é a função draw

* drawOrder: **tabela**, mesmo de executionOrder, mas específico da função draw

### `ink:call (function_name, ...)`

## Entidades

### `ink:createEntity([name [, parent_id [, tag]]])`

Cria uma nova _entidade_ e **retorna** um **número**, que é a _identificação_ da _entidade_ criada (cada _entidade_ tem uma _identificação_ única)

* name: **string**, opcional, é o nome da _entidade_ que será criada.  
Caso o argumento não seja passado, o nome da _entidade_ será "entity"

* parent_id: **número**, opcional, é a _identificação_ da _entidade_ pai, o valor 0 significa "sem pai".  
Caso o argumento não seja passado, o parent_id da _entidade_ será 0.

* tag: **string**, opcional, é a etiqueta da _entidade_.  
Caso o argumento não seja passado, a etiqueta da _entidade_ será "default"


### `ink:removeEntity(entity_id)`

Remove a _entidade_ que tenha a _identificação_ passada no argumento   entity_id, também remove essa _entidade_ dos _sistemas_ que a tivesse.

* entity_id: **número**, é a _identificação_ da _entidade_ a ser removida


### `ink:getEntity (entity_id)`

**Retorna** a **tabela** da _entidade_ através da _identificação_ passada.
> Aviso: Sempre use-o como variável local

* entity_id: **número**, é a _identifição_ da _entidade_ que se pretende obter.

Exemplo:

    local heroi = ink:getEntity(heroi_id)
    heroi.rect_transform.position.x = 40

## Componentes

### `ink:addComponent (entity_id, component_name, component)`

Adiciona à _entidade_ _identificada_ uma chave com o nome passado pelo argumento component_name, o valor dessa chave será uma **tabela** passada pelo argumento component, essa chave representa o _componente_.
> Ao executar essa função, todos os sistemas terão suas listas de entidades atualizadas.

* entity_id: **número**, é a _identificação_ da _entidade_ que terá um novo _componente_.

* component_name: **string**, é o nome do _componente_ a ser adicionado, isso é, a chave dentro da **tabela** da _entidade_ que terá o conteúdo do componente.

* component: **tabela**, é o conteúdo do _componente_, ou seja, a chave criada na _entidade_ terá o valor passado pelo argumento component.

Exemplo:

    ink:addComponent(heroi_id, "componente_ataque", {
        forca = 10,
        dano = 20,
        tipo = "fisíco"
    })


> Dica: Você pode criar arquivos dos componentes e usar a função **require**, ou funções que retornem a **tabela** do _componente_

### `ink:removeComponent (entity_id, component_name)`

Remove a chave passada pelo argumento component_name da _entidade_ _identificada_, essa chave representa o _componente_.
> Ao executar essa função, todos os sistemas terão suas listas de entidades atualizadas.

* entity_id: **número**, é a _identificação_ da _entidade_ que terá seu _componente_ (chave) removido.

* component_name: **string**, é o nome do _componente_ a ser removido, ou seja, a chave a ser anulada.

## Sistemas

### `ink:addSystem (url)`

Adiciona um _sistema_ no jogo, o _sistema_ é obtida através de um **require**, no endereço passado pelo argumento url.

* url: **string**, é o endereço onde se encontra o arquivo a ser carregado como _sistema_.
> Observação: Um sistema deve obedecer à alguns critérios, abra um dos componentes que vem com o ink para usar como exemplo.

### `ink:getSystem (system_name)`

### `ink:removeSystem (system_name)`
