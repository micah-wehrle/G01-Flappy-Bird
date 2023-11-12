extends StaticBody2D

var player;
var menu_brain;
var has_scored: bool;


# Called when the node enters the scene tree for the first time.
func _ready():
	has_scored = false;
	player = $"../Film Track/Player";
	menu_brain = $"../HUD/Menu";
	if player.global_position.x >= global_position.x:
		has_scored = true; #prevents the pre-loaded wall from scoring
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !has_scored && player.global_position.x >= global_position.x:
		menu_brain.add_point();
		has_scored = true;
		create_floating_score_text();
	pass

func create_floating_score_text():
	var floating_score = Label.new();
	floating_score.set_script(load("res://scripts/Floating Score.gd"));
	floating_score.global_position = global_position*2;
	$"../WorldCanvas".add_child(floating_score);
	pass;
