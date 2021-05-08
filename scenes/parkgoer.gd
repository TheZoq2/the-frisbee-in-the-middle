extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var next_frisbee = 0;
var next_direction_change = 0;
var direction = Vector3(0, 0, 0);

var frisbee_template = preload("res://scenes/frisbee.tscn")

var is_throwing = false
var has_thrown = false
var animation_position_to_throw = 1.0

# TODO: Adjust these for non-VR 
var player_too_close = 5;
var player_too_far = 10;


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	self.new_velocity()
	self.throw_frisbee()
	$person/AnimationPlayer.play("walk")

func new_velocity():
	var move_angle = randf() * 2*PI

	var player = get_parent().player;
	if player:
		var player_pos = player.get_position();
		var player_direction = (player_pos - self.global_transform.origin);

		var distance = player_direction.length()
		player_direction = player_direction.normalized()

		if distance > player_too_far:
			move_angle = atan2(player_direction.x, player_direction.z);
		elif distance < player_too_close:
			move_angle = atan2(-player_direction.x, -player_direction.z);

	self.rotation = Vector3(0, move_angle, 0)

	self.direction = self.transform.basis.z
	self.next_direction_change = rand_range(1, 10)
	
func start_throw():
	$person/AnimationPlayer.play("throw")
	is_throwing = true
	has_thrown = false

func throw_frisbee():
	var frisbee = frisbee_template.instance()
	frisbee.transform.origin = self.get_node("frisbee_origin").global_transform.origin
	get_parent().call_deferred("add_child", frisbee)
	$AudioStreamPlayer3D.play()
	self.next_frisbee = rand_range(1, 5)
	self.has_thrown = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not is_throwing:
		self.next_direction_change -= delta
		self.next_frisbee -= delta
		
		if self.next_frisbee < 0:
			self.start_throw()

		if self.next_direction_change < 0:
			self.new_velocity()

		if self.move_and_collide(Vector3(self.direction * delta)):
			pass

		if not $person/AnimationPlayer.is_playing():
			$person/AnimationPlayer.play("walk")
	else:
		var anim_pos = $person/AnimationPlayer.current_animation_position 
		if not self.has_thrown and anim_pos > animation_position_to_throw:
			self.throw_frisbee()

		if not $person/AnimationPlayer.is_playing():
			$person/AnimationPlayer.play("walk")
			self.is_throwing = false
