extends CanvasLayer
class_name PantallaMenuPrincipal

@export var boton_nueva_partida:Button
@export var boton_cargar_partida:Button
@export var boton_opciones:Button
@export var boton_puntuacion:Button
@export var boton_salir:Button

func _ready():
	if boton_nueva_partida:
		boton_nueva_partida.pressed.connect(nueva_partida)
	if boton_cargar_partida:
		boton_cargar_partida.pressed.connect(cargar_partida)
	if boton_opciones:
		boton_opciones.pressed.connect(mostrar_opciones)
	if boton_puntuacion:
		boton_puntuacion.pressed.connect(mostrar_puntuaciones)
	if boton_salir:
		boton_salir.pressed.connect(salir_juego)


func nueva_partida():
	get_tree().change_scene_to_file("res://scenes/Nivel_Temp.tscn")


func cargar_partida():
	pass


func mostrar_puntuaciones():
	pass


func mostrar_opciones():
	pass


func mostrar_creditos():
	get_tree().change_scene_to_file("res://Pantallas/Menus/MenuCreditos.tscn")


func salir_juego():
	#guardar datos
	get_tree().quit()
