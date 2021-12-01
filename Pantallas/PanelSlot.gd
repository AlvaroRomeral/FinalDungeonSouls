extends Panel

signal devolverInfo(id)
var itemId


func _ready():
	pass


func setId(id):
	itemId = id


func setIcono(icono):
	$Icono.texture = load(Global.pathIconos+icono)


func setCantidad(cantidad):
	$Cantidad.text = String(cantidad)



func _on_PanelSlot_mouse_entered():
	emit_signal("devolverInfo",itemId)
