extends CanvasLayer
class_name PantallaMenuPrincipal

@export var boton_jugar:Button
@export var boton_opciones:Button
@export var boton_salir:Button

func _ready():
    boton_jugar.pressed.connect(_jugar)
    boton_opciones.pressed.connect(_opciones)
    boton_salir.pressed.connect(_salir)


func _jugar():
    pass


func _opciones():
    pass


func _salir():
    get_tree().quit()