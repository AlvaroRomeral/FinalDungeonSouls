extends Area2D

export var item = {
	"id": "1001",
	"cantidad": 1
	}

func _ready():
	pass


func itemRecogido():
	DatosJugador.anadirItem(item)
	queue_free()


func _on_FrascoVida_body_entered(body):
	itemRecogido()
