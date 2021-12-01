extends Control

onready var slot = preload("res://Pantallas/PanelInventario.tscn")
onready var gridInventario = $Panel/PanelInventario/GridContainer
onready var txtNombre = $Panel/PanelNombre/TextoNombre
onready var txtDescripcion = $Panel/PanelDescripcion/TextoDescripcion


func _ready():
	pass


func _on_Inventario_draw():
	get_tree().paused = true
	generarSlots()


func generarSlots():
	for i in gridInventario.get_children():
		i.queue_free()
	for i in DatosJugador.inventario:
		var itemNuevo = slot.instance()
		var itemId = i["id"]
		gridInventario.call_deferred("add_child",itemNuevo)
		itemNuevo.setIcono(Global.itemData[itemId]["icono"])
		itemNuevo.setCantidad(i["cantidad"])
		itemNuevo.setId(i["id"])
		itemNuevo.connect("devolverInfo",self,"cargarInfo")


func cargarInfo(id):
	txtNombre.text = Global.itemData[id]["nombre"]
	txtDescripcion.text = Global.itemData[id]["descripcion"]


func _on_Inventario_hide():
	get_tree().paused = false
