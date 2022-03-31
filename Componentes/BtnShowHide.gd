extends TextureButton

export(Texture) var icono_on = preload("res://Recursos/Imagenes/Iconos/icon_16.png")
export(Texture) var icono_off = preload("res://Recursos/Imagenes/Iconos/icon_17.png")
export(NodePath) var nodo_afectado

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
