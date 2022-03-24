extends Control

onready var slot = preload("res://Pantallas/Interfaces/PanelInventario.gd")
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
	for x in Jugador.inventario:
		var item_nuevo = slot.new()
		gridInventario.call_deferred("add_child",item_nuevo)
		item_nuevo.setValores(x["id"],x["cantidad"])
		item_nuevo.connect("devolverInfo",self,"cargarInfo")
		item_nuevo.connect("actualizado",self,"generarSlots")
	if Jugador.array_equipo[0]["id"] != null:
		slotCabeza.setValores	(Jugador.array_equipo[0]["id"], Jugador.array_equipo[0]["cantidad"])
	if Jugador.array_equipo[1]["id"] != null:
		slotPecho.setValores	(Jugador.array_equipo[1]["id"], Jugador.array_equipo[1]["cantidad"])
	if Jugador.array_equipo[2]["id"] != null:
		slotPiernas.setValores	(Jugador.array_equipo[2]["id"], Jugador.array_equipo[2]["cantidad"])
	if Jugador.array_equipo[3]["id"] != null:
		slotPies.setValores		(Jugador.array_equipo[3]["id"], Jugador.array_equipo[3]["cantidad"])
	if Jugador.array_equipo[4]["id"] != null:
		slotEspalda.setValores	(Jugador.array_equipo[4]["id"], Jugador.array_equipo[4]["cantidad"])
	if Jugador.array_equipo[5]["id"] != null:
		slotManos.setValores	(Jugador.array_equipo[5]["id"], Jugador.array_equipo[5]["cantidad"])
	if Jugador.array_equipo[6]["id"] != null:
		slotDedoDer.setValores	(Jugador.array_equipo[7]["id"], Jugador.array_equipo[7]["cantidad"])
	if Jugador.array_equipo[7]["id"] != null:
		slotDedoIzq.setValores	(Jugador.array_equipo[6]["id"], Jugador.array_equipo[6]["cantidad"])

func cargarInfo(id):
	txtNombre.text = Datos.items_db[id]["nombre"]
	txtDescripcion.text = Datos.items_db[id]["descripcion"]
	if Datos.items_db[id]["cant_defensa"] != 0:
		txtEstadisticas.text = "Defense: " + String(Datos.items_db[id]["cant_defensa"])
	else:
		txtEstadisticas.text = ""


func _on_Inventario_hide():
	get_tree().paused = false
