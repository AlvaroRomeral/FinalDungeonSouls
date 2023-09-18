extends Node2D
class_name ControlArma

@export var animacion:AnimationPlayer
@export var hitbox:Hitbox
@export var sprite:Sprite2D

func atacar(direccion:Vector2):
	sprite.look_at(direccion)
	animacion.play("ataque")
