extends Node2D;


# Called when the node enters the scene tree for the first time.
func _ready():
	# get start posotion of floor
	build_floor();
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# check if a floor tile needs to be moved 
	var floor_rect = $"../Film Track/Floor/CollisionShape2D";
	var leftmost = find_left_tile();
	if floor_rect.global_position.x - floor_rect.shape.get_rect().size.x/2 > leftmost.position.x:
		var rightmost = find_right_tile();
		leftmost.position.x = rightmost.position.x + rightmost.scale.x * rightmost.get_rect().size.x;
	
func build_floor(): 
	#   $"../RootT.ile".scale * $"../RootTile".get_rect().size.x
	var root_tile = $"../RootTile";#.get_rect().position;
	var root_size = root_tile.scale * root_tile.get_rect().size;
	var floor_rect = $"../Film Track/Floor/CollisionShape2D".shape.get_rect();
	
	var placement_pos = floor_rect.position;
	placement_pos.x -= root_size.x/2;
	placement_pos.y += root_size.y/2;
	
	var target_pos = floor_rect.end;
	target_pos.x += root_size.x/2;
	while placement_pos < target_pos:
		var tile = root_tile.duplicate();
		tile.position = to_local(placement_pos);
		
		add_child(tile);
		placement_pos.x += root_size.x;
	root_tile.queue_free();
	

func find_left_tile():
	var leftmost;
	var leftmost_pos = 10000000000000;
	for tile in get_children():
		if tile.position.x < leftmost_pos:
			leftmost = tile;
			leftmost_pos = tile.position.x;
	return leftmost;

func find_right_tile():
	var rightmost;
	var rightmost_pos = -10000000000000;
	for tile in get_children():
		if tile.position.x > rightmost_pos:
			rightmost = tile;
			rightmost_pos = tile.position.x;
	return rightmost;
