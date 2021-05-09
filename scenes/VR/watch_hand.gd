extends MeshInstance


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	print(get_node("/root/GameData").game_time)
	print(get_node("/root/GameData").game_time / 60.0)
	print(get_node("/root/GameData").game_time / 60.0 * PI*2)
	self.rotation = Vector3(0, get_node("/root/GameData").game_time / 60.0 * PI*2, 0)
