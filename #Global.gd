extends Node

const PATH_ICONOS = "res://Images/Iconos/"
const PATH_DATOS = "user://data/"
const PATH_SAVES = "user://saves/"
const PATH_JSONS = "res://Json/"
const EXTE_SAVES = ".save"
const EXTE_PERSISTENCIA = ".dat"

signal notificacion_recibida(texto)

var nivel: String = "res://NIVELES/Test.tscn"

func _ready():
	pass

# print("Hola {nombre}, vete, no aceptamos viejos de {edad} años".format(DatosJugador.datosPersonales))

func cambiarNivel(nivel):
	get_tree().change_scene(nivel)

# ==============================================================================
# ================================= FUNCIONES ==================================
# ==============================================================================

func Notificacion(texto: String):
	emit_signal("notificacion_recibida",texto)
