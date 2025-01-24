Claro! Aqui está um exemplo de README para o seu projeto Flask:

---

# Projeto Flask de Gestão de Serviços

Este projeto é uma aplicação web desenvolvida com Flask para gerenciar serviços, unidades e órgãos. Ele permite que os usuários façam login, visualizem e editem serviços, e que coordenadores gerem relatórios de atendimentos.

## Funcionalidades

- **Login e Logout**: Autenticação de usuários com diferentes perfis (usuário e coordenador).
- **Visualização de Serviços**: Usuários podem visualizar serviços disponíveis.
- **Edição de Serviços**: Coordenadores podem editar serviços e salvar as alterações.
- **Relatório de Atendimentos**: Coordenadores podem gerar relatórios de atendimentos por serviço e órgão.
- **Assinatura de Serviços**: Coordenadores podem assinar todos os serviços de uma vez.

## Tecnologias Utilizadas

- Python
- Flask
- MySQL
- HTML/CSS
- JavaScript
- ReportLab (para geração de PDFs)

## Instalação

1. Clone o repositório:

   ```bash
   git clone https://github.com/seu-usuario/seu-repositorio.git
   ```

2. Navegue até o diretório do projeto:

   ```bash
   cd seu-repositorio
   ```

3. Crie um ambiente virtual e ative-o:

   ```bash
   python -m venv venv
   source venv/bin/activate  # No Windows, use `venv\Scripts\activate`
   ```

4. Instale as dependências:

   ```bash
   pip install -r requirements.txt
   ```

5. Configure o banco de dados MySQL:

   - Crie um banco de dados chamado `servicos`.
   - Importe o esquema do banco de dados (arquivo `schema.sql`).

6. Configure as variáveis de ambiente no arquivo `.env`:

   ```env
   FLASK_APP=app.py
   FLASK_ENV=development
   DATABASE_HOST=*********
   DATABASE_USER=*********
   DATABASE_PASSWORD=*********
   DATABASE_NAME=servicos
   SECRET_KEY=sua_chave_secreta
   ```

## Uso

1. Inicie a aplicação Flask:

   ```bash
   flask run
   ```

2. Acesse a aplicação no navegador:

   ```
   http://127.0.0.1:5000
   ```

## Estrutura do Projeto

- `app.py`: Arquivo principal da aplicação Flask.
- `templates/`: Diretório contendo os templates HTML.
- `static/`: Diretório contendo arquivos estáticos (CSS, JavaScript).
- `requirements.txt`: Arquivo de dependências do projeto.
- `schema.sql`: Arquivo SQL para criação do esquema do banco de dados.

## Contribuição

1. Faça um fork do projeto.
2. Crie uma branch para sua feature (`git checkout -b feature/nova-feature`).
3. Commit suas mudanças (`git commit -am 'Adiciona nova feature'`).
4. Faça o push para a branch (`git push origin feature/nova-feature`).
5. Abra um Pull Request.

## Licença

Este projeto está licenciado sob a Licença MIT. Veja o arquivo LICENSE para mais detalhes.

---

