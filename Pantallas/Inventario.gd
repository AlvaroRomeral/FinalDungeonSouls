extends Control

onready var slot = preload("res://Pantallas/PanelInventario.tscn")
onready var gridInventario = $Panel/PanelInventario/GridContainer
onready var txtNombre = $Panel/PanelNombre/TextoNombre
onready var txtDescripcion = $Panel/PanelDescripcion/ScrollContainer/VBoxContainer/TextoDescripcion
onready var txtEstadisticas = $Panel/PanelDescripcion/ScrollContainer/VBoxContainer/TextoEstadisticas

onready var slotCabeza = $Panel/PanelCabeza/PanelInventario
onready var slotPecho = $Panel/PanelPecho/PanelInventario
onready var slotPiernas = $Panel/PanelPiernas/PanelInventario
onready var slotPies = $Panel/PanelPies/PanelInventario
onready var slotEspalda = $Panel/PanelEspalda/PanelInventario
onready var slotManos = $Panel/PanelManos/PanelInventario
onready var slotDedoIzq = $Panel/PanelDedo_izq/PanelInventario
onready var slotDedoDer = $Panel/PanelDedo_der/PanelInventario

func _ready():
	pass


func _on_Inventario_draw():
	get_tree().paused = true
	generarSlots()


func generarSlots():
	for i in gridInventario.get_children():
		i.queue_free()
	for x in DatosJugador.inventario:
		var itemNuevo = slot.instance()
		gridInventario.call_deferred("add_child",itemNuevo)
		itemNuevo.setValores(x["id"],x["cantidad"])
		itemNuevo.connect("devolverInfo",self,"cargarInfo")
		itemNuevo.connect("actualizado",self,"generarSlots")
	if DatosJugador.arrayEquipo[0]["id"] != null:
		slotCabeza.setValores	(DatosJugador.arrayEquipo[0]["id"], DatosJugador.arrayEquipo[0]["cantidad"])
	if DatosJugador.arrayEquipo[1]["id"] != null:
		slotPecho.setValores	(DatosJugador.arrayEquipo[1]["id"], DatosJugador.arrayEquipo[1]["cantidad"])
	if DatosJugador.arrayEquipo[2]["id"] != null:
		slotPiernas.setValores	(DatosJugador.arrayEquipo[2]["id"], DatosJugador.arrayEquipo[2]["cantidad"])
	if DatosJugador.arrayEquipo[3]["id"] != null:
		slotPies.setValores		(DatosJugador.arrayEquipo[3]["id"], DatosJugador.arrayEquipo[3]["cantidad"])
	if DatosJugador.arrayEquipo[4]["id"] != null:
		slotEspalda.setValores	(DatosJugador.arrayEquipo[4]["id"], DatosJugador.arrayEquipo[4]["cantidad"])
	if DatosJugador.arrayEquipo[5]["id"] != null:
		slotManos.setValores	(DatosJugador.arrayEquipo[5]["id"], DatosJugador.arrayEquipo[5]["cantidad"])
	if DatosJugador.arrayEquipo[6]["id"] != null:
		slotDedoDer.setValores	(DatosJugador.arrayEquipo[7]["id"], DatosJugador.arrayEquipo[7]["cantidad"])
	if DatosJugador.arrayEquipo[7]["id"] != null:
		slotDedoIzq.setValores	(DatosJugador.arrayEquipo[6]["id"], DatosJugador.arrayEquipo[6]["cantidad"])

func cargarInfo(id):
	txtNombre.text = Global.itemData[id]["nombre"]
	txtDescripcion.text = Global.itemData[id]["descripcion"]
	if Global.itemData[id]["cant_defensa"] != 0:
		txtEstadisticas.text = "Defense: " + String(Global.itemData[id]["cant_defensa"])
	else:
		txtEstadisticas.text = ""


func _on_Inventario_hide():
	get_tree().paused = false
