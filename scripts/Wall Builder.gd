extends Node2D

var base_wall;
var last_wall;
var walls = [];
var delete_gap;
const spacing = 300;
const offset = 300;

# Called when the node enters the scene tree for the first time.
func _ready():
	base_wall = $"../../Wall Section";
	last_wall = base_wall;
	delete_gap = global_position.x - base_wall.global_position.x;
	
	# I tried calling place_wall() 3 times here but for some reason it wans't working, I think you can't add_child here or something.
	$"../../Wall Section2".position.y -= randi_range(0, offset);
	$"../../Wall Section3".position.y -= randi_range(0, offset);
	#$"../../Wall Section4".position.y -= randi_range(0, offset);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global_position.x - last_wall.global_position.x > spacing:
		last_wall = place_wall();
	
	if global_position.x - walls[0].global_position.x > delete_gap:
		var wall = walls.pop_front();
		wall.queue_free();
	pass
	
func place_wall():
	var wall = base_wall.duplicate();
	get_parent().get_parent().add_child(wall);
	wall.global_position = global_position;
	wall.has_scored = false;
	wall.global_position.y -= randi_range(0, offset);
	walls.push_back(wall);
	return wall;
