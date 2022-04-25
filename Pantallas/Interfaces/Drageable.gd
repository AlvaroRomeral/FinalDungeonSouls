extends TextureRect

signal item_dropeado(datos)

var tipo

var datos = {
	"id" : null,
	"cantidad" : 0,
	"index" : -1,
	"icono" : texture,
	"origen" : self,
	"tipo" : tipo
}

func _ready():
	pass


func setDatos(id, cantidad, index):
	datos["id"] = id
	datos["cantidad"] = cantidad
	datos["index"] = index
	updateAspecto()


func updateAspecto():
	if datos["id"] == null:
		texture = null
		$Cantidad.visible = false
	else:
		texture = load(Global.PATH_ICONOS + Datos.getItemInfo(datos["id"])["icono"])
		if datos["cantidad"] > 1:
			$Cantidad.visible = true


func get_drag_data(position):
	if datos["id"] != null:
		var datos_exportados = datos.duplicate()
		
		var imagen = Sprite.new()
		imagen.texture = texture
		var control = Control.new()
		control.add_child(imagen)
		set_drag_preview(control)
		
#		datos["id"] = null
#		datos["cantidad"] = 0
#		updateAspecto()
		
		return datos_exportados


func can_drop_data(position, data):
	var item_tipo = Datos.getItemTipo(data["id"])
	match tipo:
		"inv":
			return true
		"arma":
			if item_tipo != "arma":
				return false
			return true
		"cabeza":
			if item_tipo != "cabeza":
				return false
			return true
		"torso":
			if item_tipo != "torso":
				return false
			return true
		"piernas":
			if item_tipo != "piernas":
				return false
			return true
		"pies":
			if item_tipo != "pies":
				return false
			return true
		"amuleto":
			if item_tipo != "amuleto":
				return false
			return true
	return false


func drop_data(position, data):
	match data["origen"].tipo:
		"inv":
			Jugador.inventario[data["index"]] = {
				"id" : null,
				"cantidad" : null
			}
		"arma":
			Jugador.equipamiento["arma"] = null
		"cabeza":
			Jugador.equipamiento["cabeza"] = null
			pass
		"torso":
			Jugador.equipamiento["torso"] = null
			pass
		"piernas":
			Jugador.equipamiento["piernas"] = null
			pass
		"pies":
			Jugador.equipamiento["pies"] = null
			pass
		"amuleto1":
			Jugador.equipamiento["amuleto1"] = null
			pass
	match tipo:
		"inv":
			Jugador.inventario[datos["index"]]["id"] = data["id"]
			Jugador.inventario[datos["index"]]["cantidad"] = data["cantidad"]
		"arma":
			Jugador.equipamiento["arma"] = data["id"]
		"cabeza":
			Jugador.equipamiento["cabeza"] = data["id"]
		"torso":
			Jugador.equipamiento["torso"] = data["id"]
		"piernas":
			Jugador.equipamiento["piernas"] = data["id"]
		"pies":
			Jugador.equipamiento["pies"] = data["id"]
		"amuleto1":
			Jugador.equipamiento["amuleto1"] = data["id"]
	Jugador.emit_signal("inventarioActualizado")
