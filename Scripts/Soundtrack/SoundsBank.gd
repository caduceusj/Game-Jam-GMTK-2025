extends Node

var new_stream_player
var aux_music = null
var music
var music_pos : float = 0.0
@onready var ost = $Music
#MUSIC

#SFXs
#INTERACTION

var save_game = {
	"stream" : preload("res://Soundtracks/SFXs/Background/Game Save/save17.ogg"),
	"volume" : -10.0,
	"pitch" : [0.8,1.6],
} 

var ui_accept = {
	"stream" : preload("res://Soundtracks/SFXs/UI/UI Accept/ui8.ogg"),
	"volume" : 0.0,
	"pitch" : [0.8,1.6],
}

var ui_refuse = {
	"stream" : preload("res://Soundtracks/SFXs/UI/UI Refuse/ui10.ogg"),
	"volume" : 0.0,
	"pitch" : [0.8,1.6],
}

 #ENEMY
var enemy_death = { 
	"stream" : preload("res://Soundtracks/SFXs/Enemy/Enemy Hit/3rd Attempt/enemyHit13.ogg"),
 	"volume" : 0.0,
	"pitch" : [0.8,1.6],
}
var enemy_damage = {
	"stream" : preload("res://Soundtracks/SFXs/Enemy/Enemy Death/1st Attempt/enemyDeath6.ogg"),
	"volume" : 0.0,
	"pitch" : [0.8,1.6],
}
var enemy_jump = {
	"stream" : preload("res://Soundtracks/SFXs/Player/Player Jump/Jump Start/2nd Attempt/playerJump7.ogg"),
	"volume" : -17.5,
	"pitch" : [0.8,1.6],
}

var enemy_footstep = {
	"stream" : preload("res://Soundtracks/SFXs/Player/Player Footstep/2nd Attempt/playerFootstep11.ogg"),
	"volume" : -20.0,
	"pitch" : [0.8,1.6],
}

var enemy_big_crash = {
	"stream" : preload("res://Soundtracks/SFXs/Enemy/Enemy Big Crash/1st Attempt/enemy_big_crash.ogg"),
	"volume" : -4.5,
	"pitch" : [0.8,1.1],
}
 #PLAYER

var player_footstep = {
	"stream" : preload("res://Soundtracks/SFXs/Player/Player Footstep/1st Attempt/playerFootstep3.ogg"),
	"volume" : -17.5,
	"pitch" : [0.8,1.6],
}
var player_damage = {
	"stream" : preload("res://Soundtracks/SFXs/Player/Player Hit/1st Attempt/playerHit1.ogg"),
	"volume" : 0.0,
	"pitch" : [0.8,1.6],
} 
var player_death = {		
	"stream" : preload("res://Soundtracks/SFXs/Player/Player Death/1st Attempt/playerDeath11.ogg"),
	"volume" : 7.0,
	"pitch" : [0.9,1],
}

  #JUMP
var player_jump_start = {
	"stream" : preload("res://Soundtracks/SFXs/Player/Player Jump/Jump Start/1st Attempt/playerJump2.ogg"),
	"volume" : -1.0,
	"pitch" : [0.8,1.6],
}

var player_jump_end = {
	"stream" : preload("res://Soundtracks/SFXs/Player/Player Jump/Jump End/1st Attempt/hitGround1.ogg"),
	"volume" : 0.0,
	"pitch" : [0.8,1.6],
}

  #PICKUP
var player_minor_pickup = {
	"stream" : preload("res://Soundtracks/SFXs/Player/Player Pickup/Minor Pickup/2nd Attempt/minorPickup.ogg"),
	"volume" : 0.0,
	"pitch" : [1,1],
}

var player_major_pickup = {
	"stream" : preload("res://Soundtracks/SFXs/Player/Player Pickup/Major Pickup/2nd Attempt/majorPickup.ogg"),
	"volume" : 0.0,
	"pitch" : [1,1],
}

 #WEAPONS
var fire_magic = {
	"stream" : preload("res://Soundtracks/SFXs/Player/Player Weapons/Fire Magic/2nd Attempt/fire15.ogg"),
	"volume" : 0.0,
	"pitch" : [0.8,1.6],
}

var fire_vulnerable = {
	"stream" : preload("res://Soundtracks/SFXs/Player/Player Weapons/Needle/Fire Magic Needle/fire_needle.ogg"),
	"volume" : -9.0,
	"pitch" : [1,1.6],
}

var hammer = {
	"stream" : preload("res://Soundtracks/SFXs/Player/Player Weapons/Hammer/hammer.ogg"),
	"volume" : 0.0,
	"pitch" : [0.8,1.0],
}

  #AXE
var axe_throw = {
	"stream" : preload("res://Soundtracks/SFXs/Player/Player Weapons/Axe/Axe Throw/1st Attempt/axeThrow1.ogg"),
	"volume" : 0.0,
	"pitch" : [0.8,1.0],
}
var axe_return = {
	"stream" : preload("res://Soundtracks/SFXs/Player/Player Weapons/Axe/Axe Return/1st Attempt/axeReturn2.ogg"),
	"volume" : 0.0,
	"pitch" : [0.8,1.0],
}

  #NEEDLE
var needle_throw = {
	"stream" : preload("res://Soundtracks/SFXs/Player/Player Weapons/Needle/Needle Throw/needleThrow10.ogg"),
	"volume" : 0.0,
	"pitch" : [0.8,1.6],
}
var needle_hit_enemy = {
	"stream" : preload("res://Soundtracks/SFXs/Player/Player Weapons/Needle/Needle Hit Enemy/1st Attempt/needle_hit_enemy.ogg"),
	"volume" : 0.0,
	"pitch" : [0.8,1.6],
}

var needle_hit_wall = {
	"stream" : preload("res://Soundtracks/SFXs/Player/Player Weapons/Needle/Needle Hit Wall/1st Attempt/needle_hit_wall5.ogg"),
	"volume" : 0.0,
	"pitch" : [0.6,1],
}

  #STING
var sting_throw = {
	"stream" : preload("res://Soundtracks/SFXs/Player/Player Weapons/Hags Finger/1st Attempt/hag_finger_start.ogg"),
	"volume" : 0.0,
	"pitch" : [0.1,1.0],
}
var sting_return = {
	"stream" : preload("res://Soundtracks/SFXs/Player/Player Weapons/Hags Finger/1st Attempt/hag_finger_end.ogg"),
	"volume" : 0.0,
	"pitch" : [0.8,1.6],
}

  #FLAMETHROWER
var flamethrower_start = {
	"stream" : preload("res://Soundtracks/SFXs/Player/Player Weapons/Hags Head/1st Attempt/hag_head.ogg"),
	"volume" : -5.0,
	"pitch" : [1.0,1.2],
}

  #WEB
var web_cast = {
	"stream" : preload("res://Soundtracks/SFXs/Player/Player Weapons/Web/Web Cast/webCast.ogg"),
	"volume" : 0.0,
	"pitch" : [0.8,1.2],
}

var web_jump = {
	"stream" : preload("res://Soundtracks/SFXs/Player/Player Weapons/Web/Web Jump/webJump.ogg"),
	"volume" : -2.0,
	"pitch" : [0.6,1.2],
}

#AMBIENCE
var suspended_block = {
	"stream" : preload("res://Soundtracks/SFXs/Background/Suspended Block/suspendedBlock.ogg"),
	"volume" : -4.5,
	"pitch" : [0.8,1.1],
}

	
#func play_stream(stream_player,path,name,volume):
	#stream_player.set_stream(load(path))		
	#Sfx.add_child(stream_player)	
	#return stream_player 
		
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
