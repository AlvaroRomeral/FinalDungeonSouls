extends TextureRect

signal item_dropeado(datos)

var tipo

var datos = {
	"id" : null,
	"cantidad" : 0,
	"index" : -1,
	"icono" : texture,
	"origen" :self
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
		
		datos["id"] = null
		datos["cantidad"] = 0
		updateAspecto()
		
		return datos_exportados


func can_drop_data(position, data):
	var item_data = Datos.getItemInfo(data["id"])
	match tipo:
		"inv":
			Jugador.emit_signal("inventarioActualizado")
			return true
		"arma":
			if item_data["tipo"] != "arma":
				datos["origen"].setDatos(datos["id"],datos["cantidad"],datos["index"])
				return false
			return true
		"cabeza":
			if item_data["tipo"] != "cabeza":
				datos["origen"].setDatos(datos["id"],datos["cantidad"],datos["index"])
				return false
			Jugador.equipamiento["cabeza"] = data["id"]
			return true
		"torso":
			if item_data["tipo"] != "torso":
				datos["origen"].setDatos(datos["id"],datos["cantidad"],datos["index"])
				return false
			return true
		"piernas":
			if item_data["tipo"] != "piernas":
				datos["origen"].setDatos(datos["id"],datos["cantidad"],datos["index"])
				return false
			return true
		"pies":
			if item_data["tipo"] != "pies":
				datos["origen"].setDatos(datos["id"],datos["cantidad"],datos["index"])
				return false
			return true
		"amuleto":
			if item_data["tipo"] != "amuleto":
				datos["origen"].setDatos(datos["id"],datos["cantidad"],datos["index"])
				return false
			return true
	datos["origen"].setDatos(datos["id"],datos["cantidad"],datos["index"])
	return false


func drop_data(position, data):
	texture = data["icono"]
	Jugador.inventario[data["index"]] = {
		"id" : data["id"],
		"cantidad" : data["cantidad"]
	}
	datos["id"] = data["id"]
	datos["cantidad"] = data["cantidad"]
