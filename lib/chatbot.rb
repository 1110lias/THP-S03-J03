require 'http'
require 'json'
require 'dotenv'

# Chargez les variables d'environnement à partir du fichier .env
Dotenv.load('.env')

# Configurez la clé API OpenAI
api_key = ENV["OPENAI_API_KEY"]
url = "https://api.openai.com/v1/completions"
headers = {
  "Content-Type" => "application/json",
  "Authorization" => "Bearer #{api_key}"
}

# Définir une phrase de sortie pour terminer la conversation
exit_phrase = "exit"

# Définir une phrase d'accueil
puts "Bienvenue ! Posez-moi des questions sur les recettes de cuisine ou discutons de tout ce qui vous intéresse. Pour quitter, tapez 'exit'."

# Historique de la conversation
conversation_history = []

# Boucle pour la conversation
while true
  # Demandez à l'utilisateur de saisir sa question ou sa réponse
  print "Vous: "
  user_input = gets.chomp

  # Ajouter l'entrée de l'utilisateur à l'historique de la conversation
  conversation_history << "#{user_input}"

  # Vérifiez si l'utilisateur souhaite quitter
  break if user_input.downcase == exit_phrase.downcase

  # Définir les données à envoyer à l'API OpenAI
  data = {
    "prompt" => conversation_history.join("\n"),
    "max_tokens" => 200,
    "temperature" => 0.8,
    "model" => "gpt-3.5-turbo-instruct"
  }

  # Envoyer la requête à l'API OpenAI
  response = HTTP.post(url, headers: headers, body: data.to_json)
  response_body = JSON.parse(response.body.to_s)
  response_string = response_body['choices'][0]['text'].strip

  # Afficher la réponse de l'IA
  puts "Bot: #{response_string}"

  # Ajouter la réponse du bot à l'historique de la conversation
  conversation_history << "#{response_string}"
end

puts "Au revoir !"
