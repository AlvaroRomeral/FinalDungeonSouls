extends Control

@export var velocidad_montanas: float = 0.05
@export var velocidad_arboles_fondo: float = 0.3
@export var velocidad_arboles: float = 0.6

func _ready():
	get_tree().paused = false


func _process(delta):
	$ParallaxBackground/ParallaxArbolesFondo.motion_offset.x -= velocidad_arboles_fondo
	$ParallaxBackground/ParallaxMontanas.motion_offset.x -= velocidad_montanas
	$ParallaxBackground/ParallaxArboles.motion_offset.x -= velocidad_arboles


func cargarNivel():
	get_tree().change_scene_to_file(Global.nivel)

# BOTONES PRINCIPALES ==============================================================================

func _on_BtnNuevoJuego_botonPresionado():
	$ColorRect.mouse_filter =Control.MOUSE_FILTER_STOP
	Global.nivel = "res://Niveles/Nivel_Temp.tscn"
	Datos.nuevosDatos()
	Datos.cargarDatos()
	$AnimationPlayer.play("Obscurecer")


func _on_BtnCargar_botonPresionado():
	pass # Replace with function body.


func _on_BtnOpciones_botonPresionado():
	$Opciones.show()


func _on_BtnCreditos_botonPresionado():
	get_tree().change_scene_to_file("res://Pantallas/Menus/MenuCreditos.tscn")


func _on_BtnSalir_botonPresionado():
	Datos.guardarPersistencia()
	print_orphan_nodes()
	get_tree().quit()

# OTROS BOTONES ====================================================================================

func _on_btnJugarTest_botonPresionado():
	Datos.nuevosDatos()
	Datos.cargarDatos()
	get_tree().change_scene_to_file(Global.nivel)


func _on_BtnPantallaCompleta_button_up():
	Datos.ar_persistencia.pantalla_completa = !((get_window().mode == Window.MODE_EXCLUSIVE_FULLSCREEN) or (get_window().mode == Window.MODE_FULLSCREEN))
	Datos.cargarDatosPersistencia()


func _on_btnTestCreacionPersonaje_botonPresionado():
	get_tree().change_scene_to_file("res://Pantallas/Interfaces/CreadorPersonajes.tscn")


func _on_btnScoreboard_botonPresionado():
	get_tree().change_scene_to_file("res://addons/silent_wolf/Scores/Leaderboard.tscn")


func _on_BtnPuntuacion_botonPresionado():
	get_tree().change_scene_to_file("res://Pantallas/Menus/PantallaPuntuacion.tscn")


func _on_HSlider_value_changed(value):
	Datos.ar_persistencia.volumen_musica = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Musica"),value)


func _on_SliderEfectos_value_changed(value):
	Datos.ar_persistencia.volumen_efectos = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Efectos"),value)


func _on_Button_button_up():
	$Opciones.hide()
