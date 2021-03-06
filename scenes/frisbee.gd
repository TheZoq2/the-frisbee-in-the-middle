extends RigidBody
class_name Frisbee


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var gravity_compensation : float = 9.6;
var has_collided : bool = false

var is_highlighted_this_frame: bool = false
var outline_mesh: MeshInstance
var is_caught: bool = false
var has_landed: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var player_pos: Vector3 = get_parent().player.get_position()

	var max_offset_angle = PI/4;
	if get_node("/root/GameState").is_vr:
		max_offset_angle = PI/10;

	var player_direction = (player_pos - self.global_transform.origin).normalized();
	#print(player_direction)
	var direction = atan2(player_direction.z, player_direction.x) + rand_range(-max_offset_angle, max_offset_angle)
	var force = 4;
	var upforce = 0.1
	self.apply_central_impulse(Vector3(cos(direction), upforce, sin(direction)) * force)
	self.add_torque(Vector3(0, 100, 0))

	outline_mesh = self.find_node("Outline") as MeshInstance
	#print(outline_mesh != null)
	outline_mesh.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(linear_velocity)
	
	if not has_collided:
		self.apply_central_impulse(Vector3(0, gravity_compensation * delta, 0))

	if has_landed:
		self.apply_central_impulse(Vector3(0, 9.8 * delta, 0))
		#slowly sink into the ground

	outline_mesh.visible = is_highlighted_this_frame
	if !is_caught:
		is_highlighted_this_frame = false

func highlight_this_frame():
	is_highlighted_this_frame = true
	#print("highlighting frisbee")


func _on_frisbee_body_entered(body):
	has_collided = true
	if is_caught: # Hand already on the way
		return
	if body.name == "ground":
		is_caught = true
		has_landed = true
		angular_velocity = Vector3.ZERO
		linear_velocity = Vector3.ZERO
		collision_layer = 0
		collision_mask = 0
		$DespawnTimer.start()


func play_sound():
	$AudioStreamPlayer3D.play()

func stop_sound():
	$AudioStreamPlayer3D.stop()
	


func _on_DespawnTimer_timeout():
	queue_free()
