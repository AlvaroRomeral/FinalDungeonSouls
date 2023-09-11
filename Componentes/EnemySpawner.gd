extends Node2D

@onready var enemigo_1 = preload("res://Entidades/Enemigos/Enemigo.tscn")
@onready var enemigo_2 = preload("res://Entidades/Enemigos/Enemigo_2.tscn")
@onready var enemigo_3 = preload("res://Entidades/Enemigos/Enemigo_3.tscn")

var activo = false

func _ready():
	Global.connect("oleadaIniciada", Callable(self, "reactivar"))


func spawnearEnemigo():
	if activo:
		var enemigo
		var tier = 0
		if Global.enemigo_1_reserva > 0:
			tier = 1
		elif Global.enemigo_2_reserva > 0:
			tier = 2
		elif Global.enemigo_3_reserva > 0:
			tier = 3
		match tier:
			0:
				activo = false
				return
			1:
				enemigo = enemigo_1.instantiate()
				Global.enemigo_1_reserva -= 1
			2:
				enemigo = enemigo_2.instantiate()
				Global.enemigo_2_reserva -= 1
			3:
				enemigo = enemigo_3.instantiate()
				Global.enemigo_3_reserva -= 1
		enemigo.global_position = global_position
		get_parent().call_deferred("add_child",enemigo)
		Global.emit_signal("enemigoSpawneado")


func reactivar():
	activo = true


func _on_Timer_timeout():
	spawnearEnemigo()
