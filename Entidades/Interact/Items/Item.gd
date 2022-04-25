extends Area2D
class_name FDS_Item

onready var lbl_ident = $Label

export var item_id: int = 1
export(int, 1, 999) var cantidad: = 1

var interactuable = false

func _ready():
	connect("body_entered",self,"setInteractuable")
	connect("body_exited",self,"removeInteractuable")
	$Sprite.texture = load(Global.PATH_ICONOS + Datos.getItemInfo(item_id)["icono"] + ".png")
	lbl_ident.text = Datos.getItemInfo(item_id)["nombre"]
	if cantidad > 1:
		lbl_ident.text = lbl_ident.text + " (" + String(cantidad) + ")"


func _physics_process(delta):
	if lbl_ident.visible:
		lbl_ident.set_global_position(get_global_mouse_position())


func _input(event):
	if event.is_action_released("INTERACTUAR") and interactuable:
		itemRecogido()


func itemRecogido():
	if item_id == 2:
		Jugador.monedas = cantidad
		queue_free()
		return
	var sobra = Jugador.anadirItem(item_id, cantidad)
	if sobra == 0:
		Global.Notificacion("Recogido " + Datos.getItemInfo(item_id)["nombre"] + "(" + String(cantidad) + ")")
		queue_free()
	else:
		cantidad = sobra


func removeInteractuable(body):
	interactuable  = false


func setInteractuable(body):
	interactuable  = true


func _on_Item_mouse_entered():
	lbl_ident.visible = true


func _on_Item_mouse_exited():
	lbl_ident.visible = false
