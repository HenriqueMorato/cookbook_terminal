require_relative 'receita'
def welcome
  puts 'Bem-vindo ao My Cookbook, sua rede social de receitas culinárias!'
end

def clear
  system('clear')
  puts
end

def menu
  puts '[1] Cadastrar uma receita'
  puts '[2] Ver todas as receitas'
  puts '[3] Sair'

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

welcome
opcao = menu

receitas = []

while opcao != 3
  if opcao == 1
    receitas << insert_recipe
    wait_keypress
    clear
  elsif opcao == 2
    receitas.each_with_index do |receita, index|
      puts "##{index + 1} - #{receita.to_s}"
    end
    puts 'Nenhuma receita cadastrada' if receitas.empty?
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

