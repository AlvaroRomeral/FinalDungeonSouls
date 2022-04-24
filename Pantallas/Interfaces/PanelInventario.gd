extends Panel

signal devolverInfo(id)

export(String,"inv","arma","cabeza","torso","piernas","pies","amuleto") var tipo = "inv"

onready var com_icono = $Icono

var item_posicion

func _ready():
	com_icono.tipo = tipo


func setValores(id, cantidad, index):
	item_posicion = index
	com_icono.setDatos(id, cantidad, index)


func _on_PanelInventario_mouse_entered():
	emit_signal("devolverInfo",com_icono.datos["id"])


func _on_PanelInventario_mouse_exited():
	emit_signal("devolverInfo",null)
