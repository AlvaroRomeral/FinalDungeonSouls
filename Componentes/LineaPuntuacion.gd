extends HBoxContainer
class_name LineaPuntuacion

onready var txt_nombre = $Nombre
onready var txt_puntuacion = $Puntuacion

export var nombre = ""
export var puntuacion = ""

func _ready():
	txt_nombre.text = nombre
	txt_puntuacion.text = puntuacion
