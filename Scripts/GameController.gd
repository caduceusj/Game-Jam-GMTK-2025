extends Node

#TREND ESCOLHIDA SORTEADA A CADA ROUND
var chosenTrend : String

var secondaryTrend : String

var thirdTrend : String

var impression : String

var impressionArray : Array[String] = ["positive", "negative"]

var playerChoice : String
var playerImpression : String

@onready var tweet = preload("res://Cenas/tweetSkeleton.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	changeRound()
	pass # Replace with function body.

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
	
	impression = impressionArray[randi_range(0,1)]
	for x in get_node("/root/Main/ScrollContainer/TweetsContainer").get_child_count():
		if(x==0):
			pass
		else:
			get_node("/root/Main/ScrollContainer/TweetsContainer").get_child(x).close()
	generate_tweets(infoDictionary.trends_dict[chosenTrend]["negative"],infoDictionary.trends_dict[chosenTrend]["positive"], chosenTrend)
	generate_tweets(infoDictionary.trends_dict[secondaryTrend]["negative"],infoDictionary.trends_dict[secondaryTrend]["positive"], secondaryTrend)
	generate_tweets(infoDictionary.trends_dict[thirdTrend]["negative"],infoDictionary.trends_dict[thirdTrend]["positive"], thirdTrend, 2)
	
	shuffle_children(get_node("/root/Main/ScrollContainer/TweetsContainer"))

func playerTweet():	
	var likesAux : int = generateLikes(playerImpression, playerChoice)
	var user_string = "You The Player"
	var tweetInstance = tweet.instantiate()
	tweetInstance.likes = likesAux
	tweetInstance.user = user_string
	print(playerChoice)
	print(playerImpression)
	var arrayAux = infoDictionary.trends_dict[playerChoice][playerImpression]
	print(arrayAux)
	tweetInstance.tweet = arrayAux.pick_random()
	await(get_tree().create_timer(0.1).timeout)
	get_node("/root/Main/ScrollContainer/TweetsContainer/NewPostPanel").add_sibling(tweetInstance)	

func generate_tweets(negativePost : Array, positivePost : Array, trend : String, number : int = 4):
	var auxArray : Array[Array] = [negativePost.duplicate(), positivePost.duplicate()]

	for x in 4:
		if(auxArray[0].size() == 0):
			var postAux = auxArray[1].pick_random()
			auxArray[1].remove_at(auxArray[1].find(postAux))
			add_tweet(postAux, trend, impressionArray[1])
		elif(auxArray[1].size() == 0):
			var postAux = auxArray[0].pick_random()
			auxArray[0].remove_at(auxArray[0].find(postAux))
			add_tweet(postAux, trend, impressionArray[0])
		else:
			var aux = randi_range(0,1)
			var postAux = auxArray[aux].pick_random()
			auxArray[aux].remove_at(auxArray[aux].find(postAux))
			add_tweet(postAux, trend, impressionArray[aux])
	
func shuffle_children(node : Control) -> void:

	if node.get_child_count() <= 1:
		print("Não há filhos suficientes para embaralhar.")
		return
	var children_to_shuffle: Array[Node] = node.get_children().slice(1)
	children_to_shuffle.shuffle()
	for i in range(children_to_shuffle.size()):
		var child_node = children_to_shuffle[i]
		node.move_child(child_node, i + 1)
	
func add_tweet(tweet_text : String, trend : String , opinion : String, premadeUser : bool = false):
	var likesAux : int = generateLikes(opinion, trend)
	var user_string
	if(premadeUser == false):
		user_string = randomize_user()
	var tweetInstance = tweet.instantiate()
	tweetInstance.likes = likesAux
	tweetInstance.user = user_string
	tweetInstance.tweet = tweet_text
	get_node("/root/Main/ScrollContainer/TweetsContainer").add_child(tweetInstance)

func generateLikes(opinion : String, trend : String) -> int:
	var likes = randi_range(0,10)
	if(trend == chosenTrend):
		likes += randi_range(50, 200)
		if(opinion == impression):
			likes += randi_range(300, 600)
	elif(trend == secondaryTrend):
		likes += randi_range(50, 100)
	return likes


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


func to_handle(base_name: String) -> String:
	return base_name.replace(" ", "")

# Retorna o nome com espaços (pode parecer redundante, mas mantém a API consistente)
func to_spaced_name(base_name: String) -> String:
	return base_name

# Converte "Nome Base" para "@nome_base"
func to_twitter_handle(base_name: String) -> String:
	return "@" + base_name.to_lower().replace(" ", "_")

func _input(event: InputEvent) -> void:	
	if event.is_action_pressed("mouse_left_click"):
		SoundsBank.play_sfx(SoundsBank.ui_click)		
	elif event.is_action_pressed("mouse_right_click"):
		SoundsBank.play_sfx(SoundsBank.ui_deny)		
