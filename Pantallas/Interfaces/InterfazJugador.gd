extends CanvasLayer

onready var monedasUI = $PanelMonedas/Monedas
onready var nivelUI = $Panel/Nivel
onready var expbarUI = $Panel/BarraExperiencia
onready var tween_expbar = $Panel/TweenBarraExperiencia
# Tween
onready var tween_vida = $BarraVida/TweenVida
onready var tween_mana = $BarraMana/TweenMana
onready var tween_estamina = $BarraEstamina/TweenStamina
onready var tween_monedas = $PanelMonedas/TweenMonedas
# Barras
onready var vidaUI = $BarraVida
onready var manaUI = $BarraMana
onready var estaminaUI = $BarraEstamina
# Pantallas
onready var inventario = $Inventario
onready var pausa = $MenuPausa
onready var notificacion = preload("res://Componentes/Notificaion.tscn")
onready var alerta = preload("res://Componentes/Alerta.tscn")

var monedas:int = 0

func _ready():
	get_tree().paused = false
	Global.connect("notificacion_recibida",self,"addNotificacion")
	Jugador.connect("datosActualizados",self,"actualizarUI")
	actualizarUI()


func _process(delta):
	$BarraVida/Label.text = str(Jugador.vida) + "/" + str(Jugador.vida_max)
	$BarraMana/Label.text = str(Jugador.mana) + "/" + str(Jugador.mana_max)
	$BarraEstamina/Label.text = str(Jugador.esta) + "/" + str(Jugador.esta_max)
	monedasUI.text = str(monedas)


func actualizarUI():
	vidaUI.max_value = Jugador.vida_max
	manaUI.max_value = Jugador.mana_max
	estaminaUI.max_value = Jugador.esta_max
	tween_vida.interpolate_property(
		vidaUI, #objeto
		"value", #propiedad
		vidaUI.value, #valor inicial
		Jugador.vida, #valor final
		1, #duracion
		Tween.TRANS_LINEAR, #tipo de transicion
		Tween.EASE_IN_OUT #modo de transiccion (Ej: EASE_IN = mas rapido al principio)
	)
	tween_mana.interpolate_property(
		manaUI,
		"value",
		manaUI.value,
		Jugador.mana,
		1,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	tween_estamina.interpolate_property(
		estaminaUI,
		"value",
		estaminaUI.value,
		Jugador.esta,
		1,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	tween_monedas.interpolate_property(
		self,
		"monedas",
		monedas,
		Jugador.monedas,
		1,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	tween_expbar.interpolate_property(
		expbarUI,
		"value",
		expbarUI.value,
		Jugador.experiencia,
		1,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	nivelUI.text = str(Jugador.nivel)
	tween_vida.start()
	tween_mana.start()
	tween_estamina.start()
	tween_monedas.start()
	tween_expbar.start()
	expbarUI.max_value = Datos.getNivelesExpReq()


func _input(event):
	if event.is_action_released("INVENTARIO"):
		if inventario.visible:
			get_tree().paused = false
			inventario.hide()
		elif !pausa.visible:
			get_tree().paused = true
			inventario.show()
	if event.is_action_released("ui_cancel"):
		if pausa.visible:
			get_tree().paused = false
			pausa.hide()
		else:
			get_tree().paused = true
			inventario.hide()
			pausa.show()


func addNotificacion(text):
	var noti_nueva = notificacion.instance()
	$Notificaiones.call_deferred("add_child",noti_nueva)
	noti_nueva.texto = text


func addAlerta(texto):
	var nueva_alerta: Alerta = alerta.instance()
	nueva_alerta.texto = texto
	call_deferred("add_child",nueva_alerta)
