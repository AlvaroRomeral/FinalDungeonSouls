extends Node

const ITEMS_JSON = "res://data/items.json"
const WAVES_JSON = "res://data/waves.json"
# const ENEMIGOS_JSON = "res://data/enemigos.json"

var items_datos

func _ready():
	cargar_items()


func cargar_items():
	var archivo = FileAccess.open(ITEMS_JSON, FileAccess.READ)
	var content = archivo.get_as_text()
	items_datos = JSON.parse_string(content)
	archivo.close()


func get_item(id):
	if id in items_datos.keys():
		return items_datos[id]
	else:
		return false