# ligne très importante qui appelle les gems.
require 'http'
require 'json'
require 'dotenv' # <================================================================================== NE PAS OUBLIER

# n'oublie pas les lignes pour Dotenv ici…
Dotenv.load('.env') # <============================================================================ NE PAS OUBLIER
# POUR APPELER LE .env, attention à la position pwd du terminal 

# création de la clé d'api et indication de l'url utilisée.
api_key = ENV["OPENAI_API_KEY"]
url = "https://api.openai.com/v1/completions"

# un peu de json pour faire la demande d'autorisation d'utilisation à l'api OpenAI
headers = {
  "Content-Type" => "application/json",
  "Authorization" => "Bearer #{api_key}"
}

# un peu de json pour envoyer des informations directement à l'API
data = {
  "prompt" => "les 5 étapes composées de 10 mots maximum, d'une recette de cuisine en français. La recette doit être finie en 5 etapes.",
  "max_tokens" => 200,
  # "n" => 10,
  # "stop" => ["-"],
  "temperature" => 0.8,
  "model" => "gpt-3.5-turbo-instruct"
}


# une partie un peu plus complexe :
# - cela permet d'envoyer les informations en json à ton url
# - puis de récupéré la réponse puis de séléctionner spécifiquement le texte rendu
response = HTTP.post(url, headers: headers, body: data.to_json)
response_body = JSON.parse(response.body.to_s)
response_string = response_body['choices'][0]['text'].strip

# ligne qui permet d'envoyer l'information sur ton terminal
puts "Voici 1 recette de cuisine aléatoires:"
puts response_string