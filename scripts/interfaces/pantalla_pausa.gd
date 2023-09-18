extends CanvasLayer
class_name PantallaPausa

@export var boton_continuar:Button
@export var boton_opciones:Button
@export var boton_salir:Button

func _ready():
	boton_continuar.pressed.connect(continuar)
	boton_opciones.pressed.connect(mostrar_opciones)
	boton_salir.pressed.connect(salir)


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		show()
		get_tree().paused = true


func continuar():
	get_tree().paused = false
	hide()


func mostrar_opciones():
	pass


func salir():
	get_tree().paused = false
	get_tree().change_scene_to_file(Global.MENU_PRINCIPAL)