extends Area2D
class_name Hurtbox

@export var control_estado:ControlEstado
@export var control_ataque:ControlAtaque

func _ready():
	area_entered.connect(damagear)


func damagear(area:Hitbox):
	if !control_estado.estado_base["equipo"] == area.datos["atacante"].estado_base["equipo"]:
		control_estado.recibir_damage(area.datos["damage"])
