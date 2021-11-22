extends Control

func _ready():
	pass

func cargarNivel():
	get_tree().change_scene("res://Niveles/Test.tscn")


func _on_btnJugar_botonPresionado():
	$AnimationPlayer.play("Obscurecer")


func _on_btnCargar_botonPresionado():
	pass # Replace with function body.


func _on_btnSalir_botonPresionado():
	get_tree().quit()
