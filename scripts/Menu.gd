extends Window

var current_score: int = 0;
var high_score: int = PersistentData.high_score;

var pregame: bool = true;
var game_over: bool = false;
var game_over_time = 0;
const game_over_delay = 1000;

var scored_sound;

# Called when the node enters the scene tree for the first time.
func _ready():
	scored_sound = $"../../Film Track/Player/Scored";
	update_hs_text();
	get_tree().paused = true;
	borderless = true;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	visible = pregame or game_over;
	
	if pregame:
		$Instruction.text = "Press the Spacebar to Fly!";
	else:
		$Instruction.text = "Press the Spacebar to Try Again!";
	
	$"../Label".text = "Score: " + str(current_score);
	
	if Input.is_action_just_pressed("Flap"):
		if pregame:
			pregame = false;
			get_tree().paused = false;
		elif get_tree().paused and game_over and Time.get_ticks_msec() - game_over_time > game_over_delay:
			PersistentData.music_position = $"../../Film Track/Player/Music".get_playback_position();
			get_tree().reload_current_scene();
	pass

func add_point():
	scored_sound.play();
	current_score += 1;
	pass;
	
func set_game_over():
	game_over = true;
	game_over_time = Time.get_ticks_msec();
	get_tree().paused = true;
	
	if high_score < current_score:
		high_score = current_score;
		PersistentData.high_score = high_score;
	update_hs_text();
	
	pass;

func update_hs_text():
	$"High Score".text = "High Score: " + str(high_score);

