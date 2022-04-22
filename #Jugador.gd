extends Node

signal datosActualizados
signal inventarioActualizado

# DATOS
var vida = 3 
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
var item_cap_max = 1
## EQUIPAMIENTO
var cosmeticos: Array = [2,5,8]
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
	for i in inventario_cap:
		inventario.append({
			"id": null,
			"cantidad": null
		})
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
	var sobra = cantidad
	while sobra != 0:
		var index_con_espacio = getSimilaresConEspacio(item_id)
		if index_con_espacio != -1:
			var restante = item_cap_max - inventario[index_con_espacio]["cantidad"]
			if restante > sobra:
				inventario[index_con_espacio]["cantidad"] += sobra
				emit_signal("inventarioActualizado")
				return 0
			else:
				sobra = sobra - restante
				inventario[index_con_espacio]["cantidad"] = item_cap_max
		else:
			if getEspaciosVacios() > 0: #Si recogo un item que contiene mas de la capacidad maxima no funcionaria
				for x in inventario_cap:
					if inventario[x]["id"] == null:
						inventario[x]["id"] = item_id
						inventario[x]["cantidad"] = sobra
						emit_signal("inventarioActualizado")
						return 0
			else:
				emit_signal("inventarioActualizado")
				return sobra


func quitarItem(item_id: int, cantidad: int):
	var cant_faltante = cantidad
	if getSimilares(item_id) != -1:
		if getCantidad(item_id) >= cant_faltante:
			while cant_faltante > 0:
				for x in inventario_cap:
					if inventario[x]["id"] == item_id:
						var cant_item = inventario[x]["cantidad"]
						if cant_item <= cant_faltante:
							cant_faltante = cant_faltante - cant_item
							inventario[x]["id"] = null
							inventario[x]["cantidad"] = null
						else:
							cant_item = cant_item - cant_faltante
							inventario[x]["cantidad"] = cant_item
							emit_signal("inventarioActualizado")
							return
#			Global.mostrarAlerta("[color=#902323]" + Datos.getItemInfo(item_id)["nombre"] + " eliminado de la mochila")
			emit_signal("inventarioActualizado")
			return
		else:
			Global.Notificacion("Se pide mas " + Datos.getItemInfo(item_id)["nombre"] + " de lo que hay")
			return
	else:
		Global.Notificacion("No se encontro " + Datos.getItemInfo(item_id)["nombre"])


func quitarItemPos(cantidad:int, posicion:int):
	Jugador.inventario[posicion]["cantidad"] -= cantidad
	if Jugador.inventario[posicion]["cantidad"] == 0:
		Jugador.inventario[posicion]["id"] = null
	emit_signal("inventarioActualizado")


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
			emit_signal("inventarioActualizado")
			return
		2: #Arma
			Datos.getArmaInfo(item_id)
#			emit_signal("inventarioActualizado")
			emit_signal("inventarioActualizado")
			return
		3: #Consumible
			Datos.getConsumibleInfo(item_id)
			pass # al usar una puerta se le abre el inventario
			emit_signal("inventarioActualizado")
			return
		0: #Nada
			pass
			return
	Global.Notificacion("No hay ningun objeto")


func equipar(item_id: int, posicion: int):
	emit_signal("inventarioActualizado")
	if array_equipo[posicion]["id"] == null:
		array_equipo[posicion] = quitarItem(item_id, 1)
	else:
		anadirItem(item_id, 1)
		array_equipo[posicion] = quitarItem(item_id, 1)
	setEstasEquipo()


func getSimilaresConEspacio(item_id: int):
	for x in inventario_cap:
		if inventario[x]["id"] == item_id and (inventario[x]["cantidad"] < item_cap_max):
			return x
	return -1


func getSimilares(item_id: int):
	for x in inventario_cap:
		if inventario[x]["id"] == item_id:
			return x
	return -1


func getCantidad(item_id: int):
	var cantidad_total = 0
	for x in inventario_cap:
		if inventario[x]["id"] == item_id:
			cantidad_total = inventario[x]["cantidad"] + cantidad_total
	return cantidad_total


func getEspaciosVacios():
	var espacios_vacios = 0
	for i in inventario:
		if i["id"] == null:
			espacios_vacios =+ 1
	return espacios_vacios


# GETTERS

func getJugador():
	return get_tree().get_nodes_in_group("jugador")[0]


func getInterfaz():
	return get_tree().get_nodes_in_group("interfaz")[0]


func getValor(id, campo):
	return Datos.items_db[id][campo]
