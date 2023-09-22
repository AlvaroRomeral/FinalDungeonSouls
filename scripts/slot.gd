extends Resource
class_name Slot

signal slot_modificado()

@export var id:String = ""
@export var cantidad:int = 0

func mover_slot(slot_origen:Slot):
	if slot_origen.id == id:
		id = slot_origen.id
		cantidad += slot_origen.cantidad
		slot_origen.id = ""
		slot_origen.cantidad = 0
		slot_modificado.emit()
	elif slot_origen.id != id:
		var new_id = slot_origen.id
		var new_cantidad = slot_origen.cantidad
		slot_origen.id = id
		slot_origen.cantidad = cantidad
		id = new_id
		cantidad += new_cantidad
		slot_modificado.emit()