extends TextureButton

@export var icono_on: Texture2D = preload("res://Recursos/Imagenes/Iconos/icon_16.png")
@export var icono_off: Texture2D = preload("res://Recursos/Imagenes/Iconos/icon_17.png")
@export var nodo_afectado: NodePath

var nodo

func _ready():
	nodo = get_node(nodo_afectado)
	texture_normal = icono_off


func _on_BtnShowHide_button_up():
	if nodo.visible:
		nodo.hide()
		texture_normal = icono_on
	else:
		nodo.show()
		texture_normal = icono_off
