extends Node2D

onready var Enemy = preload("res://Entidades/Enemigos/Enemigo.tscn")

var Entidad
var en_pantalla

func spawnearEnemigo():
	Entidad = Enemy.instance()
	Entidad.global_position = global_position
	get_parent().call_deferred("add_child",Entidad)


func _on_Timer_timeout():
	if en_pantalla == false:
		if Entidad == null:
			spawnearEnemigo()
		elif Entidad.vida <= 0:
			spawnearEnemigo()


func _on_VisibilityEnabler2D_screen_entered():
	en_pantalla = true
	print("dentro")


func _on_VisibilityEnabler2D_screen_exited():
	en_pantalla = false
	print("fuera")
