extends Area2D
class_name ResItem

export var item_id: int = 0
export(int, 1, 999) var cantidad: = 1

var interactuable = false

func _ready():
	$Sprite.texture = load(Global.PATH_ICONOS + Datos.getItemInfo(item_id)["icono"])


func _input(event):
	if event.is_action_released("INTERACTUAR") and interactuable:
		itemRecogido()


func itemRecogido():
	var sobra = Jugador.anadirItem(item_id, cantidad)
	if sobra == 0:
		Global.Notificacion("Recogido " + Datos.getItemInfo(item_id)["nombre"] + "(" + String(cantidad) + ")")
		queue_free()
	else:
		cantidad = sobra


func _on_FrascoVida_body_entered(body):
	interactuable = true


func _on_Item_body_exited(body):
	interactuable = false
