extends Area2D

export var cantidad = 1
export (String,"vida","dinero") var tipo = "dinero"

func _ready():
	match tipo:
		"vida":
			$AnimatedSprite.animation = "Vida"
		"dinero":
			$AnimatedSprite.animation = "Moneda"

func itemRecogida():
	match tipo:
		"vida":
			DatosJugador.setVida(cantidad)
		"dinero":
			DatosJugador.setMonedas(cantidad)
	queue_free()

func _on_Moneda_body_entered(body):
	itemRecogida()
