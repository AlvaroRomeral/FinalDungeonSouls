extends Node2D
class_name ActivadorOleadas

@export var control_oleadas:ControlOleadas

@export var panel_zona_oleada:PanelZonaOleada
@export var brasero:Brasero
@export var area_detecccion:Area2D

func _ready():
	panel_zona_oleada.empezar_oleada_presionado.connect(llamar_a_comienza_oleadas)
	area_detecccion.body_entered.connect(func(_cuerpo): panel_zona_oleada.show())
	area_detecccion.body_exited.connect(func(_cuerpo): panel_zona_oleada.hide())


func llamar_a_comienza_oleadas():
	control_oleadas.comenzar_oleada()
	brasero.encender_llama()
	brasero.cambiar_llama("azul")
