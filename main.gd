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
var vr_end_game_menu : PackedScene = preload("res://scenes/VR/vr_end_game.tscn")
var end_game_menu : PackedScene = preload("res://scenes/menues/end_game_menu.tscn")
var is_vr : bool = false

var last_scene
#11. onready variables                                          #
#                                                               #
#12. optional built-in virtual _init method                     #
#13. built-in virtual _ready method                             #
func _ready():
	self.set_scene(main_menu.instance())
	
#14. remaining built-in virtual methods                         #
#15. public methods                                             #

#16. private methods                                            #

func set_scene(new_scene):
	if self.last_scene:
		self.last_scene.queue_free()
	add_child(new_scene)
	self.last_scene = new_scene

func _on_startgame():
	get_node("/root/GameData").on_restart()
	self.set_scene(main.instance())
	is_vr = false
	get_tree().paused = false

func _on_startvr():
	get_node("/root/GameData").on_restart()

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

		is_vr = true
		self.set_scene(main.instance())
		get_tree().paused = false
	else:
		print("OpenVR did not start correctly")

func game_over():
	get_tree().paused = true
	restart()
	
func restart():
	# if is_vr:
		# _on_startvr(current_scene)
	# else:
	enter_end_game_menu()


func enter_end_game_menu():
	var end_menu = end_game_menu.instance()
	if is_vr:
		end_menu = vr_end_game_menu.instance()

	self.set_scene(end_menu)
	get_tree().paused = false
	
		#_on_startgame(current_scene)
#################################################################































