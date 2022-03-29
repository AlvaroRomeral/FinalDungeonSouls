extends CanvasLayer

onready var monedasUI = $PanelMonedas/Monedas
onready var nivelUI = $Panel/Nivel
# Barras
onready var vidaUI = $BarraVida
onready var manaUI = $BarraMana
onready var estaminaUI = $BarraEstamina
# Pantallas
onready var inventario = $Inventario
onready var notificacion = preload("res://Componentes/Notificaion.tscn")


func _ready():
	Global.connect("notificacion_recibida",self,"addNotificacion")
	Jugador.connect("datosActualizados",self,"actualizarUI")
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


func _input(event):
	if event.is_action_released("INVENTARIO"):
		if inventario.visible:
			inventario.hide()
		else:
			inventario.show()


func addNotificacion(text):
	var noti_nueva = notificacion.instance()
	$Notificaiones.call_deferred("add_child",noti_nueva)
	noti_nueva.texto = text
