*** Settings ***

Documentation    Função que faz o download das imagens a serem comparadas e exclui a pasta downloads

*** Keywords ***
Comparar_imagens
    [Arguments]    ${IMAGE_XPATH}    ${url_img}    ${DOWNLOADED_IMAGE}
    
    ${image_url}=        Get Attribute    ${IMAGE_XPATH}    src
    ${image_url}=    Catenate    SEPARATOR=    ${url_img}    ${image_url}
    #Directory Should Not Exist    downloads
    Create Directory    downloads
    Create Session    mysession    ${image_url}
    ${response}=    Get       ${image_url}
    Should Be Equal As Strings    ${response.status_code}    200
    Create Binary File    ${DOWNLOADED_IMAGE}    ${response.content}