#################################################################
#01. tool                                                       #
#03. extends                                                    #
#02. class_name                                                 #
class_name Player
#03. extends                                                    #

extends KinematicBody

#04. # docstring                                                #
#                                                               #
#05. signals                                                    #
signal update_treat_count

#06. enums                                                      #
#07. constants                                                  #
#08. exported variables                                         #
export var move_speed : float = 10.0
export var max_speed : float = 20.0
export var gravity : float = -0.80
export var jump_impulse : float =  20.0
export var throw_impulse : float = 5.0
export var max_num_treats : int = 5

#09. public variables                                           #


#10. private variables                                          #
var input_direction : Vector3 = Vector3.ZERO
var rotation_speed_factor : float = 5.0
var velocity : Vector3 = Vector3.ZERO
var remaining_treats: int = max_num_treats

var treat_template = preload("res://scenes/treat.tscn")
var throw_action_pressed = false




#11. onready variables                                          #
#                                                               #
#12. optional built-in virtual _init method                     #
#13. built-in virtual _ready method                             #
func _ready():
# warning-ignore:return_value_discarded
	$Catcher.connect("frisbee_caught", get_node("../GUI"), "_on_Catcher_frisbee_caught")
# warning-ignore:return_value_discarded
	self.connect("update_treat_count", get_node("../GUI"), "_on_Player_update_treat_count")
	emit_signal("update_treat_count", remaining_treats)
	
#14. remaining built-in virtual methods                         #
func _input(event: InputEvent) -> void:

	input_direction = Vector3(
		Input.get_action_strength("Move_Right") - Input.get_action_strength("Move_Left"),
		event.is_action_pressed("Jump"),
		Input.get_action_strength("Move_Backwards") - Input.get_action_strength("Move_Forward")
	)

	if event.is_action_pressed("throw"):
		throw_action_pressed = true

 
func throw_treat():
	var treat = treat_template.instance()
	treat.transform.origin = self.get_node("TreatOrigin").global_transform.origin
	get_parent().add_child(treat)
	var direction = -self.global_transform.basis.z * throw_impulse
	treat.apply_central_impulse(direction)
	remaining_treats -= 1
	throw_action_pressed = false
	emit_signal("update_treat_count", remaining_treats)

func _physics_process(_delta: float) -> void:
	#take input
	#var input := whatever
	#print("Mainstate_physics")
	var forwards_vec : Vector3 
	var tan_to_forw : Vector3 
	
	
	#self.rotate_y(input_direction.x * rotation_speed_factor * delta) 
	forwards_vec = self.global_transform.basis.z * input_direction.z
	tan_to_forw = self.global_transform.basis.x * input_direction.x
	var heading := forwards_vec  + tan_to_forw

	if heading.length() > 1.0:
		heading = heading.normalized()
	heading.y = 0

	velocity = calculate_velocity(heading)

	# print(velocity)
	velocity = move_and_slide(velocity, Vector3.UP, true,  4, 0.785398, false)
	
	if throw_action_pressed and remaining_treats > 0:
		throw_treat()



#15. public methods                                             #

func get_position():
	return self.global_transform.origin

#16. private methods                                            #

func calculate_velocity(move_direction : Vector3) -> Vector3:
	# find bew speed
	var new_vel : Vector3 = move_direction * (move_speed + ( max_speed - move_speed) * Input.get_action_strength("L_Shift"))
	if new_vel.length() > max_speed:
		new_vel = new_vel.normalized() * max_speed
	#apply gravity
	
	new_vel.y *= jump_impulse
	new_vel.y += gravity
	return new_vel 
	

#################################################################
