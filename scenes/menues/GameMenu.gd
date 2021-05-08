#################################################################
#01. tool                                                       #
#03. extends                                                    #
#02. class_name                                                 #
class_name GameMenu
#03. extends                                                    #

extends Control

#04. # docstring                                                #
#                                                               #
#05. signals                                                    #
#06. enums                                                      #
#07. constants                                                  #
#08. exported variables                                         #
#09. public variables                                           #
#10. private variables                                          #
#11. onready variables                                          #
onready var quit_button = $ColorRect/MarginContainer/VBoxContainer/Control2/QuitButton
onready var resume_button = $ColorRect/MarginContainer/VBoxContainer/Control/ResumeButton

#                                                               #
#12. optional built-in virtual _init method                     #
#13. built-in virtual _ready method                             #
func _ready():
	quit_button.connect("pressed", get_parent(), "_on_QuitGameButton_pressed")
	resume_button.connect("pressed", get_parent(), "_on_ResumeButton_pressed")
#14. remaining built-in virtual methods                         #
#15. public methods                                             #

#16. private methods                                            #



#################################################################
