#################################################################
#01. tool                                                       #
#03. extends                                                    #
#02. class_name                                                 #
#class_name %CLASSNAME%
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
#                                                               #
#12. optional built-in virtual _init method                     #
#13. built-in virtual _ready method                             #
func _ready():
	connect("startgame", get_parent(), "_on_startgame")
	connect("startvr", get_parent(), "_on_startvr")
#14. remaining built-in virtual methods                         #
#15. public methods                                             #

#16. private methods                                            #



#################################################################


func _on_TextureButton_pressed():
	emit_signal("startgame", self)

func _on_startvr_pressed():
	emit_signal("startvr", self)
