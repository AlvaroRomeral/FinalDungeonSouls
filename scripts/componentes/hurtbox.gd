extends Area2D
class_name Hurtbox

@export var control_estado:ControlEstado
@export var control_ataque:ControlAtaque

func _ready():
	area_entered.connect(damagear)


func damagear(area:Hitbox):
	if !control_estado.estado_actual["equipo"] == area.datos["atacante"].estado_actual["equipo"]:
		control_estado.recibir_damage(area.datos["damage"])
