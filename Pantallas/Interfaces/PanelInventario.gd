extends Panel

signal devolverInfo(id)

onready var com_popup = $MenuAcciones
onready var com_cantidad = $Cantidad
onready var com_icono = $Icono

var item_id = null
var item_cantidad = 0
var item_posicion
var clickeado

func _ready():
	com_popup.get_popup().connect("id_pressed",self,"opcionSeleccionada")
	com_popup.disabled = true


func _physics_process(delta):
	if clickeado:
		$Icono.rect_position = lerp($Icono.rect_position, get_global_mouse_position(),25 * delta)

# INICIALIZACION

func setValores(id, cantidad, posicion: int):
	item_id = id
	item_cantidad = cantidad
	item_posicion = posicion
	$MenuAcciones.get_popup().clear()
	if id != null:
		match Datos.getItemTipo(id):
			0:
				$MenuAcciones.get_popup().add_item("Usar",0)
			1:
				$MenuAcciones.get_popup().add_item("Equipar",0)
			2:
				$MenuAcciones.get_popup().add_item("Equipar",0)
			3:
				$MenuAcciones.get_popup().add_item("Consumir",0)
		$MenuAcciones.get_popup().add_item("Soltar",1)
		$MenuAcciones.get_popup().add_item("Descartar",2)
		$MenuAcciones.get_popup().set_item_disabled(1,true)
	setAspecto()


func setAspecto():
	if item_id != null:
		var datos_item = Datos.getItemInfo(item_id)
		$Icono.visible = true
		$Icono.texture = load(Global.PATH_ICONOS + datos_item["icono"])
	else:
		$Icono.visible = false
	if item_cantidad != null:
		if item_cantidad <= 1:
			$Cantidad.hide()
		else:
			$Cantidad.show()
			$Cantidad.text = String(item_cantidad)


func limpiar():
	$Icono.texture = null
	$Cantidad.hide()
	item_id = null
	item_cantidad = null


func opcionSeleccionada(id):
	match id:
		0:
			Jugador.usarItem(item_id)
		1:
			pass
		2:
			Jugador.quitarItemPos(1, item_posicion)


func get_drag_data(position):
	if item_id != null:
		var imagen = Sprite.new()
		imagen.texture = load(Global.PATH_ICONOS + Datos.getItemInfo(item_id)["icono"])
		var control = Control.new()
		control.add_child(imagen)
		set_drag_preview(control)


func _on_PopupMenu_mouse_entered():
	$MenuAcciones.disabled = false
	emit_signal("devolverInfo",item_id)


func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_pressed("ATACAR"):
		clickeado = true
