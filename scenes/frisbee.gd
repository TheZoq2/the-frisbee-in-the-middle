extends RigidBody
class_name Frisbee


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var gravity_compensation : float = 9.6;
var has_collided : bool = false

var is_highlighted_this_frame: bool = false
var outline_mesh: MeshInstance

# Called when the node enters the scene tree for the first time.
func _ready():
	var player: Vector3 = get_parent().player.get_position()
	var direction = rand_range(0, PI*2)
	var force = 3;
	self.apply_central_impulse(Vector3(cos(direction), 0.2, sin(direction)) * force)
	self.add_torque(Vector3(0, 100, 0))

	outline_mesh = self.find_node("Outline") as MeshInstance
	outline_mesh.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(linear_velocity)
	if linear_velocity.y != 0:
		if not has_collided:
			self.apply_central_impulse(Vector3(0, gravity_compensation * delta, 0))
		else:
			self.apply_central_impulse(Vector3(0, 0, 0))
	else:
		if linear_velocity.length() < 0.2:
			#print("starting despawn timer")
			$DespawnTimer.start()

	outline_mesh.visible = is_highlighted_this_frame
	is_highlighted_this_frame = false

func highlight_this_frame():
	is_highlighted_this_frame = true


func _on_frisbee_body_entered(body):
	print("collision with: ", body.name)
	has_collided = true


func _on_DespawnTimer_timeout():
	queue_free()
