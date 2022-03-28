extends Node

const res_guardado = preload("res://ResGuardado.gd")
const res_persistencia = preload("res://ResPersistencia.gd")
const sqlite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")

var ar_guardado : ResGuardado
var ar_persistencia : ResPersistencia
var nombre_guardado = "auto_save"
var items_db: Dictionary
var fdsdb: sqlite

func _ready():
	#Comprobacion de directorios
	var directorio = Directory.new()
	if not directorio.file_exists(Global.PATH_SAVES):
		directorio.make_dir_recursive(Global.PATH_SAVES)
	if not directorio.file_exists(Global.PATH_DATOS):
		directorio.make_dir_recursive(Global.PATH_DATOS)
	#Cargar guardado
	ar_guardado = res_guardado.new()
	#Cargar persistencia
	if not directorio.file_exists(Global.PATH_DATOS + "per" + Global.EXTE_PERSISTENCIA):
		ar_persistencia = res_persistencia.new()
		ResourceSaver.save(Global.PATH_DATOS + "per" + Global.EXTE_PERSISTENCIA, ar_persistencia)
	else:
		ar_persistencia = load(Global.PATH_DATOS + "per" + Global.EXTE_PERSISTENCIA)
	#Cargar Json
	var itemDataFile = File.new()
	itemDataFile.open(Global.PATH_DB + "DataItems.json", File.READ)
	var itemDataJson = JSON.parse(itemDataFile.get_as_text())
	itemDataFile.close()
	items_db = itemDataJson.result
	#Cargar base de datos
	fdsdb = sqlite.new()
	fdsdb.path = Global.PATH_FSDDB
	fdsdb.open_db()

# ARCHIVO GUARDADO

func guardarPartida():
	guardarDatos()
	ResourceSaver.save(Global.PATH_SAVES + nombre_guardado + ".save", ar_guardado)


func cargarPartida():
	ar_guardado = ResourceLoader.load(Global.PATH_SAVES + nombre_guardado + ".save")

# DATOS GUARDADO

func nuevosDatos():
	ar_guardado = res_guardado.new()


func guardarDatos():
	pass


func cargarDatos():
	pass

# PERSISTENCIA

# BASE DE DATOS

func getItemInfo(id_item):
	if fdsdb.query("SELECT * FROM items WHERE id_item =" + String(id_item) + ";"):
		var resultado = fdsdb.query_result
		return resultado[0]
	else: #Si ni encuentra el objeto por id que devuelva el primero de la tabla
		fdsdb.query("SELECT * FROM items WHERE id_item = 0;")
		var resultado = fdsdb.query_result
		return resultado[0]


func getItemTipo(id_item):
	if fdsdb.query("SELECT id_item FROM items WHERE id_item =" + String(id_item) + ";"):
		var resultado = fdsdb.query_result
		return resultado[0]


func getConsumibleInfo(id_item):
	fdsdb.query("SELECT consumibles.vida, consumibles.mana FROM items INNER JOIN consumibles ON items.id_item=consumibles.id_item")
	var resultado = fdsdb.query_result
	return resultado


func getEquipoInfo(id_item):
	fdsdb.query("SELECT equipos.def_num, equipos.def_por FROM items INNER JOIN equipos ON items.id_item=equipos.id_item")
	var resultado = fdsdb.query_result
	return resultado


func getArmaInfo(id_item):
	fdsdb.query("SELECT armas.atc_num, armas.atc_por FROM items INNER JOIN armas ON items.id_item=armas.id_item")
	var resultado = fdsdb.query_result
	return resultado
