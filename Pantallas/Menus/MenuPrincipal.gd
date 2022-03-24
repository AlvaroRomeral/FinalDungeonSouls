extends Control

func _on_btnJugar_botonPresionado():
	Datos.nuevosDatos()
	$AnimationPlayer.play("Obscurecer")


func cargarNivel():
	Global.cambiarNivel(Global.nivel)


func _on_btnCargar_botonPresionado():
	pass #pantalla de cargar


func _on_btnSalir_botonPresionado():
	get_tree().quit()


func _on_btnJugarTest_botonPresionado():
	Datos.nuevosDatos()
	get_tree().change_scene(Global.nivel)
