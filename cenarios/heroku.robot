*** Settings ***

Library    Browser
#...      timeout=00:00:05
#...    enable_presenter_mode=${true}

Resource    ../resources/script.resource

Test Setup    Abrir
Test Teardown    fechar

*** Test Cases ***
Validar titulo da tela do heroku
    
    Given que abro o navegador
    When acesso o site do Heroku
    Then o titulo do site é the internet

Validar A/B Testing
    Given acesso o site do Heroku
    When clico no link A/B Testing
    Then sou redirecionado para pagina A/B Test Control
    
Validar Add / Remove Elements
    Given acesso o site do Heroku
    When clico no link Add / Remove Elements
    Then sou direcionado para a pagina    Add/Remove Elements

Validar inserção de elemento
    Given acesso a pagina     Add/Remove Elements
    When clico no botão Add Element
    Then é apresentado o botão    Delete

Validar a apresentação de varios botões Delete
    Given acesso a pagina     Add/Remove Elements
    When clico 4 vezes no botão para adicionar elemento
    Then é apresentado 4 botões    Delete

Validar exclusão dos botões adicionados
    Given que tenha adicionado 4 botões Delete
    When clico 4 vezes no botão delete
    Then então todos os botões são excluidos

#Validar aprsentação da mensagem Not authorized
#    Given que o pop up Fazer login esteja sendo apresentado
#    When clico no botão Cancelar
#    Then é apresentada a mensagem

Elemento "Adipisci4" deve ser apresentado na tabela
    Given que acesso a pagina Challenging DOM
    When a tabela é carregada 
    Then identifico na tabela o elemento     #Adipisci4

Coluna "Diceret" deve ser apresentado na tabela
    Given que acesso a pagina Challenging DOM
    When a tabela é carregada
    Then identifico na tabela a coluna     #Diceret

Linha "Diceret" deve ser apresentado na tabela
    Given que acesso a pagina Challenging DOM
    When a tabela é carregada
    Then identifico na tabela a linha     #Iuvaret9 Apeirian9 Adipisci9

Desmarcar "CheckBox"
    Given que acesso a tela checkboxes
    When dou um check no checkbox2
    Then é desmarcado o chechbox2

Marcar checkbox
    Given que acesso a tela checkboxes
    When dou um check no checkbox1
    Then o chechbox1 é marcado

Trocar a posição do elemento A pelo elemento B
    Given que acesso a tela Drag and Drop
    When movimento o elemento A para a posição do elemento B
    Then o elemento A fica na posição do elemento B