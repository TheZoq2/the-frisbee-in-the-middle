extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var since_direction_change = 0;
var rng = RandomNumberGenerator.new()
var direction = Vector3(0, 0, 0);


# Called when the node enters the scene tree for the first time.
func _ready():
	self.new_velocity()

func new_velocity():
	since_direction_change = 0

	var move_angle = rng.randf() * 2*PI;

	self.direction = Vector3(cos(move_angle), 0, sin(move_angle))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	since_direction_change += delta

	if since_direction_change > randf() * 5 + 5:
		self.new_velocity()


	if self.move_and_collide(Vector3(self.direction * delta)):
		pass
