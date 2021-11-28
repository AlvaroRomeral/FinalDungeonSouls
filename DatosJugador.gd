extends Node

signal datosActualizados
signal inventarioActualizado

var monedas = 0 setget setMonedas
var vida = 3 setget setVida
var vidaMax = 10 setget setVidaMax
var mana = 10 setget setMana
var manaMax = 10
var estamina = 10 setget setEstamina
var estaminaMax = 10
var ataque = 1 setget setAtaque

var inventario = []

# VALORES ======================================================================

func setMonedas(cantidad):
	monedas += cantidad
	emit_signal("datosActualizados")

func setVida(cantidad):
	vida += cantidad
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


# MAXIMOS ======================================================================

func setVidaMax(cantidad):
	vidaMax = cantidad
	if vida > vidaMax:
		vida = vidaMax
	emit_signal("datosActualizados")

func setAtaque(cantidad):
	ataque += cantidad

# INVENTARIO ===================================================================

func anadirItem(itemData):
	for i in inventario:
		if i["id"] == itemData["id"]:
			i["cantidad"] = i["cantidad"] + itemData["cantidad"]
			emit_signal("inventarioActualizado")
			return
	inventario.append(itemData)
	emit_signal("inventarioActualizado")

func quitarItem():
	pass

func chekearItem(item) -> bool:
	if item in inventario:
		return true
	return false
