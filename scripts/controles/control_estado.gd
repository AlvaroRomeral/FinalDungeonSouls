extends Node
class_name ControlEstado

signal muerto()

@export var estado_base = {
	"salud" : 10,
	"salud_max" : 10,
	"estamina" : 1,
	"estamina_max" : 10,
	"mana" : 1,
	"mana_max" : 10,
	"equipo" : 1,
}
@export_category("componentes (no tocar)")
@export var animacion:AnimationPlayer
@export var estados:Node

var estado_actual


func _ready():
	estado_actual = estado_base.duplicate()


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
	if estado_actual["salud"] <= 0:
		muerto.emit()