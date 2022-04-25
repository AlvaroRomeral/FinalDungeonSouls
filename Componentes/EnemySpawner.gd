extends Node2D

onready var Enemy = preload("res://Entidades/Enemigos/Enemigo.tscn")

var Entidad
var en_pantalla = false

func spawnearEnemigo():
	if Entidad == null or Entidad.vida <= 0:
		if en_pantalla == false:
			Entidad = Enemy.instance()
			Entidad.global_position = global_position
			get_parent().call_deferred("add_child",Entidad)


func _on_Timer_timeout():
	spawnearEnemigo()


func _on_VisibilityEnabler2D_screen_entered():
	en_pantalla = true


func _on_VisibilityEnabler2D_screen_exited():
	en_pantalla = false
