extends Control
class_name PanelInventario

const slot = preload("res://interfaces/componentes/slot_inventario.tscn")

@export var interfaz:PantallaInterfaz
@export_category("Componentes (no tocar)")
@export var grid:GridContainer
@export var label_dinero:Label

func _ready():
	actualizar()


func actualizar():
	for x in grid.get_children():
		x.queue_free()
	for x in interfaz.jugador.control_equipo.inventario:
		var new_slot = slot.instantiate()
		new_slot.slot_ref = x
		grid.add_child(new_slot)
	label_dinero.text = str(interfaz.jugador.control_equipo.dinero)
