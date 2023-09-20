extends Node2D
class_name ControlAtaque

@export var control_estado:ControlEstado
@export_category("componentes (no toar")
@export var animacion:AnimationPlayer
@export var hitbox:Hitbox
@export var sprite:Sprite2D

func _ready():
	hitbox.datos["atacante"] = control_estado


func atacar(direccion:Vector2):
	sprite.look_at(direccion)
	animacion.play("ataque")