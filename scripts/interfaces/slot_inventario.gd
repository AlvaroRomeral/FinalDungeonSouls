extends Control
class_name SlotInventario

enum tipos {
	INVENTARIO,
	EQUIPO_CABEZA,
	EQUIPO_CUERPO,
	EQUIPO_BRAZOS,
	EQUIPO_PIERNAS,
	EQUIPO_ARMA,
	EQUIPO_TRINKET,
}

@export var tipo:tipos = tipos.INVENTARIO
@export_category("Componentes (no tocar)")
@export var sprite_fondo:TextureRect
@export var sprite_icono:TextureRect
@export var sprite_borde:TextureRect

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
		6:
			sprite_fondo.texture = load("res://assets/imagenes/interfaces/slot_fondo_trinkets.png")


func actualizar():
	if slot_ref.id != "" and slot_ref.cantidad > 0:
		if DatosManager.get_item(slot_ref.id):
			var datos_item = DatosManager.get_item(slot_ref.id)
			sprite_icono.texture = load(datos_item.icon)
			match str(datos_item.rareza):
				"1":
					sprite_borde.texture = load("res://assets/imagenes/interfaces/slot_borde_comun.png")
				"2":
					sprite_borde.texture = load("res://assets/imagenes/interfaces/slot_borde_raro.png")
				"3":
					sprite_borde.texture = load("res://assets/imagenes/interfaces/slot_borde_epico.png")
				"4":
					sprite_borde.texture = load("res://assets/imagenes/interfaces/slot_borde_legendario.png")
	else:
		sprite_icono.texture = null
		sprite_borde.texture = load("res://assets/imagenes/interfaces/slot_borde_comun.png")


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

		return {
			"ref": slot_ref,
			"slot": self
		}


func _can_drop_data(_at_position, data):
	if slot_ref == data.ref: #Si es el mismo slot
		return false
	
	elif slot_ref.is_vacio(): #Si el slot esta vacio
		if tipo == 0: #Si el destino es slot de inventario
			return true
		else: #Si el destino es slot de equipo
			var datos = DatosManager.get_item(data.ref.id)
			match datos.tipo:
				"cabeza":
					if tipo == tipos.EQUIPO_CABEZA:
						return true
					else:
						return false
				"cuerpo":
					if tipo == tipos.EQUIPO_CUERPO:
						return true
					else:
						return false
				"brazos":
						if tipo == tipos.EQUIPO_BRAZOS:
							return true
						else:
							return false
				"piernas":
					if tipo == tipos.EQUIPO_PIERNAS:
						return true
					else:
						return false
				"arma":
					if tipo == tipos.EQUIPO_ARMA:
						return true
					else:
						return false
				"trinket":
					if tipo == tipos.EQUIPO_TRINKET:
						return true
					else:
						return false
			return false

	else: #Si se va a sustituir
		if tipo == 0: #Si el destino es slot de inventario
			var datos = DatosManager.get_item(slot_ref.id)
			match data.slot.tipo: #Dependiendo de el tipo de origen
				0:
					return true
				1:
					if datos.tipo == "cabeza":
						return true
					else:
						return false
				2:
					if datos.tipo == "cuerpo":
						return true
					else:
						return false
				3:
					if datos.tipo == "brazos":
						return true
					else:
						return false
				4:
					if datos.tipo == "piernas":
						return true
					else:
						return false
				5:
					if datos.tipo == "arma":
						return true
					else:
						return false
				6:
					if datos.tipo == "trinket":
						return true
					else:
						return false
		else: #Si el destino es slot de equipo
			var datos = DatosManager.get_item(data.ref.id)
			match datos.tipo:
				"cabeza":
					if tipo == tipos.EQUIPO_CABEZA:
						return true
					else:
						return false
				"cuerpo":
					if tipo == tipos.EQUIPO_CUERPO:
						return true
					else:
						return false
				"brazos":
						if tipo == tipos.EQUIPO_BRAZOS:
							return true
						else:
							return false
				"piernas":
					if tipo == tipos.EQUIPO_PIERNAS:
						return true
					else:
						return false
				"arma":
					if tipo == tipos.EQUIPO_ARMA:
						return true
					else:
						return false
				"trinket":
					if tipo == tipos.EQUIPO_TRINKET:
						return true
					else:
						return false
			return false
	return false


func _drop_data(_at_position, data):
	slot_ref.mover_slot(data.ref)


# func posible_convinacion(origen, destino):
# 	pass
