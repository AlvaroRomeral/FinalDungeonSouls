extends Area2D

export var damage = 1
export var equipo = 1

func setActico(activo:bool):
	if activo:
		$CollisionShape2D.set_deferred("disabled", false)
	else:
		$CollisionShape2D.set_deferred("disabled", true)
