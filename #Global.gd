extends Node

const PATH_ICONOS = "res://Recursos/Imagenes/Iconos/"
const PATH_DATOS = "user://data/"
const PATH_SAVES = "user://saves/"
const PATH_DB = "res://Datos/"
const PATH_FSDDB = "res://Datos/fds"

const EXTE_SAVES = ".res"
const EXTE_PERSISTENCIA = ".res"

const RES_ALERTA = preload("res://Componentes/Alerta.tscn")

signal notificacion_recibida(texto)

var nivel: String = "res://Niveles/Test.tscn"

func _ready():
	SilentWolf.configure({
		"api_key": "JfoawfqtBo4511Wujjwba5ZgQdQ35YKG4xSMPywe",
		"game_id": "FinalDungeonSouls",
		"game_version": "0.1.0",
		"log_level": 1
	})
	SilentWolf.configure_scores({
		"open_scene_on_close": "res://Pantallas/Menus/MenuPrincipal.tscn"
	})

# print("Hola {nombre}, vete, no aceptamos viejos de {edad} años".format(DatosJugador.datosPersonales))

func cambiarNivel(nivel):
	get_tree().change_scene(nivel)


func Notificacion(texto: String):
	emit_signal("notificacion_recibida",texto)


func mostrarAlerta(texto: String):
	Jugador.getInterfaz().addAlerta(texto)
	
