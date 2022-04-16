extends Panel


func _ready():
	hide()


func _on_Continuar_botonPresionado():
	hide()


func _on_Guardar_botonPresionado():
	Datos.guardarDatos()
	Datos.guardarPartida()
	Datos.guardarNivel()


func _on_Cargar_botonPresionado():
	Datos.cargarPartida()
	Datos.cargarDatos()
	Datos.cargarNivel()


func _on_Salir_botonPresionado():
	get_tree().change_scene("res://Pantallas/Menus/MenuPrincipal.tscn")
