#coding:utf-8

require 'unicode'

class ReferenciaBibliografica < String
  def initialize(documento)
    gerar(documento)
  end

  def _monta_nome(autores)
    lista_autores = autores.split(';')
    lista_autores.each_index do |i|
      nome_autor = lista_autores[i].split(' ')
      nome_autor.delete('') if nome_autor.include? ('')
      nome_abnt = Unicode.upcase nome_autor.pop + ','
      nome_autor.each_index do |j|
        nome_abnt += ' ' + nome_autor[j][0] + '.'
      end
      lista_autores[i] = nome_abnt
    end
    lista_autores * "; "
  end

  def _referencia_trabalho_conclusao(trabalho_conclusao)
    autores = _monta_nome(trabalho_conclusao.autores)
    titulo =  trabalho_conclusao.titulo
    subtitulo = _gerar_subtitulo(trabalho_conclusao)
    defesa = trabalho_conclusao.data_defesa
    folhas = trabalho_conclusao.total_folhas
    tipo = trabalho_conclusao.tipo_trabalho
    instituicao = trabalho_conclusao.instituicao
    local = trabalho_conclusao.local_defesa
     "#{autores} #{titulo}#{subtitulo}. #{defesa}. "\
     "#{folhas} f. #{tipo} - #{instituicao}, #{local}."
  end

  def _referencia_artigo_anais_evento(artigo_anais_evento)
    autores = _monta_nome(artigo_anais_evento.autores)
    titulo = artigo_anais_evento.titulo
    subtitulo = _gerar_subtitulo(artigo_anais_evento)
    nome_evento = artigo_anais_evento.nome_evento
    numero_evento = artigo_anais_evento.numero_evento
    ano_evento = artigo_anais_evento.ano_evento
    local_evento = artigo_anais_evento.local_evento
    titulo_anais = artigo_anais_evento.titulo_anais
    local_publicacao = artigo_anais_evento.local_publicacao
    editora = artigo_anais_evento.editora
    ano_publicacao = artigo_anais_evento.ano_publicacao
    pagina_inicial = artigo_anais_evento.pagina_inicial
    pagina_final = artigo_anais_evento.pagina_final
    "#{autores} #{titulo}.#{subtitulo} In: #{nome_evento}, " \
    "#{numero_evento}., #{ano_evento}, #{local_evento}. " \
    "#{titulo_anais}. #{local_publicacao}: #{editora}, " \
    "#{ano_publicacao}. P. #{pagina_inicial}-#{pagina_final}."
  end

  def _referencia_artigo_periodico(artigo_periodico)
    autores = _monta_nome(artigo_periodico.autores)
    titulo = artigo_periodico.titulo
    subtitulo = _gerar_subtitulo(artigo_periodico)
    nome = artigo_periodico.nome_periodico
    local = artigo_periodico.local_publicacao
    volume = artigo_periodico.volume
    fasciculo = artigo_periodico.fasciculo
    pagina_inicial = artigo_periodico.pagina_inicial
    pagina_final = artigo_periodico.pagina_final
    data = artigo_periodico.data_publicacao
    "#{autores} #{titulo}#{subtitulo}. #{nome}, #{local}, " \
    "v. #{volume}, n. #{fasciculo}, " \
    "p. #{pagina_inicial}-#{pagina_final}, #{data}."
  end

  def _referencia_periodico_tecnico_cientifico(periodico_tecnico_cientifico)
    titulo = periodico_tecnico_cientifico.titulo
    local= periodico_tecnico_cientifico.local_publicacao
    editora = periodico_tecnico_cientifico.editora
    ano_primeiro = periodico_tecnico_cientifico.ano_primeiro_volume
    ano_ultimo = periodico_tecnico_cientifico.ano_ultimo_volume
    "#{titulo}. #{local}: #{editora}, " \
    "#{ano_primeiro}-#{ano_ultimo}"
  end

  def _referencia_livro(livro)
    autores = _monta_nome(livro.autores)
    titulo = livro.titulo
    subtitulo = _gerar_subtitulo(livro)
    traducao = _gerar_opcional(livro.traducao)
    edicao = _gerar_opcional(livro.edicao)
    publicacao = livro.local_publicacao
    editora = livro.editora
    ano = livro.ano_publicacao
    paginas = livro.numero_paginas
    "#{autores} #{titulo}: #{subtitulo}. #{traducao}#{edicao}" \
    "#{publicacao}: #{editora}, #{ano}. #{paginas} p."
  end

  def _referencia_relatorio_tecnico_cientifico(relatorio_tecnico_cientifico)
    autores = _monta_nome(relatorio_tecnico_cientifico.autores)
    titulo = relatorio_tecnico_cientifico.titulo
    local = relatorio_tecnico_cientifico.local_publicacao
    instituicao = relatorio_tecnico_cientifico.instituicao
    ano = relatorio_tecnico_cientifico.ano_publicacao
    paginas = relatorio_tecnico_cientifico.numero_paginas
    "#{autores} #{titulo}. #{local}: #{instituicao}, #{ano}. " \
    "#{paginas} p."
  end

  def _referencia_imagem(imagem)
    autores = _monta_nome(imagem.autores)
    titulo = imagem.titulo
    instituicao = imagem.instituicao
    local = imagem.local
    "#{autores} #{titulo}. #{instituicao}, #{local}."
  end

  def _referencia_objetos_de_aprendizagem(objetos_de_aprendizagem)
    autores = _monta_nome(objetos_de_aprendizagem.autores)
    titulo = objetos_de_aprendizagem.titulo
    instituicao = objetos_de_aprendizagem.instituicao
    "#{autores} #{titulo}. #{instituicao}."
  end

  def _referencia_outros_conteudos(outros_conteudos)
    autores = _monta_nome(outros_conteudos.autores)
    titulo = outros_conteudos.titulo
    instituicao = outros_conteudos.instituicao
    "#{autores} #{titulo}. #{instituicao}."
  end

  def _gerar_subtitulo(documento)
    _gerar_opcional(documento.subtitulo)
  end

  def _gerar_opcional(text)
    text || ''
  end

  private

  def gerar(documento)
    conversores = {
      'trabalho de conclusão'        => :_referencia_trabalho_conclusao,
      'artigo de anais de eventos'   => :_referencia_artigo_anais_evento,
      'artigo de periodico'          => :_referencia_artigo_periodico,
      'periodico tecnico cientifico' => :_referencia_periodico_tecnico_cientifico,
      'livro'                        => :_referencia_livro,
      'relatorio tecnico cientifico' => :_referencia_relatorio_tecnico_cientifico,
      'imagem'                       => :_referencia_imagem,
      'objetos de aprendizagem'      => :_referencia_objetos_de_aprendizagem,
      'outros conteúdos'             => :_referencia_outros_conteudos }
    replace(public_method(conversores[documento.tipo]).call documento)
  end
end
