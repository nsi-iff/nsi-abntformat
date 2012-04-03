#coding: utf-8
require_relative "spec_helper"

describe ReferenciaBibliografica do
  class Documento
    include ReferenciaBibliografica
  end

  subject { Documento.new }

  xit "converte nome completo em citação" do
    referencia = ReferenciaBibliografica.new
    referencia._monta_nome('Ruhan Ferreira Almeida; Carlos Souza Teste').should \
      == ("ALMEIDA, R. F.; TESTE, C. S.")
  end

  it "trabalho de conclusão" do
    subject.stub('tipo') { 'trabalho de conclusão' }
    subject.stub('autores') { 'Ian Fantucci' }
    subject.stub('titulo') { 'Contribuição do alerta, da atenção, '\
    'da intenção e da expectativa temporal para o desempenho de '\
    'humanos em tarefas de tempo de reação' }
    subject.stub('subtitulo') { nil }
    subject.stub('data_defesa') { '2001' }
    subject.stub('total_folhas') { '130' }
    subject.stub('tipo_trabalho') { 'Tese (Doutorado em Psicologia)' }
    subject.stub('instituicao') { 'Instituto de Psicologia, '\
    'Universidade de São Paulo' }
    subject.stub!('local_defesa') { 'São Paulo' }

    subject.referencia_abnt.should == (
      'FANTUCCI, I. Contribuição do alerta, da atenção, da intenção e da'\
      ' expectativa temporal para o desempenho de humanos em tarefas de '\
      'tempo de reação. 2001. 130 f. Tese (Doutorado em Psicologia) - '\
      'Instituto de Psicologia, Universidade de São Paulo, São Paulo.')
  end

  it "gerando referencia para artigos de anais de eventos" do
    subject.stub('tipo') { 'artigo de anais de eventos' }
    subject.stub('autores') { 'Antônio Fernandes Bueno Moreira' }
    subject.stub('titulo') { 'Multiculturalismo, Currículo e '\
                             'Formação de Professores' }
    subject.stub('subtitulo') { nil }
    subject.stub('nome_evento') { 'SEMINÁRIO DE EDUCAÇÃO BÁSICA' }
    subject.stub('numero_evento') { '2' }
    subject.stub('ano_evento') { '1998' }
    subject.stub('local_evento') { 'Santa Cruz do Sul' }
    subject.stub('titulo_anais') { 'Anais' }
    subject.stub('local_publicacao') { 'Santa Cruz do Sul' }
    subject.stub('editora') { 'EDUNISC' }
    subject.stub('ano_publicacao') { '1998' }
    subject.stub('pagina_inicial') { '15' }
    subject.stub('pagina_final') { '30' }

    subject.referencia_abnt.should == (
      'MOREIRA, A. F. B. Multiculturalismo, Currículo e Formação de '\
      'Professores. In: SEMINÁRIO DE EDUCAÇÃO BÁSICA, 2., 1998, Santa '\
      'Cruz do Sul. Anais. Santa Cruz do Sul: EDUNISC, 1998. P. 15-30.')
  end

  xit "gerando referencia de artigo de periodico" do
    artigo_periodico = mock(:artigo_periodico)
    artigo_periodico.stub('tipo') { 'artigo de periodico' }
    artigo_periodico.stub('autores') { 'Demerval Saviani' }
    artigo_periodico.stub('titulo') { 'A Universidade e a Problemática da Educação e Cultura' }
    artigo_periodico.stub('subtitulo') { nil }
    artigo_periodico.stub('nome_periodico') { 'Educação Brasileira' }
    artigo_periodico.stub('local_publicacao') { 'Brasília' }
    artigo_periodico.stub('volume') { '1' }
    artigo_periodico.stub('fasciculo') { '3' }
    artigo_periodico.stub('pagina_inicial')  { '35' }
    artigo_periodico.stub('pagina_final') { '58' }
    artigo_periodico.stub('data_publicacao') { '1979' }

    referencia_artigo_periodico = ReferenciaBibliografica.new(artigo_periodico)
    referencia_artigo_periodico.should == (
      "SAVIANI, D. A Universidade e a Problemática da Educação e Cultura."\
      " Educação Brasileira, Brasília, v. 1, n. 3, p. 35-58, 1979.")
  end

  xit "gerando referencia de periodico tecnico cientifico" do
    periodico_tecnico_cientifico = mock(:periodico_tecnico_cientifico)
    periodico_tecnico_cientifico.stub('tipo') { 'periodico tecnico cientifico' }
    periodico_tecnico_cientifico.stub('titulo') { 'EDUCAÇÃO & REALIDADE' }
    periodico_tecnico_cientifico.stub('local_publicacao') { 'Porto Alegre' }
    periodico_tecnico_cientifico.stub('editora') { 'UFRGS/FACED' }
    periodico_tecnico_cientifico.stub('ano_primeiro_volume') { '1975' }
    periodico_tecnico_cientifico.stub('ano_ultimo_volume') { nil }

    referencia_tecnico_cientifico = ReferenciaBibliografica.new(periodico_tecnico_cientifico)
    referencia_tecnico_cientifico.should == (
      'EDUCAÇÃO & REALIDADE. Porto Alegre:'\
      ' UFRGS/FACED, 1975-')
  end

  xit "gerando referencia de livro" do
    livro = mock(:livro)
    livro.stub('tipo') { 'livro' }
    livro.stub('autores') { 'Marcos Antônio Azevedo; '\
    'Vinícios Nogueira Almeida Guerra' }
    livro.stub('titulo') { 'Mania de bater' }
    livro.stub('subtitulo') { 'a punição corporal doméstica de crianças '\
    'e adolescentes no Brasil' }
    livro.stub('traducao') { nil }
    livro.stub('edicao') { nil }
    livro.stub('local_publicacao') { 'São Paulo' }
    livro.stub('editora') { 'Iglu' }
    livro.stub('ano_publicacao') { '2001' }
    livro.stub('numero_paginas') { '386' }

    referencia_livro = ReferenciaBibliografica.new(livro)
    referencia_livro.should == (
      'AZEVEDO, M. A.; GUERRA, V. N. A. '\
      'Mania de bater: a punição corporal doméstica de crianças e '\
      'adolescentes no Brasil. São Paulo: Iglu, 2001. 386 p.')
  end

  xit "gerando referencia de relatorio tecnico cientifico" do
    relatorio_tecnico_cientifico = mock(:relatorio_tecnico_cientifico)
    relatorio_tecnico_cientifico.stub('tipo') { 'relatorio tecnico cientifico' }
    relatorio_tecnico_cientifico.stub('autores') { 'Ubiraci Espinelli Souza; '\
                                                   'Silvio Burratino Melhado' }
    relatorio_tecnico_cientifico.stub('titulo') { 'Subsídios para a avaliação'\
                                                  ' do custo de mão-de-obra na'\
                                                  ' construção civil' }
    relatorio_tecnico_cientifico.stub('local_publicacao') { 'São Paulo' }
    relatorio_tecnico_cientifico.stub('instituicao') { 'EPUSP' }
    relatorio_tecnico_cientifico.stub('ano_publicacao') { '1991' }
    relatorio_tecnico_cientifico.stub('numero_paginas') { '38' }

    referencia_relatorio_cientifico = ReferenciaBibliografica.new(relatorio_tecnico_cientifico)
    referencia_relatorio_cientifico.should == (
      'SOUZA, U. E.; MELHADO, S. B. Subsídios para a avaliação do '\
      'custo de mão-de-obra na construção civil. São Paulo: EPUSP, 1991. '\
      '38 p.')
  end

  xit "gerando referencia de imagem" do
    imagem = mock(:imagem)

    imagem.stub('tipo') { 'imagem' }
    imagem.stub('autores') { 'Alberto Gomes Pereira; Ricardo Silva' }
    imagem.stub('titulo') { 'As crianças da indonésia' }
    imagem.stub('instituicao') { 'Instituto Federal Fluminense' }
    imagem.stub('local') { 'Campos dos Goytacazes' }

    referencia_imagem = ReferenciaBibliografica.new(imagem)
    referencia_imagem.should == ('PEREIRA, A. G.; SILVA, R. As '\
                                  'crianças da indonésia. Instituto Federal '\
                                  'Fluminense, Campos dos Goytacazes.')
  end

  xit "gerando referencia de objetos de aprendizagem" do
    objetos_de_aprendizagem = mock(:objetos_de_aprendizagem)
    objetos_de_aprendizagem.stub('tipo') { 'objetos de aprendizagem' }
    objetos_de_aprendizagem.stub('autores') { 'Ariosvaldo Gomes' }
    objetos_de_aprendizagem.stub('titulo') { 'Viver é aprender' }
    objetos_de_aprendizagem.stub('instituicao') { 'Instituto Federal Fluminense' }

    referencia_aprendizagem = ReferenciaBibliografica.new(objetos_de_aprendizagem)
    referencia_aprendizagem.should == ('GOMES, A. Viver é aprender. '\
                                       'Instituto Federal Fluminense.')
  end

  it "gerando referencia de outros conteudos" do
    subject.stub('tipo') { 'outros conteúdos' }
    subject.stub('autores') { 'Adalberto Pereira Silva' }
    subject.stub('titulo') { 'Tenho joanetes' }
    subject.stub('instituicao') { 'Instituto Federal Fluminense' }

    subject.referencia_abnt.should eql ('SILVA, A. P. Tenho joanetes. '\
                                  'Instituto Federal Fluminense.')
  end
end