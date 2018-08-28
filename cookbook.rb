require_relative 'receita'

INSERIR_RECEITA    = 1
VIZUALIZAR_RECEITA = 2
PESQUISAR_RECEITA  = 3
EXCLUIR_RECEITA    = 4
SAIR               = 5

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
  print 'Digite o tipo da receita: '
  tipo_da_receita = read_input
  puts
  puts "Receita #{nome} cadastrada com sucesso!"
  Receita.new(nome, modo_de_preparo, tipo_da_receita)
end

def search_recipe(receitas)
  print 'Por qual termo você gostaria de pesquisar? '
  termo = gets.chomp
  receitas_encontradas = Receita.search(termo, receitas)
  puts 'Receitas encontradas: ' unless receitas_encontradas.empty?
  receitas_encontradas
end

def remove_recipe(receitas)
  print_with_index(receitas)
  print 'Qual o número da tarefa que deseja apagar? '
  index = gets.to_i
  receitas.delete_at(index - 1)
  puts 'Receita apagada com sucesso!'
end

def print_with_index(receitas)
  receitas.each_with_index do |receita, index|
    puts "##{index + 1} - #{receita.to_s}"
  end
end

welcome
opcao = menu

receitas = []

while opcao != SAIR
  if opcao == INSERIR_RECEITA
    receitas << insert_recipe
    wait_keypress
    clear
  elsif opcao == VIZUALIZAR_RECEITA
    print_with_index(receitas)
    puts 'Nenhuma receita cadastrada' if receitas.empty?
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

puts 'Obrigado por usar o Cookbook'

