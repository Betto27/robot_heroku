*** Settings ***

Library    Browser
Library    Process
Library    Collections
Library    OperatingSystem
Library    RequestsLibrary

Resource    ../resources/variaveis.resource
Resource    ../resources/Components/Comparar_imagens.resource

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
    Should Contain        ${texto}     A/B Test

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

#Validar aprsentação da mensagem Not authorized
que o pop up Fazer login esteja sendo apresentado
    Click    div#content.large-12.columns li:nth-child(3) a

clico no botão Cancelar
    Promise To    Wait For Alert    action=accept    prompt_input="hello hello hello hello"
    Click    id=promtButton

é apresentada a mensagem
    ${texto}    Get Text    body
    Should Be Equal    Not authorized     ${texto}

#Validar alteração do numero gerado
que acesso a pagina Challenging DOM
    Click    //*[@id="content"]/ul/li[5]/a

a tabela é carregada
    Wait For Elements State    css=div.columns.large-10 table

identifico na tabela o elemento
    ${elemento}  Get Table Cell Element    css=div.columns.large-10 table    "Dolor"    "Adipisci4"
    ${nome}      Get Text     ${elemento}  ==  Adipisci4
    Should Be Equal    ${nome}    Adipisci4

#Coluna "Diceret" deve ser apresentado na tabela
identifico na tabela a coluna
    #${elemento}    Get Table Cell Index    css=div.columns.large-10 table >> "Diceret"
    #Log To Console    ${elemento}
    #${num}    Convert To Integer    5
    #Should Be Equal    ${elemento}    ${num}
    Get Table Cell Index    css=div.columns.large-10 table >> "Diceret"    ==    5

#Linha "Diceret" deve ser apresentado na tabela
identifico na tabela a linha
    #${elemento}    Get Table Row Index    css=div.columns.large-10 table >> "Iuvaret9"
    #Log To Console    ${elemento}
    #${num}    Convert To Integer    10
    #Should Be Equal    ${elemento}    ${num}
    Get Table Row Index    css=div.columns.large-10 table >> "Iuvaret9"    ==    10

#Desmarcar "CheckBox"
que acesso a tela checkboxes
    Click    css=[href='/checkboxes']

dou um check no checkbox2
    Uncheck Checkbox        xpath=//*[@id="checkboxes"]/input[2]

é desmarcado o chechbox2
    ${res}    Get Checkbox State    xpath=//*[@id="checkboxes"]/input[2]
    ${False}    Convert To Boolean    False
    Should Be Equal    ${res}    ${False}

#Marcar checkbox
dou um check no checkbox1
    Check Checkbox    xpath=//*[@id="checkboxes"]/input[1]

o chechbox1 é marcado
    ${res}    Get Checkbox State    xpath=//*[@id="checkboxes"]/input[1]
    ${True}    Convert To Boolean    True
    Should Be Equal    ${res}    ${True}

#Trocar a posição do elemento A pelo elemento B
que acesso a tela Drag and Drop
    Click    css=[href='/drag_and_drop']

movimento o elemento A para a posição do elemento B
    Drag And Drop     css=#column-a      css=#column-b

o elemento A fica na posição do elemento B
    ${col_A}    Get Text        css=#column-a
    ${col_B}    Get Text    css=#column-b
    Should Be Equal    ${col_A}    B
    Should Be Equal    ${col_B}    A

#Selecionar "Option 2" na pagina "Dropdown List"
que acesso a pagina "Dropdown List"
    Click    css=[href='/dropdown']
    
seleciono a opção "Option 2"
    Wait For Elements State    h3
    Select Options By     id=dropdown    text    Option 2

é apresentado no "Dropdown List" a opção "Option 2"
    ${res}    Get Text    css=option[selected='selected'][value='2']
    Should Be Equal    ${res}    Option 2

#Validar atualização de conteudo da pagina "Dynamic Content" 
que acesso a pagina "Dynamic"
    Click    [href='/dynamic_content']

clico no link "click here"
    Wait For Elements State    xpath=//H3[contains(text(), 'Dynamic Content')]

é atualizado a imagem a/ou texto
    
    #Chama o arquivo comparar imagens da pasta Components passando os parametros para execução da função que faz o download das imagens
    Comparar_imagens   ${IMAGE_XPATH}    ${url_img}    ${DOWNLOADED_IMAGE}
    #Clica no link para gerar uma nova imagem
    Click    [href='/dynamic_content?with_content=static']
    #Chama o arquivo comparar imagens da pasta Components passando os parametros para execução da função que faz o download das imagens
    Comparar_imagens    ${IMAGE_XPATH}    ${url_img}    ${DOWNLOADED_IMAGE2}
    #Chama o arquivo pyhton COMPARE_IMAGAGES passando os parametros para execução e faz a comparação das imagens para saber se são iguais ou diferentes
    ${result}=    Run Process    python    compare_images.py    ${DOWNLOADED_IMAGE}    ${DOWNLOADED_IMAGE2}    stdout=True    stderr=True
    #Should Contain    ${result.stdout}    Images are identical
    Should Not Be Equal       ${result.stdout}    Images are identical
    Remove Directory    downloads    recursive=True


#Validar apresentação do nome "User2" ao passar o mouse sobre a imagem
que acesso a pagina "Hovers"
    Click    [href='/hovers']

passo o mouse sobre a imagem 2
    Hover    //*[@id="content"]/div/div[2]/img

o nome do usuario é apresentado
    Get Element States       xpath=//h5[text() = 'name: user2']    contains    visible
    Get Element States       xpath=//h5[text() = 'name: user1']    contains    hidden
    Get Element States       xpath=//h5[text() = 'name: user3']    contains    hidden



