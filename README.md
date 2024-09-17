<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Configuração de Script no Cron</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 20px;
        }
        h1, h2, h3 {
            color: #333;
        }
        code {
            background-color: #f4f4f4;
            border-radius: 3px;
            padding: 2px 4px;
            font-size: 1.1em;
        }
        pre {
            background-color: #f4f4f4;
            border-radius: 3px;
            padding: 10px;
            overflow-x: auto;
        }
        .step {
            margin-bottom: 20px;
        }
        .step h3 {
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <h1>Passo a Passo para Configurar um Script no Cron</h1>
    <div class="step">
        <h2>1. Prepare o Script</h2>
        <p>Certifique-se de que o script que você deseja agendar esteja pronto e funcionando corretamente.</p>
        <h3>Crie o Script</h3>
        <pre><code>#!/bin/bash
# Configurações
SNX_PATH="/caminho/para/snx"  # Atualize para o caminho correto do cliente SNX
SERVER="vpn.example.com"      # Endereço do servidor VPN
USERNAME="your_username"      # Seu nome de usuário
PASSWORD="your_password"      # Sua senha
DOMAIN="your_domain"          # Domínio, se aplicável

# Verifique se o SNX está instalado
if [ ! -f "$SNX_PATH" ]; then
    echo "Cliente SNX não encontrado em $SNX_PATH" >&2
    exit 1
fi

# Realize o login
echo "Iniciando conexão com o servidor SNX..."
echo "$PASSWORD" | "$SNX_PATH" -h "$SERVER" -u "$USERNAME" -d "$DOMAIN"

# Verifique se a conexão foi bem-sucedida
if [ $? -eq 0 ]; then
    echo "Login bem-sucedido!"
else
    echo "Falha no login. Verifique suas credenciais e tente novamente." >&2
fi</code></pre>
        <h3>Torne o Script Executável</h3>
        <pre><code>chmod +x /caminho/para/seu/script/login_snx.sh</code></pre>
    </div>
    <div class="step">
        <h2>2. Adicionar o Script ao Crontab</h2>
        <h3>Abra o Crontab para Edição</h3>
        <pre><code>crontab -e</code></pre>
        <p>Para configurar o cron para o usuário <code>root</code>, use:</p>
        <pre><code>sudo crontab -e</code></pre>
        <h3>Adicione a Entrada para o Script</h3>
        <pre><code>0 */2 * * * /caminho/para/seu/script/login_snx.sh >> /caminho/para/logs/login_snx.log 2>&1</code></pre>
        <p>Isso executará o script a cada 2 horas e redirecionará a saída para um arquivo de log.</p>
        <h3>Salve e Feche o Editor</h3>
        <p>Dependendo do editor:</p>
        <ul>
            <li><strong>Vi/Vim:</strong> Pressione <code>Esc</code>, depois digite <code>:wq</code> e pressione <code>Enter</code>.</li>
            <li><strong>Nano:</strong> Pressione <code>Ctrl + X</code>, depois <code>Y</code> para confirmar as alterações e <code>Enter</code>.</li>
        </ul>
    </div>
    <div class="step">
        <h2>3. Verificar e Monitorar</h2>
        <h3>Verifique o Crontab</h3>
        <pre><code>crontab -l</code></pre>
        <h3>Verifique os Logs</h3>
        <pre><code>cat /caminho/para/logs/login_snx.log</code></pre>
        <h3>Verifique o Status do Serviço Cron</h3>
        <pre><code>sudo systemctl status cron</code></pre>
        <p>Ou, em sistemas mais antigos:</p>
        <pre><code>sudo service cron status</code></pre>
    </div>
    <div class="step">
        <h2>4. Depuração</h2>
        <ul>
            <li>Revise os logs para mensagens de erro.</li>
            <li>Execute o script manualmente para garantir que ele funciona fora do cron.</li>
            <li>Verifique permissões e caminhos.</li>
            <li>Adicione mensagens de depuração no script, se necessário.</li>
            <li>Certifique-se de que o crontab está correto para o usuário certo.</li>
        </ul>
    </div>
</body>
</html>
