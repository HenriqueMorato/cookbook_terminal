class Receita
  attr_reader :nome, :modo_de_preparo, :tipo_da_receita

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

  def self.search(termo, receitas)
    receitas.select { |receita| receita.include?(termo) }
  end
end
