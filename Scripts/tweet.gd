extends Control

var likes : int = 0
var user : String
var tweet : String = "STRING VAZIA CUIDADO"

#DEPENDENDO DO NIVEL DO JOGADOR ALGUNS EMOJIS VÃO APARECENDO EM SEUS POSTS: 🎭⚔️🗡🥇☄️💫🌟

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$TweetPanel/Text.text = tweet
	
	if(user == "You The Player"):
		$"TweetPanel/Name&Hashtag".text = get_name_with_flavor_emoji(Global.to_spaced_name(user), Global.numberOfFollowers) + "\n" + Global.to_twitter_handle(user)
	else:
		$"TweetPanel/Name&Hashtag".text = get_name_with_flavor_emoji(Global.to_spaced_name(user), likes) + "\n" + Global.to_twitter_handle(user)

	
	
	$TweetPanel/LikesNumber.text = "[center]"+str(likes)+"[center]"
	
	#EXPANSÃO DE TWEET
	$TweetPanel.scale = Vector2(0, 0)
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_EXPO)
	tween.tween_property($TweetPanel, "scale", Vector2(1,1), 1.0)
	#EXPANSÃO DE TWEET
	
	pass # Replace with function body.


func get_name_with_flavor_emoji(base_name: String, total_followers: int) -> String:
	var emoji: String = ""

	
	if total_followers >= 100000:
		emoji = "🌟"
	elif total_followers >= 50000:
		emoji = "💫"
	elif total_followers >= 10000:
		emoji = "☄️"
	elif total_followers >= 2000:
		emoji = "🥇"
	elif total_followers >= 500:
		emoji = ["⚔️", "🗡"].pick_random()
	elif total_followers >= 100:
		emoji = "🎭"
	else:
		return base_name
	return base_name + " " + emoji



func close():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_EXPO)
	tween.tween_property($TweetPanel, "scale", Vector2(0,0), 1.0)
	await(tween.finished)
	queue_free()


func _on_like_button_toggled(toggled_on: bool) -> void:
	if($TweetPanel/LikesNumber.text == "[center]"+str(likes+1)+"[center]"):
		$TweetPanel/LikesNumber.text = "[center]"+str(likes)+"[center]"
	else:
		$TweetPanel/LikesNumber.text = "[center]"+str(likes+1)+"[center]"
