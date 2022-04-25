extends Panel

signal devolverInfo(id)

export(String,"inv","arma","cabeza","torso","piernas","pies","amuleto1","amuleto2","amuleto3","amuleto4") var tipo = "inv"

onready var com_icono = $Icono
onready var com_fondo = $Fondo

var item_posicion

func _ready():
	com_icono.tipo = tipo
	match tipo:
		"inv":
			com_fondo.texture = load("res://Recursos/Imagenes/Interfaz/slot.png")
		"arma":
			com_fondo.texture = load("res://Recursos/Imagenes/Interfaz/slot_arma.png")
		"cabeza":
			com_fondo.texture = load("res://Recursos/Imagenes/Interfaz/slot_cabeza.png")
		"torso":
			com_fondo.texture = load("res://Recursos/Imagenes/Interfaz/slot_torso.png")
		"piernas":
			com_fondo.texture = load("res://Recursos/Imagenes/Interfaz/slot_piernas.png")
		"pies":
			com_fondo.texture = load("res://Recursos/Imagenes/Interfaz/slot_pies.png")
		"amuleto1":
			com_fondo.texture = load("res://Recursos/Imagenes/Interfaz/slot_amuleto.png")
		"amuleto2":
			com_fondo.texture = load("res://Recursos/Imagenes/Interfaz/slot_amuleto.png")
		"amuleto3":
			com_fondo.texture = load("res://Recursos/Imagenes/Interfaz/slot_amuleto.png")
		"amuleto4":
			com_fondo.texture = load("res://Recursos/Imagenes/Interfaz/slot_amuleto.png")


func setValores(id, cantidad, index):
	item_posicion = index
	com_icono.setDatos(id, cantidad, index)


func _on_PanelInventario_mouse_entered():
	emit_signal("devolverInfo",com_icono.datos["id"])


func _on_PanelInventario_mouse_exited():
	emit_signal("devolverInfo",null)
