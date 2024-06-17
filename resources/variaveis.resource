*** Variables ***

${browser}    chromium
${url}        https://the-internet.herokuapp.com/
${headless}   false

#${URL}                 https://the-internet.herokuapp.com/dynamic_content?with_content=static    # Substitua pela URL da página que você deseja testar
${IMAGE_XPATH}         (//div[@class='large-2 columns']/img)[last()]  # Substitua pelo XPATH da imagem
#${REFERENCE_IMAGE}     Original-Facebook-Geek-Profile-Avatar-2.jpg   # Substitua pelo caminho da sua imagem de referência
${DOWNLOADED_IMAGE2}     downloads/downloaded_image2.png
${DOWNLOADED_IMAGE}    downloads/downloaded_image.png
${url_img}             https://the-internet.herokuapp.com
