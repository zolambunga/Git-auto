# 🚀 Git-Auto: Commit & Push com Inteligência Artificial

O **Git-Auto** é uma ferramenta robusta para automatizar o fluxo de trabalho do Git.  
Ele utiliza a API do **Google Gemini (2.5 Flash)** para analisar suas alterações (`git diff`) e gerar automaticamente títulos e descrições de commit seguindo boas práticas, realizando o `add`, `commit` e `push` em um único comando.

---

## ✨ Funcionalidades

- 🧠 **IA Integrada**: Gera mensagens de commit inteligentes baseadas no código real alterado.
- 🎨 **Interface Rica**: Feedback visual com cores neon e animações (spinners).
- 🛠️ **Três Modos de Operação**:
  - Automático → IA cuida de tudo  
  - Semi-Automático → Você define o título, a IA gera a descrição  
  - Manual → Você define tudo  
- 🧹 **Limpeza Automática**: Ignora arquivos binários, temporários e lixo de compilação no diff.
- 🔐 **Setup Interativo**: Configuração simples da API Key via prompt.

---

## 🚀 Como Instalar

1. Copie o script para um arquivo local:

```bash
~/.git_auto_script.sh
```

---

## 🔐 1. Dar permissão de execução

```bash
chmod +x ~/.git_auto_script.sh
```

---

## 🐚 2. Carregar no shell

Adicione ao seu shell (~/.zshrc ou ~/.bashrc):

```bash
source ~/.git_auto_script.sh
```

Depois reinicie o terminal ou execute:

```bash
source ~/.zshrc
```

---

## ⚙️ 3. Como Aplicar

Depois de carregado no shell, o comando git-auto estará disponível globalmente.

---

## 📖 4. Como Usar
▶️ Modo Automático Total (Recomendado)

A IA analisa o seu git diff e cria o título e a descrição:

```bash
git-auto
```

---

## ⚡ 5. Modo Semi-Automático

Você fornece o título e a IA gera a descrição:

git-auto "FEAT: Adiciona sistema de autenticação"

---

## ✍️ 6. Modo Manual

Você fornece título e descrição:

`git-auto "FIX: Corrige bug no login" "O erro ocorria devido a uma falha na validação do token JWT."`

🧪 Modo Debug (Raw)

Ver resposta bruta da IA:
```bash
git-auto -r
```
ou

```bash
git-auto --raw
```

## 🔑 7. Configuração da API Key

Na primeira vez que você usar a IA, o script vai pedir sua chave automaticamente.

Caso precise configurar manualmente:

Acesse:
[https://aistudio.google.com/app/apikey](https://aistudio.google.com/app/apikey)
Gere sua API Key
Cole quando solicitado no terminal
