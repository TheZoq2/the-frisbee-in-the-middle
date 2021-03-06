extends Area
class_name CatchHand

var move_speed: float = 10
var player_height_offset: float = -0.4

var target: Frisbee = null
var catcher = null
var caught_frisbee_visual: Spatial = null
var has_grabbed: bool = false
var should_switch_parent: bool = false

var stretch_arm_template = preload("res://scenes/stretch_arm.tscn")
var stretch_arm: Spatial

func _ready():
	caught_frisbee_visual = find_node("CaughtFrisbee")
	caught_frisbee_visual.hide()

	stretch_arm = stretch_arm_template.instance()
	get_tree().get_root().add_child(stretch_arm)

# warning-ignore:return_value_discarded
	connect("body_entered", self, "on_body_entered");

func _physics_process(delta):
	var startPoint: Vector3 = catcher.get_global_transform().origin + player_height_offset * Vector3.UP

	if should_switch_parent:
		# When the player moves fast away from the target, the target can't be
		# reached if child of the player and the player can't be reached when
		# child of root. Thus, we need to switch parent
		var prev_transform: Transform = global_transform
		get_parent().remove_child(self)
		catcher.add_child(self)
		global_transform = prev_transform
		should_switch_parent = false

	if !has_grabbed: # Go to target
		global_transform.origin = lerp(global_transform.origin,
			target.global_transform.origin, move_speed * delta)
	else: # Bring target home
		global_transform.origin = lerp(global_transform.origin, startPoint,
			move_speed * delta)

		for body in get_overlapping_bodies():
			if body is Player: # Brought frisbee home
				catcher.emit_signal("frisbee_caught")
				stretch_arm.queue_free()
				queue_free()
				return

	var endPoint: Vector3 = global_transform.origin
	var length: float = startPoint.distance_to(endPoint)
	stretch_arm.scale.z = length
	stretch_arm.global_transform.origin = 0.5 * (startPoint + endPoint)
	if stretch_arm.global_transform.origin != endPoint:
		var dot: float = (endPoint - stretch_arm.global_transform.origin) \
			.normalized().dot(Vector3.UP)
		if dot == 1 || dot == 0: # Straight up or down
			stretch_arm.look_at(endPoint, Vector3.FORWARD)
			look_at(2 * endPoint - startPoint, Vector3.FORWARD)
		else:
			stretch_arm.look_at(endPoint, Vector3.UP) #generates an error if direction between node origin and target is aligned with UP
			look_at(2 * endPoint - startPoint, Vector3.UP)

func on_body_entered(body: PhysicsBody):
	if body == target: # Grabbed target
		has_grabbed = true
		caught_frisbee_visual.show()
		target.queue_free()
		should_switch_parent = true;

func set_target_and_catcher(new_target: Frisbee, new_catcher):
	target = new_target
	catcher = new_catcher
	global_transform.origin = catcher.global_transform.origin \
		+ player_height_offset * Vector3.UP

func _on_children_despawn():
	print(name, " is awaiting termination")
	stretch_arm.queue_free()
	queue_free()
