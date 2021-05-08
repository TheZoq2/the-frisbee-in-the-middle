#################################################################
#01. tool                                                       #
#03. extends                                                    #
#02. class_name                                                 #
#class_name %CLASSNAME%
#03. extends                                                    #

extends CanvasLayer

#04. # docstring                                                #
#                                                               #
#05. signals                                                    #
#06. enums                                                      #
#07. constants                                                  #
#08. exported variables                                         #
#09. public variables                                           #
#10. private variables                                          #
var caught_frisbees : int = 0
#11. onready variables                                          #
onready var number_label = get_node("HUD/TextureRect/Panel/HBoxContainer/NR")
#                                                               #
#12. optional built-in virtual _init method                     #
#13. built-in virtual _ready method                             #
func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS

#14. remaining built-in virtual methods                         #
func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		if $GameMenu.visible:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			
			$GameMenu.set("visible", false)
			get_tree().set("paused", false)
		
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			get_tree().set("paused", true)
			$GameMenu.set("visible", true)
#15. public methods                                             #

#16. private methods                                            #



#################################################################


func _on_Catcher_frisbee_caught():
	#print("# I cought one!!! ")
	caught_frisbees += 1
	number_label.text = str(caught_frisbees)


func _on_ResumeButton_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$GameMenu.set("visible", false)
	get_tree().set("paused", false)


func _on_QuitGameButton_pressed():
	get_tree().quit()