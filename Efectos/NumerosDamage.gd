extends Control


export var damage = 0


func _ready():
	$Label.text = String(damage)
	$AnimationPlayer.play("play")


func borrar():
	queue_free()
