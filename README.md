# Database

Projeto cuja finaliade é criar o banco de dados com os schemas e necessários para executar o AUTOMATA e Painel administrativo.

## Requisitos
 - Docker;
 - Docker-Compose (versão 1.28.6);

## Instalação

Cria um arquivo `.env` usando o arquivo `.env.example` como base.
Atenção aos valores de senha para o banco e do PgAdmin, essas serão suas credenciais de acesso.

Crie uma rede externa do docker com o nome __confia__.

```bash
    docker network create -d bridge confia
```

Para iniciar os containers execute:

```bash
    docker-compose up -d
```
## Customização da inicialização
Arquivos `.sql, .sql.gz e .sh` na pasta init-scipts serão executados na primeira vez que iniciar os containers.
Mais informações na [documentação da imagem docker postgres](https://hub.docker.com/_/postgres).

## Licença
[MIT](https://choosealicense.com/licenses/mit/)
