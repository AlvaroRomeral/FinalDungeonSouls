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
}

var estados = []

func get_estado_final():
	var estado_final = estado_base.duplicate()
	for x in estados:
		for y in x.keys():
			estado_final[y] += x[y]
	return estado_final


func recibir_damage(cantidad:float):
	estado_base["salud"] -= cantidad
	if estado_base["salud"] <= 0:
		muerto.emit()