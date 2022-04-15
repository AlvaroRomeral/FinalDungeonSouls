extends Control

export(float) var velocidad_creditos = 2
onready var texto = $RichTextLabel

func _ready():
	pass


func _process(delta):
	$Tween.interpolate_property($RichTextLabel, "rect_position:y",texto.rect_position.y, (texto.rect_position.y - velocidad_creditos), delta, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()


func _on_Boton_botonPresionado():
	get_tree().change_scene("res://Pantallas/Menus/MenuPrincipal.tscn")
