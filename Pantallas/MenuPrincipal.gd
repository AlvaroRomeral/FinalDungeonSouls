extends Control

func _ready():
	Global.nuevosDatos()

func cargarNivel():
	get_tree().change_scene(Global.Nivel)


func _on_btnJugar_botonPresionado():
	Global.nuevosDatos()
	$AnimationPlayer.play("Obscurecer")


func _on_btnCargar_botonPresionado():
	Global.cargarNivel(Global.Nivel)


func _on_btnSalir_botonPresionado():
	get_tree().quit()


func _on_btnJugarTest_botonPresionado():
	Global.nuevosDatos()
	get_tree().change_scene(Global.Nivel)
