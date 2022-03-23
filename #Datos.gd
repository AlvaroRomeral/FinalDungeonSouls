extends Node

onready var res_guardado = preload("res://ResGuardado.gd")
onready var res_persistencia = preload("res://ResPersistencia.gd")

var ar_guardado : ResGuardado
var ar_persistencia : ResPersistencia
var nombre_guardado = "auto_save"
var items_db: Dictionary

func _ready():
	#Comprobacion de directorios
	var directorio = Directory.new()
	if not directorio.file_exists(Global.PATH_SAVES):
		directorio.make_dir_recursive(Global.PATH_SAVES)
	if not directorio.file_exists(Global.PATH_DATOS):
		directorio.make_dir_recursive(Global.PATH_DATOS)
	
	ar_guardado = res_guardado.new()
	var itemDataFile = File.new()
	itemDataFile.open(Global.PATH_JSONS+"DataItems.json",File.READ)
	var itemDataJson = JSON.parse(itemDataFile.get_as_text())
	itemDataFile.close()
	items_db = itemDataJson.result

# ARCHIVO GUARDADO

func guardarPartida():
	guardarDatos()
	ResourceSaver.save(Global.PATH_SAVES + nombreSave + ".save", archivoGuardado)


func cargarPartida():
	archivoGuardado = ResourceLoader.load(PATH_SAVES + nombreSave + ".save")
		
		
func nuevosDatos():
	archivoGuardado = scriptGuardado.new()

# DATOS GUARDADO

func guardarDatos():
	archivoGuardado.posicionJ = DatosJugador.getJugador().global_position
			
			
func cargarDatos():
	if ar_guardado.posicionJ != null:
		DatosJugador.getJugador().global_position = archivoGuardado.posicionJ

# PERSISTENCIA