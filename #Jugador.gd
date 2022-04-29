extends Node

signal datosActualizados
signal inventarioActualizado

# DATOS
var vida: int = 1
var mana: int = 0
var esta: int = 1

var defensa: int = 0
var ataque: int = 0
var vida_max: int = 0
var mana_max: int = 0
var esta_max: int = 0

var nivel = 1
var experiencia = 0

# INVENTARIO Y EQUIPAMIENTO
var monedas: int = 0
var inventario: Array = []
var inventario_cap: int = 15
var item_cap_max = 1
var equipamiento: Dictionary = {
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
	Datos.connect("datos_cargados",self,"cargarDatos")

# SETTERS ==========================================================================================

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


func setExp(cantidad):
	experiencia += cantidad
	var faltante = Datos.getNivelesExpReq() - experiencia
	if faltante < 0:
		subidaNivel()
		setExp(abs(faltante))
	elif experiencia == Datos.getNivelesExpReq():
		subidaNivel()


func setEquipamiento(nombre, valor):
	match nombre:
		"arma":
			equipamiento["arma"] = valor
		"cabeza":
			equipamiento["cabeza"] = valor
		"torso":
			equipamiento["torso"] = valor
		"piernas":
			equipamiento["piernas"] = valor
		"pies":
			equipamiento["pies"] = valor
		"amuleto1":
			equipamiento["amuleto1"] = valor
		"amuleto2":
			equipamiento["amuleto2"] = valor
		"amuleto3":
			equipamiento["amuleto3"] = valor
		"amuleto4":
			equipamiento["amuleto4"] = valor

# GETTERS ==========================================================================================

func getEquipamiento(nombre):
	match nombre:
		"arma":
			return equipamiento["arma"]
		"cabeza":
			return equipamiento["cabeza"]
		"torso":
			return equipamiento["torso"]
		"piernas":
			return equipamiento["piernas"]
		"pies":
			return equipamiento["pies"]
		"amuleto1":
			return equipamiento["amuleto1"]
		"amuleto2":
			return equipamiento["amuleto2"]
		"amuleto3":
			return equipamiento["amuleto3"]
		"amuleto4":
			return equipamiento["amuleto4"]


func getJugador():
	return get_tree().get_nodes_in_group("jugador")[0]


func getInterfaz():
	return get_tree().get_nodes_in_group("interfaz")[0]

# CALCULAR ESTATS ==================================================================================

func actualizarStats():
	var defensa_final = 0
	var ataque_final = 0
	if getEquipamiento("cabeza") != null:
		defensa_final += Datos.getItemDefensa(getEquipamiento("cabeza"))
	if getEquipamiento("torso") != null:
		defensa_final += Datos.getItemDefensa(getEquipamiento("torso"))
	if getEquipamiento("piernas") != null:
		defensa_final += Datos.getItemDefensa(getEquipamiento("piernas"))
	if getEquipamiento("pies") != null:
		defensa_final += Datos.getItemDefensa(getEquipamiento("pies"))
	if getEquipamiento("arma") != null:
		ataque_final += Datos.getItemAtaque(getEquipamiento("arma"))
	calcularBonuses()
	getJugador().actualizarRopa()
	defensa = defensa_final
	ataque = ataque_final
	vida_max 
	emit_signal("datosActualizados")


func calcularBonuses():
	var amuletos = [getEquipamiento("amuleto1"), getEquipamiento("amuleto2"), getEquipamiento("amuleto3"), getEquipamiento("amuleto4")]
	var vida_final = 0
	var mana_final = 0
	var esta_final = 0
	for x in amuletos:
		if x != null:
			match Datos.getItemEfecto(x):
				"vida":
					vida_final = Datos.getNivelesVida() * Datos.getItemPorcentaje(x)
	vida_max = Datos.getNivelesVida() + vida_final
	mana_max = Datos.getNivelesMana() + mana_final
	esta_max = Datos.getNivelesEsta() + esta_final


func cargarDatos():
	inventario = Datos.ar_guardado.inventario
	equipamiento = Datos.ar_guardado.equipamiento
	generarInventario()


func generarInventario():
	if inventario.size() == 0:
		for i in inventario_cap:
			inventario.append({
				"id": null,
				"cantidad": null
			})
	elif inventario.size() < inventario_cap:
		var cant_faltante = inventario_cap - inventario.size()
		for x in cant_faltante:
			inventario.append({
				"id": null,
				"cantidad": null
			})


func subidaNivel():
	experiencia = 0
	nivel += 1
	actualizarStats()

# INVENTARIO =======================================================================================

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
	inventario[posicion]["cantidad"] -= cantidad
	if inventario[posicion]["cantidad"] == 0:
		inventario[posicion]["id"] = null
	emit_signal("inventarioActualizado")


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


func getEspacioVacio():
	for i in inventario.size():
		if inventario[i]["id"] == null:
			return i
	return -1


func usarItem(origen, item_id, posicion):
	if origen == "inv":
		match Datos.getItemTipo(item_id):
			"misc":
				emit_signal("inventarioActualizado")
				return
			"consumible":
				setVida(Datos.getItemVida(item_id))
				setMana(Datos.getItemMana(item_id))
				quitarItemPos(1,posicion)
				emit_signal("inventarioActualizado")
				return
			"arma":
				equiparEquipamiento(item_id, posicion)
				return
			"torso":
				equiparEquipamiento(item_id, posicion)
				return
			"cabeza":
				equiparEquipamiento(item_id, posicion)
				return
			"piernas":
				equiparEquipamiento(item_id, posicion)
				return
			"pies":
				equiparEquipamiento(item_id, posicion)
				return
			"amuleto":
				equiparEquipamiento(item_id, posicion)
				return
	else:
		var espacio_dis = getEspacioVacio()
		if espacio_dis != -1:
			inventario[espacio_dis]["id"] = item_id
			inventario[espacio_dis]["cantidad"] = 1
		setEquipamiento(origen,null)
		emit_signal("inventarioActualizado")
		return
	Global.Notificacion("No hay ningun objeto")


func equiparEquipamiento(item_id, index_origen):
	var tipo = Datos.getItemTipo(item_id)
	if tipo != "amuleto":
		var equipo_old = getEquipamiento(tipo)
		if equipo_old != null:
			inventario[index_origen] = {
				"id" : equipo_old,
				"cantidad" : 1
			}
		else:
			inventario[index_origen] = {
				"id" : equipo_old,
				"cantidad" : 0
			}
		setEquipamiento(tipo,item_id)
	else:
		var amuletos = ["amuleto1","amuleto2","amuleto3","amuleto4"]
		var amuleto_vacio = -1
		for i in range(4):
			if equipamiento[amuletos[i]] == null:
				setEquipamiento(amuletos[i],item_id)
				inventario[index_origen] = {
					"id" : null,
					"cantidad" : 0
				}
				emit_signal("inventarioActualizado")
				return
		amuletos.shuffle()
		var equipo_old = getEquipamiento(amuletos[0])
		setEquipamiento(amuletos[0],item_id)
		inventario[index_origen] = {
			"id" : equipo_old,
			"cantidad" : 1
		}
	inventario[index_origen]
	emit_signal("inventarioActualizado")
