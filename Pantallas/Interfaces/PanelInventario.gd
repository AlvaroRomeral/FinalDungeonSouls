extends Panel

signal devolverInfo(id)
signal actualizado()

var itemId
var itemCantidad
var datos

func _ready():
	$PopupMenu.get_popup().connect("id_pressed",self,"opcionSeleccionada")

# ==============================================================================
# ================================ VALORES =====================================
# ==============================================================================

func setValores(id: String, cantidad: int):
	itemId = id
	itemCantidad = cantidad
	generarDatos()
	setAspecto()

# ==============================================================================
# ================================ ASPECTO =====================================
# ==============================================================================

func setAspecto():
	$Icono.texture = load(Global.PATH_ICONOS + Datos.items_db[itemId]["icono"])
	if itemCantidad == 1:
		$Cantidad.hide()
	else:
		$Cantidad.show()
		$Cantidad.text = String(itemCantidad)


func limpiar():
	$Icono.texture = null
	$Cantidad.hide()
	itemId = null
	itemCantidad = null
	generarDatos()

# ==============================================================================
# =============================== FUNCIONES ====================================
# ==============================================================================

func generarDatos():
	datos = {
		"id": itemId,
		"cantidad": itemCantidad
	}


func opcionSeleccionada(id):
	match id:
		0:
			Jugador.usarItem(datos)
			emit_signal("actualizado")


func _on_PanelInventario_gui_input(event):
	if event is InputEventMouseButton:
		pass


func _on_PopupMenu_mouse_entered():
	emit_signal("devolverInfo",itemId)
