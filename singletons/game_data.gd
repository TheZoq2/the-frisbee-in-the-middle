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
var current_score : int
export var game_time : int
"""
{
	score : username
}
"""
var highscore_data : Array = []

export var max_num_treats : int = 5
var remaining_treats: int = max_num_treats

#11. onready variables                                          #
#                                                               #
#12. optional built-in virtual _init method                     #
#13. built-in virtual _ready method                             #
func _ready():
	highscore_data = self._get_highscore_data()
	self.on_restart()

#14. remaining built-in virtual methods                         #
#15. public methods                                             #
func save_data(data : Array, path : String) -> void:
	print("saving data")
	var file : File = File.new()
	var result = file.open(path, File.WRITE)
	if result == OK:
		file.store_line(to_json(data))
	file.close()

func on_restart():
	self.game_time = 60
	self.current_score = 0
	self.remaining_treats = max_num_treats

func add_highscore(score_entry : Dictionary):
	print("adding highscore")
	if highscore_data.empty():
		highscore_data.push_back(score_entry)
	elif int(highscore_data[0].keys()[0]) < score_entry.keys()[0]:
		highscore_data.push_front(score_entry)
	else:
		highscore_data.push_back(score_entry)
		highscore_data.sort_custom(self, "custom_sort")
		print("add highscore: ", highscore_data)
	save_data(highscore_data, HIGHSCORE)
#16. private methods                                            #

func _get_highscore_data() -> Array:
	var data = []
	var file : File = File.new()
	if not file.file_exists(HIGHSCORE):
		save_data(highscore_data, HIGHSCORE)
	var result = file.open(HIGHSCORE, File.READ)
	if result == OK:
		var file_content = file.get_as_text()
		data = parse_json(file_content)
	#print(data)
	file.close()
	return data


func custom_sort(a : Dictionary, b : Dictionary):
	return int(a.keys()[0]) > int(b.keys()[0])
#################################################################
