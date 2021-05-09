extends Area
class_name Catcher

signal frisbee_caught
signal children_despawn

var catch_hand_template = preload("res://scenes/catch_hand.tscn")
var vr_catch_pressed = false

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
			closest_frisbee.stop_sound()
			var catch_hand = catch_hand_template.instance()
			connect("children_despawn", catch_hand, "_on_children_despawn")
			get_tree().get_root().add_child(catch_hand)
			catch_hand.set_target_and_catcher(closest_frisbee, self)
		elif vr_catch_pressed:
			closest_frisbee.queue_free()
			get_node("/root/GameData").current_score += 1
		else:
			closest_frisbee.highlight_this_frame()
	vr_catch_pressed = false


func _on_Catcher_body_exited(body):
	if body is Frisbee:
		body.play_sound()


func _on_Catcher_body_entered(body):
	if body is Frisbee:
		body.stop_sound()


func _on_vr_catch_input():
	vr_catch_pressed = true

func _exit_tree():
	emit_signal("children_despawn")
