extends Node

const pathIconos = "res://Images/Iconos/"
const pathSaveGames = "user://saves/"
const pathJsons = "res://Json/"

var Nivel: String = "res://Niveles/Test.tscn"
var itemData: Dictionary

func _ready():
	# Carga de la DB de items
	var itemDataFile = File.new()
	itemDataFile.open(pathJsons+"DataItems.json",File.READ)
	var itemDataJson = JSON.parse(itemDataFile.get_as_text())
	itemDataFile.close()
	itemData = itemDataJson.result
