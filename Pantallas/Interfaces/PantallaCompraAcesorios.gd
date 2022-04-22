extends Control

onready var grid_cabeza = $Panel/Tabs/Cabeza/ScrollContainer/GridContainer
onready var grid_torso = $Panel/Tabs/Torso/ScrollContainer/GridContainer
onready var grid_piernas = $Panel/Tabs/Piernas/ScrollContainer/GridContainer
onready var grid_pies = $Panel/Tabs/Pies/ScrollContainer/GridContainer
onready var panel_cosmetico = preload("res://Pantallas/Interfaces/PanelArticuloCosmetico.tscn")

func _ready():
	recargar()


func recargar():
	var cos_cabeza = Datos.getCosmeticosCabeza()
	for x in cos_cabeza:
		var nuevo_cosmetico = panel_cosmetico.instance()
		grid_cabeza.add_child(nuevo_cosmetico)
		nuevo_cosmetico.setAspecto(x["id"],x["nombre"],x["precio"],Global.PATH_CASCOS + x["icono"] + ".png")
		if Jugador.cosmeticos.find(x["id"]) == -1:
			nuevo_cosmetico.bloquear()
		else:
			nuevo_cosmetico.connect("ropa_seleccionada",)
	
	var cos_torso = Datos.getCosmeticosTorso()
	for x in cos_cabeza:
		var nuevo_cosmetico = panel_cosmetico.instance()
		grid_torso.add_child(nuevo_cosmetico)
		nuevo_cosmetico.setAspecto(x["id"],x["nombre"],x["precio"],Global.PATH_TORSOS + x["icono"] + ".png")
		if Jugador.cosmeticos.find(x["id"]) == -1:
			nuevo_cosmetico.bloquear()
	
	var cos_piernas = Datos.getCosmeticosPiernas()   
	for x in cos_cabeza:
		var nuevo_cosmetico = panel_cosmetico.instance()
		grid_piernas.add_child(nuevo_cosmetico)
		nuevo_cosmetico.setAspecto(x["id"],x["nombre"],x["precio"],Global.PATH_PIERNAS + x["icono"] + ".png")
		if Jugador.cosmeticos.find(x["id"]) == -1:
			nuevo_cosmetico.bloquear()
	
	var cos_pies = Datos.getCosmeticosPies()
	for x in cos_cabeza:
		var nuevo_cosmetico = panel_cosmetico.instance()
		grid_pies.add_child(nuevo_cosmetico)
		nuevo_cosmetico.setAspecto(x["id"],x["nombre"],x["precio"],Global.PATH_PIES + x["icono"] + ".png")
		if Jugador.cosmeticos.find(x["id"]) == -1:
			nuevo_cosmetico.bloquear()


func cambiarCosmetico(id):
	match Datos.getCosmeticoParte(id):
		"c":
			$Panel/Panel/sprCabeza.texture = load(Datos.getCosmeticoIcono(id))
		"t":
			$Panel/Panel/sprTorso.texture = load(Datos.getCosmeticoIcono(id))
		"p":
			$Panel/Panel/sprPiernas.texture = load(Datos.getCosmeticoIcono(id))
		"pi":
			$Panel/Panel/sprPies.texture = load(Datos.getCosmeticoIcono(id))
	
