extends TextureButton

onready var lbl_nombre = $lblNombre
onready var img_cosmetico = $Cosmetico
onready var lbl_precio = $lblPrecio

func _ready():
	pass


func setAspecto(nombre, precio, pathicono):
	lbl_nombre.text = nombre
	lbl_precio.text = String(precio)
	img_cosmetico.texture = load(pathicono)
