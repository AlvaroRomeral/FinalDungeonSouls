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
			Jugador.equipamiento[0]["arma"] = datos["id"]
			Jugador.actualizarStats()
		"cabeza":
			Jugador.equipamiento[0]["cabeza"] = datos["id"]
			Jugador.actualizarStats()
		"torso":
			Jugador.equipamiento[0]["torso"] = datos["id"]
			Jugador.actualizarStats()
		"piernas":
			Jugador.equipamiento[0]["piernas"] = datos["id"]
			Jugador.actualizarStats()
		"pies":
			Jugador.equipamiento[0]["pies"] = datos["id"]
			Jugador.actualizarStats()
		"amuleto1":
			Jugador.equipamiento[0]["amuleto1"] = datos["id"]
			Jugador.actualizarStats()
		"amuleto2":
			Jugador.equipamiento[0]["amuleto2"] = datos["id"]
			Jugador.actualizarStats()
		"amuleto3":
			Jugador.equipamiento[0]["amuleto3"] = datos["id"]
			Jugador.actualizarStats()
		"amuleto4":
			Jugador.equipamiento[0]["amuleto4"] = datos["id"]
			Jugador.actualizarStats()
	match tipo: #Lo que le pasa a la casilla donde lo suelta
		"inv":
			Jugador.inventario[datos["index"]]["id"] = data["id"]
			Jugador.inventario[datos["index"]]["cantidad"] = data["cantidad"]
		"arma":
			Jugador.equipamiento[0]["arma"] = data["id"]
			Jugador.actualizarStats()
		"cabeza":
			Jugador.equipamiento[0]["cabeza"] = data["id"]
			Jugador.actualizarStats()
		"torso":
			Jugador.equipamiento[0]["torso"] = data["id"]
			Jugador.actualizarStats()
		"piernas":
			Jugador.equipamiento[0]["piernas"] = data["id"]
			Jugador.actualizarStats()
		"pies":
			Jugador.equipamiento[0]["pies"] = data["id"]
			Jugador.actualizarStats()
		"amuleto1":
			Jugador.equipamiento[0]["amuleto1"] = data["id"]
			Jugador.actualizarStats()
		"amuleto2":
			Jugador.equipamiento[0]["amuleto2"] = data["id"]
			Jugador.actualizarStats()
		"amuleto3":
			Jugador.equipamiento[0]["amuleto3"] = data["id"]
			Jugador.actualizarStats()
		"amuleto4":
			Jugador.equipamiento[0]["amuleto4"] = data["id"]
			Jugador.actualizarStats()
	Jugador.emit_signal("inventarioActualizado")
