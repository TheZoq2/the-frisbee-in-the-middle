#################################################################
#01. tool                                                       #
#03. extends                                                    #
#02. class_name                                                 #
#class_name %CLASSNAME%
#03. extends                                                    #

extends Node

#04. # docstring                                                #
#                                                               #
#05. signals                                                    #
#06. enums                                                      #
#07. constants                                                  #
const HIGHSCORE : String = "user://high_score.json"
#08. exported variables                                         #
#09. public variables                                           #
#10. private variables                                          #
var current_score : int = 0
"""
{
	score : username
}
"""
var highscore_data : Dictionary = {}
#11. onready variables                                          #
#                                                               #
#12. optional built-in virtual _init method                     #
#13. built-in virtual _ready method                             #
func _ready():
	highscore_data = self._get_highscore_data()
#14. remaining built-in virtual methods                         #
#15. public methods                                             #
func save_data(data : Dictionary, path : String) -> void:
	var file : File = File.new()
	file.open(path, File.WRITE)
	file.store_line(to_json(data))
	file.close()
#16. private methods                                            #

func _get_highscore_data() -> Dictionary:
	var file : File = File.new()
	if not file.file_exists(HIGHSCORE):
		save_data(highscore_data, HIGHSCORE)
	file.open(HIGHSCORE, File.READ)
	var file_content = file.get_as_text()
	var data = parse_json(file_content)
	file.close()
	return data

#################################################################
