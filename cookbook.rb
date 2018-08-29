class Cookbook
  INSERIR_RECEITA    = 1
  VIZUALIZAR_RECEITA = 2
  PESQUISAR_RECEITA  = 3
  EXCLUIR_RECEITA    = 4
  SAIR               = 5

  def initialize
    clear
    welcome
    puts
  end

  def start
    opcao = menu

    receitas = Receita.tipos_de_receita.each_with_object({}) do |k, h|
      h[k] = []
    end

    while opcao != SAIR
      if opcao == INSERIR_RECEITA
        receita = insert_recipe
        receitas[receita.tipo_da_receita] << receita
        wait_keypress
        clear
      elsif opcao == VIZUALIZAR_RECEITA
        print_hash_with_index(receitas)
        puts 'Nenhuma receita cadastrada' if receitas.values.flatten.empty?
        wait_keypress
        clear
      elsif opcao == PESQUISAR_RECEITA
        puts search_recipe(receitas)
        wait_keypress
        clear
      elsif opcao == EXCLUIR_RECEITA
        remove_recipe(receitas)
        wait_keypress
        clear
      else
        puts 'Opção inválida'
        wait_keypress
        clear
      end

      opcao = menu
    end

    puts
    puts 'Obrigado por usar o Cookbook'
  end

  private

  def welcome
    puts 'Bem-vindo ao My Cookbook, sua rede social de receitas culinárias!'
  end

  def clear
    system('clear')
    puts
  end

  def menu
    puts "[#{INSERIR_RECEITA}] Cadastrar uma receita"
    puts "[#{VIZUALIZAR_RECEITA}] Ver todas as receitas"
    puts "[#{PESQUISAR_RECEITA}] Pesquisar uma receita"
    puts "[#{EXCLUIR_RECEITA}] Excluir uma receita"
    puts "[#{SAIR}] Sair"

    print 'Escolha uma opção: '
    gets.to_i
  end

  def wait_keypress
    puts
    puts 'Pressione alguma tecla para continuar'
    gets
  end

  def read_input
    gets.chomp
  end

  def insert_recipe
    print 'Digite o nome da sua receita: '
    nome = read_input
    print 'Digite o modo de preparo: '
    modo_de_preparo = read_input
    print_with_index(Receita.tipos_de_receita)
    print 'Digite o número do tipo da receita: '
    tipo_da_receita = read_input.to_i
    puts
    puts "Receita #{nome} cadastrada com sucesso!"
    Receita.new(nome, modo_de_preparo, tipo_da_receita)
  end

  def search_recipe(hash)
    puts
    tipos_receita = Receita.tipos_de_receita + ['Todos']
    print_with_index(tipos_receita)
    print 'Você gostaria de procurar uma receita de qual tipo? '
    tipo = read_input.to_i
    print 'Por qual termo você gostaria de pesquisar? '
    termo = read_input
    if tipo == tipos_receita.length
      hash = hash.values.flatten
    else
      hash = hash[Receita.tipo_de_receita(tipo - 1)]
    end
    receitas_encontradas = Receita.search(termo, hash)
    return 'Nenhuma receita foi encontrada' if receitas_encontradas.empty?
    puts 'Receitas encontradas: '
    receitas_encontradas
  end

  def remove_recipe(hash)
    puts
    puts 'Tipos de receita:'
    print_with_index(Receita.tipos_de_receita)
    puts
    print 'Você deseja apagar uma receita de que tipo? '
    tipo = read_input.to_i - 1
    if hash[Receita.tipo_de_receita(tipo)].empty?
      return puts 'Não há receitas deste tipo para apagar'
    end
    print_with_index(hash[Receita.tipo_de_receita(tipo)])
    print 'Qual receita você deseja apagar? '
    index = read_input.to_i
    hash[Receita.tipo_de_receita(tipo)].delete_at(index - 1)
    puts 'Receita apagada com sucesso!'
  end

  def print_with_index(array)
    array.each_with_index do |value, index|
      puts "##{index + 1} - #{value.to_s}"
    end
  end

  def print_hash_with_index(hash)
    hash.each_value do |values|
      print_with_index(values)
    end
  end

  def print_hash_keys_with_index(hash, key)
    print_with_index(hash[key])
  end
end
