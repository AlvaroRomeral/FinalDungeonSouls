extends Node

signal notificacionRecibida(texto)
# Rondas ===========================================================================================
signal rondaIniciada(ronda)
signal rondaFinalizada(ronda)
signal puntuacionGanada(puntos)
signal subirPuntuacion(nombre, puntuacion)
signal enemigoEliminado()
signal enemigoSpawneado()
signal modoPelicula(modo)
signal dineroGastado()
signal oleadaIniciada()
signal oleadaTerminada()

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

var enemigos_spawneados = 0
var enemigos_restantes = 0
var oleada = 0
var enemigo_1_reserva = 0
var enemigo_1 = 0
var enemigo_2_reserva = 0
var enemigo_2 = 0
var enemigo_3_reserva = 0
var enemigo_3 = 0
var tiempo_entre_rondas = 5

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
	emit_signal("notificacionRecibida",texto)


func mostrarAlerta(texto: String):
	Jugador.getInterfaz().addAlerta(texto)


func subirPuntuacion(nombre, puntuacion):
	SilentWolf.Scores.persist_score(nombre, puntuacion)


func siguienteOleada():
	oleada += 1
	var enemigos = Datos.getOleadaEnemigos(oleada)
	enemigo_1 = enemigos["enemigos_1"]
	enemigo_1_reserva = enemigo_1
	print("Enemigos tier 1: " + str(enemigo_1))
	enemigo_2 = enemigos["enemigos_2"]
	enemigo_2_reserva = enemigo_2
	print("Enemigos tier 2: " + str(enemigo_2))
	enemigo_3 = enemigos["enemigos_3"]
	enemigo_3_reserva = enemigo_3
	print("Enemigos tier 3: " + str(enemigo_3))
	emit_signal("oleadaIniciada")


func enemigoElimidado(tipo):
	match tipo:
		1:
			enemigo_1 -= 1
		2:
			enemigo_2 -= 1
		3:
			enemigo_3 -= 1
	if enemigo_1 < 1 and enemigo_2 < 1 and enemigo_3 < 1:
		emit_signal("oleadaTerminada")
