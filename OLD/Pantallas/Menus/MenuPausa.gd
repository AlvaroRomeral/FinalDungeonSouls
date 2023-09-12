extends Panel

func _ready():
	hide()


func _on_Continuar_botonPresionado():
	get_tree().paused = false
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
	get_tree().change_scene_to_file("res://Pantallas/Menus/MenuPrincipal.tscn")
