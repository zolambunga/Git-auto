# --- START: GIT_AUTO CONFIGURATION (MODULAR E ROBUSTO) ---

#MY BEAUTIFUL API KEY!!
export GEMINI_API_KEY=""

# Variáveis de Cores (Definidas globalmente para ambas as funções)
NEON_GREEN='\e[38;5;47m' # Verde-neon
CYAN='\e[36m'            # Ciano
MAGENTA='\e[35m'         # Magenta/Rosa
YELLOW='\e[33m'          # Amarelo
RED='\e[31m'             # Vermelho
C_BOLD='\e[1m'
C_RESET='\e[0m'

# =========================================
# === FUNÇÃO PRINCIPAL: git_auto() ===
# =========================================
git-auto() {
    # Redefine cores localmente se a variável global não for acessível
    local NEON_GREEN='\e[38;5;47m' 
    local CYAN='\e[36m'            
    local MAGENTA='\e[35m'         
    local YELLOW='\e[33m'          
    local RED='\e[31m'             
    local C_BOLD='\e[1m'
    local C_RESET='\e[0m'

    # =========================================================
    # === FUNÇÃO DE LOGGING PADRÃO (FOFO E SILENCIOSO) ===
    # =========================================================
    _clean_log() {
        local COMMIT_TITLE="$1"
        local COMMIT_BODY="$2"
        local TMP_FILE="$3"

        echo -e "${NEON_GREEN}${C_BOLD}----------------------------------------${C_RESET}"
        echo -e "${NEON_GREEN}${C_BOLD}🚀 PAYLOAD DE COMMIT GERADO:${C_RESET}"
        echo -e "${CYAN}TÍTULO: ${C_BOLD}$COMMIT_TITLE${C_RESET}"

        # Log Curto
        local FIRST_LINE=$(echo "$COMMIT_BODY" | head -n 1)
        if [ -n "$FIRST_LINE" ]; then
            echo -e "${CYAN}DESCRIÇÃO: $(echo "$FIRST_LINE" | sed 's/^[[:space:]]*//')...${C_RESET}"
        else
            echo -e "${CYAN}DESCRIÇÃO: (Nenhuma descrição detalhada)${C_RESET}"
        fi
        echo -e "${NEON_GREEN}${C_BOLD}----------------------------------------${C_RESET}"

        # Execução Silenciosa
        echo -e "${CYAN}${C_BOLD}[~]${C_RESET} ${CYAN}Executando git commit...${C_RESET}"
        git commit -F "$TMP_FILE" >/dev/null # Silencia o commit

        if [ $? -ne 0 ]; then
            echo -e "${RED}${C_BOLD}[x] ERRO FATAL:${C_RESET} ${RED}Falha ao criar o commit. O índice pode estar vazio.${C_RESET}"
            return 1
        fi
        echo -e "${NEON_GREEN}${C_BOLD}[✓]${C_RESET} ${NEON_GREEN}Commit Criado com Sucesso!${C_RESET}"

        echo -e "${CYAN}${C_BOLD}[~]${C_RESET} ${CYAN}Executando git push...${C_RESET}"
        git push >/dev/null 2>&1 # Silencia o push

        if [ $? -eq 0 ]; then
            echo -e "${MAGENTA}${C_BOLD}[✓]${C_RESET} ${MAGENTA}Push Finalizado com Sucesso! Missão Cumprida! 💖${C_RESET}"
        else
            echo -e "${RED}${C_BOLD}[x] ERRO FATAL:${C_RESET} ${RED}Falha no 'git push'. Verifique credenciais ou branch.${C_RESET}"
            return 1
        fi
        return 0
    }

    # =====================================================
    # === FUNÇÃO DE LOGGING BRUTO (TÉCNICO E DETALHADO) ===
    # =====================================================
    _raw_log() {
        local COMMIT_TITLE="$1"
        local COMMIT_BODY="$2"
        local TMP_FILE="$3"

        echo -e "\n${YELLOW}========================================${C_RESET}"
        echo -e "${C_BOLD}RAW LOGGING MODE (-r)${C_RESET}"
        echo -e "${YELLOW}========================================${C_RESET}"
        echo -e "${CYAN}[PAYLOAD] TÍTULO: ${COMMIT_TITLE}${C_RESET}"
        echo -e "${CYAN}[PAYLOAD] CORPO (BODY):\n${COMMIT_BODY}${C_RESET}"
        echo -e "${YELLOW}========================================${C_RESET}"

        # Execução Barulhenta
        echo -e "${CYAN}[CMD] Executando git commit -F ${TMP_FILE}...${C_RESET}"
        git commit -F "$TMP_FILE" # Saída completa do commit
        local COMMIT_STATUS=$?

        if [ $COMMIT_STATUS -ne 0 ]; then
            echo -e "${RED}[ERRO] Falha ao criar o commit. Encerrando.${C_RESET}"
            return 1
        fi

        echo -e "${NEON_GREEN}[OK] Commit realizado.${C_RESET}"

        echo -e "${CYAN}[CMD] Executando git push...${C_RESET}"
        git push # Saída completa do push
        local PUSH_STATUS=$?

        if [ $PUSH_STATUS -eq 0 ]; then
            echo -e "${NEON_GREEN}[OK] Push finalizado com sucesso.${C_RESET}"
        else
            echo -e "${RED}[ERRO] Falha no git push (Status $PUSH_STATUS).${C_RESET}"
            return 1
        fi
        return 0
    }

    # === 0. FUNÇÃO INTERATIVA PARA SETUP DA CHAVE (ATUALIZADA) ===
    _setup_api_key() {
        echo -e "${YELLOW}================================================================${C_RESET}"
        echo -e "${RED}${C_BOLD}[x] CHAVE GEMINI NÃO CONFIGURADA!${C_RESET}"
        echo -e "${YELLOW}  Para usar a IA, você precisa gerar e definir sua chave API.${C_RESET}"
        echo -e "${CYAN}  1. Abrindo link de geração no seu navegador...${C_RESET}"

        local API_URL="https://makersuite.google.com/app/apikey"
        
        # Tenta abrir o navegador de forma cross-platform (Linux, macOS, Windows/WSL)
        if command -v xdg-open >/dev/null; then
            xdg-open "$API_URL" >/dev/null 2>&1
        elif command -v open >/dev/null; then
            open "$API_URL" >/dev/null 2>&1
        elif command -v start >/dev/null; then
            start "$API_URL" >/dev/null 2>&1
        else
            echo -e "${YELLOW}  > Aviso: Não foi possível abrir o navegador automaticamente.${C_RESET}"
            echo -e "${CYAN}  > Por favor, acesse manualmente: ${C_BOLD}$API_URL${C_RESET}"
        fi
        
        echo -e "${CYAN}  2. Gere a chave e cole-a abaixo.${C_RESET}"
        echo -e "${YELLOW}================================================================${C_RESET}"
        read -r -p "▶️ Por favor, cole sua chave API aqui: " NEW_KEY
        
        if [ -z "$NEW_KEY" ]; then
            echo -e "${RED}${C_BOLD}[x] Setup Cancelado.${C_RESET} A IA não será usada."
            return 1
        fi

        # Lógica de persistência da chave (mesma da versão anterior)
        local SCRIPT_FILE="$HOME/.git_auto_script.sh" # Assume a localização padrão
        
        if [ -f "$SCRIPT_FILE" ]; then
            # Sed robusto para encontrar e substituir a linha export GEMINI_API_KEY
            sed -i.bak '/^export GEMINI_API_KEY/c\export GEMINI_API_KEY="'"$NEW_KEY"'"' "$SCRIPT_FILE"
            
            if [ $? -eq 0 ]; then
                export GEMINI_API_KEY="$NEW_KEY"
                echo -e "${NEON_GREEN}${C_BOLD}[✓] Chave API Salva!${C_RESET} Ela foi escrita no seu arquivo ${CYAN}${SCRIPT_FILE}${C_RESET}."
                echo -e "${YELLOW}  > Próximos comandos usarão a chave. Você só precisa rodar ${C_BOLD}source ${SCRIPT_FILE}${C_RESET}${YELLOW} na próxima vez que iniciar o terminal.${C_RESET}"
                return 0
            else
                echo -e "${RED}${C_BOLD}[x] ERRO ao salvar.${C_RESET} A chave não pôde ser escrita no arquivo $SCRIPT_FILE."
                echo "Por favor, defina-a manualmente com: export GEMINI_API_KEY=\"$NEW_KEY\""
                export GEMINI_API_KEY="$NEW_KEY"
                return 0
            fi
        else
            echo -e "${RED}[x] Não foi possível encontrar o arquivo de script ($SCRIPT_FILE) para salvar a chave permanentemente.${C_RESET}"
            echo -e "${YELLOW}A chave foi definida apenas para esta sessão: export GEMINI_API_KEY=\"$NEW_KEY\"${C_RESET}"
            export GEMINI_API_KEY="$NEW_KEY"
            return 0
        fi
    }
    # ===== FLAGS E PARSING DE ARGUMENTOS =====
    local RAW_LOG=false
    local ARGS=()
    for arg in "$@"; do
        case "$arg" in
            -r|--raw) RAW_LOG=true ;;
            *) ARGS+=("$arg") ;;
        esac
    done
    set -- "${ARGS[@]}"

    # ===== 1. DETECÇÃO DE MODO E ARGS =====
    local COMMIT_TITLE=""
    local COMMIT_BODY=""
    local USE_AI_TITLE=false
    local USE_AI_BODY=false

    # O logging inicial é sempre fofo para dar feedback imediato
    if [ "$#" -eq 0 ]; then
        USE_AI_TITLE=true; USE_AI_BODY=true
        echo -e "${MAGENTA}${C_BOLD}[>]${C_RESET} ${MAGENTA}Modo Automático Total (IA) ativado.${C_RESET}"
    elif [ "$#" -eq 1 ]; then
        COMMIT_TITLE="$1"; USE_AI_BODY=true
        echo -e "${CYAN}${C_BOLD}[>]${C_RESET} ${CYAN}Modo Semi-Automático (Título manual, IA Body) ativado.${C_RESET}"
    else
        COMMIT_TITLE="$1"; COMMIT_BODY="$2"
        echo -e "${CYAN}${C_BOLD}[>]${C_RESET} ${CYAN}Modo Manual Completo ativado.${C_RESET}"
    fi

    # ===== 2. STAGE (git add .) =====
    echo -e "${NEON_GREEN}${C_BOLD}[+]${C_RESET} ${NEON_GREEN}Aplicando Stage (git add .)...${C_RESET}"
    git add . >/dev/null 2>&1

    local CHANGES=$(git diff --staged)
    if [ -z "$CHANGES" ]; then
        echo -e "${NEON_GREEN}${C_BOLD}[✓]${C_RESET} ${NEON_GREEN}Nenhuma alteração detectada. Encerrando.${C_RESET}"
        return 0
    fi

    # ===== 3. CHAMADA À IA (API) - MANTÉM A ROBUSTEZ =====
    if $USE_AI_TITLE || $USE_AI_BODY; then
        if [ -z "$GEMINI_API_KEY" ]; then
            echo -e "${RED}${C_BOLD}[x] ERRO FATAL:${C_RESET} ${RED}GEMINI_API_KEY não configurada. IA não pode ser usada.${C_RESET}"
            _setup_api_key
            #return 1
        fi
        
        # --- Construção do Payload ---
        local PROMPT_CONTENT="Analyze the git diff and generate a commit in JSON with keys: {\"title\":\"<CATEGORY>|<short commit title>\", \"body\":\"<detailed commit description>\"}.
CATEGORY should be ONE of: FIX, FEAT, REFACTOR, DOCS, STYLE, TEST, CHORE.
- Infer category based on type of change and file extensions.
- Output ONLY the JSON, no markdown, no backticks, no explanation.\n\n---\n$CHANGES\n---"
        local PROMPT_JSON=$(echo "$PROMPT_CONTENT" | jq -Rs .)
        local API_PAYLOAD_FILE=$(mktemp)
        
        cat > "$API_PAYLOAD_FILE" << EOF
{
    "contents": [
        { "parts": [ { "text": $PROMPT_JSON } ] }
    ],
    "systemInstruction": {
        "parts": [
            { "text": "You only return strict JSON in the format: {\\"title\\":\\"<CATEGORY>|<short title>\\", \\"body\\":\\"<detailed description>\\"}. No markdown, no backticks, no extra text." }
        ]
    },
    "generationConfig": { "temperature": 0.2 }
}
EOF
        
        # --- Chamada síncrona com tratamento de erros ---
        local API_CALL_RESULT_FILE=$(mktemp)
        echo -e "${CYAN}${C_BOLD}[~]${C_RESET} ${CYAN}Conectando à IA Gemini (gemini-2.5-flash)...${C_RESET}"

        local HTTP_CODE=$(curl -s -X POST \
            "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$GEMINI_API_KEY" \
            -H "Content-Type: application/json" \
            --data-binary @"$API_PAYLOAD_FILE" \
            -o "$API_CALL_RESULT_FILE" \
            -w "%{http_code}")
        
        local RAW_OUTPUT=$(cat "$API_CALL_RESULT_FILE")
        rm -f "$API_PAYLOAD_FILE"

        # Logs Brutos da API (só se RAW_LOG for true)
        if $RAW_LOG; then
            echo -e "${MAGENTA}${C_BOLD}--- AI RAW API OUTPUT (HTTP $HTTP_CODE) BEGIN ---${C_RESET}"
            echo "$RAW_OUTPUT" | jq . 2>/dev/null || echo "$RAW_OUTPUT"
            echo -e "${MAGENTA}${C_BOLD}--- AI RAW API OUTPUT END ---${C_RESET}"
        fi

        # Verificação de Erro de API
        if [ "$HTTP_CODE" -ge 400 ]; then
            local ERROR_MSG=$(echo "$RAW_OUTPUT" | jq -r '.error.message // "Resposta de erro desconhecida."')
            echo -e "${RED}${C_BOLD}[x] ERRO DE API (HTTP $HTTP_CODE):${C_RESET} ${RED}$ERROR_MSG${C_RESET}"
            rm -f "$API_CALL_RESULT_FILE"
            return 1
        fi

        # Verificação de Conteúdo Válido
        if ! echo "$RAW_OUTPUT" | jq -e '.candidates[0].content.parts[0].text' >/dev/null 2>&1; then
            echo -e "${RED}${C_BOLD}[x] ERRO DE PARSING:${C_RESET} ${RED}API não retornou JSON de commit válido.${C_RESET}"
            if ! $RAW_LOG; then
                echo -e "${YELLOW}  > Dica: Tente ${C_BOLD}git_auto -r${C_RESET}${YELLOW} para ver o log bruto da API para debug.${C_RESET}"
            fi
            rm -f "$API_CALL_RESULT_FILE"
            return 1
        fi
        
        # Extração e Limpeza
        local TEXT=$(echo "$RAW_OUTPUT" | jq -r '.candidates[0].content.parts[0].text // empty')
        local CLEAN=$(echo "$TEXT" | sed 's/^```json//g; s/```$//g; s/^[[:space:]]*//g; s/[[:space:]]*$//g')
        echo "$CLEAN" > /tmp/_ai_tmp.json

        local AI_TITLE=$(jq -r '.title // empty' /tmp/_ai_tmp.json)
        local AI_BODY=$(jq -r '.body // empty' /tmp/_ai_tmp.json)

        rm -f "$API_CALL_RESULT_FILE" /tmp/_ai_tmp.json

        if [ -z "$AI_TITLE" ]; then
            echo -e "${RED}${C_BOLD}[x] ERRO DE CONTEÚDO:${C_RESET} ${RED}A IA falhou em gerar o título do commit.${C_RESET}"
            return 1
        fi

        if $USE_AI_TITLE; then COMMIT_TITLE="$AI_TITLE"; fi
        if $USE_AI_BODY; then COMMIT_BODY="$AI_BODY"; fi
    fi

    # ===== 4. EXECUÇÃO DE COMMIT E PUSH (DELEGADA) =====
    
    local TMP_FILE=$(mktemp)
    echo -e "$COMMIT_TITLE\n\n$COMMIT_BODY" > "$TMP_FILE"

    # Chama a função de log apropriada
    if $RAW_LOG; then
        _raw_log "$COMMIT_TITLE" "$COMMIT_BODY" "$TMP_FILE"
    else
        _clean_log "$COMMIT_TITLE" "$COMMIT_BODY" "$TMP_FILE"
    fi
    
    local FINAL_STATUS=$?

    rm -f "$TMP_FILE"
    return $FINAL_STATUS
}

# --- END: GIT_AUTO CONFIGURATION (MODULAR E ROBUSTO) ---
