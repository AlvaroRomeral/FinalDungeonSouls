extends Node2D

onready var Enemy = preload("res://Enemigos/Enemigo.tscn")
var Entidad


func spawnearEnemigo():
	Entidad = Enemy.instance()
	Entidad.global_position = global_position
	get_parent().call_deferred("add_child",Entidad)


func _on_Timer_timeout():
	if Entidad == null:
		spawnearEnemigo()
	elif Entidad.vida <= 0:
		spawnearEnemigo()
