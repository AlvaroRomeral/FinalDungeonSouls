extends Control


func _ready():
	pass



func _on_btnJugar_button_up():
	get_tree().change_scene("res://Niveles/Test.tscn")


func _on_btnSalir_button_up():
	get_tree().quit()


