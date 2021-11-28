extends Panel


func _ready():
	pass


func setIcono(icono):
	$Icono.texture = load(Global.pathIconos+icono)


func setCantidad(cantidad):
	$Cantidad.text = String(cantidad)
