extends Spatial


var is_vr;

var normal_player : PackedScene = preload("res://scenes/player/Player.tscn")
var vr_player : PackedScene = preload("res://scenes/VR/ARVR_root.tscn")
var player;


# Called when the node enters the scene tree for the first time.
func _ready():
	if is_vr:
		player = vr_player.instance();
		self.add_child(player)
	else:
		player = normal_player.instance();
		self.add_child(player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
