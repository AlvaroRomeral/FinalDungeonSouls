extends Area2D

export var cantidad = 1

func _ready():
	pass


func itemRecogido():
	DatosJugador.setVida(cantidad)
	queue_free()


func _on_FrascoVida_body_entered(body):
	itemRecogido()
