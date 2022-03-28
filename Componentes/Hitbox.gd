extends Area2D

export var damage = 1
export var activo = true

var empuje = Vector2.ZERO

func _physics_process(delta):
	if activo:
		$CollisionShape2D.disabled = false
	else:
		$CollisionShape2D.disabled = true
