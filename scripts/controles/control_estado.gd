extends Node
class_name ControlEstado

signal estado_modificado()
signal just_muerto()

@export var curva_exp:Curve
@export var control_equipo:ControlEquipo
@export_subgroup("stats base")
@export var estado_base:Dictionary = {
	"salud": 10,
	"salud_max": 10,
	"estamina": 10,
	"estamina_max": 10,
	"mana": 10,
	"mana_max": 10,
	"ataque": 0,
	"armadura": 0,
	"velocidad": 0,
	"equipo": 1,
	"nivel": 1,
	"experiencia": 0,
	"muerto": false,
}
@export_category("componentes (no tocar)")
@export var animacion:AnimationPlayer
@export var estados:Node

var estado_actual:Dictionary

func _ready():
	if control_equipo:
		control_equipo.equipo_modificado.connect(calcular_estado_actual)
	calcular_estado_inicial()


func calcular_estado_inicial():
	estado_actual["salud"] = estado_base["salud"]
	estado_actual["salud_max"] = estado_base["salud_max"]
	estado_actual["estamina"] = estado_base["estamina"]
	estado_actual["estamina_max"] = estado_base["estamina_max"]
	estado_actual["mana"] = estado_base["mana"]
	estado_actual["mana_max"] = estado_base["mana_max"]
	estado_actual["ataque"] = estado_base["ataque"]
	estado_actual["armadura"] = estado_base["armadura"]
	estado_actual["velocidad"] = estado_base["velocidad"]
	estado_actual["equipo"] = estado_base["equipo"]
	estado_actual["nivel"] = estado_base["nivel"]
	estado_actual["experiencia"] = estado_base["experiencia"]
	estado_actual["muerto"] = estado_base["muerto"]


func calcular_estado_actual():
	estado_actual["salud_max"] = estado_base["salud_max"]
	estado_actual["estamina_max"] = estado_base["estamina_max"]
	estado_actual["mana_max"] = estado_base["mana_max"]
	estado_actual["ataque"] = estado_base["ataque"]
	estado_actual["armadura"] = estado_base["armadura"]
	estado_actual["velocidad"] = estado_base["velocidad"]

	aplicar_equipo()
		

func aplicar_equipo():
	if control_equipo:
		if control_equipo.slot_cabeza.id != "":
			sumar_stats_item(control_equipo.slot_cabeza.id)
		if control_equipo.slot_cuerpo.id != "":
			sumar_stats_item(control_equipo.slot_cuerpo.id)
		if control_equipo.slot_brazos.id != "":
			sumar_stats_item(control_equipo.slot_brazos.id)
		if control_equipo.slot_piernas.id != "":
			sumar_stats_item(control_equipo.slot_piernas.id)
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


func recibir_damage(cantidad:float):
	if animacion:
		animacion.stop()
		animacion.play("herido")

	estado_actual.salud -= cantidad
	estado_modificado.emit()

	if estado_actual.salud <= 0:
		estado_actual.muerto = true
		just_muerto.emit()


func is_muerto():
	return estado_actual.muerto

		
func exp_necesaria(valor:float):
	var posicion = valor/200
	return floor(100 * curva_exp.sample(posicion))


func add_experiencia(cantidad:float):
	estado_actual.experiencia += cantidad
	while estado_actual.experiencia > exp_necesaria(estado_actual.nivel):
		estado_actual.experiencia -= exp_necesaria(estado_actual.nivel)
		estado_actual.nivel += 1
		estado_modificado.emit()
	estado_modificado.emit()


func sumar_stats_item(id:String):
	var datos = DatosManager.get_item(id)
	estado_actual["salud_max"] += datos.stats_bases["vida"]
	estado_actual["mana_max"] += datos.stats_bases["mana"]
	estado_actual["estamina_max"] += datos.stats_bases["estamina"]
	estado_actual["ataque"] += datos.stats_bases["ataque"]
	estado_actual["armadura"] += datos.stats_bases["armadura"]
	estado_actual["velocidad"] += datos.stats_bases["velocidad"]
