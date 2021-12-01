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


func _ready():
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
		slotArma1.setCantidad(item["cantidad"])
		slotArma1.setIcono(Global.itemData[item["id"]]["icono"])
	if DatosJugador.inventario.size() > 1:
		var item = DatosJugador.inventario[1]
		slotItem1.setCantidad(item["cantidad"])
		slotItem1.setIcono(Global.itemData[item["id"]]["icono"])
	if DatosJugador.inventario.size() > 2:
		var item = DatosJugador.inventario[2]
		slotArma2.setCantidad(item["cantidad"])
		slotArma2.setIcono(Global.itemData[item["id"]]["icono"])
	if DatosJugador.inventario.size() > 3:
		var item = DatosJugador.inventario[3]
		slotItem2.setCantidad(item["cantidad"])
		slotItem2.setIcono(Global.itemData[item["id"]]["icono"])


func _input(event):
	if event.is_action_released("ui_cancel"):
		get_tree().change_scene("res://Pantallas/MenuPrincipal.tscn")
	if event.is_action_released("INVENTARIO"):
		if inventario.visible:
			inventario.hide()
		else:
			inventario.show()
