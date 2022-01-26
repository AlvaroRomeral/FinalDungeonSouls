extends Node

signal datosActualizados
signal inventarioActualizado

# ESTADISTICAS REGENERATIVAS ===================================================
var vida = 3 setget setVida
var vidaMax = 10 setget setVidaMax
var mana = 5 setget setMana
var manaMax = 10
var estamina = 10 setget setEstamina
var estaminaMax = 10
# ESTADISTICAS =================================================================
var datosPersonales = {
	"nombre": "Alvaro",
	"edad": 45
}
var ataque = 1
var def = 0
var res_magia = 0
var res_veneno = 0
# INVENTARIO ===================================================================
var monedas = 0 setget setMonedas
var inventario = []
## EQUIPAMIENTO =================================================================
var arma
var arrayEquipo = []
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
		arrayEquipo.append({
			"id": null,
			"cantidad": null
		})

# ==============================================================================
# ================================ VALORES =====================================
# ==============================================================================

func setMonedas(cantidad):
	monedas += cantidad
	emit_signal("datosActualizados")


func setVida(cantidad):
	vida = vida + cantidad
	if vida > vidaMax:
		vida = vidaMax
	elif vida < 0:
		vida = 0
	emit_signal("datosActualizados")


func setMana(cantidad):
	mana += cantidad
	if mana > manaMax:
		mana = manaMax
	elif mana < 0:
		mana = 0
	emit_signal("datosActualizados")


func setEstamina(cantidad):
	estamina += cantidad
	if estamina > estaminaMax:
		estamina = estaminaMax
	elif estamina < 0:
		estamina = 0
	emit_signal("datosActualizados")


func setEstasEquipo():
	for i in arrayEquipo:
		if i["id"] != null:
			def = def + Global.itemData[i["id"]]["cant_defensa"]

# ==============================================================================
# ================================ MAXIMOS =====================================
# ==============================================================================

func setVidaMax(cantidad):
	vidaMax = cantidad
	if vida > vidaMax:
		vida = vidaMax
	emit_signal("datosActualizados")


func setManaMax(cantidad):
	manaMax = cantidad
	if mana > manaMax:
		mana = manaMax
	emit_signal("datosActualizados")


func setEstaminaMax(cantidad):
	estaminaMax = cantidad
	if estamina > estaminaMax:
		estamina = estaminaMax
	emit_signal("datosActualizados")

# ==============================================================================
# ================================ INVENTARIO ==================================
# ==============================================================================

func anadirItem(item):
	for i in inventario:
		if i["id"] == item["id"]:
			i["cantidad"] = i["cantidad"] + item["cantidad"]
			emit_signal("inventarioActualizado")
			return
	inventario.append(item)
	emit_signal("inventarioActualizado")


func quitarItem(itemQuitado, cantidad: int):
	for i in inventario:
		if itemQuitado["id"] == i["id"]:
			var cantidadActual = i["cantidad"]
			cantidadActual = cantidadActual - cantidad
			if cantidadActual < 1:
				inventario.remove(inventario.find(i))
				return {
					"id": itemQuitado["id"],
					"cantidad": cantidad
				}
			else:
				i["cantidad"] = cantidadActual
				return {
					"id": itemQuitado["id"],
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


func usarItem(item):
	if item != null:
		for i in inventario:
			if item["id"] == i["id"]:
				var datos = Global.itemData[i["id"]]
				match datos["tipo"]:
					"consumible":
						setVida(datos["vida"])
						setMana(datos["mana"])
						quitarItem(item,1)
						return
					"equipable":
						match datos["tipo_equipo"]:
							"cabeza":
								equipar(item,0)
							"pecho":
								equipar(item,1)
							"piernas":
								equipar(item,2)
							"pies":
								equipar(item,3)
							"espalda":
								equipar(item,4)
							"manos":
								equipar(item,5)
							"dedo_der":
								equipar(item,6)
							"dedo_izq":
								equipar(item,7)
						emit_signal("inventarioActualizado")
						return
					"llave":
						pass # al usar una puerta se le abre el inventario
						return
					"otro":
						pass
						return
	#=========================================
#	var indexUsar = inventario.find(itemUsado)
#	if indexUsar != -1:
#		for x in range(veces):
#			var datosItem = Global.itemData[inventario[indexUsar]["id"]]
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
	if arrayEquipo[posicion]["id"] == null:
		arrayEquipo[posicion] = quitarItem(item, 1)
	else:
		anadirItem(arrayEquipo[posicion])
		arrayEquipo[posicion] = quitarItem(item, 1)
	setEstasEquipo()


func chekearItem(item) -> bool:
	if item in inventario:
		return true
	return false


func getValor(id, campo):
	return Global.itemData[id][campo]

# ==============================================================================
# ================================= FUNCIONES ==================================
# ==============================================================================

func getJugador():
	return get_tree().get_nodes_in_group("jugador")[0]
