extends Node2D

@export var damage_arma = 1

@onready var hitbox = $Hitbox
@onready var anim = $AnimArma

func _ready():
	$Hitbox/CollisionShape2D.disabled = true


func usar():
	hitbox.damage = damage_arma
	anim.play("Ataque")
