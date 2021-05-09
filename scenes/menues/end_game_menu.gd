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

#12. optional built-in virtual _init method                     #
#13. built-in virtual _ready method                             #
func _ready():
# warning-ignore:return_value_discarded
	connect("startgame", get_node("/root/GameState"), "_on_startgame")
# warning-ignore:return_value_discarded
	connect("startvr", get_node("/root/GameState"), "_on_startvr")
	score_label.text = str(get_node("/root/GameData").get("current_score"))
	add_score_label.text = score_label.text
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
#14. remaining built-in virtual methods                         #
#15. public methods                                             #

#16. private methods                                            #



#################################################################


func _input(_event):
	if Input.is_action_just_pressed("ui_accept"):
		if $AddScore.visible:
			_on_SaveScore_pressed()
		elif $HighScoreExit.visible:
			_on_HighScoreExit_pressed()


func _on_AddScore_pressed():
	$DisplayScore.hide()
	$AddScore.show()
	$AddScore/SaveScore.show()
	$AddScore/NameInput.grab_focus()

func _on_Restart_pressed():
	emit_signal("startgame")


func _on_RestartVR_pressed():
	emit_signal("startvr")


func _on_SaveScore_pressed():
	var score_entry : Dictionary = {}
	var user_name = name_label.text
	if user_name == "" or user_name == null:
		user_name = name_label.get_placeholder() 
	score_entry[get_node("/root/GameData").get("current_score")] = user_name
	get_node("/root/GameData").add_highscore(score_entry)
	show_highscore()


func show_highscore():
	$AddScore.hide()
	$HighScore.show()
	$HighScoreExit.show()
	refresh_highscore()


func refresh_highscore():
	$HighScore.clear()
	for i in range(10):
		#print("i: ", i)
		#print(get_node("/root/GameData").highscore_data.size())
		if get_node("/root/GameData").highscore_data.size() - 1 >= i:
			var score : Dictionary = get_node("/root/GameData").highscore_data[i]
			#print("score: ", score)
			$HighScore.add_item(str(score.keys()[0]), null, false)
			$HighScore.add_item(score.values()[0], null, false)
		else:
			break


func _on_HighScoreExit_pressed():
	$HighScore.hide()
	$HighScoreExit.hide()
	$DisplayScore.show()
	$AddScore/SaveScore.hide()


func _on_QuitGame_pressed():
	get_tree().quit()
