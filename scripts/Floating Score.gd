extends Label

var lifespan = 1000.0; #ms
var end_time = Time.get_ticks_msec() + lifespan; #ms


# Called when the node enters the scene tree for the first time.
func _ready():
	text = '+1';
	label_settings = LabelSettings.new();
	label_settings.font_size = 64;
	label_settings.font_color = Color(0.3,0.3,1);
	label_settings.outline_size = 8;
	label_settings.outline_color = Color(1,1,1,1);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var remaining = end_time - Time.get_ticks_msec();
	position.y -= 100 * delta;
	position.x += (cos(remaining/lifespan*11)*1.8);
	modulate.a = clamp((remaining / lifespan)*2, 0, 1); #makes it full transparency for half the time and then fade during the other half
	if remaining <= 0:
		queue_free();
	pass
