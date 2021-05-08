extends Area
class_name Catcher

signal frisbee_caught

var catch_hand_template = preload("res://scenes/catch_hand.tscn")

func _process(_delta):
	var closest_frisbee: Frisbee = null
	var closest_distance: float;
	for body in get_overlapping_bodies():
		if body is Frisbee and !body.is_caught:
			var distance: float = self.global_transform.origin.distance_to(
				body.global_transform.origin)
			if closest_frisbee == null or distance < closest_distance:
				closest_frisbee = body
				closest_distance = distance
	if closest_frisbee != null:
		if Input.is_action_just_pressed("catch"):
			closest_frisbee.is_caught = true
			var catch_hand = catch_hand_template.instance()
			get_tree().get_root().add_child(catch_hand)
			catch_hand.set_target_and_catcher(closest_frisbee, self)
		else:
			closest_frisbee.highlight_this_frame()
