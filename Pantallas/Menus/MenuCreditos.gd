extends Control

export var velocidad_creditos = 2
onready var texto = $RichTextLabel

func _ready():
	pass


func _process(delta):
	$Tween.interpolate_property(texto, "rect_position:y",texto.rect_position.y, (texto.rect_position.y - velocidad_creditos), delta, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)


func _on_Boton_botonPresionado():
	get_tree().change_scene("res://Pantallas/Menus/MenuPrincipal.tscn")
