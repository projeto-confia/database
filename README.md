# Database

Projeto cuja finalidade é criar o banco de dados com os schemas necessários para executar o AUTOMATA e o Painel Administrativo.

# Requisitos
 - Docker (versão 20.10.12 ou superior)
 - Docker-compose (versão 1.29.2 ou superior)

# Instalação

Crie um arquivo `.env` usando o arquivo `.env.example` como base.
Edite o novo arquivo com os nomes de usuário e senhas para o `postgreSQL` e o `pgAdmin`. Essas serão suas credenciais de acesso.

Em um terminal, execute o comando abaixo para criar uma rede externa do docker com o nome __confia__.

```bash
    docker network create -d bridge confia
```

Para criar os containers e iniciar os serviços `postgreSQL` e `pgAdmin`, execute:

```bash
    docker-compose up -d
```

# Iniciar e parar os serviços
O comando `docker compose up -d` é usado somente uma vez. Este comando cria os containers e automaticamente inicializa os serviços `postgreSQL` e `pgAdmin`.

Para as demais inicializações e paradas dos serviços, execute:

Inicializar o serviço
```
    docker-compose start
```

Parar o serviço
```
    docker-compose stop
```

# pgAdmin
Se quiser utilizar o `pgAdmin`, acesse o serviço pelo browser (localhost:16543) e faça o login com as credencias que você configurou no arquivo `.env`. Após o login, clique em `Add New Server` e além do nome do server (escolhido por você), na aba `Connection` insira os seguintes dados:

```
Host name/address: confia-db
Usarname: <usuário definido no arquivo .env>
Password: <senha definida no arquivo .env>
```

# Backup e restore
Os backups são armazenados na pasta `pg_backup`. Para fazer backup do banco de dados, execute o seguinte comando no terminal:

```
./pg_backup.sh
```

Para restaurar um backup, execute o seguinte comando no terminal, substituindo `dump.sql.gz` pelo nome do arquivo de backup que deseja restaurar:

```
./pg_restore.sh pg_backup/dump.sql.gz
```

# Scripts adicionais
Arquivos `.sql, .sql.gz e .sh` na pasta init-scipts serão executados (uma única vez) na criação dos containers.
Mais informações na [documentação da imagem docker postgres](https://hub.docker.com/_/postgres).

## Licença
[MIT](https://choosealicense.com/licenses/mit/)
