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