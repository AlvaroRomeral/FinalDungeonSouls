extends Node2D
class_name ControlAtaque

@export var control_estado:ControlEstado
@export_category("componentes (no toar")
@export var animacion:AnimationPlayer
@export var hitbox:Hitbox
@export var sprite:Sprite2D
@export var cooldown:Timer

func _ready():
	hitbox.datos["atacante"] = control_estado


func atacar(direccion:Vector2):
	if cooldown.is_stopped():
		cooldown.start()
		hitbox.datos["damage"] = control_estado.estado_actual["ataque"]
		sprite.look_at(direccion)
		animacion.play("ataque")