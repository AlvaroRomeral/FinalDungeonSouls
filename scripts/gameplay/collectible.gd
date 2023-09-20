extends Area2D
class_name Collectible

@export var animacion:AnimationPlayer

func _ready():
	body_entered.connect(recogido)
	animacion.play("idle")


func recogido(_body):
	# body llamar recogida de item
	queue_free()
