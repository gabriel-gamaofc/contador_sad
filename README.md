Projeto Flask de Gestão de Serviços
Este projeto é uma aplicação web desenvolvida com Flask para gerenciar serviços, unidades e órgãos. Ele permite que os usuários façam login, visualizem e editem serviços, e que coordenadores gerem relatórios de atendimentos.

Funcionalidades
Login e Logout: Autenticação de usuários com diferentes perfis (usuário e coordenador).
Visualização de Serviços: Usuários podem visualizar serviços disponíveis.
Edição de Serviços: Coordenadores podem editar serviços e salvar as alterações.
Relatório de Atendimentos: Coordenadores podem gerar relatórios de atendimentos por serviço e órgão.
Assinatura de Serviços: Coordenadores podem assinar todos os serviços de uma vez.
Tecnologias Utilizadas
Python
Flask
MySQL
HTML/CSS
JavaScript
ReportLab (para geração de PDFs)
Instalação
Clone o repositório:

git clone https://github.com/seu-usuario/seu-repositorio.git
Navegue até o diretório do projeto:

cd seu-repositorio
Crie um ambiente virtual e ative-o:

python -m venv venv
source venv/bin/activate  # No Windows, use `venv\Scripts\activate`
Instale as dependências:

pip install -r requirements.txt
Configure o banco de dados MySQL:

Crie um banco de dados chamado servicos.
Importe o esquema do banco de dados (arquivo schema.sql).
Configure as variáveis de ambiente no arquivo .env:

FLASK_APP=app.py
FLASK_ENV=development
DATABASE_HOST=************
DATABASE_USER=**********
DATABASE_PASSWORD=******
DATABASE_NAME=servicos
SECRET_KEY=sua_chave_secreta
Uso
Inicie a aplicação Flask:

flask run
Acesse a aplicação no navegador:

http://127.0.0.1:5000
Estrutura do Projeto
app.py: Arquivo principal da aplicação Flask.
templates/: Diretório contendo os templates HTML.
static/: Diretório contendo arquivos estáticos (CSS, JavaScript).
requirements.txt: Arquivo de dependências do projeto.
schema.sql: Arquivo SQL para criação do esquema do banco de dados.
Contribuição
Faça um fork do projeto.
Crie uma branch para sua feature (git checkout -b feature/nova-feature).
Commit suas mudanças (git commit -am 'Adiciona nova feature').
Faça o push para a branch (git push origin feature/nova-feature).
Abra um Pull Request.
Licença
Este projeto está licenciado sob a Licença MIT. Veja o arquivo LICENSE para mais detalhes.
