extends Node2D
class_name ControlArma

@export var animacion:AnimationPlayer
@export var hitbox:Hitbox
@export var sprite:Sprite2D

func atacar():
	# if get_global_mouse_position().x < global_position.x:
	# 	sprite.flip_h = true
	# else:
	# 	sprite.flip_h = false
	sprite.look_at(get_global_mouse_position())
	animacion.play("ataque")
