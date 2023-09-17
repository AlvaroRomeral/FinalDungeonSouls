extends Area2D
class_name Hurtbox

@export var control_estado:ControlEstado

func _ready():
	area_entered.connect(damagear)


func damagear(area:Hitbox):
	if control_estado:
		control_estado.recibir_damage(area.datos["damage"])
