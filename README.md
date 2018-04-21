**I will not keep this repository anymore, because I created a new library that subs with similar goals: https://github.com/Andre-LA/Motor**

# Ink

![ink demo gif](http://i.imgur.com/WoQ8Laa.gif)

## English (google translated :P)

The purpose of ink is to: create components and connect them to entities

It works as follows:

For each function executed in ink (via :call ("function_name") function), the functions of the same name of the components are executed (it only executes the components that contain a function with this name).

For each function performed on a component, the entities that contain that component (that is, a key with the name of the component file) are taken as parameters.

Entities are tables that primarily contain id, name, tag, group, and parent (id).

When you attach a component to an entity, the entity creates a key with the name of the component's file with the properties that the component will use to perform its function, and will be inserted into the 'entities' property of the component's id of that entity.

## Português

O objetivo do ink é: criar componentes e conectá-los às entidades

Funciona da seguinte maneira:

Para cada função executada no ink (via :call("function_name") function), são executadas as funções de mesmo nome dos componentes (apenas executa os componentes que contém uma função com este nome).

Para cada função executada de um componente, é levada como parâmetro as entidades que contém esse componente (ou seja, uma chave com o nome do arquivo do componente).

As entidades são tabelas que, primariamente contém com id, nome, tag, grupo e pai (id).

Quando se anexa um componente à uma entidade, a entidade cria uma chave com o nome do arquivo do componente com as propriedades que o componente usará para executar sua função e será inserida na propriedade 'entidades' do componente a id dessa entidade.
