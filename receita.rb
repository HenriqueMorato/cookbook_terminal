class Receita
  attr_reader :nome, :modo_de_preparo
  @@TIPOS_DE_RECEITA = ['Entrada', 'Prato principal', 'Sobremesa'].freeze

  def initialize(nome, modo_de_preparo, tipo_da_receita)
    @nome = nome
    @modo_de_preparo = modo_de_preparo
    @tipo_da_receita = tipo_da_receita
  end

  def to_s
    <<~MENSAGEM
      #{nome} - #{tipo_da_receita}
        #{modo_de_preparo}
    MENSAGEM
  end

  def include?(other)
    nome.downcase.include?(other)
  end

  def tipo_da_receita
    @@TIPOS_DE_RECEITA[@tipo_da_receita - 1]
  end

  class << self
    def tipos_de_receita
      @@TIPOS_DE_RECEITA
    end

    def tipo_de_receita(index)
      @@TIPOS_DE_RECEITA[index]
    end

    def search(termo, receitas)
      receitas.select { |receita| receita.include?(termo) }
    end
  end
end
