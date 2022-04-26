extends Node2D

export var damage_arma = 1
export(String, "Enemigo", "Jugador") var propietario

onready var hitbox = $Hitbox
onready var anim = $AnimArma

func usar():
	hitbox.propietario = propietario
	hitbox.damage = damage_arma
	anim.play("Ataque")
