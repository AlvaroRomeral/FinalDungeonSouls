extends Area2D

export var item_id: int = 0
export var cantidad: int = 1

func _ready():
	$Sprite.texture = load(Global.PATH_ICONOS + Datos.getItemInfo(item_id)["icono"])


func itemRecogido():
	Jugador.anadirItem(item_id, cantidad)
	Global.Notificacion(String(item_id))
	queue_free()


func _on_FrascoVida_body_entered(body):
	itemRecogido()
