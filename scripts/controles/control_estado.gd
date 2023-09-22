extends Node
class_name ControlEstado

signal estado_modificado()
signal muerto()

@export_subgroup("stats base")
@export var salud = 10
@export var salud_max = 10
@export var estamina = 1
@export var estamina_max = 10
@export var mana = 1
@export var mana_max = 10
@export var equipo = 1
@export_category("componentes (no tocar)")
@export var animacion:AnimationPlayer
@export var estados:Node

var estado_actual:Dictionary


func _ready():
	# estado_actual = {
	# 	"salud" : salud,
	# 	"salud_max" : 10,
	# 	"estamina" : 1,
	# 	"estamina_max" : 10,
	# 	"mana" : 1,
	# 	"mana_max" : 10,
	# 	"equipo" : 1,
	# }
	estado_actual["salud"] = salud
	estado_actual["salud_max"] = salud_max
	estado_actual["estamina"] = estamina
	estado_actual["estamina_max"] = estamina_max
	estado_actual["mana"] = mana
	estado_actual["mana_max"] = mana_max
	estado_actual["equipo"] = equipo


func get_estado_final():
	# for x in estados.get_children():
	# 	for y in x.keys():
	# 		estado_actual[y] += x[y]
	return estado_actual


func recibir_damage(cantidad:float):
	if animacion:
		animacion.stop()
		animacion.play("herido")

	estado_actual["salud"] -= cantidad
	estado_modificado.emit()

	if estado_actual["salud"] <= 0:
		muerto.emit()