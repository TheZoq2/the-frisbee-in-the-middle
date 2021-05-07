extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var last_frisbee = 10;
var since_direction_change = 10;
var rng = RandomNumberGenerator.new()
var direction = Vector3(0, 0, 0);

var frisbee_template = preload("res://scenes/frisbee.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	self.new_velocity()
	self.throw_frisbee()

func new_velocity():
	since_direction_change = 0

	var move_angle = rng.randf() * 2*PI;

	self.direction = Vector3(cos(move_angle), 0, sin(move_angle))

func throw_frisbee():
	var frisbee = frisbee_template.instance()
	get_tree().get_root().add_child(frisbee)
	frisbee.global_transform.origin = self.get_node("frisbee_origin").global_transform.origin
	self.last_frisbee = 0;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.since_direction_change += delta
	self.last_frisbee += delta

	if since_direction_change > randf() * 5 + 5:
		self.new_velocity()

	if last_frisbee > randf() * 5 + 5:
		self.throw_frisbee()

	if self.move_and_collide(Vector3(self.direction * delta)):
		pass
