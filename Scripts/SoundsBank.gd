extends Node

var new_stream_player
var aux_music = null
var music
var music_pos : float = 0.0
@onready var ost = $Music
#MUSIC

#SFXs
#INTERACTION
var ui_click = {
	"stream" : preload("res://Soundtrack/SFXs/UIClick/1st Attempt/wav/uiClick2.wav"),
	"volume" : -25.0,
	"pitch" : [0.8,1.2],
}


var ui_accept = {
	"stream" : preload("res://Soundtrack/SFXs/UIAccept/1st Attempt/wav/uiAccept6.wav"),
	"volume" : -20.0,
	"pitch" : [0.9,1.1],
}

var ui_deny = {
	"stream" : preload("res://Soundtrack/SFXs/UIDeny/1st Attempt/wav/uiDeny5.wav"),
	"volume" : -25.0,
	"pitch" : [0.9,1.1],
}

var keyboard_key = {
	"stream" : preload("res://Soundtrack/SFXs/KeyboardKey/1st Attempt/wav/keyboardKey1.wav"),
	"volume" : 0.0,
	"pitch" : [0.8,1.6],
}

var new_post_positive = {
	"stream" : preload("res://Soundtrack/SFXs/NewPostPositive/2nd Attempt/wav/NewPost1.wav"),
	"volume" : 0.0,
	"pitch" : [1.0,1.2],
}

var new_post_negative = {
	"stream" : preload("res://Soundtrack/SFXs/NewPostNegative/1st Attempt/wav/NewPost1.wav"),
	"volume" : 0.0,
	"pitch" : [0.8,1.0],
}

var like = {
	"stream" : preload("res://Soundtrack/SFXs/Like/1st Attempt/wav/like1.wav"),
	"volume" : 0.0,
	"pitch" : [0.9,1.1],
}

var dislike = {
	"stream" : preload("res://Soundtrack/SFXs/Dislike/1st Attempt/wav/dislike1.wav"),
	"volume" : 0.0,
	"pitch" : [0.9,1.1],
}
			
func play_ost(audio):
	if audio != null:		
		aux_music = music
		ost.set_stream(audio)
		ost.play()
		

func start_sfx(audio, stream_player):		
	if audio["stream"] != null: 				
		stream_player.set_stream(audio["stream"])	
		stream_player.volume_db = audio["volume"]
		stream_player.bus = "SFX"	
		stream_player.process_mode = Node.PROCESS_MODE_ALWAYS
		stream_player.set_pitch_scale(randf_range(audio["pitch"][0], audio["pitch"][1]))
	return stream_player 		
	
func play_directional_sfx(audio,node):
	new_stream_player = StreamPlayer2D.new()
	node.add_child(start_sfx(audio,new_stream_player))
	
func play_sfx(audio):
	new_stream_player = StreamPlayer.new() 
	add_child(start_sfx(audio,new_stream_player))	
		
func pause_resume_ost(timer): 	
	music_pos = ost.get_playback_position()
	ost.stop()
	await(get_tree().create_timer(timer).timeout)
	ost.play(music_pos)
		
	
	#ost.play(music_pos)	
#func stop_stream(name):	
	#if(Sfx.get_node(name)):
	#Sfx.get_node(name).queue_free()
