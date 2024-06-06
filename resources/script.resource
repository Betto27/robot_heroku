*** Settings ***

Library    Browser

Resource    ../resources/variaveis.resource

*** Keywords ***

Abrir
    New Browser    ${browser}    headless=${headless}
    New Page       ${url}

Fechar
    Take Screenshot
    Close Page

#Validar titulo da tela do heroku
que abro o navegador
    Sleep     0.1

acesso o site do Heroku
    Sleep     0.1
    #Log     ${titulo}

o titulo do site é the internet
    ${titulo}    Get Title
    Should Be Equal    ${titulo}    The Internet

#Validar A/B Testing

clico no link A/B Testing
    Click    :nth-child(1) > a
    #content > ul > li:nth-child(2) > a


sou redirecionado para pagina A/B Test Control
    ${texto}    Get Text    .example > h3
    Should Be Equal    ${texto}     A/B Test Control
    
    ${text2}    Get Text    .large-4 > div
    #Log To Console    ${text2}
    Should Be Equal    Powered by Elemental Selenium    ${text2}

#Validar Add / Remove Elements
clico no link Add / Remove Elements
    Click    div#content.large-12.columns li:nth-child(2) a
    
    

sou direcionado para a pagina
    [Arguments]    ${msg}
    ${texto}    Get Text    //div[@id='content']//h3[contains(text(), 'Add/Remove Elements')]
    Should Be Equal    ${texto}    ${msg}
    
#Validar inserção de elemento
acesso a pagina
    [Arguments]    ${msg}

    Click    div#content.large-12.columns li:nth-child(2) a
    ${texto}    Get Text    //div[@id='content']//h3[contains(text(), 'Add/Remove Elements')]
    Should Be Equal    ${texto}    ${msg}

clico no botão Add Element
    Click    .example > button

é apresentado o botão
    [Arguments]    ${msg}
    ${texto}    Get Text    div .added-manually
    Should Be Equal    ${texto}     ${msg}

#Validar a apresentação de varios botões Delete
clico 4 vezes no botão para adicionar elemento
    Click With Options      .example > button    clickCount=4
    
é apresentado 4 botões
    [Arguments]    ${msg}
    ${texto}    Get Text    //div[@id="elements"]/button[4]
    Should Be Equal    ${texto}     ${msg}

#Validar exclusão dos botões adicionados
que tenha adicionado 4 botões Delete
    Click    div#content.large-12.columns li:nth-child(2) a
    Click With Options      .example > button    clickCount=4
    
clico 4 vezes no botão delete
    Click With Options    //div[@id="elements"]/button[1]    clickCount=4

então todos os botões são excluidos
    ${vazio}    Get Text               //div[@id="elements"]
    Log To Console    ${vazio}
    Should Be Empty    ${vazio}