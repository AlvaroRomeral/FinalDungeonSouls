extends Area2D
class_name Collectible

@export var id:String
@export var cantidad:int
@export var animacion:AnimationPlayer

func _ready():
	body_entered.connect(recogido)
	animacion.play("idle")


func recogido(body:Jugador):
	if id and cantidad:
		if body.control_equipo.item_annadido(id, cantidad):
			queue_free()