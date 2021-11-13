extends Area2D

onready var tiempoInvencible = $NoDamageTimer

signal damageRecivido(cantidad)

var invencible = false

func _on_AreaDamage_area_entered(area):
	if !invencible:
		emit_signal("damageRecivido",area.damage)
		invencible = true
		tiempoInvencible.start()

func _on_NoDamageTimer_timeout():
	invencible = false
