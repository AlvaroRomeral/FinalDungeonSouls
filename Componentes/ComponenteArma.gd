extends Node2D

export var damage_arma = 1

func _ready():
	$Hitbox.damage = damage_arma


func usar():
	$AnimArma.play("Ataque")
