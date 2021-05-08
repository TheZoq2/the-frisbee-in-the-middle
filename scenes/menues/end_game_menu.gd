#################################################################
#01. tool                                                       #
#03. extends                                                    #
#02. class_name                                                 #
class_name EndGameMenu
#03. extends                                                    #

extends Control

#04. # docstring                                                #
#                                                               #
#05. signals                                                    #
signal startgame
signal startvr
#06. enums                                                      #
#07. constants                                                  #
#08. exported variables                                         #
#09. public variables                                           #
#10. private variables                                          #
#11. onready variables                                          #
onready var score_label = $DisplayScore/ScoreLabel
onready var add_score_label = $AddScore/ScoreLabel
onready var name_label = $AddScore/NameInput
#                                                               #
#12. optional built-in virtual _init method                     #
#13. built-in virtual _ready method                             #
func _ready():
	var parent = get_parent()
	connect("startgame", parent, "_on_startgame")
	connect("startvr", parent, "_on_startvr")
	score_label.text = str(get_node("/root/GameData").get("current_score"))
	add_score_label.text = score_label.text
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
#14. remaining built-in virtual methods                         #
#15. public methods                                             #

#16. private methods                                            #
func _toggle_state():
	$DisplayScore.visible = !$DisplayScore.visible
	$AddScore.visible = !$AddScore.visible


#################################################################


func _on_AddScore_pressed():
	_toggle_state()

func _on_Restart_pressed():
	emit_signal("startgame", self)


func _on_RestartVR_pressed():
	emit_signal("startvr", self)


func _on_SaveScore_pressed():
	pass





