extends Node2D
class_name ControlEquipo

signal equipo_modificado()

@export var dinero:int = 0
@export var inventario:Array[Slot]
@export var slot_cabeza:Slot
@export var slot_cuerpo:Slot
@export var slot_brazos:Slot
@export var slot_piernas:Slot
@export var slot_arma:Slot
@export var slot_trinket_1:Slot
@export var slot_trinket_2:Slot
@export var slot_trinket_3:Slot
@export var slot_trinket_4:Slot
@export var control_estado:ControlEstado
@export_category("Componentes (no tocar)")
@export var sprite_cabeza:Sprite2D
@export var sprite_cuerpo:Sprite2D
@export var sprite_brazos:Sprite2D
@export var sprite_piernas:Sprite2D
@export var sprite_arma:Sprite2D

func _ready():
	for x in inventario:
		if x != null:
			x.slot_modificado.connect(func(): equipo_modificado.emit())

	slot_cabeza.slot_modificado.connect(actualizar_equipo)
	slot_cuerpo.slot_modificado.connect(actualizar_equipo)
	slot_brazos.slot_modificado.connect(actualizar_equipo)
	slot_piernas.slot_modificado.connect(actualizar_equipo)
	slot_arma.slot_modificado.connect(actualizar_equipo)
	slot_trinket_1.slot_modificado.connect(actualizar_equipo)
	slot_trinket_2.slot_modificado.connect(actualizar_equipo)
	slot_trinket_3.slot_modificado.connect(actualizar_equipo)
	slot_trinket_4.slot_modificado.connect(actualizar_equipo)
	

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


func actualizar_equipo():
	if slot_cabeza.id != "":
		sprite_cabeza.texture = load(DatosManager.get_item(slot_cabeza.id).sprite)
	if slot_cuerpo.id != "":
		sprite_cuerpo.texture = load(DatosManager.get_item(slot_cuerpo.id).sprite)
	if slot_brazos.id != "":
		sprite_brazos.texture = load(DatosManager.get_item(slot_brazos.id).sprite)
	if slot_piernas.id != "":
		sprite_piernas.texture = load(DatosManager.get_item(slot_piernas.id).sprite)
	if slot_arma.id != "":
		sprite_arma.texture = load(DatosManager.get_item(slot_arma.id).sprite)
	equipo_modificado.emit()