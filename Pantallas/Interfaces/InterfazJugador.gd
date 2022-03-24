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
onready var notificacion = preload("res://Componentes/Notificaion.tscn")


func _ready():
	Global.connect("notificacion_recibida",self,"addNotificacion")
	Jugador.connect("datosActualizados",self,"actualizarUI")
	Jugador.connect("inventarioActualizado",self,"actualizarInventario")
	actualizarUI()

#func _process(delta):
#	pass

func actualizarUI():
	monedasUI.text = String(Jugador.monedas)
	vidaUI.max_value = Jugador.vida_max
	manaUI.max_value = Jugador.mana_max
	estaminaUI.max_value = Jugador.estamina_max
	vidaUI.value = Jugador.vida
	manaUI.value = Jugador.mana
	estaminaUI.value = Jugador.estamina
	actualizarInventario()


func actualizarInventario():
	if Jugador.inventario.size() > 0:
		var item = Jugador.inventario[0]
		slotArma1.setValores(item["id"],item["cantidad"])
	else:
		slotArma1.limpiar()
	if Jugador.inventario.size() > 1:
		var item = Jugador.inventario[1]
		slotItem1.setValores(item["id"],item["cantidad"])
	else:
		slotItem1.limpiar()
	if Jugador.inventario.size() > 2:
		var item = Jugador.inventario[2]
		slotArma2.setValores(item["id"],item["cantidad"])
	else:
		slotArma2.limpiar()
	if Jugador.inventario.size() > 3:
		var item = Jugador.inventario[3]
		slotItem2.setValores(item["id"],item["cantidad"])
	else:
		slotItem2.limpiar()


func _input(event):
	if event.is_action_released("INVENTARIO"):
		if inventario.visible:
			inventario.hide()
		else:
			inventario.show()
	if event.is_action_released("TECLA_RAPIDA_1"):
		Jugador.usarItem(slotArma1.datos)
	if event.is_action_released("TECLA_RAPIDA_2"):
		Jugador.usarItem(slotItem1.datos)
	if event.is_action_released("TECLA_RAPIDA_3"):
		Jugador.usarItem(slotArma2.datos)
	if event.is_action_released("TECLA_RAPIDA_4"):
		Jugador.usarItem(slotItem2.datos)


func addNotificacion(text):
	var nuevaNoti = notificacion.instance()
	$Notificaiones.call_deferred("add_child",nuevaNoti)
	nuevaNoti.text = text
