extends Control
class_name PanelZonaOleada

signal empezar_oleada_presionado()

@export var boton_empezar_oleada:Button

func _ready():
	boton_empezar_oleada.pressed.connect(boton_empezar_oleada_presionado)


func abrir_interfaz():
	show()


func boton_empezar_oleada_presionado():
	empezar_oleada_presionado.emit()
	hide()