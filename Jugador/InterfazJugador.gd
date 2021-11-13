extends CanvasLayer

onready var monedasUI = $Panel_Dinero/Monedas
onready var nivelUI = $Panel_Nivel/Nivel
onready var vidaUI = $BarraVida
onready var manaUI = $BarraMana
onready var estaminaUI = $BarraEstamina

func _ready():
	DatosJugador.connect("datosActualizados",self,"actualizarUI")

#func _process(delta):
#	pass

func actualizarUI():
	monedasUI.text = String(DatosJugador.monedas)
	vidaUI.max_value = DatosJugador.vidaMax
	vidaUI.value = DatosJugador.vida
	

func _input(event):
	if event.is_action_released("ui_cancel"):
		get_tree().change_scene("res://Pantallas/MenuPrincipal.tscn")
