extends Node

signal datosActualizados
signal inventarioActualizado

# DATOS
var vida = 3 setget setVida
var vida_max = 10 setget setvida_max
var mana = 5 setget setMana
var mana_max = 10
var estamina = 10 setget setEstamina
var estamina_max = 10
var defensa = 0
# ESTADISTICAS
var stats = {
	"vigor" : 1,
	"inteligencia" : 1,
	"aguante" : 1,
	"fuerza" : 1,
	"sabiduria" : 1,
	"destreza" : 1
}

# INVENTARIO
var monedas: int = 0 setget setMonedas
var inventario: Array = []
var inventario_cap: int = 20
## EQUIPAMIENTO
var array_equipo = []
# [0] cabeza
# [1] pecho
# [2] piernas
# [3] pies
# [4] espalda
# [5] manos
# [6] dedo_der
# [7] dedo_izq


func _ready():
	for i in range(8):
		array_equipo.append({
			"id": null,
			"cantidad": null
		})

# SETTERS

func setMonedas(cantidad):
	monedas += cantidad
	emit_signal("datosActualizados")


func setVida(cantidad):
	vida = vida + cantidad
	if vida > vida_max:
		vida = vida_max
	elif vida < 0:
		vida = 0
	emit_signal("datosActualizados")


func setMana(cantidad):
	mana += cantidad
	if mana > mana_max:
		mana = mana_max
	elif mana < 0:
		mana = 0
	emit_signal("datosActualizados")


func setEstamina(cantidad):
	estamina += cantidad
	if estamina > estamina_max:
		estamina = estamina_max
	elif estamina < 0:
		estamina = 0
	emit_signal("datosActualizados")


func setEstasEquipo():
	for i in array_equipo:
		if i["id"] != null:
			defensa = defensa + Datos.items_db[i["id"]]["defensa"]


func setvida_max(cantidad):
	vida_max = cantidad
	if vida > vida_max:
		vida = vida_max
	emit_signal("datosActualizados")


func setmana_max(cantidad):
	mana_max = cantidad
	if mana > mana_max:
		mana = mana_max
	emit_signal("datosActualizados")


func setestamina_max(cantidad):
	estamina_max = cantidad
	if estamina > estamina_max:
		estamina = estamina_max
	emit_signal("datosActualizados")

# INVENTARIO

func anadirItem(item_id: int, cantidad: int):
	var nuevo_item = {
		"id" : item_id,
		"cantidad" : cantidad
	}
	for i in inventario:
		if i["id"] == nuevo_item["id"]:
			i["cantidad"] = i["cantidad"] + nuevo_item["cantidad"]
			emit_signal("inventarioActualizado")
			return
	inventario.append(nuevo_item)
	emit_signal("inventarioActualizado")


func quitarItem(item_id: int, cantidad: int):
	for i in inventario:
		if item_id == i["id"]:
			var cantidadActual = i["cantidad"]
			cantidadActual = cantidadActual - cantidad
			if cantidadActual < 1:
				inventario.remove(inventario.find(i))
				return {
					"id": item_id,
					"cantidad": cantidad
				}
			else:
				i["cantidad"] = cantidadActual
				return {
					"id": item_id,
					"cantidad": cantidad
				}
			return null
		#==========================================
#	var indexQuitar = inventario.find(itemQuitado)
#	if indexQuitar != -1:
#		var cantidadActual = inventario[indexQuitar]["cantidad"]
#		cantidadActual = cantidadActual - cantidad
#		if cantidadActual < 2:
#			inventario.remove(indexQuitar)
#			emit_signal("inventarioActualizado")
#		else:
#			inventario[indexQuitar]["cantidad"] = cantidadActual
#			emit_signal("inventarioActualizado")
#	else:
	Global.Notificacion("No hay ningun objeto")
	return null


func usarItem(item_id: int):
	match Datos.getItemTipo(item_id):
		1: #Equipo
			Datos.getEquipoInfo(item_id)
#			match datos["tipo_equipo"]:
#				"cabeza":
#					equipar(item_id,0)
#				"pecho":
#					equipar(item_id,1)
#				"piernas":
#					equipar(item_id,2)
#				"pies":
#					equipar(item_id,3)
#				"espalda":
#					equipar(item_id,4)
#				"manos":
#					equipar(item_id,5)
#				"dedo_der":
#					equipar(item_id,6)
#				"dedo_izq":
#					equipar(item_id,7)
			return
		2: #Arma
			Datos.getArmaInfo(item_id)
#			emit_signal("inventarioActualizado")
			return
		3: #Consumible
			Datos.getConsumibleInfo(item_id)
			pass # al usar una puerta se le abre el inventario
			return
		0: #Nada
			pass
			return
	#=========================================
#	var indexUsar = inventario.find(itemUsado)
#	if indexUsar != -1:
#		for x in range(veces):
#			var datosItem = Datos.items_db[inventario[indexUsar]["id"]]
#			match datosItem["tipo"]:
#				"consumible":
#					setVida(datosItem["vida"])
#					setMana(datosItem["mana"])
#					quitarItem(itemUsado,1)
#				"equipo":
#					pass # se se le coloca en el slot de equipo y borra del inventario
#				"llave":
#					pass # al usar una puerta se le abre el inventario
#	else:
	Global.Notificacion("No hay ningun objeto")


func equipar(item, posicion):
	if array_equipo[posicion]["id"] == null:
		array_equipo[posicion] = quitarItem(item, 1)
	else:
		anadirItem(item, 1)
		array_equipo[posicion] = quitarItem(item, 1)
	setEstasEquipo()


func chekearItem(item) -> bool:
	if item in inventario:
		return true
	return false

# GETTERS

func getJugador():
	return get_tree().get_nodes_in_group("jugador")[0]


func getValor(id, campo):
	return Datos.items_db[id][campo]
