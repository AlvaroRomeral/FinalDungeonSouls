extends Panel


func _ready():
	hide()


func _input(event):
	if event.is_action_released("ui_cancel"):
		if visible:
			hide()
		else:
			show()


func _on_Continuar_botonPresionado():
	hide()


func _on_Guardar_botonPresionado():
	pass # Replace with function body.


func _on_Cargar_botonPresionado():
	pass # Replace with function body.


func _on_Salir_botonPresionado():
	get_tree().change_scene("res://Pantallas/Menus/MenuPrincipal.tscn")
