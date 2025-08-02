extends Panel

var option1 : String
var option2 : String
var option3 : String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sortOptions()


func sortOptions():
	var dicAux = infoDictionary.trends_dict.keys().duplicate()
	print(Global.chosenTrend)
	dicAux.remove_at(dicAux.find(Global.chosenTrend))
	dicAux.remove_at(dicAux.find(Global.secondaryTrend))
	var optionsArray = [Global.chosenTrend, Global.secondaryTrend, Global.thirdTrend]
	optionsArray.shuffle()
	for x in 3:
		option1 = optionsArray[0]
		option2 = optionsArray[1]
		option3 = optionsArray[2]
	$SubjectSelection/Button.text = option1
	$SubjectSelection/Button2.text = option2
	$SubjectSelection/Button3.text = option3


func _on_button_button_down() -> void:
	Global.playerChoice = option1
	$SubjectSelection.hide()
	$"Like&Dislike".show()
	pass # Replace with function body.


func _on_button_2_button_down() -> void:
	Global.playerChoice = option2
	$SubjectSelection.hide()
	$"Like&Dislike".show()
	pass # Replace with function body.


func _on_button_3_button_down() -> void:
	Global.playerChoice = option3
	$SubjectSelection.hide()
	$"Like&Dislike".show()
	pass # Replace with function body.


func _on_like_button_down() -> void:
	Global.playerImpression = "positive"
	Global.playerTweet()
	$SubjectSelection.show()
	$"Like&Dislike".hide()
	Global.changeRound()
	sortOptions()
	pass # Replace with function body.


func _on_dislike_button_down() -> void:
	Global.playerImpression = "negative"

	Global.playerTweet()
	$SubjectSelection.show()
	$"Like&Dislike".hide()
	Global.changeRound()
	sortOptions()
	pass # Replace with function body.
