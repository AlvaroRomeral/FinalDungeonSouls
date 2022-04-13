extends Node2D

export var damage_arma = 1
export(String, "Enemigo", "Jugador") var tipo

func _ready():
	$Hitbox.damage = damage_arma


func usar():
	$AnimArma.play("Ataque")


func cambiarEnemigo():
	if tipo == "Enemigo":
		$Hitbox.collision_mask = [6]
	elif tipo == "Jugador":
		$Hitbox.collision_mask = [7]
