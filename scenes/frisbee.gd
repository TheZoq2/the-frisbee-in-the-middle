extends RigidBody
class_name Frisbee


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var gravity_compensation = 9.6;

var is_highlighted_this_frame: bool = false
var outline_mesh: MeshInstance

# Called when the node enters the scene tree for the first time.
func _ready():
	var player_pos: Vector3 = get_parent().player.get_position()

	var player_direction = (player_pos - self.global_transform.origin).normalized();
	print(player_direction)
	var direction = atan2(player_direction.z, player_direction.x) + rand_range(-PI/4, PI/4)
	var force = 3;
	self.apply_central_impulse(Vector3(cos(direction), 0, sin(direction)) * force)
	self.add_torque(Vector3(0, 100, 0))

	outline_mesh = self.find_node("Outline") as MeshInstance
	outline_mesh.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.apply_central_impulse(Vector3(0, gravity_compensation * delta, 0))

	outline_mesh.visible = is_highlighted_this_frame
	is_highlighted_this_frame = false

func highlight_this_frame():
	is_highlighted_this_frame = true
