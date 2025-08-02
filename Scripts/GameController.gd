extends Node

#TREND ESCOLHIDA SORTEADA A CADA ROUND
var chosenTrend : String

var secondaryTrend : String

var thirdTrend : String

var impression : String

var impressionArray : Array[String] = ["positive", "negative"]

var playerChoice : String
var playerImpression : String

var tweetCounter : int = 0
var numberOfFollowers : int = 0
var weekFollowers : int = 0

@onready var tweet = preload("res://Cenas/tweetSkeleton.tscn")
@onready var feedback = preload("res://Cenas/last5Tweets.tscn")


func _ready() -> void:
	changeRound()


#FUNÇÃO QUE CRIA UM NOVO SPREAD DE TWEETS E TRENDS
func changeRound():
	randomize()

	playerChoice = ""
	playerImpression = ""
	var dicAux = infoDictionary.trends_dict.keys().duplicate()
	chosenTrend = dicAux[randi() % dicAux.size()]
	dicAux.remove_at(dicAux.find(chosenTrend))
	secondaryTrend = dicAux[randi() % dicAux.size()]
	dicAux.remove_at(dicAux.find(secondaryTrend))
	thirdTrend = dicAux[randi() % dicAux.size()]
	
	
	print(impression)
	impression = impressionArray[randi_range(0,1)]
	print("TREND: " + chosenTrend +", IMPRESSION "+impression)
	for x in get_node("/root/Main/ScrollContainer/TweetsContainer").get_child_count():
		if(x==0):
			pass
		else:
			get_node("/root/Main/ScrollContainer/TweetsContainer").get_child(x).close()
	generate_tweets(infoDictionary.trends_dict[chosenTrend]["negative"],infoDictionary.trends_dict[chosenTrend]["positive"], chosenTrend)
	generate_tweets(infoDictionary.trends_dict[secondaryTrend]["negative"],infoDictionary.trends_dict[secondaryTrend]["positive"], secondaryTrend)
	generate_tweets(infoDictionary.trends_dict[thirdTrend]["negative"],infoDictionary.trends_dict[thirdTrend]["positive"], thirdTrend, 2)
	shuffle_children(get_node("/root/Main/ScrollContainer/TweetsContainer"))
#FUNÇÃO QUE CRIA UM NOVO SPREAD DE TWEETS E TRENDS



#FUNÇÃO QUE CRIA O TWEET DO JOGADOR
func playerTweet():
	var likesAux : int = generateLikes(playerImpression, playerChoice)
	var user_string = "You The Player"
	var tweetInstance = tweet.instantiate()
	tweetInstance.likes = likesAux + numberOfFollowers
	gainFollowers(tweetInstance.likes)
	tweetInstance.user = user_string
	print(playerChoice)
	print(playerImpression)
	var arrayAux = infoDictionary.trends_dict[playerChoice][playerImpression]

	tweetCounter+=1
	tweetInstance.tweet = arrayAux.pick_random()
	await(get_tree().create_timer(0.1).timeout)

	get_node("/root/Main/ScrollContainer/TweetsContainer/NewPostPanel").add_sibling(tweetInstance)
	if(tweetCounter == 5):
		tweetCounter =0
		var feedbackInstance = feedback.instantiate()
		get_node("/root/Main/ScrollContainer/TweetsContainer/NewPostPanel").add_sibling(feedbackInstance)
#FUNÇÃO QUE CRIA O TWEET DO JOGADOR



#CALCULO DE GANHO DE SEGUIDORES
func gainFollowers(likes : int):
	var multiplier 
	if(playerImpression == impression):
		multiplier = 1
	else:
		multiplier = -1
	weekFollowers += likes/20 *multiplier
	
	numberOfFollowers +=  likes/20 *multiplier
	
	if(numberOfFollowers < 0):
		numberOfFollowers = 0
		weekFollowers = 0
#CALCULO DE GANHO DE SEGUIDORES


#GERA TWEETS
func generate_tweets(negativePost: Array, positivePost: Array, trend: String, number: int = 4):
	var aux_negative = negativePost.duplicate()
	var aux_positive = positivePost.duplicate()
	for x in number:
		var opinion_type = randi_range(0, 1) 
		if opinion_type == 0 and not aux_negative.is_empty():
			var post_text = aux_negative.pick_random()
			aux_negative.erase(post_text) 
			add_tweet(post_text, trend, "negative") 
		elif opinion_type == 1 and not aux_positive.is_empty():
			var post_text = aux_positive.pick_random()
			aux_positive.erase(post_text)
			add_tweet(post_text, trend, "positive") 
		elif not aux_positive.is_empty():
			var post_text = aux_positive.pick_random()
			aux_positive.erase(post_text)
			add_tweet(post_text, trend, "positive")
			
		elif not aux_negative.is_empty():
			var post_text = aux_negative.pick_random()
			aux_negative.erase(post_text)
			add_tweet(post_text, trend, "negative")
#GERA TWEETS


#DA SHUFFLE NA ORDEM DOS TWEETS
func shuffle_children(node : Control) -> void:

	if node.get_child_count() <= 1:
		print("Não há filhos suficientes para embaralhar.")
		return
	var children_to_shuffle: Array[Node] = node.get_children().slice(1)
	children_to_shuffle.shuffle()
	for i in range(children_to_shuffle.size()):
		var child_node = children_to_shuffle[i]
		node.move_child(child_node, i + 1)
#DA SHUFFLE NA ORDEM DOS TWEETS


#FUNÇÃO QUE INSTANCIA OS TWEETS
func add_tweet(tweet_text : String, trend : String , opinion : String, premadeUser : bool = false):
	var likesAux : int = generateLikes(opinion, trend)
	var user_string
	if(premadeUser == false):
		user_string = randomize_user()
	var tweetInstance = tweet.instantiate()
	
	tweetInstance.likes = likesAux
	tweetInstance.user = user_string
	tweetInstance.tweet = tweet_text
	
	tweetCounter
	get_node("/root/Main/ScrollContainer/TweetsContainer").add_child(tweetInstance)
#FUNÇÃO QUE INSTANCIA OS TWEETS

#FUNÇÃO QUE CALCULA OS LIKES
func generateLikes(opinion : String, trend : String) -> int:
	var likes = randi_range(0,10)
	if(trend == chosenTrend):
		likes += randi_range(50, 200)
		if(opinion == impression):
			likes += randi_range(300, 600)
	elif(trend == secondaryTrend):
		likes += randi_range(50, 150)
	return likes
#FUNÇÃO QUE CALCULA OS LIKES

#FUNÇÃO QUE ALEATORIZA O USUÁRIO
func randomize_user():
	var adjectives: Array = infoDictionary.WORD_LIST.adjectives
	var nouns: Array = infoDictionary.WORD_LIST.nouns
	var verbs: Array = infoDictionary.WORD_LIST.verbs_ing
	var places: Array = infoDictionary.WORD_LIST.places
	
	var pattern: int = randi() % 3
	var base_name: String
	
	match pattern:
		0: # Padrão: Adjetivo + Substantivo
			var adj: String = adjectives.pick_random()
			var noun: String = nouns.pick_random()
			base_name = adj+" "+ noun
		1: # Padrão: Verbo + Substantivo
			var verb: String = verbs.pick_random()
			var noun: String = nouns.pick_random()
			base_name = verb+" "+noun
		2: # Padrão: The + Substantivo + of The + Lugar
			var noun: String = nouns.pick_random()
			var place: String = places.pick_random()
			base_name = "The "+ noun+ " of The "+ place
			
	return base_name
#FUNÇÃO QUE ALEATORIZA O USUÁRIO


#FUNÇÕES DE CONVERSÃO DE STRING

func to_handle(base_name: String) -> String:
	return base_name.replace(" ", "")

# Retorna o nome com espaços (pode parecer redundante, mas mantém a API consistente)
func to_spaced_name(base_name: String) -> String:
	return base_name

# Converte "Nome Base" para "@nome_base"
func to_twitter_handle(base_name: String) -> String:
	return "@" + base_name.to_lower().replace(" ", "_")

#FUNÇÕES DE CONVERSÃO DE STRING
