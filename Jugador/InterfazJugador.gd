extends CanvasLayer

onready var monedasUI = $Monedas
onready var nivelUI = $Nivel
# Barras
onready var vidaUI = $BarraVida
onready var manaUI = $BarraMana
onready var estaminaUI = $BarraEstamina
#Items
onready var slotArma1 = $PanelSlotArma1
onready var slotArma2 = $PanelSlotArma2
onready var slotItem1 = $PanelSlotItem1
onready var slotItem2 = $PanelSlotItem2


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


func actualizarInventario():
	var item = DatosJugador.inventario[0]
	if item != null:
		slotItem1.setCantidad(item["cantidad"])
		slotItem1.setIcono(item["icono"])


func _input(event):
	if event.is_action_released("ui_cancel"):
		get_tree().change_scene("res://Pantallas/MenuPrincipal.tscn")
