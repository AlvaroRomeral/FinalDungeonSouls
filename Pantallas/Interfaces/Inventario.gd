extends Control

const slot = preload("res://Pantallas/Interfaces/PanelInventario.tscn")

onready var gridInventario = $PanelInventario/GridContainer
onready var txtnombre = $PanelNombre/TextoNombre
onready var txtdescri = $PanelDescripcion/ScrollContainer/VBoxContainer/TextoDescripcion
onready var txtestats = $PanelDescripcion/ScrollContainer/VBoxContainer/TextoEstadisticas
onready var slotarma = $PanelEquipo/SlotArma
onready var slotcabeza = $PanelEquipo/SlotCabeza
onready var slottorso = $PanelEquipo/SlotTorso
onready var slotpiernas = $PanelEquipo/SlotPiernas
onready var slotpies = $PanelEquipo/SlotPies
onready var slotamuleto1 = $PanelEquipo/SlotAmuleto_1
onready var slotamuleto2 = $PanelEquipo/SlotAmuleto_2
onready var slotamuleto3 = $PanelEquipo/SlotAmuleto_3
onready var slotamuleto4 = $PanelEquipo/SlotAmuleto_4

func _ready():
	hide()
	Jugador.connect("inventarioActualizado",self,"actualizarSlots")
	Jugador.connect("datosActualizados",self,"actualizarDatos")
	generarSlots()


func _on_Inventario_draw():
	get_tree().paused = true
	generarSlots()


func generarSlots():
#	for i in gridInventario.get_children():
#		i.queue_free()
	for x in Jugador.inventario_cap:
		var item_nuevo = slot.instance()
		gridInventario.add_child(item_nuevo)
#		if Jugador.inventario[x]["id"] != null:
		item_nuevo.setValores(Jugador.inventario[x]["id"],Jugador.inventario[x]["cantidad"],x)
		item_nuevo.connect("devolverInfo",self,"mostrarInfo")


func actualizarSlots():
	for x in gridInventario.get_children():
		x.setValores(Jugador.inventario[x.item_posicion]["id"],Jugador.inventario[x.item_posicion]["cantidad"],x.item_posicion)
	slotarma.setValores(Jugador.equipamiento["arma"],1,null)
	slotcabeza.setValores(Jugador.equipamiento["cabeza"],1,null)
	slottorso.setValores(Jugador.equipamiento["torso"],1,null)
	slotpiernas.setValores(Jugador.equipamiento["piernas"],1,null)
	slotpies.setValores(Jugador.equipamiento["pies"],1,null)
	slotamuleto1.setValores(Jugador.equipamiento["amuleto1"],1,null)
	slotamuleto2.setValores(Jugador.equipamiento["amuleto2"],1,null)
	slotamuleto3.setValores(Jugador.equipamiento["amuleto3"],1,null)
	slotamuleto4.setValores(Jugador.equipamiento["amuleto4"],1,null)

func mostrarInfo(id_item):
	if id_item != null:
		var datos = Datos.getItemInfo(id_item)
		txtnombre.text = ""
		txtnombre.text = datos["nombre"]
		txtdescri.text = ""
		txtdescri.text = datos["descripcion"]
		txtestats.bbcode_text = ""
		match Datos.getItemTipo(id_item):
			"consumible":
				if datos["vida"] != 0:
					txtestats.bbcode_text = "[center]Vida: [color=red]" + str(datos["vida"])
				else:
					txtestats.bbcode_text = "[center]Mana: [color=blue]" + str(datos["mana"])
			"arma":
				txtestats.bbcode_text = "[center]Ataque: " + str(datos["ataque"])
			"torso":
				txtestats.bbcode_text = "[center]Defensa: " + str(datos["defensa"])
			"cabeza":
				txtestats.bbcode_text = "[center]Defensa: " + str(datos["defensa"])
			"piernas":
				txtestats.bbcode_text = "[center]Defensa: " + str(datos["defensa"])
			"pies":
				txtestats.bbcode_text = "[center]Defensa: " + str(datos["defensa"])
			"amuleto":
				match datos["efecto"]:
					"vida":
						txtestats.bbcode_text = "[center]Vida extra: [color=red]" + str(datos["porcen"]*100) + "%"
	else:
		txtnombre.text = ""
		txtdescri.text = ""
		txtestats.bbcode_text = ""


func actualizarDatos():
	$PanelEquipo/LblAtaque.text = "Atq: " + str(Jugador.ataque)
	$PanelEquipo/LblDefensa.text = "Def: " + str(Jugador.defensa)
	$PanelEquipo/LblVida.text = "Vid: " + str(Jugador.vida)
	$PanelEquipo/LblMana.text = "Man: " + str(Jugador.mana)


func _on_Inventario_hide():
	get_tree().paused = false
