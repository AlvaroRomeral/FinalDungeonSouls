extends Control

const slot = preload("res://Pantallas/Interfaces/PanelInventario.tscn")

onready var gridInventario = $PanelInventario/GridContainer
onready var txtNombre = $PanelNombre/TextoNombre
onready var txtDescripcion = $PanelDescripcion/ScrollContainer/VBoxContainer/TextoDescripcion
onready var txtEstadisticas = $PanelDescripcion/ScrollContainer/VBoxContainer/TextoEstadisticas

func _ready():
	hide()
	Jugador.connect("inventarioActualizado",self,"actualizarSlots")
	generarSlots()


func _on_Inventario_draw():
	get_tree().paused = true
	generarSlots()


func generarSlots():
#	for i in gridInventario.get_children():
#		i.queue_free()
	for x in Jugador.inventario_cap:
		var item_nuevo = slot.instance()
		gridInventario.call_deferred("add_child",item_nuevo)
#		if Jugador.inventario[x]["id"] != null:
		item_nuevo.setValores(Jugador.inventario[x]["id"],Jugador.inventario[x]["cantidad"],x)
		item_nuevo.connect("devolverInfo",self,"mostrarInfo")


func actualizarSlots():
	for x in gridInventario.get_children():
		x.setValores(Jugador.inventario[x.item_posicion]["id"],Jugador.inventario[x.item_posicion]["cantidad"],x.item_posicion)


func mostrarInfo(id_item):
	if id_item != null:
		var datos_item = Datos.getItemInfo(id_item)
		txtNombre.text = ""
		txtNombre.text = datos_item["nombre"]
		txtDescripcion.text = ""
		txtDescripcion.text = datos_item["descripcion"]
		
		txtEstadisticas.bbcode_text = ""
		match Datos.getItemTipo(id_item):
			1:
				var equipo_info = Datos.getEquipoInfo(id_item)
				txtEstadisticas.bbcode_text = "[center]Defensa: " + String(equipo_info["def_num"]) + "\nPorcentaje: " + String(equipo_info["def_por"]) + "%"
			2:
				var arma_info = Datos.getArmaInfo(id_item)
				txtEstadisticas.bbcode_text = "[center]Ataque: " + String(arma_info["atc_num"]) + "\nPorcentaje: " + String(arma_info["atc_por"]) + "%"
			3:
				var consumible_info = Datos.getConsumibleInfo(id_item)
				txtEstadisticas.bbcode_text = "[center]Vida: [color=red]" + String(consumible_info["vida"]) + "[/color] \nMana: [color=blue]" + String(consumible_info["mana"])
	else:
		txtNombre.text = ""
		txtDescripcion.text = ""
		txtEstadisticas.bbcode_text = ""


func _on_Inventario_hide():
	get_tree().paused = false
