extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
class_name Doggo

var velocity:Vector3 = Vector3.ZERO
export var gravity = -5
export var speed = 5

signal dog_caught_frisbee

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	var target = find_closest_frisbee()
	if target:
		look_at(target.target.global_transform.origin, Vector3.UP)
		rotation.x = 0
		velocity = -transform.basis.z * speed
		if transform.origin.distance_to(target.global_transform.origin) < .5:
			velocity = Vector3.ZERO
			target.queue_free()
			emit_signal("dog_caught_frisbee")
	velocity = move_and_slide(velocity, Vector3.UP)

func find_closest_frisbee() -> Frisbee:
	var frisbees = get_tree().get_nodes_in_group("frisbee")
	if frisbees == null||frisbees.size() == 0:
		return null
		
	var closest_frisbee: Frisbee = null
	var closest_distance: float;
	for body in frisbees:
		if body is Frisbee:
			var distance: float = self.global_transform.origin.distance_to(
				body.global_transform.origin)
			if closest_frisbee == null or distance < closest_distance:
				closest_frisbee = body
				closest_distance = distance
	return closest_frisbee
