from flask import Flask, render_template, request, redirect, url_for, session, jsonify
import mysql.connector
from functools import wraps
from datetime import datetime

app = Flask(__name__)
app.secret_key = 'your_secret_key'

def get_db_connection():
    conn = mysql.connector.connect(
        host='10.1.106.200',
        user='dba',
        password='Sad#Suporte',
        database='servicos'
    )
    return conn

def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if 'logged_in' not in session:
            return redirect(url_for('login'))
        return f(*args, **kwargs)
    return decorated_function

def coordinator_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if session.get('perfil') != 'coordenador':
            return redirect(url_for('index'))
        return f(*args, **kwargs)
    return decorated_function

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute('SELECT * FROM usuarios WHERE username = %s AND password = %s', (username, password))
        user = cursor.fetchone()
        cursor.close()
        conn.close()
        if user:
            session['logged_in'] = True
            session['user_id'] = user['id']
            session['perfil'] = user['perfil']
            session['unidade_id'] = user['unidade_id']  # Assumindo que a tabela de usuários tem uma coluna unidade_id
            if user['perfil'] == 'coordenador':
                return redirect(url_for('extrato'))
            return redirect(url_for('index'))
        else:
            return 'Invalid credentials'
    return render_template('login.html')

@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('login'))

@app.route('/')
@login_required
def index():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute('SELECT * FROM unidades')
    unidades = cursor.fetchall()
    cursor.execute('SELECT * FROM orgaos')
    orgaos = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template('escolha.html', unidades=unidades, orgaos=orgaos)

@app.route('/get_orgaos', methods=['POST'])
@login_required
def get_orgaos():
    unidade_id = request.form['unidade_id']
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute('''
        SELECT DISTINCT o.id, o.nome 
        FROM orgaos o
        JOIN servicos s ON o.id = s.orgao_id
        WHERE s.unidade_id = %s
    ''', (unidade_id,))
    orgaos = cursor.fetchall()
    cursor.close()
    conn.close()
    return jsonify(orgaos)

@app.route('/contador', methods=['POST'])
@login_required
def contador():
    unidade_id = request.form['unidade']
    orgao_id = request.form['orgao']
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute('''
        SELECT s.id, s.nome 
        FROM servicos s
        WHERE s.unidade_id = %s AND s.orgao_id = %s
    ''', (unidade_id, orgao_id))
    servicos = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template('contador.html', servicos=servicos)

@app.route('/resultado', methods=['POST'])
@login_required
def resultado():
    resultados = request.form.to_dict()
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    
    # Obter os nomes dos serviços, órgãos e unidades
    servico_ids = list(resultados.keys())
    format_strings = ','.join(['%s'] * len(servico_ids))
    
    query = f'''
        SELECT s.id as servico_id, s.nome as servico_nome, o.nome as orgao_nome, u.nome as unidade_nome
        FROM servicos s
        JOIN orgaos o ON s.orgao_id = o.id
        JOIN unidades u ON s.unidade_id = u.id
        WHERE s.id IN ({format_strings})
    '''
    
    cursor.execute(query, tuple(servico_ids))
    servicos_info = cursor.fetchall()
    
    # Gravar os resultados na tabela resultados_detalhados
    for info in servicos_info:
        servico_nome = info['servico_nome']
        orgao_nome = info['orgao_nome']
        unidade_nome = info['unidade_nome']
        quantidade = resultados[str(info['servico_id'])]
        
        cursor.execute('''
            INSERT INTO resultados_detalhados (servico_nome, orgao_nome, unidade_nome, quantidade)
            VALUES (%s, %s, %s, %s)
        ''', (servico_nome, orgao_nome, unidade_nome, quantidade))
    
    # Commit the transaction to save the results
    conn.commit()
    
    cursor.close()
    conn.close()
    
    resultados_detalhados = {}
    
    for info in servicos_info:
        servico_nome = info['servico_nome']
        orgao_nome = info['orgao_nome']
        unidade_nome = info['unidade_nome']
        quantidade = resultados[str(info['servico_id'])]
        
        if (orgao_nome, unidade_nome) not in resultados_detalhados:
            resultados_detalhados[(orgao_nome, unidade_nome)] = []
        
        resultados_detalhados[(orgao_nome, unidade_nome)].append((servico_nome, quantidade))
    
    total_servicos = sum(int(v) for v in resultados.values())
    
    return render_template('resultado.html', resultados=resultados_detalhados, total=total_servicos)

@app.route('/extrato')
@coordinator_required
def extrato():
    unidade_id = session['unidade_id']
    current_month = datetime.now().month
    current_year = datetime.now().year
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute('''
        SELECT * FROM resultados_detalhados 
        WHERE unidade_nome = (SELECT nome FROM unidades WHERE id = %s)
        AND MONTH(data_hora) = %s AND YEAR(data_hora) = %s
    ''', (unidade_id, current_month, current_year))
    resultados = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template('extrato.html', resultados=resultados)

@app.route('/assinar', methods=['POST'])
@coordinator_required
def assinar():
    conn = get_db_connection()
    cursor = conn.cursor()
    
    # Atualizar os serviços com os novos valores
    for key, value in request.form.items():
        if key.startswith('servico_nome_'):
            resultado_id = key.split('_')[2]
            servico_nome = value
            orgao_nome = request.form[f'orgao_nome_{resultado_id}']
            unidade_nome = request.form[f'unidade_nome_{resultado_id}']
            quantidade = request.form[f'quantidade_{resultado_id}']
            
            cursor.execute('''
                UPDATE resultados_detalhados
                SET servico_nome = %s, orgao_nome = %s, unidade_nome = %s, quantidade = %s
                WHERE id = %s
            ''', (servico_nome, orgao_nome, unidade_nome, quantidade, resultado_id))
    
    # Assinar todos os serviços
    coordenador_id = session['user_id']
    cursor.execute('''
        UPDATE resultados_detalhados
        SET assinado = 1, coordenador_id = %s
        WHERE assinado = 0
    ''', (coordenador_id,))
    
    conn.commit()
    cursor.close()
    conn.close()
    return redirect(url_for('extrato'))

if __name__ == '__main__':
    app.run(debug=True)