extends TextureRect

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
			$Cantidad.text = str(datos["cantidad"])
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
			Jugador.setEquipamiento("arma",datos["id"])
		"cabeza":
			Jugador.setEquipamiento("cabeza",datos["id"])
		"torso":
			Jugador.setEquipamiento("torso",datos["id"])
		"piernas":
			Jugador.setEquipamiento("piernas",datos["id"])
		"pies":
			Jugador.setEquipamiento("pies",datos["id"])
		"amuleto1":
			Jugador.setEquipamiento("amuleto1",datos["id"])
		"amuleto2":
			Jugador.setEquipamiento("amuleto2",datos["id"])
		"amuleto3":
			Jugador.setEquipamiento("amuleto3",datos["id"])
		"amuleto4":
			Jugador.setEquipamiento("amuleto4",datos["id"])
	match tipo: #Lo que le pasa a la casilla donde lo suelta
		"inv":
			Jugador.inventario[datos["index"]]["id"] = data["id"]
			Jugador.inventario[datos["index"]]["cantidad"] = data["cantidad"]
		"arma":
			Jugador.setEquipamiento("arma",data["id"])
		"cabeza":
			Jugador.setEquipamiento("cabeza",data["id"])
		"torso":
			Jugador.setEquipamiento("torso",data["id"])
		"piernas":
			Jugador.setEquipamiento("piernas",data["id"])
		"pies":
			Jugador.setEquipamiento("pies",data["id"])
		"amuleto1":
			Jugador.setEquipamiento("amuleto1",data["id"])
		"amuleto2":
			Jugador.setEquipamiento("amuleto2",data["id"])
		"amuleto3":
			Jugador.setEquipamiento("amuleto3",data["id"])
		"amuleto4":
			Jugador.setEquipamiento("amuleto4",data["id"])
	Jugador.actualizarStats()
	Jugador.emit_signal("inventarioActualizado")


func _on_Icono_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.is_doubleclick():
			if datos["id"] != null:
				Jugador.usarItem(tipo, datos["id"], datos["index"])
				Jugador.actualizarStats()
