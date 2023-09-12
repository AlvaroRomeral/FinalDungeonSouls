extends Node2D

func _ready():
	randomize()
	Global.connect("oleadaTerminada", Callable(self, "timerOleadaSiguiente"))
	empezarModoOleada()

# SISTEMA DE OLEADA ================================================================================

func empezarModoOleada():
	Jugador.puntuacion = 0
	Global.oleada = 0
	Global.emit_signal("oleadaTerminada")


func timerOleadaSiguiente():
	var timer = Timer.new()
	timer.connect("timeout", Callable(self, "timerTerminado"))
	timer.wait_time = Global.tiempo_entre_rondas
	timer.one_shot = true
	add_child(timer)
	timer.start()


func timerTerminado():
	Global.siguienteOleada()
