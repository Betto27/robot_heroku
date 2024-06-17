*** Settings ***

Library    Browser
#...      timeout=00:00:05
#...    enable_presenter_mode=${true}

Resource    ../resources/script.resource

Test Setup    Abrir
Test Teardown    fechar

*** Test Cases ***
Selecionar "Option 2" na pagina "Dropdown List"
    Given que acesso a pagina "Dropdown List"
    When seleciono a opção "Option 2"
    Then é apresentado no "Dropdown List" a opção "Option 2"
    
Validar atualização de conteudo da pagina "Dynamic Content" 
    Given que acesso a pagina "Dynamic"
    When clico no link "click here"
    Then é atualizado a imagem a/ou texto
    
Validar apresentação do nome "User2" ao passar o mouse sobre a imagem
    Given que acesso a pagina "Hovers"
    When passo o mouse sobre a imagem 2
    Then o nome do usuario é apresentado