extends Area
class_name Catcher

signal frisbee_caught

func _process(_delta):
	var closest_frisbee: Frisbee = null
	var closest_distance: float;
	for body in get_overlapping_bodies():
		if body is Frisbee:
			var distance: float = self.global_transform.origin.distance_to(
				body.global_transform.origin)
			if closest_frisbee == null or distance < closest_distance:
				closest_frisbee = body
				closest_distance = distance
	if closest_frisbee != null:
		if Input.is_action_pressed("catch"):
			closest_frisbee.queue_free()
			emit_signal("frisbee_caught")
