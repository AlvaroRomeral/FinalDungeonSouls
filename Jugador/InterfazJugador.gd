extends CanvasLayer

onready var monedasUI = $Panel_Dinero/Monedas
onready var nivelUI = $Panel_Nivel/Nivel
onready var vidaUI = $BarraVida
onready var manaUI = $BarraMana
onready var estaminaUI = $BarraEstamina

func _ready():
	DatosJugador.connect("datosActualizados",self,"actualizarUI")
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
	

func _input(event):
	if event.is_action_released("ui_cancel"):
		get_tree().change_scene("res://Pantallas/MenuPrincipal.tscn")
