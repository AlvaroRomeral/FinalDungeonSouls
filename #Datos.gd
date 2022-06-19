extends Node

signal datos_cargados
signal datos_guardados

const res_guardado = preload("res://ResGuardado.gd")
const res_persistencia = preload("res://ResPersistencia.gd")
const sqlite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")

var ar_guardado : ResGuardado
var ar_persistencia : ResPersistencia
var nombre_guardado = "auto_save"
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
	fdsdb.read_only = true
	fdsdb.path = Global.PATH_FSDDB
	fdsdb.open_db()

# MANEJO DE ARCHIVO ================================================================================

func guardarPartida():
	guardarDatos()
	ResourceSaver.save(Global.PATH_SAVES + nombre_guardado + Global.EXTE_SAVES, ar_guardado)


func cargarPartida():
	ar_guardado = load(Global.PATH_SAVES + nombre_guardado + Global.EXTE_SAVES)


func guardarPersistencia():
	ResourceSaver.save(Global.PATH_DATOS + "per" + Global.EXTE_PERSISTENCIA, ar_persistencia)


func cargarPersistencia():
	ar_persistencia = load(Global.PATH_DATOS + "per" + Global.EXTE_PERSISTENCIA)

# MANEJO DE DATOS ==================================================================================

func nuevosDatos():
	ar_guardado = res_guardado.new()


func guardarDatos():
	ar_guardado.vida = Jugador.vida 
	ar_guardado.mana = Jugador.mana
	ar_guardado.esta = Jugador.esta
	ar_guardado.nivel = Jugador.nivel
	ar_guardado.experiencia = Jugador.experiencia
	ar_guardado.monedas = Jugador.monedas
	ar_guardado.equipamiento["arma"] = Jugador.getEquipamiento("arma")
	ar_guardado.equipamiento["cabeza"] = Jugador.getEquipamiento("cabeza")
	ar_guardado.equipamiento["torso"] = Jugador.getEquipamiento("torso")
	ar_guardado.equipamiento["piernas"] = Jugador.getEquipamiento("piernas")
	ar_guardado.equipamiento["pies"] = Jugador.getEquipamiento("pies")
	ar_guardado.equipamiento["amuleto1"] = Jugador.getEquipamiento("amuleto1")
	ar_guardado.equipamiento["amuleto2"] = Jugador.getEquipamiento("amuleto2")
	ar_guardado.equipamiento["amuleto3"] = Jugador.getEquipamiento("amuleto3")
	ar_guardado.equipamiento["amuleto4"] = Jugador.getEquipamiento("amuleto4")
	ar_guardado.inventario = Jugador.inventario
	emit_signal("datos_guardados")


func cargarDatos():
	Jugador.vida = ar_guardado.vida
	Jugador.mana = ar_guardado.mana
	Jugador.esta = ar_guardado.esta
	Jugador.nivel = ar_guardado.nivel
	Jugador.experiencia = ar_guardado.experiencia
	Jugador.monedas = ar_guardado.monedas
	Jugador.setEquipamiento("arma",ar_guardado.equipamiento["arma"])
	Jugador.setEquipamiento("cabeza",ar_guardado.equipamiento["cabeza"])
	Jugador.setEquipamiento("torso",ar_guardado.equipamiento["torso"])
	Jugador.setEquipamiento("piernas",ar_guardado.equipamiento["piernas"])
	Jugador.setEquipamiento("pies",ar_guardado.equipamiento["pies"])
	Jugador.setEquipamiento("amuleto1",ar_guardado.equipamiento["amuleto1"])
	Jugador.setEquipamiento("amuleto2",ar_guardado.equipamiento["amuleto2"])
	Jugador.setEquipamiento("amuleto3",ar_guardado.equipamiento["amuleto3"])
	Jugador.setEquipamiento("amuleto4",ar_guardado.equipamiento["amuleto4"])
	Jugador.inventario.clear()
	Jugador.inventario = ar_guardado.inventario
	emit_signal("datos_cargados")


func guardarNivel():
	var nivel_pack = PackedScene.new()
	nivel_pack.pack(get_tree().get_nodes_in_group("nivel")[0])
	ResourceSaver.save(Global.PATH_SAVES + "nivelGuardado.tscn", nivel_pack)


func cargarNivel():
	var nivel = load(Global.PATH_SAVES + "nivelGuardado.tscn")
	get_tree().change_scene(Global.PATH_SAVES + "nivelGuardado.tscn")


func cargarDatosPersistencia():
	OS.window_fullscreen = ar_persistencia.pantalla_completa
	OS.window_size = ar_persistencia.resolucion

# BBDD ITEMS =======================================================================================

func getItemInfo(id): #devuelve "id", "nombre", "descripcion", "icono"
	if fdsdb.query("SELECT * FROM items WHERE id = " + str(id)):
		var resultado = fdsdb.query_result[0]
		return resultado


func getItemVida(id):
	if fdsdb.query("SELECT vida FROM items WHERE id = " + str(id)):
		var resultado = fdsdb.query_result[0]["vida"]
		return resultado


func getItemMana(id):
	if fdsdb.query("SELECT mana FROM items WHERE id = " + str(id)):
		var resultado = fdsdb.query_result[0]["mana"]
		return resultado


func getItemTipo(id): #devuelve el "tipo"
	if fdsdb.query("SELECT tipo FROM items WHERE id = " + str(id)):
		var resultado = fdsdb.query_result[0]["tipo"]
		return resultado


func getItemDefensa(id):
	if fdsdb.query("SELECT defensa FROM items WHERE id = " + str(id)):
		var resultado = fdsdb.query_result[0]["defensa"]
		return resultado


func getItemAtaque(id):
	if fdsdb.query("SELECT ataque FROM items WHERE id = " + str(id)):
		var resultado = fdsdb.query_result[0]["ataque"]
		return resultado


func getItemPorcentaje(id):
	if fdsdb.query("SELECT porcen FROM items WHERE id = " + str(id)):
		var resultado = fdsdb.query_result[0]["porcen"]
		return resultado


func getItemEfecto(id):
	if fdsdb.query("SELECT efecto FROM items WHERE id = " + str(id)):
		var resultado = fdsdb.query_result[0]["efecto"]
		return resultado


func getItemTextura(id):
	if fdsdb.query("SELECT textura FROM items WHERE id = " + str(id)):
		var resultado = fdsdb.query_result[0]["textura"]
		return resultado


func getItemIcono(id):
	if fdsdb.query("SELECT icono FROM items WHERE id = " + str(id)):
		var resultado = fdsdb.query_result[0]["icono"]
		return resultado

# BBDD DIALOGO =====================================================================================

func getDialogo(id:int):
	fdsdb.query("SELECT texto FROM dialogos WHERE id =" + str(id))
	var resultado = fdsdb.query_result[0]["texto"]
	return resultado

# BBDD COSMETICOS ==================================================================================

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
	fdsdb.query("SELECT parte FROM cosmeticos WHERE id = " + str(id))
	var resultado = fdsdb.query_result[0]["parte"]
	return resultado


func getCosmeticoIcono(id):
	fdsdb.query("SELECT icono FROM cosmeticos WHERE id = " + str(id))
	var resultado = fdsdb.query_result[0]["icono"]
	return resultado

# BBDD NIVELES =====================================================================================

func getNivelesVida():
	fdsdb.query("SELECT vida FROM niveles WHERE id = " + str(Jugador.nivel))
	var resultado = fdsdb.query_result[0]["vida"]
	return resultado


func getNivelesMana():
	fdsdb.query("SELECT mana FROM niveles WHERE id = " + str(Jugador.nivel))
	var resultado = fdsdb.query_result[0]["mana"]
	return resultado


func getNivelesEsta():
	fdsdb.query("SELECT esta FROM niveles WHERE id = " + str(Jugador.nivel))
	var resultado = fdsdb.query_result[0]["esta"]
	return resultado


func getNivelesExpReq():
	fdsdb.query("SELECT exp_req FROM niveles WHERE id = " + str(Jugador.nivel))
	var resultado = fdsdb.query_result[0]["exp_req"]
	return resultado

# BBDD OLEADAS =====================================================================================

func getOleadaEnemigos(oleada):
	fdsdb.query("SELECT enemigos_1,enemigos_2,enemigos_3 FROM oleadas WHERE id = " + str(oleada))
	var resultado = fdsdb.query_result[0]
	return resultado

# ARCHIVOS =========================================================================================

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
