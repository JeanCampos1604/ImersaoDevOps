FROM python:3.13.5-alpine3.22

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia o arquivo de dependências primeiro para aproveitar o cache do Docker
COPY requirements.txt .

# Instala as dependências
RUN pip install --no-cache-dir -r requirements.txt

# Copia todo o código da aplicação para o diretório de trabalho
COPY . .

# Expõe a porta 8000, que é o padrão do Uvicorn
EXPOSE 8000

# Comando para iniciar a aplicação com Uvicorn
# O host 0.0.0.0 é necessário para que a aplicação seja acessível de fora do contêiner
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
