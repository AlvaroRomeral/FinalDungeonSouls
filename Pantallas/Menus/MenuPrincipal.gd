extends Control

export(float) var velocidad_montanas = 0.05
export(float) var velocidad_arboles_fondo = 0.3
export(float) var velocidad_arboles = 0.6

func _process(delta):
	$ParallaxBackground/ParallaxArbolesFondo.motion_offset.x -= velocidad_arboles_fondo
	$ParallaxBackground/ParallaxMontanas.motion_offset.x -= velocidad_montanas
	$ParallaxBackground/ParallaxArboles.motion_offset.x -= velocidad_arboles


func _on_btnJugar_botonPresionado():
	$btnJugarTest.disabled = true
	$VBoxContainer/btnCargar.disabled = true
	$VBoxContainer/btnJugar.disabled = true
	$VBoxContainer/btnSalir.disabled = true
	Datos.nuevosDatos()
	$AnimationPlayer.play("Obscurecer")


func cargarNivel():
	Global.cambiarNivel(Global.nivel)


func _on_btnCargar_botonPresionado():
	pass #pantalla de cargar


func _on_btnSalir_botonPresionado():
	Datos.guardarPersistencia()
	get_tree().quit()


func _on_btnJugarTest_botonPresionado():
	Datos.nuevosDatos()
	get_tree().change_scene(Global.nivel)


func _on_BtnPantallaCompleta_button_up():
	Datos.ar_persistencia.pantalla_completa = !OS.window_fullscreen
	Datos.cargarDatosPersistencia()
