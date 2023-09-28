extends Node2D
class_name ControlEquipo

signal equipo_modificado()

@export var dinero:int = 0
@export var inventario:Array[Slot]
@export var slot_cabeza:Slot
@export var slot_cuerpo:Slot
@export var slot_brazos:Slot
@export var slot_pierna:Slot
@export var slot_arma:Slot
@export var slot_trinket_1:Slot
@export var slot_trinket_2:Slot
@export var slot_trinket_3:Slot
@export var slot_trinket_4:Slot
@export_category("Componentes (no tocar)")
@export var equipamiento_cabeza:Node2D
@export var equipamiento_cuerpo:Node2D
@export var equipamiento_brazos:Node2D
@export var equipamiento_pierna:Node2D
@export var equipamiento_arma:Node2D

func _ready():
	for x in inventario:
		if x != null:
			x.slot_modificado.connect(func(): equipo_modificado.emit())

	slot_cabeza.slot_modificado.connect(func(): equipo_modificado.emit())
	slot_cuerpo.slot_modificado.connect(func(): equipo_modificado.emit())
	slot_brazos.slot_modificado.connect(func(): equipo_modificado.emit())
	slot_pierna.slot_modificado.connect(func(): equipo_modificado.emit())
	slot_arma.slot_modificado.connect(func(): equipo_modificado.emit())
	slot_trinket_1.slot_modificado.connect(func(): equipo_modificado.emit())
	slot_trinket_2.slot_modificado.connect(func(): equipo_modificado.emit())
	slot_trinket_3.slot_modificado.connect(func(): equipo_modificado.emit())
	slot_trinket_4.slot_modificado.connect(func(): equipo_modificado.emit())
	

func item_annadido(id:String, cantidad:int):
	if id == "dinero":
		dinero += cantidad
		equipo_modificado.emit()
		# emit_signal("equipo_modificado")
		return true
	else:
		var item_datos = DatosManager.get_item(id)
		for x in inventario:
			if x.id == id and item_datos.stakable:
				x.cantidad += cantidad
				equipo_modificado.emit()
				return true
			else:
				x.id = id
				x.cantidad = cantidad
				equipo_modificado.emit()
				return true
	return false


# func item_dropeado():
