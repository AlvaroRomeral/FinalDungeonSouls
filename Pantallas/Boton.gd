extends Button

signal botonPresionado

export var texto = "texto"


func _ready():
	text = texto


func _on_Boton_mouse_entered():
	$Audio_Select.play()
	grab_focus()


func _on_Boton_button_up():
	$Audio_Ok.play()
	emit_signal("botonPresionado")
