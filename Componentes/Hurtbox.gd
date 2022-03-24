extends Area2D

onready var tiempoInvencible = $NoDamageTimer
onready var damageIndiator = preload("res://Entidades/Efectos/NumerosDamage.tscn")

signal damageRecivido(cantidad)

var invencible = false


func _on_AreaDamage_area_entered(area):
	if !invencible:
		emit_signal("damageRecivido",area.damage)
		var numerito = damageIndiator.instance()
		numerito.damage = area.damage
		call_deferred("add_child",numerito)
		$AudioStreamPlayer2D.play()
		invencible = true
		tiempoInvencible.start()


func _on_NoDamageTimer_timeout():
	invencible = false
