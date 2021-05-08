extends Spatial

var parent

onready var BoomYRot = get_node("BoomYRot")
onready var BoomXRot = get_node("BoomYRot/BoomXRot")
onready var BOOM_CAM_SEP = get_node("BoomYRot/BoomXRot/BOOM_CAM_SEP")
onready var CameraXRot = get_node("BoomYRot/BoomXRot/BOOM_CAM_SEP/CameraY_Rotator/CameraX_Rotator")
onready var CameraYRot = get_node("BoomYRot/BoomXRot/BOOM_CAM_SEP/CameraY_Rotator")
onready var Cam = get_node("BoomYRot/BoomXRot/BOOM_CAM_SEP/CameraY_Rotator/CameraX_Rotator/Camera")


var camera_sensitivity := 0.1
var camera_zoom_sensitivity := 0.1
############################     ######     #      ###  ###
######  Camera Control #####     ##        # #     #  ##  #
############################     ##       #####    #      #
############################     ######  #     #   #      #
func _ready():
	parent = get_parent()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	assert(parent != null, "CamController needs a parent")
	#assert(parent.rotate_camera != null && parent.mouse_right != null, "parent has to have the variables mouse_right and rotate_camera")
	

func _input(event: InputEvent) -> void:

	if event is InputEventMouseMotion:
		
		get_parent().rotate_y(deg2rad(-event.relative.x) * self.camera_sensitivity)
			
		self.BoomXRot.rotate_x(deg2rad(event.relative.y) * self.camera_sensitivity)
		self.BoomXRot.rotation_degrees.x = clamp(self.BoomXRot.rotation_degrees.x, -90, 90) 



