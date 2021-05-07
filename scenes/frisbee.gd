extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var gravity_compensation = 9.6;


# Called when the node enters the scene tree for the first time.
func _ready():
	self.apply_central_impulse(Vector3(3, 0, 0))
	self.add_torque(Vector3(0, 100, 0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.apply_central_impulse(Vector3(0, gravity_compensation * delta, 0))
