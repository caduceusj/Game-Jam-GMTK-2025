extends Control

var likes : int = 0
var user : String
var tweet : String = "STRING VAZIA CUIDADO"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$TweetPanel/Text.text = tweet
	
	$"TweetPanel/Name&Hashtag".text = Global.to_spaced_name(user) + "\n" + Global.to_twitter_handle(user)
	
	$TweetPanel/LikesNumber.text = "[center]"+str(likes)+"[center]"
	
	#EXPANSÃO DE TWEET
	$TweetPanel.scale = Vector2(0, 0)
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_EXPO)
	tween.tween_property($TweetPanel, "scale", Vector2(1,1), 1.0)
	#EXPANSÃO DE TWEET
	
	pass # Replace with function body.


func close():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_EXPO)
	tween.tween_property($TweetPanel, "scale", Vector2(0,0), 1.0)
	await(tween.finished)
	queue_free()


func _on_like_button_toggled(toggled_on: bool) -> void:
	if($TweetPanel/LikesNumber.text == "[center]"+str(likes+1)+"[center]"):
		SoundsBank.play_sfx(SoundsBank.dislike)
		$TweetPanel/LikesNumber.text = "[center]"+str(likes)+"[center]"
	else:
		SoundsBank.play_sfx(SoundsBank.like)
		$TweetPanel/LikesNumber.text = "[center]"+str(likes+1)+"[center]"
