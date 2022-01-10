extends Node

const PATH_ICONOS = "res://Images/Iconos/"
const PATH_SAVES = "user://saves/"
const PATH_JSONS = "res://Json/"

signal notificacion_recibida(texto)

var Nivel: String = "res://NIVELES/Test.tscn"
var itemData: Dictionary

func _ready():
	# Carga de la DB de items
	var itemDataFile = File.new()
	itemDataFile.open(PATH_JSONS+"DataItems.json",File.READ)
	var itemDataJson = JSON.parse(itemDataFile.get_as_text())
	itemDataFile.close()
	itemData = itemDataJson.result


# ==============================================================================
# ============================= Guardar Partida ================================
# ==============================================================================



# ==============================================================================
# ============================== Cargar Partida ================================
# ==============================================================================



# ==============================================================================
# ================================= FUNCIONES ==================================
# ==============================================================================

func Notificacion(texto: String):
	emit_signal("notificacion_recibida",texto)
