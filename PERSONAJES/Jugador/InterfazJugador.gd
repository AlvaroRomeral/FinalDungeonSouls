extends CanvasLayer

onready var monedasUI = $PanelMonedas/Monedas
onready var nivelUI = $Panel/Nivel
# Barras
onready var vidaUI = $BarraVida
onready var manaUI = $BarraMana
onready var estaminaUI = $BarraEstamina
# Items
onready var slotArma1 = $PanelSlotArma1
onready var slotArma2 = $PanelSlotArma2
onready var slotItem1 = $PanelSlotItem1
onready var slotItem2 = $PanelSlotItem2
# Pantallas
onready var inventario = $Inventario
onready var notificacion = preload("res://Pantallas/Notificaion.tscn")


func _ready():
	Global.connect("notificacion_recibida",self,"addNotificacion")
	DatosJugador.connect("datosActualizados",self,"actualizarUI")
	DatosJugador.connect("inventarioActualizado",self,"actualizarInventario")
	actualizarUI()

#func _process(delta):
#	pass

func actualizarUI():
	monedasUI.text = String(DatosJugador.monedas)
	vidaUI.max_value = DatosJugador.vidaMax
	manaUI.max_value = DatosJugador.manaMax
	estaminaUI.max_value = DatosJugador.estaminaMax
	vidaUI.value = DatosJugador.vida
	manaUI.value = DatosJugador.mana
	estaminaUI.value = DatosJugador.estamina
	actualizarInventario()


func actualizarInventario():
	if DatosJugador.inventario.size() > 0:
		var item = DatosJugador.inventario[0]
		slotArma1.setValores(item["id"],item["cantidad"])
	else:
		slotArma1.limpiar()
	if DatosJugador.inventario.size() > 1:
		var item = DatosJugador.inventario[1]
		slotItem1.setValores(item["id"],item["cantidad"])
	else:
		slotItem1.limpiar()
	if DatosJugador.inventario.size() > 2:
		var item = DatosJugador.inventario[2]
		slotArma2.setValores(item["id"],item["cantidad"])
	else:
		slotArma2.limpiar()
	if DatosJugador.inventario.size() > 3:
		var item = DatosJugador.inventario[3]
		slotItem2.setValores(item["id"],item["cantidad"])
	else:
		slotItem2.limpiar()


func _input(event):
	if event.is_action_released("ui_cancel"):
		if $MenuPausa.visible:
			$MenuPausa.hide()
		else:
			$MenuPausa.show()
	if event.is_action_released("INVENTARIO"):
		if inventario.visible:
			inventario.hide()
		else:
			inventario.show()
	if event.is_action_released("TECLA_RAPIDA_1"):
		DatosJugador.usarItem(slotArma1.datos)
	if event.is_action_released("TECLA_RAPIDA_2"):
		DatosJugador.usarItem(slotItem1.datos)
	if event.is_action_released("TECLA_RAPIDA_3"):
		DatosJugador.usarItem(slotArma2.datos)
	if event.is_action_released("TECLA_RAPIDA_4"):
		DatosJugador.usarItem(slotItem2.datos)

# ==============================================================================
# ============================== Cargar Partida ================================
# ==============================================================================

func addNotificacion(text):
	var nuevaNoti = notificacion.instance()
	$Notificaiones.call_deferred("add_child",nuevaNoti)
	nuevaNoti.text = text


func _on_Salir_botonPresionado():
	get_tree().change_scene("res://Pantallas/MenuPrincipal.tscn")


func _on_Continuar_botonPresionado():
	$MenuPausa.hide()


func _on_Guardar_botonPresionado():
	Global.guardarDatos()
	Global.guardarPartida()


func _on_Cargar_botonPresionado():
	pass # Replace with function body.
