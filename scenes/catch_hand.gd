extends Area
class_name CatchHand

var move_speed = 10

var target: Frisbee = null
var catcher = null
var caught_frisbee_visual: Spatial = null
var has_grabbed: bool = false
var should_switch_parent: bool = false

func _ready():
	caught_frisbee_visual = find_node("CaughtFrisbee")
	caught_frisbee_visual.hide()
	connect("body_entered", self, "on_body_entered");

func _physics_process(delta):
	if should_switch_parent:
		# When the player moves fast away from the target, the target can't be
		# reached if child of the player and the player can't be reached when
		# child of root. Thus, we need to switch parent
		var prev_pos: Vector3 = global_transform.origin
		get_parent().remove_child(self)
		catcher.add_child(self)
		global_transform.origin = prev_pos
		should_switch_parent = false

	if !has_grabbed: # Go to target
		look_at(target.global_transform.origin, Vector3.UP);
		global_transform.origin = lerp(global_transform.origin,
			target.global_transform.origin, move_speed * delta)
	else: # Bring target home
		look_at(2 * global_transform.origin - catcher.global_transform.origin,
			Vector3.UP);
		global_transform.origin = lerp(global_transform.origin,
			catcher.global_transform.origin, move_speed * delta)

		for body in get_overlapping_bodies():
			if body is Player: # Brought frisbee home
				catcher.emit_signal("frisbee_caught")
				queue_free()

func on_body_entered(body: PhysicsBody):
	if body == target: # Grabbed target
		has_grabbed = true
		caught_frisbee_visual.show()
		target.queue_free()
		should_switch_parent = true;

func set_target_and_catcher(new_target: Frisbee, new_catcher):
	self.target = new_target
	self.catcher = new_catcher
