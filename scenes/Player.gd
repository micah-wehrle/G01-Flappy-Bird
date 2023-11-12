extends CharacterBody2D;

const JUMP_VELOCITY = -500.0;
const TERMINAL_VEL = 1000;
const GRAV_MULT = 1.7;
const MAX_ROTATION = 0.2;
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity");

var true_y_vel = JUMP_VELOCITY; #start flapped!

var sprite;
var flap_sound;
var music;
var death_sound;

func _ready():
	sprite = $CollisionShape2D/AnimatedSprite2D;
	flap_sound = $Flap;
	music = $Music;
	death_sound = $Death;
	
	sprite.play();
	flap_sound.play();
	music.play(PersistentData.music_position);
	pass
	
func _physics_process(delta):
	
	# Add the gravity.
	true_y_vel += gravity * delta * GRAV_MULT;
	# Handle Jump.
	if Input.is_action_just_pressed("Flap"):
		true_y_vel = JUMP_VELOCITY;
		if sprite.is_playing():
			sprite.stop();
		sprite.play();
		flap_sound.play();
	
	velocity.y = clamp(true_y_vel, -TERMINAL_VEL, TERMINAL_VEL);
	
	$CollisionShape2D.rotation = (velocity.y / TERMINAL_VEL)
	
	

	if move_and_slide():
		death_sound.play();
		$"../../HUD/Menu".set_game_over();
		pass;
