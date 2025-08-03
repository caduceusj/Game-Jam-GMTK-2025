extends Control
@onready var tweet_panel: Panel = $TweetPanel

func _ready():
	get_node("TweetPanel/Text").text = get_follower_feedback_message()

# Function that gets follower data from Global variables and returns a feedback message.
func get_follower_feedback_message() -> String:
	
	# Get the follower change directly from the global variable.
	var follower_change = Global.weekFollowers
	
	# Prepare the change number for display.
	var sign: String = ""
	if follower_change > 0:
		sign = "+"
	var number_str: String = sign + str(follower_change)
	
	var feedback_message: String

	# Check the gain/loss "tiers" with reduced numbers.
	if follower_change >= 1000:
		# Viral 🚀
		var messages = [
			"VIRAL! Your audience exploded with " + number_str + " new subscribers!",
			"Unbelievable! You've become an overnight phenomenon, gaining " + number_str + " followers.",
			"The algorithm loves you! " + number_str + " new people arrived this month. Get ready for fame."
		]
		feedback_message = messages.pick_random()
		
	elif follower_change >= 500:
		# Great Growth ✨
		var messages = [
			"Massive growth! You've won over " + number_str + " new fans this month.",
			"Excellent work! The channel is taking off with " + number_str + " new sign-ups.",
			"Your dedication is paying off! " + number_str + " more followers. Keep it up!"
		]
		feedback_message = messages.pick_random()

	elif follower_change >= 100:
		# Good Growth 📈
		var messages = [
			"A very strong month! Gains of " + number_str + " followers.",
			"The audience is loving it! " + number_str + " new subscribers in your community.",
			"Great numbers! You ended the month with " + number_str + " more followers."
		]
		feedback_message = messages.pick_random()
		
	elif follower_change > 0:
		# Modest Growth 🙂
		var messages = [
			"Steady growth. You gained " + number_str + " followers this month.",
			"One step at a time... " + number_str + " new people have joined you.",
			"Every new follower counts! Welcome to the " + number_str + " new members."
		]
		feedback_message = messages.pick_random()
		
	elif follower_change == 0:
		# Stagnation 😐
		feedback_message = "The month ended with no follower gains or losses. Time to plan the next content."
		
	elif follower_change > -100:
		# Minor Loss 📉
		var messages = [
			"A slightly difficult month. You had a loss of " + number_str + " followers.",
			"It happens. " + number_str + " people unfollowed, but many are still here.",
			"A small dip of " + number_str + ". It's a chance to re-evaluate the strategy."
		]
		feedback_message = messages.pick_random()
		
	else: # follower_change <= -100
		# Significant Loss 💀
		var messages = [
			"Warning! A significant loss of " + number_str + " followers this month. Something needs to change.",
			"Ouch. The audience didn't react well, resulting in " + number_str + " fewer followers.",
			"Crisis on the horizon. The loss of " + number_str + " subscribers is a clear sign that action is needed."
		]
		feedback_message = messages.pick_random()

	# Append the current total follower count to the end of the message.
	var final_message = feedback_message + "\n(Current followers: " + str(Global.numberOfFollowers) + ")"
	Global.weekFollowers = 0
	return final_message

func close():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_EXPO)
	tween.tween_property(tweet_panel, "scale", Vector2(0,0), 1.0)
	await(tween.finished)
	queue_free()
