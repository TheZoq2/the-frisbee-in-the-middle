extends ARVRController


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var visual_treat : PackedScene = preload("res://scenes/treat_mesh.tscn")
var treat_prefab : PackedScene = preload("res://scenes/treat.tscn")

var current_treat : Node;

var velocity : Vector3;
var last_position : Vector3 = Vector3(0, 0, 0);

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.velocity = (self.global_transform.origin - self.last_position) / delta
	self.last_position = self.global_transform.origin

	if current_treat:
		current_treat.global_transform = self.global_transform

func _on_catch_pressed():
	print("On catch pressed fired")
	$Area._on_vr_catch_input()

func _on_treat_pressed():
	if get_node("/root/GameData").remaining_treats > 0:
		current_treat = visual_treat.instance()
		get_node("/root/GameState").last_scene.add_child(current_treat)
		get_node("/root/GameData").remaining_treats -= 1

func _on_treat_release():
	if current_treat:
		var actual_treat = treat_prefab.instance()
		actual_treat.global_transform = current_treat.global_transform
		get_node("/root/GameState").last_scene.add_child(actual_treat)
		actual_treat.apply_central_impulse(self.velocity)
		current_treat.queue_free()
		current_treat = null
