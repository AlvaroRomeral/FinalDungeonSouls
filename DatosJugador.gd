extends Node

signal datosActualizados

var monedas = 0 setget setMonedas
var vida = 10 setget setVida
var vidaMax = 10 setget setVidaMax
var mana = 10 setget setMana
var manaMax = 10
var estamina = 10 setget setEstamina
var estaminaMax = 10
var ataque = 1 setget setAtaque

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
