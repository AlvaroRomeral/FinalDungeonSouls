extends Area2D

@export var cantidad = 1

func _ready():
	$AnimationPlayer.play("Idle")


func itemRecogido():
	Jugador.setMonedas(cantidad)
	queue_free()


func _on_Moneda_body_entered(body):
	itemRecogido()
