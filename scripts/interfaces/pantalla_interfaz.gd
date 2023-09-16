extends CanvasLayer
class_name PantallaInterfaz

@export var jugador:Jugador

@export var label_cooldown_ataque:Label
@export var bar_vida:ProgressBar
@export var bar_estamina:ProgressBar
@export var bar_mana:ProgressBar

func _process(_delta):
	if jugador:
		label_cooldown_ataque.text = str(roundf(jugador.cooldown_ataque.time_left))
		var status = jugador.control_estado.get_estado_final()
		bar_vida.max_value = status["salud_max"]
		bar_vida.value = status["salud"]
		bar_estamina.max_value = status["estamina_max"]
		bar_estamina.value = status["estamina"]
		bar_mana.max_value = status["mana_max"]
		bar_mana.value = status["mana"]
