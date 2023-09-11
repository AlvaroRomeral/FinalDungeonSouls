extends Control

var linea_puntuacion = preload("res://Componentes/LineaPuntuacion.tscn")

func _ready():
	await SilentWolf.Scores.get_high_scores().sw_scores_received
	for x in SilentWolf.Scores.scores:
		var nueva_linea = linea_puntuacion.instantiate()
		nueva_linea.nombre = str(x["player_name"])
		nueva_linea.puntuacion = str(x["score"])
		$Panel/ScrollContainer/VBoxContainer.add_child(nueva_linea)
	$Panel/Cargando.hide()


func _on_Boton_botonPresionado():
	get_tree().change_scene_to_file("res://Pantallas/Menus/MenuPrincipal.tscn")
