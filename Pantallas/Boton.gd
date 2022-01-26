extends Button

signal botonPresionado

#export var texto = "texto"


func _ready():
	if disabled:
		focus_mode = Control.FOCUS_NONE
#	text = texto


func _on_Boton_mouse_entered():
	if !disabled:
		$Audio_Select.play()
		grab_focus()


func _on_Boton_button_up():
	if !disabled:
		$Audio_Ok.play()
		emit_signal("botonPresionado")
