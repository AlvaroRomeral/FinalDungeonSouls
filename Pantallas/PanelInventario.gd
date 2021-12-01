extends Panel

signal devolverInfo(id)

onready var popupMenu = $PopupMenu
var itemId



func setId(id):
	itemId = id


func setIcono(icono):
	$Icono.texture = load(Global.PATH_ICONOS+icono)


func setCantidad(cantidad):
	$Cantidad.text = String(cantidad)



func _on_PanelSlot_mouse_entered():
	emit_signal("devolverInfo",itemId)


func _on_PanelInventario_gui_input(event):
	if event is InputEventMouseButton:
		pass
