extends Panel

signal comprado()

export var id_item = 1
var coste:int = 0
var cantidad = 1

func _ready():
	actualizar()
	Global.connect("dineroGastado",self,"actualizar")


func actualizar():
	coste = Datos.getItemInfo(id_item)["coste"]
	$HBoxContainer/CosteCantidad.text = str(coste)
	var path_icono = Global.PATH_ICONOS + Datos.getItemIcono(id_item) + ".png"
	$Producto.texture = load(path_icono)
	if coste > Jugador.monedas or cantidad < 1:
		self.material.set_shader_param("activo",true)
		$BotonProducto.disabled = true
	else:
		self.material.set_shader_param("activo",false)
		$BotonProducto.disabled = false


func _on_BotonProducto_button_up():
	if cantidad > 0:
		cantidad -= 1
		Jugador.setMonedas(-coste)
		Jugador.anadirItem(id_item,1)
		Global.emit_signal("dineroGastado")
