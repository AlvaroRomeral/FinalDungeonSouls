extends Node2D
class_name ControlArma

@export var animacion:AnimationPlayer
@export var sprite:Sprite2D

func atacar():
	if get_global_mouse_position().x < global_position.x:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

	animacion.play("ataque")