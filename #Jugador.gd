extends Node

signal datosActualizados
signal inventarioActualizado

# DATOS
var vida: int = 10 setget setVida
var mana: int = 10 setget setMana
var esta: int = 10 setget setEsta

var defensa: int = 0
var ataque: int = 0
var vida_max: int = 0
var mana_max: int = 0
var esta_max: int = 0
var nivel = 1

# INVENTARIO Y EQUIPAMIENTO
var monedas: int = 0 setget setMonedas
var inventario: Array = []
var inventario_cap: int = 15
var item_cap_max = 1
var equipamiento = {
	"arma" : null,
	"cabeza" : null,
	"torso" : null,
	"piernas" : null,
	"pies" : null,
	"amuleto1" : null,
	"amuleto2" : null,
	"amuleto3" : null,
	"amuleto4" : null
}
var cosmeticos: Array = [2,5,8]

func _ready():
	for i in inventario_cap:
		inventario.append({
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


func setEsta(cantidad):
	esta += cantidad
	if esta > esta_max:
		esta = esta_max
	elif esta < 0:
		esta = 0
	emit_signal("datosActualizados")


func actualizarStats():
	var defensa_final = 0
	var ataque_final = 0
	if equipamiento["cabeza"] != null:
		defensa_final += Datos.getItemDefensa(equipamiento["cabeza"])
	if equipamiento["torso"] != null:
		defensa_final += Datos.getItemDefensa(equipamiento["torso"])
	if equipamiento["piernas"] != null:
		defensa_final += Datos.getItemDefensa(equipamiento["piernas"])
	if equipamiento["pies"] != null:
		defensa_final += Datos.getItemDefensa(equipamiento["pies"])
	if equipamiento["arma"] != null:
		ataque_final += Datos.getItemAtaque(equipamiento["arma"])
	calculateAmuletos()
	defensa = defensa_final
	ataque = ataque_final
	vida_max 
	emit_signal("datosActualizados")


func calculateAmuletos():
	var amuletos = [equipamiento["amuleto1"],equipamiento["amuleto2"],equipamiento["amuleto3"],equipamiento["amuleto4"]]
	var vida_final = 0
	var mana_final = 0
	var esta_final = 0
	for x in amuletos:
		if x != null:
			match Datos.getItemEfecto(x):
				"vida":
					vida_final = vida_max * Datos.getItemPorcentaje(x)
	vida_max = Datos.getNivelesVida() + vida_final
	mana_max = Datos.getNivelesMana() + mana_final
	esta_max = Datos.getNivelesEsta() + esta_final

# INVENTARIO

func anadirItem(item_id: int, cantidad: int):
	var item_max = Datos.getItemInfo(item_id)["max"]
	var sobra = cantidad
	while sobra != 0:
		var index_con_espacio = getSimilaresConEspacio(item_id, item_max)
		if index_con_espacio != -1:
			var restante = item_max - inventario[index_con_espacio]["cantidad"]
			if restante > sobra:
				inventario[index_con_espacio]["cantidad"] += sobra
				emit_signal("inventarioActualizado")
				return 0
			else:
				sobra = sobra - restante
				inventario[index_con_espacio]["cantidad"] = item_max
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


func getSimilaresConEspacio(item_id: int, item_max):
	for x in inventario_cap:
		if inventario[x]["id"] == item_id and (inventario[x]["cantidad"] < item_max):
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
