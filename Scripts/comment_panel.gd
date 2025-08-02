extends Panel

var initial_position: Vector2

var replies : Array[String] = ["positive", "negative", "bot", "ask_grorc"]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if $CommentLabel:
		initial_position = $CommentLabel.position
	modify_text()
	$Timer.wait_time = 10 - get_parent().get_parent().likes/100
	$Timer.start()
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	change_text()
	

func change_text():
	var scroll_offset: float = 30.0
	var tween = create_tween()

	var out_tween = tween.parallel()
	out_tween.tween_property($CommentLabel, "position:y", initial_position.y - scroll_offset, 0.25).set_trans(Tween.TRANS_QUAD)


	tween.tween_callback(self._prepare_label_for_entry.bind(scroll_offset))
	
	var in_tween = tween.parallel()
	in_tween.tween_property($CommentLabel, "position:y", initial_position.y, 0.25).set_trans(Tween.TRANS_QUAD)

	
func _prepare_label_for_entry(scroll_offset: float):
	modify_text()
	var new_pos = initial_position
	new_pos.y += scroll_offset
	$CommentLabel.position = new_pos


func modify_text():
	var full_text
	if(get_parent().get_parent().likes < 10):
		full_text = Global.to_twitter_handle(Global.randomize_user()) + " : " + infoDictionary.generic_replies_dict[replies[2]].pick_random()
	elif get_parent().get_parent().likes < 250:
		full_text = Global.to_twitter_handle(Global.randomize_user()) + " : " + infoDictionary.generic_replies_dict[replies[randi_range(0,3)]].pick_random()
	else:
		full_text = Global.to_twitter_handle(Global.randomize_user()) + " : " + infoDictionary.generic_replies_dict[replies[0]].pick_random()
	var final_text: String
	if len(full_text) > 63:
		final_text = full_text.substr(0, 60) + "..."
	else:
		final_text = full_text
	$CommentLabel.text = final_text
