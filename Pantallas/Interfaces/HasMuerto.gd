extends Control

onready var anim = $AnimationPlayer

func _on_Control_draw():
	anim.play("Aparece")


func _on_Timer_timeout():
	anim.play("Desaparecer")


func empezarTimer():
	$Timer.start()

func terminaMensaje():
	get_tree().paused=false
	get_tree().change_scene("res://Pantallas/Menus/MenuPrincipal.tscn")
