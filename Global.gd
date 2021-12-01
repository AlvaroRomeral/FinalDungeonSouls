extends Node

const PATH_ICONOS = "res://Images/Iconos/"
const PATH_SAVES = "user://saves/"
const PATH_JSONS = "res://Json/"

var Nivel: String = "res://Niveles/Test.tscn"
var itemData: Dictionary

func _ready():
	# Carga de la DB de items
	var itemDataFile = File.new()
	itemDataFile.open(PATH_JSONS+"DataItems.json",File.READ)
	var itemDataJson = JSON.parse(itemDataFile.get_as_text())
	itemDataFile.close()
	itemData = itemDataJson.result
