extends Control

func _ready():
	pass

func cargarNivel():
	get_tree().change_scene(Global.Nivel)


func _on_btnJugar_botonPresionado():
	$AnimationPlayer.play("Obscurecer")


func _on_btnCargar_botonPresionado():
	pass # Replace with function body.


func _on_btnSalir_botonPresionado():
	get_tree().quit()


func _on_btnJugarTest_botonPresionado():
	Global.Nivel = "res://Niveles/Test.tscn"
	$AnimationPlayer.play("Obscurecer")
