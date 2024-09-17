#!/bin/bash

# Configurações
SNX_PATH="/usr/bin/snx"  # Caminho para o cliente SNX
SERVER="ipvpn"  # Endereço do servidor VPN
USERNAME="user"  # Seu nome de usuário
PASSWORD="password"  # Sua senha
#DOMAIN="your_domain"       Domínio, se aplicável

# Verifique se o SNX está instalado
if [ ! -f "$SNX_PATH" ]; then
   echo "Cliente SNX não encontrado em $SNX_PATH"
   exit 1
fi

# Realize o login
echo "Iniciando conexão com o servidor SNX..."

echo "$PASSWORD" | "$SNX_PATH" -s "$SERVER" -u "$USERNAME"

# Verifique se a conexão foi bem-sucedida
if [ $? -eq 0 ]; then
    echo "Login bem-sucedido!"
else
    echo "Falha no login. Verifique suas credenciais e tente novamente."
fi

