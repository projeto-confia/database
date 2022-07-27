SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


INSERT INTO admin_panel.env_variable(name, description, type, default_value, value)  VALUES
('ENGINE.FREQUENCY', 'Valor numérico inteiro que define o tempo de intervalo em segundos entre cada inicialização de um novo ciclo de processamento do AUTOMATA. Cada ciclo de processamento do AUTOMATA engloba as etapas de processamento de todos os módulos do sistema.', 'int', '21600', '21600'),
('MONITOR.STREAM_FILTER_OF_SHARES', 'Valor numérico inteiro maior ou igual a 0. Atua como um limiar para descarte dos tweets colhidos via streaming que possuem um número de compartilhamentos menor do que o valor definido em MONITOR.STREAM_FILTER_OF_SHARES.', 'int', '10', '10'),
('MONITOR.STREAM_TIME', 'Valor numérico inteiro que define o tempo de coleta em segundos de publicações em tempo real (stream) das redes sociais virtuais.', 'int', '1200', '1200'),
('MONITOR.SEARCH_TAGS', 'Define as palavras-chave de busca. Uma publicação na rede social virtual somente será coletada pelo AUTOMATA se conter pelo menos uma palavra-chave definida nesta variável.', 'array[string]', 'COVID;covid;Covid;CORONAVIRUS;Coronavirus;coronavirus;CORONAVÍRUS;Coronavírus;coronavírus;COVID-19;Covid-19;covid-19;VACINA;Vacina;vacina;PANDEMIA;pandemia;Pandemia;PFIZER;Pfizer;pfizer;CORONAVAC;coronavac;Coronavac;CoronaVac;JOHNSON;johnson;Johnson;OXFORD;oxford;Oxford;ASTRAZENECA;astrazeneca;Astrazeneca;AstraZeneca;SPUTINIK;sputinik;Sputinik', 'COVID;covid;Covid;CORONAVIRUS;Coronavirus;coronavirus;CORONAVÍRUS;Coronavírus;coronavírus;COVID-19;Covid-19;covid-19;VACINA;Vacina;vacina;PANDEMIA;pandemia;Pandemia;PFIZER;Pfizer;pfizer;CORONAVAC;coronavac;Coronavac;CoronaVac;JOHNSON;johnson;Johnson;OXFORD;oxford;Oxford;ASTRAZENECA;astrazeneca;Astrazeneca;AstraZeneca;SPUTINIK;sputinik;Sputinik'),
('MONITOR.WINDOW_SIZE', 'Valor numérico inteiro que define o tamanho em dias da janela de tempo passada para busca de publicações similares no banco de dados. Publicações coletadas da rede social virtual serão associadas (se possível) à publicações já existentes na base de dados caso o texto das publicações sejam similares. Para o cálculo da similaridade e associação, serão consideradas somente as publicações da base de dados que tem data de publicação igual ou superior à WINDOW_SIZE dias anteriores à data atual.', 'int', '30', '30'),
('INTERVENTOR.WINDOW_SIZE', 'Valor numérico inteiro que define o tamanho em dias da janela de tempo passada para seleção de publicações candidatas à checagem. Serão consideradas somente as publicações da base de dados que tem data de publicação igual ou superior à WINDOW_SIZE dias anteriores à data atual. Este parâmetro compõe o conjunto de parâmetros do algoritmo de seleção de publicações para checagem.', 'int', '7', '7'),
('INTERVENTOR.PROB_CLASSIF_THRESHOLD', 'Valor numérico contínuo entre 0 e 1 que define o grau de certeza atribuído à publicação pelo módulo de detecção que servirá como limiar para seleção de publicações candidatas à checagem. Valores mais próximos de 0 indicam baixa certeza, enquanto valores mais próximos de 1 indicam alta certeza. Serão consideradas somente as publicações com grau de certeza acima de PROB_CLASSIF_THRESHOLD. Este parâmetro compõe o conjunto de parâmetros do algoritmo de seleção de publicações para checagem.', 'float[0-1]', '0.9', '0.9'),
('INTERVENTOR.NUM_NEWS_TO_SELECT', 'Valor numérico inteiro que define o número de publicações que serão enviadas para checagem. Este parâmetro compõe o conjunto de parâmetros do algoritmo de seleção de publicações para checagem.', 'int', '4', '4'),
('INTERVENTOR.CURATOR', 'Se habilitado redireciona as publicações selecionadas para checagem para o módulo de curadoria.', 'bool', 'True', 'True'),
('INTERVENTOR.SOCIAL_MEDIA_ALERT_ACTIVATE', 'Se habilitado dispara um alerta PREMATURO na rede social virtual para cada publicação enviada para checagem, informando que a publicação foi detectada como POSSÍVEL Fake News.', 'bool', 'False', 'False'),
('FCMANAGER.SOCIAL_MEDIA_ALERT_ACTIVATE', 'Se habilitado dispara um alerta na rede social virtual para cada publicação confirmada pela agẽncia de checagem de fatos como sendo Fake News, informando que a notícia foi CONFIRMADA como Fake News.', 'bool', 'False', 'False')
