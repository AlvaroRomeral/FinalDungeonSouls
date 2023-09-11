extends TextureButton

signal ropa_seleccionada(id_cosmetico)

@onready var pnl_fondo = $NinePatchRect
@onready var lbl_nombre = $lblNombre
@onready var lbl_precio = $lblPrecio
@onready var img_cosmetico = $Cosmetico
@onready var img_maniqui = $BaseManiqui

var bloqueado = false
var id = -1

func _ready():
	pass


func setAspecto(id_cosmetico, nombre, precio, pathicono):
	id = id_cosmetico
	lbl_nombre.text = nombre
	lbl_precio.text = String(precio)
	img_cosmetico.texture = load(pathicono)


func bloquear():
	pnl_fondo.use_parent_material = true
	img_cosmetico.use_parent_material = true
	img_maniqui.use_parent_material = true
	bloqueado = true


func _on_PanelArticuloCosmetico_button_up():
	emit_signal("ropa_seleccionada",id)
