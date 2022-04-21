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
		nuevo_cosmetico.setAspecto(x["nombre"],x["precio"],Global.PATH_CASCOS + x["icono"] + ".png")
	
	var cos_torso = Datos.getCosmeticosTorso()
	for x in cos_cabeza:
		var nuevo_cosmetico = panel_cosmetico.instance()
		grid_torso.add_child(nuevo_cosmetico)
		nuevo_cosmetico.setAspecto(x["nombre"],x["precio"],Global.PATH_TORSOS + x["icono"] + ".png")
	
	var cos_piernas = Datos.getCosmeticosPiernas()   
	for x in cos_cabeza:
		var nuevo_cosmetico = panel_cosmetico.instance()
		grid_piernas.add_child(nuevo_cosmetico)
		nuevo_cosmetico.setAspecto(x["nombre"],x["precio"],Global.PATH_PIERNAS + x["icono"] + ".png")
	
	var cos_pies = Datos.getCosmeticosPies()
	for x in cos_cabeza:
		var nuevo_cosmetico = panel_cosmetico.instance()
		grid_pies.add_child(nuevo_cosmetico)
		nuevo_cosmetico.setAspecto(x["nombre"],x["precio"],Global.PATH_PIES + x["icono"] + ".png")
