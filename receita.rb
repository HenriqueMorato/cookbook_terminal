require 'forwardable'

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

  def to_h
    { "#{self.tipo_da_receita}" => [self] }
  end

  def save
    hash = Receita.all.merge(self.to_h) do |key, old_val, new_val|
      old_val + new_val
    end
    Receita.repository.save_all(hash)
  end

  class << self
    extend Forwardable
    def_delegators :repository, :all, :empty?

    def tipos_de_receita
      @@TIPOS_DE_RECEITA
    end

    def tipo_de_receita(index)
      @@TIPOS_DE_RECEITA[index]
    end

    def receitas_de_tipo(index)
      all[tipo_de_receita(index)] || []
    end

    def search(termo, tipo_da_busca)
      array = all[tipo_de_receita(tipo_da_busca)] || all.values.flatten
      array.select do |receita|
        receita.include?(termo)
      end
    end

    def remove(tipo, index)
      hash = all.tap do |h|
        h[Receita.tipo_de_receita(tipo)].delete_at(index)
      end
      repository.save_all(hash)
    end

    def repository
      @repository ||= FileSaver.new(recipe_type_hash)
    end

    def recipe_type_hash
      hash = Receita.tipos_de_receita.each_with_object({}) do |k, h|
        h[k] = []
      end
      hash
    end
  end
end
