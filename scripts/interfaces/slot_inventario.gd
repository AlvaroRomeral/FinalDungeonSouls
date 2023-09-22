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
	if slot_ref.id != "":
		if DatosManager.get_item(slot_ref.id):
			var datos_item = DatosManager.get_item(slot_ref.id)
			sprite.texture = load(datos_item.icon)
	else:
		sprite.texture = null


func _get_drag_data(_at_position):
	if slot_ref.id != "":
		var new_control = Control.new()
		var new_icono = TextureRect.new()

		new_icono.texture = sprite.texture
		new_icono.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
		new_icono.position = Vector2(-16,-16)
		new_icono.size = Vector2(32,32)
		new_control.add_child(new_icono)

		set_drag_preview(new_control)

		return slot_ref


func _can_drop_data(_at_position, data):
	if slot_ref.id == "":
		return true
	elif slot_ref.id == data.id:
		return true
	else:
		return false


func _drop_data(_at_position, data):
	slot_ref.mover_slot(data)
	# slot_ref.id = data.id
	# slot_ref.cantidad += data.cantidad
	# data.id = ""
	# data.cantidad = 0
