extends Area2D

export var cantidad = 1
export var itemData = {
	"id": 0000,
	"icono": "Frasco_VidaP.png",
	"cantidad": 1
}

func _ready():
	pass


func itemRecogido():
	DatosJugador.anadirItem(itemData)
	DatosJugador.setVida(cantidad)
	queue_free()


func _on_FrascoVida_body_entered(body):
	itemRecogido()
