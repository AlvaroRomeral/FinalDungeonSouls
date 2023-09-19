extends Area2D
class_name Hurtbox

@export var control_estado:ControlEstado
@export var control_arma_ignorado:ControlArma
@export var equipo:String = "Neutral"

func _ready():
	area_entered.connect(damagear)


func damagear(area:Hitbox):
	if control_estado and area != control_arma_ignorado.hitbox:
		control_estado.recibir_damage(area.datos["damage"])
