extends Node

const PATH_ICONOS = "res://Images/Iconos/"
const PATH_SAVES = "user://saves/"
const PATH_JSONS = "res://Json/"

signal notificacion_recibida(texto)

onready var scriptGuardado = preload("res://guardado.gd")
onready var archivoGuardado = scriptGuardado.new()

var Nivel: String = "res://NIVELES/Test.tscn"
var itemData: Dictionary
var nombreSave = "autosave"

func _ready():
	# ========================== CARGA DE JSON ITEMS ===========================
	var itemDataFile = File.new()
	itemDataFile.open(PATH_JSONS+"DataItems.json",File.READ)
	var itemDataJson = JSON.parse(itemDataFile.get_as_text())
	itemDataFile.close()
	itemData = itemDataJson.result
	# ==========================================================================

# print("Hola {nombre}, vete, no aceptamos viejos de {edad} años".format(DatosJugador.datosPersonales))

# ==============================================================================
# ============================= Guardar Partida ================================
# ==============================================================================

func guardarPartida():
	guardarDatos()
	ResourceSaver.save(PATH_SAVES + nombreSave + ".save", archivoGuardado)


func guardarDatos():
	archivoGuardado.posicionJ = DatosJugador.getJugador().global_position


func nuevosDatos():
	archivoGuardado = scriptGuardado.new()

# ==============================================================================
# ============================== Cargar Partida ================================
# ==============================================================================

func cargarPartida():
	archivoGuardado = ResourceLoader.load(PATH_SAVES + nombreSave + ".save")


func cargarDatos():
	if archivoGuardado.posicionJ != null:
		DatosJugador.getJugador().global_position = archivoGuardado.posicionJ


func cargarNivel(nivel):
	get_tree().change_scene(nivel)
	cargarDatos()

# ==============================================================================
# ================================= FUNCIONES ==================================
# ==============================================================================

func Notificacion(texto: String):
	emit_signal("notificacion_recibida",texto)
