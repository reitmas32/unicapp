import os
import http.server
import socketserver

# Define el nombre del archivo .env
env_file = "./assets/.env"

# Lista de las variables de entorno que deseas escribir en el archivo
env_variables = [
    "ENVIRONMENT",
    "PROD_UNIACCONTS_API_KEY",
    "PROD_SERVICE_NAME",
    "PROD_UNIACCONTS_URL_API",
    "PROD_YONESTO_API_KEY",
    "PROD_YONESTO_URL_API",
    "DEV_UNIACCONTS_API_KEY",
    "DEV_SERVICE_NAME",
    "DEV_UNIACCONTS_URL_API",
    "DEV_YONESTO_API_KEY",
    "DEV_YONESTO_URL_API",
    "STG_UNIACCONTS_API_KEY",
    "STG_SERVICE_NAME",
    "STG_UNIACCONTS_URL_API",
    "STG_YONESTO_API_KEY",
    "STG_YONESTO_URL_API",
]

# Abre el archivo .env en modo escritura
with open(env_file, "w") as file:
    # Escribe las variables de entorno en el archivo
    for var_name in env_variables:
        var_value = os.environ.get(var_name, "")
        file.write(f"{var_name}={var_value}\n")
        print(f"{var_name}={var_value}\n")

with open(env_file, "r") as file:
    print(file.read())

PORT = 5000

Handler = http.server.SimpleHTTPRequestHandler

with socketserver.TCPServer(("", PORT), Handler) as httpd:
    print(f"Serving at port {PORT}")
    httpd.serve_forever()