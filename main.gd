#################################################################
#01. tool                                                       #
#03. extends                                                    #
#02. class_name                                                 #
class_name GameState
#03. extends                                                    #

extends Node

#04. # docstring                                                #
#                                                               #
#05. signals                                                    #
#06. enums                                                      #
#07. constants                                                  #
#08. exported variables                                         #
#09. public variables                                           #
#10. private variables                                          #
var main_menu : PackedScene = preload("res://scenes/menues/MainMenu.tscn")
var main : PackedScene = preload("res://scenes/the_park/the_park.tscn")
#11. onready variables                                          #
#                                                               #
#12. optional built-in virtual _init method                     #
#13. built-in virtual _ready method                             #
func _ready():
	var start_scene = main_menu.instance()
	add_child(start_scene)
	
#14. remaining built-in virtual methods                         #
#15. public methods                                             #

#16. private methods                                            #

func _on_startgame(current_scene):
	var main_scene = main.instance()
	current_scene.queue_free()
	add_child(main_scene)

#################################################################
