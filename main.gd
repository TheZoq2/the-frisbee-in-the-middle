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
var end_game_menu : PackedScene = preload("res://scenes/menues/end_game_menu.tscn")
var is_vr : bool = false
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
	current_scene.queue_free()
	var main_scene = main.instance()
	is_vr = false
	add_child(main_scene)
	get_tree().paused = false

func _on_startvr(current_scene):
	var interface = ARVRServer.find_interface("OpenVR")
	if interface and interface.initialize():
		# turn to ARVR mode
		get_viewport().arvr = true

		# keep linear color space, not needed with the GLES2 renderer
		get_viewport().keep_3d_linear = true

		# make sure vsync is disabled or we'll be limited to 60fps
		OS.vsync_enabled = false
		
		# up our physics to 90fps to get in sync with our rendering
		Engine.iterations_per_second = 90

		var main_scene = main.instance()
		is_vr = true
		current_scene.queue_free()
		add_child(main_scene)
		get_tree().paused = false
	else:
		print("OpenVR did not start correctly")

func game_over():
	get_tree().paused = true
	var current_scene = get_child(1)
	restart(current_scene)
	
func restart(current_scene):
	if is_vr:
		_on_startvr(current_scene)
	else:
		end_game_menu(current_scene)

func end_game_menu(current_scene):
	var end_menu = end_game_menu.instance()
	current_scene.queue_free()
	get_tree().paused = false
	add_child(end_menu)
	
		#_on_startgame(current_scene)
#################################################################































