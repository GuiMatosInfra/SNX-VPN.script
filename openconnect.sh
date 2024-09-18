#!/bin/bash

# Configurações
SERVER="vpn-pmm.manaus.am.gov.br"  # Endereço do servidor VPN
USERNAME="04897291267"             # Seu nome de usuário
PROTOCOL="gp"                      # Protocolo do VPN
LOGFILE="/var/log/openconnect.log" # Arquivo de log

# Função para iniciar a VPN
start_vpn() {
    echo "Iniciando conexão VPN com OpenConnect..." | tee -a "$LOGFILE"
    echo "$PASSWORD" | sudo openconnect --protocol="$PROTOCOL" "$SERVER" -u "$USERNAME" --passwd-on-stdin >> "$LOGFILE" 2>&1
}

# Verifique se o OpenConnect já está em execução
if pgrep -x "openconnect" > /dev/null; then
    echo "OpenConnect já está em execução." | tee -a "$LOGFILE"
else
    # Inicie a VPN com nohup
    nohup bash -c 'start_vpn' > /dev/null 2>&1 &
    echo "OpenConnect iniciado em segundo plano." | tee -a "$LOGFILE"
fi
