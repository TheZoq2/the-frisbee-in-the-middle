extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var treats = [
		get_node("treat0"),
		get_node("treat1"),
		get_node("treat2"),
		get_node("treat3"),
		get_node("treat4")
	]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var num_treats = get_node("/root/GameData").remaining_treats
	for i in range(num_treats, 5):
		treats[i].hide()


