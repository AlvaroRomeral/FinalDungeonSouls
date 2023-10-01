extends Node

const MENU_PRINCIPAL = "res://scenes/menu_principal.tscn"
const NIVEL_1 = "res://scenes/nivel_1.tscn"

func _ready():
    Input.set_custom_mouse_cursor(load("res://assets/imagenes/iconos/18.png"),Input.CURSOR_FORBIDDEN)
    Input.set_custom_mouse_cursor(load("res://assets/imagenes/iconos/01.png"),Input.CURSOR_DRAG)
    Input.set_custom_mouse_cursor(load("res://assets/imagenes/iconos/11.png"),Input.CURSOR_CAN_DROP)