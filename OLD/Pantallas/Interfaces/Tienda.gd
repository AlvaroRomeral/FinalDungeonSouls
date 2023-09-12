extends Control


func _ready():
	pass


func generarProductos():
	for x in $Panel/GridContainer.get_children():
		var id = int(randf_range(4,19))
		x.id_item = id
		x.cantidad = 1
		x.actualizar()


func _on_ButtonSalir_button_up():
	get_tree().paused = false
	hide()


func _on_Tienda_draw():
	generarProductos()
	get_tree().paused = true
