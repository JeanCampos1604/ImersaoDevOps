# Imersão DevOps - Alura Google Cloud

Este projeto é uma API desenvolvida com FastAPI para gerenciar alunos, cursos e matrículas em uma instituição de ensino.

## Pré-requisitos

- [Python 3.10 ou superior instalado](https://www.python.org/downloads/)
- [Git](https://git-scm.com/downloads)
- [Docker](https://www.docker.com/get-started/)

## Passos para subir o projeto local host

### 1. Faça o download do repositório:
   [Clique aqui para realizar o download](https://github.com/guilhermeonrails/imersao-devops/archive/refs/heads/main.zip)

### 2. Crie um ambiente virtual:
   ```sh
   python3 -m venv ./venv
   ```

### 3. Ative o ambiente virtual:
   - No Linux/Mac:
     ```sh
     source venv/bin/activate
     ```
   - No Windows, abra um terminal no modo administrador e execute o comando:
   ```sh
   Set-ExecutionPolicy RemoteSigned
   ```

     ```sh
     venv\Scripts\activate
     ```

### 4. Instale as dependências:
   ```sh
   pip install -r requirements.txt
   ```

### 5. Execute a aplicação:
   ```sh
   uvicorn app:app --reload
   ```

### 6. Acesse a documentação interativa:

   Abra o navegador e acesse:  
   [http://127.0.0.1:8000/docs](http://127.0.0.1:8000/docs)

   Aqui você pode testar todos os endpoints da API de forma interativa.

---

## Usando Docker para rodar o projeto

Para rodar a aplicação em um ambiente isolado e consistente, usamos o Docker. Abaixo estão os passos e os dois métodos principais para executar o projeto.

### 1. Crie o `Dockerfile`
Na raiz do projeto, crie um arquivo chamado `Dockerfile` (sem extensão). Ele define os passos para construir a imagem da sua aplicação.

```dockerfile
# Define a imagem base do Python que será usada
FROM python:3.10-slim

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia o arquivo de dependências para o contêiner e as instala
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia todos os arquivos do projeto para o diretório de trabalho no contêiner
COPY . .

# Expõe a porta 8000 para que a aplicação possa ser acessada de fora do contêiner
EXPOSE 8000

# Define o comando que será executado quando o contêiner iniciar
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
```

### 2. (Opcional, mas recomendado) Crie o `.dockerignore`
Para otimizar o build e evitar copiar arquivos desnecessários para dentro da imagem, crie um arquivo `.dockerignore` na raiz do projeto:

```
# .dockerignore
venv
__pycache__
*.pyc
*.db
*.db-journal
.git
.vscode
.pytest_cache
```
 ### 3. Execute a Aplicação

**Método A: Usando `docker build` e `docker run` (Manual)**

1.  **Construa a imagem:**
    ```sh
    docker build -t imersao-devops .
    ```
2.  **Execute o contêiner:**
    ```sh
    docker run -p 8000:8000 imersao-devops
    ```

**Método B: Usando `docker-compose` (Recomendado para Desenvolvimento)**

O Docker Compose simplifica o gerenciamento, usando um arquivo `docker-compose.yml` para configurar e rodar a aplicação com um único comando. Isso também facilita o *hot-reloading* (alterações no código são refletidas no contêiner sem precisar reconstruir a imagem).

1.  **Crie o arquivo `docker-compose.yml`** na raiz do projeto:
    ```yaml
    services:
      api:
        build: .
        container_name: imersao-devops-api
        ports:
          - "8000:8000"
        volumes:
          - .:/app
    ```

2.  **Suba a aplicação:**
    ```sh
    docker-compose up
    ```
    > Para parar e remover o contêiner, use `docker-compose down`.

---

## Deploy no Google Cloud Run

Para fazer o deploy da sua aplicação no Google Cloud Run, você precisará do Google Cloud SDK (gcloud CLI) instalado e configurado.

### 1. Instale o Google Cloud SDK

- Link para download: https://cloud.google.com/sdk/docs/install#windows

### 2. Passos para o Deploy

Após a instalação, siga os passos abaixo no seu terminal, na raiz do projeto.

**2.1. Faça login na sua conta Google Cloud**
Este comando abrirá uma janela no seu navegador para que você possa se autenticar.
****
```sh
gcloud auth login
```

**2.2 Configure o projeto**
Defina qual projeto do Google Cloud você deseja usar. Substitua `PROJECT_ID` pelo ID do seu projeto. Você pode encontrar o ID na página inicial do seu projeto no Google Cloud Console.
```sh
gcloud config set project PROJECT_ID
```

**2.3. execute o projeto**
```sh
gcloud run deploy --port=8000
```

---

## Estrutura do Projeto

- `app.py`: Arquivo principal da aplicação FastAPI.
- `models.py`: Modelos do banco de dados (SQLAlchemy).
- `schemas.py`: Schemas de validação (Pydantic).
- `database.py`: Configuração do banco de dados SQLite.
- `routers/`: Diretório com os arquivos de rotas (alunos, cursos, matrículas).
- `requirements.txt`: Lista de dependências do projeto.

---

- O banco de dados SQLite será criado automaticamente como `escola.db` na primeira execução.
- Para reiniciar o banco, basta apagar o arquivo `escola.db` (isso apagará todos os dados).

---
