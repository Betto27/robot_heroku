*** Settings ***

Library    Browser
Library    Process
Library    Collections
Library    OperatingSystem
Library    RequestsLibrary

Resource    ../resources/variaveis.resource
Resource    ../resources/Components/Comparar_imagens.resource

*** Keywords ***



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
    Comparar Imagens    ${IMAGE_XPATH}    ${url_img}    ${DOWNLOADED_IMAGE}
    Take Screenshot
    Sleep    3
    #Clica no link para gerar uma nova imagem
    Click    [href='/dynamic_content?with_content=static']
    #Chama o arquivo comparar imagens da pasta Components passando os parametros para execução da função que faz o download das imagens
    Comparar Imagens    ${IMAGE_XPATH}    ${url_img}    ${DOWNLOADED_IMAGE2}
    #Chama o arquivo pyhton COMPARE_IMAGAGES passando os parametros para execução e faz a comparação das imagens para saber se são iguais ou diferentes
    ${result}=    Run Process    python    compare_images.py    ${DOWNLOADED_IMAGE}    ${DOWNLOADED_IMAGE2}    stdout=True    stderr=True
    #Should Contain    ${result.stdout}    Images are identical
    Should Not Be Equal       ${result.stdout}    Images are identical
    Remove Directory    downloads    recursive=True
    Sleep    3

#Validar apresentação do nome "User2" ao passar o mouse sobre a imagem
que acesso a pagina "Hovers"
    Click    [href='/hovers']

passo o mouse sobre a imagem 2
    Hover    //*[@id="content"]/div/div[2]/img
    Sleep    3
o nome do usuario é apresentado
    Get Element States       xpath=//h5[text() = 'name: user2']    contains    visible
    Get Element States       xpath=//h5[text() = 'name: user1']    contains    hidden
    Get Element States       xpath=//h5[text() = 'name: user3']    contains    hidden


