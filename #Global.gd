extends Node

signal notificacion_recibida(texto)
signal ronda_iniciada(ronda)
signal ronda_finalizada
signal puntuacion_ganada(puntos)

const PATH_ICONOS = "res://Recursos/Imagenes/Iconos/"
const PATH_CASCOS = "res://Recursos/Imagenes/Sprites/Equipo/Cabeza/"
const PATH_TORSOS = "res://Recursos/Imagenes/Sprites/Equipo/Pecho/"
const PATH_PIERNAS = "res://Recursos/Imagenes/Sprites/Equipo/Piernas/"
const PATH_PIES = "res://Recursos/Imagenes/Sprites/Equipo/Pies/"
const PATH_EQUIPO = "res://Recursos/Imagenes/Sprites/Equipo/Armas/"
const PATH_CUERPOS = "res://Recursos/Imagenes/Sprites/Cuerpo/"

const PATH_DATOS = "user://data/"
const PATH_SAVES = "user://saves/"
const PATH_DB = "res://Datos/"
const PATH_FSDDB = "res://Datos/fds"

const EXTE_SAVES = ".res"
const EXTE_PERSISTENCIA = ".res"

const RES_ALERTA = preload("res://Componentes/Alerta.tscn")

var nivel: String = "res://Niveles/Test.tscn"
var ronda_actual = 1
var enemigos_restantes = 1

func _ready():
	SilentWolf.configure({
		"api_key": "JfoawfqtBo4511Wujjwba5ZgQdQ35YKG4xSMPywe",
		"game_id": "FinalDungeonSouls",
		"game_version": "0.3",
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

# RONDAS ===========================================================================================

func enemigoEliminado():
	if enemigos_restantes <= 0 and isEnemigosVivos():
		siguienteRonda()


func isEnemigosVivos():
	if get_tree().get_nodes_in_group("enemigos").size() > 0:
		return true
	return false


func siguienteRonda():
	ronda_actual += 1
	emit_signal("ronda_finalizada")
