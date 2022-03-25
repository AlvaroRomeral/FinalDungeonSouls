extends Panel

signal devolverInfo(id)
signal actualizado()

var item_id
var item_cantidad
var item_posicion

func _ready():
	$PopupMenu.get_popup().connect("id_pressed",self,"opcionSeleccionada")

# INICIALIZACION

func setValores(id: int, cantidad: int, posicion: int):
	item_id = id
	item_cantidad = cantidad
	item_posicion = posicion
	setAspecto()


func setAspecto():
	var datos_item = Datos.getItemInfo(item_id)
	$Icono.texture = load(Global.PATH_ICONOS + datos_item["icono"])
	if item_cantidad == 1:
		$Cantidad.hide()
	else:
		$Cantidad.show()
		$Cantidad.text = String(item_cantidad)


func limpiar():
	$Icono.texture = null
	$Cantidad.hide()
	item_id = null
	item_cantidad = null

# ==============================================================================
# =============================== FUNCIONES ====================================
# ==============================================================================

func opcionSeleccionada(id):
	match id:
		0:
			Jugador.usarItem(item_id)
			emit_signal("actualizado")


func _on_PanelInventario_gui_input(event):
	if event is InputEventMouseButton:
		pass


func _on_PopupMenu_mouse_entered():
	emit_signal("devolverInfo",item_id)
