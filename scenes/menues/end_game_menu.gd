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



#################################################################


func _on_AddScore_pressed():
	$DisplayScore.visible = false 
	$AddScore.visible = true 
	$AddScore/SaveScore.visible = true

func _on_Restart_pressed():
	emit_signal("startgame", self)


func _on_RestartVR_pressed():
	emit_signal("startvr", self)


func _on_SaveScore_pressed():
	var score_entry : Dictionary = {}
	score_entry[get_node("/root/GameData").get("current_score")] = name_label.text
	get_node("/root/GameData").add_highscore(score_entry)
	show_highscore()


func show_highscore():
	$AddScore.visible = false
	$HighScore.visible = true
	$HighScoreExit.visible = true
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
	$HighScore.visible = false
	$HighScoreExit.visible = false
	$DisplayScore.visible = true
	$AddScore/SaveScore.visible = false
