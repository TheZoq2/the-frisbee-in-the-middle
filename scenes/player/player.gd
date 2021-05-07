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
#06. enums                                                      #
#07. constants                                                  #
#08. exported variables                                         #
export var move_speed : float = 10.0
export var max_speed : float = 20.0
export var gravity : float = -0.80
export var jump_impulse : float =  20.0


#09. public variables                                           #
#10. private variables                                          #
var input_direction : Vector3 = Vector3.ZERO
var rotation_speed_factor : float = 5.0
var velocity : Vector3 = Vector3.ZERO




#11. onready variables                                          #
#                                                               #
#12. optional built-in virtual _init method                     #
#13. built-in virtual _ready method                             #

#14. remaining built-in virtual methods                         #
func _input(event: InputEvent) -> void:

    input_direction = Vector3(
        Input.get_action_strength("Move_Right") - Input.get_action_strength("Move_Left"),
        event.is_action_pressed("Jump"),
        Input.get_action_strength("Move_Backwards") - Input.get_action_strength("Move_Forward")
    )
 


func _physics_process(delta: float) -> void:
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

    print(velocity)
    velocity = move_and_slide(velocity, Vector3.UP, true,  4, 0.785398, false)



#15. public methods                                             #

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
