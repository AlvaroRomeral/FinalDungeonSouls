extends TextureRect

signal item_droped

var item_id = null
var cantidad = 0

func _ready():
	pass


func get_drag_data(position):
#	if item_id != null:
		var data = {}
		var imagen = Sprite.new()
		imagen.texture = load(Global.PATH_ICONOS + Datos.getItemInfo(item_id)["icono"])
		
		var control = Control.new()
		control.add_child(imagen)
		set_drag_preview(control)
		
		return data


func can_drop_data(position, data):
	return true
	return false


func drop_data(position, data):
	pass
