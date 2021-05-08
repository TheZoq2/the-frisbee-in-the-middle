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
#06. enums                                                      #
#07. constants                                                  #
#08. exported variables                                         #
#09. public variables                                           #
#10. private variables                                          #
#11. onready variables                                          #
onready var score_label = $DisplayScore/ScoreLabel
onready var add_score_label = $AddScore/ScoreLabel
#                                                               #
#12. optional built-in virtual _init method                     #
#13. built-in virtual _ready method                             #
func _ready():
	score_label.text = str(get_node("/root/GameData").get("current_score"))
#14. remaining built-in virtual methods                         #
#15. public methods                                             #

#16. private methods                                            #



#################################################################


func _on_AddScore_pressed():
	pass # Replace with function body.


func _on_Restart_pressed():
	pass # Replace with function body.


func _on_RestartVR_pressed():
	pass # Replace with function body.
