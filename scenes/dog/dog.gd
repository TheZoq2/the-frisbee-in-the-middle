extends KinematicBody

class_name dog

onready var _velocity:Vector3 = Vector3.ZERO
onready var _distance:float = 0.0

export var gravity: float = -5.0
export var speed: float = 5.0
export var rotation_factor: float = 0.5
export var arrive_threshold: float = 1.25


signal dog_caught_frisbee

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	var target = find_target()
	if target:
		_distance = transform.origin.distance_to(target.global_transform.origin)
		if _distance < arrive_threshold:
			#_velocity = Vector3.ZERO
			target.queue_free()
			target = find_target()
			emit_signal("dog_caught_frisbee")
			return
		var new_dog_transform = transform.looking_at(target.global_transform.origin, Vector3.UP)
		transform = transform.interpolate_with(new_dog_transform, (rotation_factor * delta) / _distance)
		rotation.x = 0
		_velocity = -transform.basis.z * speed

	_velocity = move_and_slide(_velocity, Vector3.UP)

func find_target() :
	var closest_frisbee = find_closest_frisbee()
	var nearby_treat = find_treats_in_range()
	
	return nearby_treat if nearby_treat else closest_frisbee

func find_closest_frisbee() -> Frisbee:
	var frisbees = get_tree().get_nodes_in_group("frisbee")
	if frisbees == null||frisbees.size() == 0:
		return null
		
	var closest_frisbee: Frisbee = null
	var closest_distance: float;
	for body in frisbees:
		if (body as Frisbee).is_caught:
			continue
		var distance: float = self.global_transform.origin.distance_to(
			body.global_transform.origin)
		if closest_frisbee == null or distance < closest_distance:
			closest_frisbee = body
			closest_distance = distance
	return closest_frisbee
	
func find_treats_in_range() -> Treat:
	var overlapping_bodies = $ActiveCandyArea.get_overlapping_bodies()
	
	if overlapping_bodies.size() == 0:
		return null
		
	var closest_treat: Treat = null
	var closest_distance: float;
	
	for body in overlapping_bodies:
		if body is Treat:
			var distance: float = self.global_transform.origin.distance_to(
			body.global_transform.origin)

			if closest_treat == null or distance < closest_distance:
				closest_treat = body
				closest_distance = distance
	return closest_treat

	
	
	
