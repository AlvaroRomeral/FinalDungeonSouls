extends Resource
class_name Slot

signal slot_modificado()

@export var id:String = ""
@export var cantidad:int = 0

func mover_slot(slot_origen:Slot):
	id = slot_origen.id
	cantidad += slot_origen.cantidad
	slot_origen.id = ""
	slot_origen.cantidad = 0
	slot_modificado.emit()