extends Control

@export var velocidad_creditos: float = 2
@onready var texto = $RichTextLabel

func _ready():
	pass


func _process(delta):
	$Tween.interpolate_property($RichTextLabel, "position:y",texto.position.y, (texto.position.y - velocidad_creditos), delta, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()


func _on_Boton_botonPresionado():
	get_tree().change_scene_to_file("res://Pantallas/Menus/MenuPrincipal.tscn")
