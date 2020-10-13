require 'csv'
require_relative 'scrapper.rb'

def display_list(gifts_list)
  # 1. iphone (800€) - [ ]
  # Iterer sur la gifts_list
  puts "_"*12
  puts " Gift List"
  gifts_list.each_with_index do |gift, index|

    # already_bought = ""
    # if gift[:bought] == true
    #   already_bought = "[X]"
    # else
    #   already_bought = "[ ]"
    # end

    # if gift[:bought]
    #   already_bought = "[X]"
    # else
    #   already_bought = "[ ]"
    # end

    already_bought = gift[:bought] ? "[X]" : "[ ]"
    puts "#{index + 1} - #{gift[:name]} (#{gift[:price]}€) - #{already_bought}"
  end
  puts "_"*12
  # Pour chaque itération (C'est un hash), je construis une string avec les éléments qui nous intéressent

end

def add_gift(gifts_list)
  # Demander à l'utilisateut le nom du cadeau et le stocker dans une variable
  puts "What is the name of the gift you want to add ?"
  name = gets.chomp
  # Demander à l'utilisateut le prix du cadeau et le stocker dans une variable
  puts "What is the price of the gift you want to add ?"
  price = gets.chomp.to_i

  # Créer le hash / le gift avec ces éléments
  gift = {
    name: name,
    price: price,
    bought: false
  }

  # Ajouter un cadeau à la gift_list
  gifts_list << gift
  save_csv(gifts_list)
end

def delete_gift(gifts_list)
  # Afficher la liste
  display_list(gifts_list)
  # Demander à l'utilisateur quel cadeau il veut supprimer
  puts "What is the gift id you want to delete ?"
  index = gets.chomp.to_i - 1
  # Récupérer l'index du cadeau à supprimer - attention au -1
  gifts_list.delete_at(index)
  # Supprimer sur l'array/gifts_list.delete_at(index)
  save_csv(gifts_list)
end


def mark_as_bought(gifts_list)
  # Afficher la liste
  display_list(gifts_list)
  # Demander à l'utilisateur quel cadeau il veut marquer comme acheté
  puts "What is the gift id you want to mark as bought ?"
  # Récupérer l'index du cadeau à marquer comme acheté - attention au
  index = gets.chomp.to_i - 1
  # Retrouver le gift dans la gift_list
  gift = gifts_list[index]
  gift[:bought] = true
  # gifts_list[index][:bought] = true
  # Mettre à jour le gift/Hash , mettre à jour la valeur de sa clé [:bought]
  save_csv(gifts_list)
end


def import(gifts_list)
  # Demander à l'utilisateur le mot clé recherché
  puts "What are you looking for ?"
  keyword = gets.chomp
  # Scrapper Etsy pour avoir une liste d'idées
  ideas = scrap(keyword)
  # Afficher les idées ( display_list(array of hash) )
  display_list(ideas)
  # Demander à l'utilisateur quelle idée il choisit
  puts "What is the number of the idea you want to add ?"
  index = gets.chomp.to_i - 1
  idea = ideas[index ]
  # Ajouter l'idée dans ma gifts_list
  gifts_list << idea
  save_csv(gifts_list)
end


def load_csv
  csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
  filepath    = 'gifts.csv'
  gifts = []

  CSV.foreach(filepath, csv_options) do |row|
    # TODO: build new gift from information stored in each row
    gift = {
      name: row[0],
      price: row[1].to_i,
      bought: row[2] == "true"
    }
    gifts << gift
  end
  return gifts
  # => Array of hash
end

def save_csv(gifts_list)
  csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
  filepath    = 'gifts.csv'

  CSV.open(filepath, 'wb', csv_options) do |csv|
    # We had headers to the CSV
    csv << ['name', 'price', 'bought']
    #TODO: store each gift
    gifts_list.each do |gift|
      csv << [gift[:name], gift[:price], gift[:bought]]
    end
  end
end

