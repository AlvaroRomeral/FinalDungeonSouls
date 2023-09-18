extends CanvasLayer
class_name PantallaInterfaz

@export var jugador:Jugador

@export var label_cooldown_ataque:Label
@export var panel_inventario:PanelInventario
@export_category("Vida")
@export var bar_vida:ProgressBar
@export var label_cantidad_vida:Label
@export var label_max_vida:Label
@export_category("Estamina")
@export var bar_estamina:ProgressBar
@export var label_cantidad_estamina:Label
@export var label_max_estamina:Label
@export_category("Mana")
@export var bar_mana:ProgressBar
@export var label_cantidad_mana:Label
@export var label_max_mana:Label


func _process(_delta):
	if jugador:
		label_cooldown_ataque.text = str(roundf(jugador.cooldown_ataque.time_left))
		var status = jugador.control_estado.get_estado_final()
		bar_vida.max_value = status["salud_max"]
		label_max_vida.text = str(status["salud_max"])
		bar_vida.value = status["salud"]
		label_cantidad_vida.text = str(status["salud"])
		
		bar_estamina.max_value = status["estamina_max"]
		label_max_estamina.text = str(status["estamina_max"])
		bar_estamina.value = status["estamina"]
		label_cantidad_estamina.text = str(status["estamina"])
		
		bar_mana.max_value = status["mana_max"]
		label_max_mana.text = str(status["mana_max"])
		bar_mana.value = status["mana"]
		label_cantidad_mana.text = str(status["mana"])


func _input(event):
	if event.is_action_pressed("INVENTARIO"):
		if panel_inventario.visible:
			panel_inventario.hide()
		else:
			panel_inventario.show()
