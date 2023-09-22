import requests
import time
from datetime import datetime

# Lista de URLs que deseas visitar
urls = [
    'https://yonesto-api-testing.onrender.com/',
    'https://uniaccounts-api-test.onrender.com/',
]

# Función para visitar las páginas y mostrar la hora
def visitar_paginas(urls):
    for url in urls:
        try:
            response = requests.get(url)
            if response.status_code == 200:
                hora_actual = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
                print(f'{hora_actual} - Página visitada con éxito: {url}')
            else:
                hora_actual = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
                print(f'{hora_actual} - Error al visitar la página: {url}')
        except Exception as e:
            hora_actual = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
            print(f'{hora_actual} - Error al visitar la página: {url}, {e}')

# Loop principal que visita las páginas cada 60 segundos
while True:
    visitar_paginas(urls)
    time.sleep(60)