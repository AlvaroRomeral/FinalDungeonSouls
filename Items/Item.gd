extends Area2D

export var itemId: String = "1001"
export var itemCantidad: int = 1

var datos

func _ready():
	datos = {
		"id": itemId,
		"cantidad": itemCantidad
	}
	$Sprite.texture = load(Global.PATH_ICONOS + Global.itemData[itemId]["icono"])


func itemRecogido():
	DatosJugador.anadirItem(datos)
	Global.Notificacion(String(datos))
	queue_free()


func _on_FrascoVida_body_entered(body):
	itemRecogido()
