extends Control
class_name SlotInventario

enum tipos {
	NORMAL,
	CABEZA,
	CUERPO,
	BRAZOS,
	PIERNA,
	ARMA,
}

@export var tipo:tipos = tipos.NORMAL
@export_category("Componentes (no tocar)")
@export var sprite_icono:TextureRect
@export var sprite_fondo:TextureRect

var slot_ref:Slot

func _ready():
	if slot_ref:
		actualizar()
	match tipo:
		0:
			sprite_fondo.texture = load("res://assets/imagenes/interfaces/slot_fondo_normal.png")
		1:
			sprite_fondo.texture = load("res://assets/imagenes/interfaces/slot_fondo_cabeza.png")
		2:
			sprite_fondo.texture = load("res://assets/imagenes/interfaces/slot_fondo_cuerpo.png")
		3:
			sprite_fondo.texture = load("res://assets/imagenes/interfaces/slot_fondo_brazos.png")
		4:
			sprite_fondo.texture = load("res://assets/imagenes/interfaces/slot_fondo_pierna.png")
		5:
			sprite_fondo.texture = load("res://assets/imagenes/interfaces/slot_fondo_arma.png")


func actualizar():
	if slot_ref.id != "":
		if DatosManager.get_item(slot_ref.id):
			var datos_item = DatosManager.get_item(slot_ref.id)
			sprite_icono.texture = load(datos_item.icon)
	else:
		sprite_icono.texture = null


func _get_drag_data(_at_position):
	if slot_ref.id != "":
		var new_control = Control.new()
		var new_icono = TextureRect.new()

		new_icono.texture = sprite_icono.texture
		new_icono.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
		new_icono.position = Vector2(-16,-16)
		new_icono.size = Vector2(32,32)
		new_control.add_child(new_icono)

		set_drag_preview(new_control)

		return slot_ref


func _can_drop_data(_at_position, data):
	if slot_ref != data:
		return true
	elif tipo == tipos.NORMAL:
		return true
	else:
		return false


func _drop_data(_at_position, data):
	slot_ref.mover_slot(data)
