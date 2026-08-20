-- Criação do Banco de Dados
CREATE DATABASE StreamingDB;
USE StreamingDB;

-- ==========================================================
-- CRIAÇÃO DAS TABELAS
-- ==========================================================

CREATE TABLE Setores (
    Id_Setor INT AUTO_INCREMENT PRIMARY KEY,
    Nome_Setor VARCHAR(100) NOT NULL
);

CREATE TABLE Planos (
    Id_Plano INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Valor_mensal DECIMAL(10,2) NOT NULL
);

CREATE TABLE Conteudos (
    Id_Conteudo INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    Genero VARCHAR(100),
    Faixa_Etaria VARCHAR(20),
    Ano_Lancamento INT
);

CREATE TABLE Distribuidores (
    Id_Distribuidor INT AUTO_INCREMENT PRIMARY KEY,
    Nome_Fornecedor VARCHAR(255) NOT NULL,
    Pais_Origem VARCHAR(100),
    Contatos VARCHAR(255),
    Exclusividade BOOLEAN,
    Relacionamento_Direto BOOLEAN
);

CREATE TABLE Funcionarios (
    Id_Func INT AUTO_INCREMENT PRIMARY KEY,
    Nome_Completo VARCHAR(255) NOT NULL,
    Cpf VARCHAR(11) UNIQUE NOT NULL,
    Cargo VARCHAR(100),
    Salario DECIMAL(10,2),
    Data_Admissao DATE,
    Regime VARCHAR(50),
    Id_Setor_FK INT,
    FOREIGN KEY (Id_Setor_FK) REFERENCES Setores(Id_Setor)
);

CREATE TABLE Clientes (
    Id_Cliente INT AUTO_INCREMENT PRIMARY KEY,
    Cpf VARCHAR(11) UNIQUE NOT NULL,
    Nome VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Senha VARCHAR(255) NOT NULL,
    Idioma_preferencia VARCHAR(50),
    Id_Plano_FK INT,
    FOREIGN KEY (Id_Plano_FK) REFERENCES Planos(Id_Plano)
);

CREATE TABLE Conteudo_Distribuidor (
    Id_Conteudo_FK INT,
    Id_Distribuidor_FK INT,
    PRIMARY KEY (Id_Conteudo_FK, Id_Distribuidor_FK),
    FOREIGN KEY (Id_Conteudo_FK) REFERENCES Conteudos(Id_Conteudo),
    FOREIGN KEY (Id_Distribuidor_FK) REFERENCES Distribuidores(Id_Distribuidor)
);

CREATE TABLE Filme_Documentario (
    Id_Filme INT AUTO_INCREMENT PRIMARY KEY,
    Duracao INT,
    Id_Conteudo_FK INT UNIQUE,
    FOREIGN KEY (Id_Conteudo_FK) REFERENCES Conteudos(Id_Conteudo)
);

CREATE TABLE Series (
    Id_Serie INT AUTO_INCREMENT PRIMARY KEY,
    Id_Conteudo_FK INT UNIQUE,
    FOREIGN KEY (Id_Conteudo_FK) REFERENCES Conteudos(Id_Conteudo)
);

CREATE TABLE Endereco (
    Id_Endereco INT AUTO_INCREMENT PRIMARY KEY,
    Rua VARCHAR(255),
    Numero VARCHAR(20),
    Bairro VARCHAR(100),
    Cidade VARCHAR(100),
    Estado CHAR(2),
    CEP VARCHAR(20),
    Id_Cliente_FK INT UNIQUE,
    FOREIGN KEY (Id_Cliente_FK) REFERENCES Clientes(Id_Cliente)
);

CREATE TABLE Suporte (
    Protocolo INT AUTO_INCREMENT PRIMARY KEY,
    Data_Abertura DATE,
    Tipo_Problema VARCHAR(100),
    Descricao TEXT,
    Status VARCHAR(50),
    Id_Cliente_FK INT,
    FOREIGN KEY (Id_Cliente_FK) REFERENCES Clientes(Id_Cliente)
);

CREATE TABLE Pagamentos (
    Id_Pagamento INT AUTO_INCREMENT PRIMARY KEY,
    Metodo_Pagamento VARCHAR(50),
    Data DATE,
    Valor DECIMAL(10,2),
    Id_Cliente_FK INT,
    FOREIGN KEY (Id_Cliente_FK) REFERENCES Clientes(Id_Cliente)
);

CREATE TABLE Perfil (
    Id_Perfil INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100),
    Tipo VARCHAR(50),
    Id_Cliente_FK INT,
    FOREIGN KEY (Id_Cliente_FK) REFERENCES Clientes(Id_Cliente)
);

CREATE TABLE Temporadas (
    Id_Temporada INT AUTO_INCREMENT PRIMARY KEY,
    Numero_Temporada INT,
    Id_Serie_FK INT,
    FOREIGN KEY (Id_Serie_FK) REFERENCES Series(Id_Serie)
);

CREATE TABLE Episodios (
    Id_Episodio INT AUTO_INCREMENT PRIMARY KEY,
    Numero_Episodio INT,
    Titulo_Episodio VARCHAR(255),
    Duracao INT,
    Id_Temporada_FK INT,
    FOREIGN KEY (Id_Temporada_FK) REFERENCES Temporadas(Id_Temporada)
);

-- ==========================================================
-- 1. TABELAS INDEPENDENTES (INSERTS)
-- ==========================================================

INSERT INTO Setores (Nome_Setor) VALUES
('Engenharia de Software'),
('Infraestrutura de TI'),
('Suporte Técnico'),
('Atendimento ao Cliente'),
('Financeiro'),
('Recursos Humanos'),
('Marketing'),
('Vendas'),
('Jurídico'),
('Operações e Logística');

INSERT INTO Planos (Nome, Valor_mensal) VALUES
('Básico SD', 19.90),
('Padrão HD', 29.90),
('Premium 4K', 45.90),
('Estudante', 14.90),
('Família', 55.90),
('Mobile', 12.90),
('Anual Básico', 199.00),
('Anual Premium', 450.00),
('Teste 7 Dias', 0.00),
('Promocional', 9.90);

INSERT INTO Conteudos (Nome, Genero, Faixa_Etaria, Ano_Lancamento) VALUES
('O Resgate do Soldado', 'Ação', '16 Anos', 2021),
('Mistério na Mansão', 'Suspense', '14 Anos', 2023),
('Comédia de Verão', 'Comédia', 'Livre', 2022),
('O Último Voo', 'Drama', '12 Anos', 2025),
('Aventuras no Deserto', 'Aventura', '10 Anos', 2024),
('Guerra das Estrelas Perdidas', 'Ficção Científica', 'Livre', 2019),
('Amor em Paris', 'Romance', '12 Anos', 2025),
('O Ladrão de Casacas', 'Ação', '14 Anos', 2023),
('A Cidade Sombria', 'Terror', '18 Anos', 2026),
('O Navio Fantasma', 'Mistério', '16 Anos', 2021),
('Investigação Criminal', 'Policial', '16 Anos', 2020),
('Mundo Mágico', 'Fantasia', 'Livre', 2022),
('Dramas de Hospital', 'Drama', '14 Anos', 2018),
('A Família do Lado', 'Comédia', '10 Anos', 2021),
('Zumbis ao Amanhecer', 'Terror', '18 Anos', 2023),
('Detetives do Tempo', 'Ficção Científica', '12 Anos', 2025),
('Império Antigo', 'Histórico', '16 Anos', 2022),
('A Ilha Perdida', 'Sobrevivência', '14 Anos', 2024),
('Os Viajantes', 'Aventura', 'Livre', 2026),
('A Nova Fronteira', 'Documentário', 'Livre', 2023);

INSERT INTO Distribuidores (Nome_Fornecedor, Pais_Origem, Contatos, Exclusividade, Relacionamento_Direto) VALUES
('Estúdios Globais', 'EUA', 'contato@globais.com', false, true),
('Cinema Universal', 'Reino Unido', 'info@universal.co.uk', false, false),
('Streaming Originals', 'Canadá', 'originals@streaming.ca', true, true),
('Tokyo Filmes', 'Japão', 'tokyo@filmes.jp', false, true),
('Produtora Nacional', 'Brasil', 'nacional@produtora.com.br', false, true),
('Distribuidora Europeia', 'França', 'euro@distrib.fr', false, false),
('CineTech', 'EUA', 'cinetech@estudios.com', false, true),
('Indie Films', 'Alemanha', 'indie@films.de', true, false),
('Natureza Docs', 'Austrália', 'docs@natureza.au', false, true),
('Animação Ásia', 'Coreia do Sul', 'animacao@asia.kr', true, true);

-- ==========================================================
-- 2. TABELAS DE PRIMEIRO NÍVEL DE DEPENDÊNCIA
-- ==========================================================

INSERT INTO Funcionarios (Nome_Completo, Cpf, Cargo, Salario, Data_Admissao, Regime, Id_Setor_FK) VALUES
('Carlos Almeida', '11122233344', 'Desenvolvedor Java', 5500.00, '2025-01-10', 'CLT', 1),
('Ana Clara', '22233344455', 'Analista de Redes', 4800.00, '2025-02-15', 'CLT', 2),
('João Pedro', '33344455566', 'Técnico de Suporte', 3200.00, '2025-03-20', 'CLT', 3),
('Mariana Silva', '44455566677', 'Atendente N1', 2500.00, '2025-04-05', 'CLT', 4),
('Lucas Santos', '55566677788', 'Analista Financeiro', 6000.00, '2025-05-12', 'PJ', 5),
('Fernanda Costa', '66677788899', 'Gerente de RH', 8500.00, '2024-11-01', 'CLT', 6),
('Pedro Henrique', '77788899900', 'Especialista em SEO', 5000.00, '2025-06-22', 'PJ', 7),
('Beatriz Lima', '88899900011', 'Executiva de Contas', 7000.00, '2025-07-30', 'CLT', 8),
('Rafael Souza', '99900011122', 'Advogado Tributário', 9000.00, '2024-08-15', 'PJ', 9),
('Camila Rocha', '00011122233', 'Coordenadora de Operações', 6500.00, '2025-09-10', 'CLT', 10);

INSERT INTO Clientes (Cpf, Nome, Email, Senha, Idioma_preferencia, Id_Plano_FK) VALUES
('10120230340', 'Arthur Fernandes', 'arthur@email.com', 'senha123', 'PT-BR', 1),
('20230340450', 'Bruna Marques', 'bruna@email.com', 'senha456', 'EN-US', 2),
('30340450560', 'Caio Ribeiro', 'caio@email.com', 'senha789', 'PT-BR', 3),
('40450560670', 'Daniela Alves', 'daniela@email.com', 'senha321', 'ES-ES', 4),
('50560670780', 'Eduardo Gomes', 'eduardo@email.com', 'senha654', 'PT-BR', 5),
('60670780890', 'Flávia Martins', 'flavia@email.com', 'senha987', 'EN-US', 6),
('70780890900', 'Gabriel Nunes', 'gabriel@email.com', 'senhaabc', 'PT-BR', 7),
('80890900010', 'Helena Castro', 'helena@email.com', 'senhacba', 'PT-BR', 8),
('90900010120', 'Igor Moura', 'igor@email.com', 'senhaqwe', 'EN-UK', 9),
('00010120230', 'Juliana Borges', 'juliana@email.com', 'senhaewq', 'PT-BR', 10);

INSERT INTO Conteudo_Distribuidor (Id_Conteudo_FK, Id_Distribuidor_FK) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

INSERT INTO Filme_Documentario (Duracao, Id_Conteudo_FK) VALUES
(120, 1), (145, 2), (90, 3), (110, 4), (85, 5),
(105, 6), (95, 7), (130, 8), (100, 9), (115, 10);

INSERT INTO Series (Id_Conteudo_FK) VALUES
(11), (12), (13), (14), (15);

-- ==========================================================
-- 3. TABELAS DE SEGUNDO NÍVEL DE DEPENDÊNCIA
-- ==========================================================

INSERT INTO Endereco (Rua, Numero, Bairro, Cidade, Estado, CEP, Id_Cliente_FK) VALUES
('Rua das Flores', '120', 'Centro', 'São Paulo', 'SP', '01001-000', 1),
('Avenida Paulista', '1500', 'Bela Vista', 'São Paulo', 'SP', '01310-100', 2),
('Rua do Sol', '45', 'Boa Vista', 'Recife', 'PE', '50060-000', 3),
('Avenida Brasil', '500', 'Centro', 'Belo Horizonte', 'MG', '30180-000', 4),
('Rua XV de Novembro', '100', 'Centro', 'Curitiba', 'PR', '80020-310', 5),
('Avenida Afonso Pena', '200', 'Centro', 'Campo Grande', 'MS', '79002-070', 6),
('Rua da Paz', '10', 'Aldeota', 'Fortaleza', 'CE', '60150-120', 7),
('Avenida Sete de Setembro', '800', 'Vitória', 'Salvador', 'BA', '40060-001', 8),
('Rua das Aves', '300', 'Moinhos de Vento', 'Porto Alegre', 'RS', '90570-020', 9),
('Rua das Oliveiras', '99', 'Lagoa Nova', 'Natal', 'RN', '59056-000', 10);

INSERT INTO Suporte (Data_Abertura, Tipo_Problema, Descricao, Status, Id_Cliente_FK) VALUES
('2026-06-01', 'Cobrança', 'Cobrança duplicada no cartão', 'Aberto', 1),
('2026-06-02', 'Acesso', 'Não consigo redefinir a senha', 'Resolvido', 2),
('2026-06-03', 'Técnico', 'Travamento na Smart TV', 'Em Andamento', 3),
('2026-06-04', 'Dúvida', 'Como mudar o idioma padrão?', 'Resolvido', 4),
('2026-06-05', 'Cancelamento', 'Desejo cancelar o plano', 'Aberto', 5),
('2026-06-06', 'Técnico', 'Erro de tela preta no PC', 'Resolvido', 6),
('2026-06-07', 'Plano', 'Quero fazer upgrade para o 4K', 'Fechado', 7),
('2026-06-08', 'Cobrança', 'Boleto não chegou no e-mail', 'Resolvido', 8),
('2026-06-09', 'Acesso', 'Conta bloqueada após 3 tentativas', 'Em Andamento', 9),
('2026-06-10', 'Conteúdo', 'Série sem legenda em PT-BR', 'Aberto', 10);

INSERT INTO Pagamentos (Metodo_Pagamento, Data, Valor, Id_Cliente_FK) VALUES
('Cartão de Crédito', '2026-06-01', 19.90, 1),
('Cartão de Crédito', '2026-06-02', 29.90, 2),
('Pix', '2026-06-03', 45.90, 3),
('Boleto', '2026-06-04', 14.90, 4),
('Cartão de Crédito', '2026-06-05', 55.90, 5),
('Pix', '2026-06-06', 12.90, 6),
('Cartão de Crédito', '2026-06-07', 199.00, 7),
('Boleto', '2026-06-08', 450.00, 8),
('Pix', '2026-06-09', 0.00, 9),
('Cartão de Crédito', '2026-06-10', 9.90, 10);

INSERT INTO Perfil (Nome, Tipo, Id_Cliente_FK) VALUES
('Arthur Principal', 'Adulto', 1),
('Bruna Kids', 'Infantil', 2),
('Caio Filmes', 'Adulto', 3),
('Daniela Séries', 'Adulto', 4),
('Dudu Animações', 'Infantil', 5),
('Flávia Docs', 'Adulto', 6),
('Gabriel Games', 'Adulto', 7),
('Helena Principal', 'Adulto', 8),
('Igor Tech', 'Adulto', 9),
('Juliana Convidados', 'Adulto', 10);

INSERT INTO Temporadas (Numero_Temporada, Id_Serie_FK) VALUES
(1, 1), (2, 2), (1, 3), (3, 4), (1, 5), (4, 6), (2, 7), (1, 8), (5, 9), (1, 10);