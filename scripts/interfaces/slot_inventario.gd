extends Control
class_name SlotInventario

enum tipos {
	NORMAL,
	CABEZA,
	CUERPO,
	BRAZOS,
	PIERNA,
}

@export var tipo:tipos = tipos.NORMAL
@export_category("Componentes (no tocar)")
@export var sprite:TextureRect

var slot_ref:Slot

func _ready():
	if slot_ref:
		actualizar()


func actualizar():
	if slot_ref.id != null:
		if DatosManager.get_item(slot_ref.id):
			var datos_item = DatosManager.get_item(slot_ref.id)
			sprite.texture = load(datos_item.icon)
	else:
		sprite.texture = null


func _get_drag_data(_at_position):
	pass


func _can_drop_data(_at_position, data):
	if slot_ref.id == "":
		return true
	elif slot_ref.id == data["slot_red"].id:
		return true
	else:
		return false


func _drop_data(_at_position, data):
	slot_ref.id = data["slot_red"].id
