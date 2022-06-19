extends Control

onready var anim = $AnimationPlayer
onready var nombreInput = $Panel/LineEdit
onready var botonSubir = $Panel/Button

func _on_Control_draw():
	anim.play("Aparece")


func volverMenuPrincipal():
	get_tree().change_scene("res://Pantallas/Menus/MenuPrincipal.tscn")


func _on_Label_draw():
	$Panel/Label.text = "Puntuacion: " + str(Jugador.puntuacion)


func _on_LineEdit_text_changed(new_text):
	if nombreInput.text == "":
		botonSubir.disabled = true
	else:
		botonSubir.disabled = false


func _on_Button_button_up():
	Global.subirPuntuacion(nombreInput.text, Jugador.puntuacion)
	volverMenuPrincipal()


func _on_ButtonSalir_button_up():
	volverMenuPrincipal()
