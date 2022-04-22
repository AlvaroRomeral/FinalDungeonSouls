extends Node

const res_guardado = preload("res://ResGuardado.gd")
const res_persistencia = preload("res://ResPersistencia.gd")
const sqlite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")

var ar_guardado : ResGuardado
var ar_persistencia : ResPersistencia
var nombre_guardado = "auto_save"
#var items_db: Dictionary
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
		print(directorio.file_exists("Existencia de archivo persistente: " + Global.PATH_DATOS + "per" + Global.EXTE_PERSISTENCIA))
		ar_persistencia = res_persistencia.new()
		guardarPersistencia()
	else:
		cargarPersistencia()
	cargarDatosPersistencia()
	#Cargar Json
#	var itemDataFile = File.new()
#	itemDataFile.open(Global.PATH_DB + "DataItems.json", File.READ)
#	var itemDataJson = JSON.parse(itemDataFile.get_as_text())
#	itemDataFile.close()
#	items_db = itemDataJson.result
	#Cargar base de datos
	fdsdb = sqlite.new()
	fdsdb.path = Global.PATH_FSDDB
	fdsdb.open_db()

# ARCHIVO GUARDADO

func guardarPartida():
	guardarDatos()
	ResourceSaver.save(Global.PATH_SAVES + nombre_guardado + Global.EXTE_SAVES, ar_guardado)


func cargarPartida():
	ar_guardado = load(Global.PATH_SAVES + nombre_guardado + Global.EXTE_SAVES)

# DATOS GUARDADO

func nuevosDatos():
	ar_guardado = res_guardado.new()


func guardarDatos():
	ar_guardado.ju_vida = Jugador.vida
	ar_guardado.inventario = Jugador.inventario


func cargarDatos():
	Jugador.vida = ar_guardado.ju_vida
	Jugador.vida_max = ar_guardado.ju_vida
	Jugador.mana = ar_guardado.ju_mana
	Jugador.mana_max = ar_guardado.ju_mana_max
	Jugador.estamina_max = ar_guardado.ju_estamina_max
	Jugador.inventario = ar_guardado.inventario


func guardarNivel():
	var nivel_pack = PackedScene.new()
	nivel_pack.pack(get_tree().get_nodes_in_group("nivel")[0])
	ResourceSaver.save(Global.PATH_SAVES + "nivelGuardado.tscn", nivel_pack)


func cargarNivel():
	var nivel = load(Global.PATH_SAVES + "nivelGuardado.tscn")
	get_tree().change_scene(Global.PATH_SAVES + "nivelGuardado.tscn")

# PERSISTENCIA

func guardarPersistencia():
	ResourceSaver.save(Global.PATH_DATOS + "per" + Global.EXTE_PERSISTENCIA, ar_persistencia)


func cargarPersistencia():
	ar_persistencia = load(Global.PATH_DATOS + "per" + Global.EXTE_PERSISTENCIA)


func cargarDatosPersistencia():
	OS.window_fullscreen = ar_persistencia.pantalla_completa
	OS.window_size = ar_persistencia.resolucion

# BASE DE DATOS

func getItemInfo(id_item): #devuelve "id_item", "nombre", "descripcion", "icono"
	if fdsdb.query("SELECT * FROM items WHERE id_item =" + String(id_item) + ";"):
		var resultado = fdsdb.query_result[0]
		return resultado
	else: #Si ni encuentra el objeto por id que devuelva el primero de la tabla
		fdsdb.query("SELECT * FROM items WHERE id_item = 0;")
		var resultado = fdsdb.query_result[0]
		return resultado


func getItemTipo(id_item): #devuelve el int de "id_tipo"
	if fdsdb.query("SELECT id_tipo FROM items WHERE id_item =" + String(id_item) + ";"):
		var resultado = fdsdb.query_result[0]["id_tipo"]
		return resultado


func getConsumibleInfo(id_item): #devuelve "vida" y "mana"
	fdsdb.query("SELECT consumibles.vida, consumibles.mana FROM items INNER JOIN consumibles ON items.id_item=consumibles.id_item WHERE items.id_item ="+String(id_item) + ";")
	var resultado = fdsdb.query_result[0]
	return resultado


func getEquipoInfo(id_item): #devuelve "def_num" y "def_por"
	fdsdb.query("SELECT equipos.def_num, equipos.def_por FROM items INNER JOIN equipos ON items.id_item=equipos.id_item WHERE items.id_item ="+String(id_item) + ";")
	var resultado = fdsdb.query_result[0]
	return resultado


func getArmaInfo(id_item): #devuelve "atc_num" y "atc_por"
	fdsdb.query("SELECT armas.atc_num, armas.atc_por FROM items INNER JOIN armas ON items.id_item=armas.id_item WHERE items.id_item ="+String(id_item) + ";")
	var resultado = fdsdb.query_result[0]
	return resultado


func getDialogo(id:int):
	fdsdb.query("SELECT texto FROM dialogos WHERE id =" + String(id))
	var resultado = fdsdb.query_result[0]["texto"]
	return resultado


func getCosmeticosCabeza():
	fdsdb.query("SELECT * FROM cosmeticos WHERE parte = 'c'")
	var resultado = fdsdb.query_result
	return resultado


func getCosmeticosTorso():
	fdsdb.query("SELECT * FROM cosmeticos WHERE parte = 't'")
	var resultado = fdsdb.query_result
	return resultado


func getCosmeticosPiernas():
	fdsdb.query("SELECT * FROM cosmeticos WHERE parte = 'p'")
	var resultado = fdsdb.query_result
	return resultado


func getCosmeticosPies():
	fdsdb.query("SELECT * FROM cosmeticos WHERE parte = 'pi'")
	var resultado = fdsdb.query_result
	return resultado


func getCosmeticoParte(id):
	fdsdb.query("SELECT parte FROM cosmeticos WHERE id = "+id)
	var resultado = fdsdb.query_result[0]
	return resultado


func getCosmeticoIcono(id):
	fdsdb.query("SELECT icono FROM cosmeticos WHERE id = "+id)
	var resultado = fdsdb.query_result[0]
	return resultado

# ARCHIVOS

func getArchivosDePath(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin(true)

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif !file.ends_with(".import"):
			files.append(file)

	dir.list_dir_end()

	return files
