extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var next_frisbee = 0;
var next_direction_change = 0;
var direction = Vector3(0, 0, 0);

var frisbee_template = preload("res://scenes/frisbee.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	self.new_velocity()
	self.throw_frisbee()

func new_velocity():
	var move_angle = randf() * 2*PI
	self.rotation = Vector3(0, move_angle, 0)

	self.direction = self.transform.basis.z
	self.next_direction_change = rand_range(1, 10)

func throw_frisbee():
	var frisbee = frisbee_template.instance()
	frisbee.transform.origin = self.get_node("frisbee_origin").transform.origin
	get_parent().call_deferred("add_child", frisbee)
	self.next_frisbee = rand_range(1, 5);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.next_direction_change -= delta
	self.next_frisbee -= delta

	# print(self.next_frisbee)

	if self.next_frisbee < 0:
		self.throw_frisbee()

	if self.next_direction_change < 0:
		self.new_velocity()

	if self.move_and_collide(Vector3(self.direction * delta)):
		pass
