extends Control

onready var slot = preload("res://Pantallas/PanelSlot.tscn")

func _ready():
	pass


func _on_Inventario_draw():
	generarSlots()


func generarSlots():
	for i in $Panel/GridContainer.get_children():
		i.queue_free()
		print("borrado")
	for i in DatosJugador.inventario:
		print("anyadido")
		var itemNuevo = slot.instance()
		$Panel/GridContainer.call_deferred("add_child",itemNuevo)
		itemNuevo.setIcono(i["icono"])
		itemNuevo.setCantidad(i["cantidad"])
