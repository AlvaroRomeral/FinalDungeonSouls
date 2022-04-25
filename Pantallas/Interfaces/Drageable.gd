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
		texture = load(Global.PATH_ICONOS + Datos.getItemInfo(datos["id"])["icono"] + ".png")
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
#			if data["origen"].tipo != "inv" and datos["id"] != null:
#				return false
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
		"amuleto1":
			if item_tipo != "amuleto":
				return false
			return true
		"amuleto2":
			if item_tipo != "amuleto":
				return false
			return true
		"amuleto3":
			if item_tipo != "amuleto":
				return false
			return true
		"amuleto4":
			if item_tipo != "amuleto":
				return false
			return true
	return false


func drop_data(position, data):
	match data["origen"].tipo: #Lo que le pasa a la casilla de donde salio
		"inv":
			Jugador.inventario[data["index"]] = {
				"id" : datos["id"],
				"cantidad" : datos["cantidad"]
			}
		"arma":
			Jugador.equipamiento["arma"] = datos["id"]
		"cabeza":
			Jugador.equipamiento["cabeza"] = datos["id"]
		"torso":
			Jugador.equipamiento["torso"] = datos["id"]
		"piernas":
			Jugador.equipamiento["piernas"] = datos["id"]
		"pies":
			Jugador.equipamiento["pies"] = datos["id"]
		"amuleto1":
			Jugador.equipamiento["amuleto1"] = datos["id"]
		"amuleto2":
			Jugador.equipamiento["amuleto2"] = datos["id"]
		"amuleto3":
			Jugador.equipamiento["amuleto3"] = datos["id"]
		"amuleto4":
			Jugador.equipamiento["amuleto4"] = datos["id"]
	match tipo: #Lo que le pasa a la casilla donde lo suelta
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
		"amuleto2":
			Jugador.equipamiento["amuleto2"] = data["id"]
		"amuleto3":
			Jugador.equipamiento["amuleto3"] = data["id"]
		"amuleto4":
			Jugador.equipamiento["amuleto4"] = data["id"]
	Jugador.emit_signal("inventarioActualizado")
