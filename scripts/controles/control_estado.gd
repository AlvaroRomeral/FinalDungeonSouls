extends Node
class_name ControlEstado

signal estado_modificado()
signal muerto()

@export var curva_exp:Curve
@export var control_equipo:ControlEquipo
@export_subgroup("stats base")
@export var salud = 10
@export var salud_max = 10

@export var estamina = 1
@export var estamina_max = 10

@export var mana = 1
@export var mana_max = 10

@export var equipo = 1

@export var nivel = 1
@export var experiencia = 0
@export_category("componentes (no tocar)")
@export var animacion:AnimationPlayer
@export var estados:Node

var estado_actual:Dictionary

func _ready():
	estado_actual["salud"] = salud
	estado_actual["salud_max"] = salud_max
	estado_actual["estamina"] = estamina
	estado_actual["estamina_max"] = estamina_max
	estado_actual["mana"] = mana
	estado_actual["mana_max"] = mana_max
	estado_actual["equipo"] = equipo
	estado_actual["nivel"] = nivel
	estado_actual["experiencia"] = experiencia


func calcular_estado_actual():
	estado_actual["salud"] = salud
	estado_actual["salud_max"] = salud_max
	estado_actual["estamina"] = estamina
	estado_actual["estamina_max"] = estamina_max
	estado_actual["mana"] = mana
	estado_actual["mana_max"] = mana_max
	estado_actual["equipo"] = equipo
	estado_actual["nivel"] = nivel
	estado_actual["experiencia"] = experiencia

	if control_equipo:
		if control_equipo.slot_cabeza.id != "":
			sumar_stats_item(control_equipo.slot_cabeza.id)
		if control_equipo.slot_cuerpo.id != "":
			sumar_stats_item(control_equipo.slot_cuerpo.id)
		if control_equipo.slot_brazos.id != "":
			sumar_stats_item(control_equipo.slot_brazos.id)
		if control_equipo.slot_pierna.id != "":
			sumar_stats_item(control_equipo.slot_pierna.id)
		if control_equipo.slot_arma.id != "":
			sumar_stats_item(control_equipo.slot_arma.id)
		if control_equipo.slot_trinket_1.id != "":
			sumar_stats_item(control_equipo.slot_trinket_1.id)
		if control_equipo.slot_trinket_2.id != "":
			sumar_stats_item(control_equipo.slot_trinket_2.id)
		if control_equipo.slot_trinket_3.id != "":
			sumar_stats_item(control_equipo.slot_trinket_3.id)
		if control_equipo.slot_trinket_4.id != "":
			sumar_stats_item(control_equipo.slot_trinket_4.id)
		
	# for x in estados.get_children():
	# 	for y in x.keys():
	# 		estado_actual[y] += x[y]


func recibir_damage(cantidad:float):
	if animacion:
		animacion.stop()
		animacion.play("herido")

	salud -= cantidad
	estado_modificado.emit()

	if salud <= 0:
		muerto.emit()

		
func exp_necesaria(valor:float):
	var posicion = valor/200
	return floor(100 * curva_exp.sample(posicion))


func add_experiencia(cantidad:float):
	experiencia += cantidad
	while experiencia > exp_necesaria(nivel):
		experiencia -= exp_necesaria(nivel)
		nivel += 1
		estado_modificado.emit()
	estado_modificado.emit()


func sumar_stats_item(id:String):
	var datos = DatosManager.get_item(id)
	estado_actual["salud_max"] = datos.vida
	estado_actual["mana_max"] = datos.mana
	estado_actual["estamina_max"] = datos.estamina
	estado_actual["estamina_max"] = datos.ataque
	estado_actual["mana"] = datos.armadura
	estado_actual["mana_max"] = datos.velocidad
