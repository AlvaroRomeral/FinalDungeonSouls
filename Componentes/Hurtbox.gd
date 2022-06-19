extends Area2D

signal recibeDamage(damage,posicion)
signal enShock()
signal noShock()

onready var tiempoInvencible = $NoDamageTimer
onready var damageIndiator = preload("res://Entidades/Efectos/NumerosDamage.tscn")

var invencible = false
var ultimoDamage = 0
export var equipo = 1 

func mostrarDamageEfecto(damage):
	var numerito = damageIndiator.instance()
	numerito.damage = damage
	call_deferred("add_child",numerito)


func _on_AreaDamage_area_entered(area):
	if !invencible and area.equipo != equipo:
		mostrarDamageEfecto(area.damage)
		invencible = true
		$CollisionShape2D.set_deferred("disabled",true)
		emit_signal("enShock")
		emit_signal("recibeDamage",area.damage,area.global_position)
		tiempoInvencible.start()


func _on_NoDamageTimer_timeout():
	invencible = false
	$CollisionShape2D.set_deferred("disabled",false)
	emit_signal("noShock")
