extends Control

@onready var grid_cabeza = $Panel/TabBar/Cabeza/ScrollContainer/GridContainer
@onready var grid_torso = $Panel/TabBar/Torso/ScrollContainer/GridContainer
@onready var grid_piernas = $Panel/TabBar/Piernas/ScrollContainer/GridContainer
@onready var grid_pies = $Panel/TabBar/Pies/ScrollContainer/GridContainer
@onready var panel_cosmetico = preload("res://Pantallas/Interfaces/PanelArticuloCosmetico.tscn")

func _ready():
	recargar()


func recargar():
	var cos_cabeza = Datos.getCosmeticosCabeza()
	for x in cos_cabeza:
		var nuevo_cosmetico = panel_cosmetico.instantiate()
		grid_cabeza.add_child(nuevo_cosmetico)
		nuevo_cosmetico.setAspecto(x["id"],x["nombre"],x["precio"],Global.PATH_CASCOS + x["icono"] + ".png")
		if Jugador.cosmeticos.find(x["id"]) == -1:
			nuevo_cosmetico.bloquear()
		else:
			nuevo_cosmetico.connect("ropa_seleccionada", Callable(self, "cambiarCosmetico"))
	
	var cos_torso = Datos.getCosmeticosTorso()
	for x in cos_cabeza:
		var nuevo_cosmetico = panel_cosmetico.instantiate()
		grid_torso.add_child(nuevo_cosmetico)
		nuevo_cosmetico.setAspecto(x["id"],x["nombre"],x["precio"],Global.PATH_TORSOS + x["icono"] + ".png")
		if Jugador.cosmeticos.find(x["id"]) == -1:
			nuevo_cosmetico.bloquear()
		else:
			nuevo_cosmetico.connect("ropa_seleccionada", Callable(self, "cambiarCosmetico"))
	
	var cos_piernas = Datos.getCosmeticosPiernas()   
	for x in cos_cabeza:
		var nuevo_cosmetico = panel_cosmetico.instantiate()
		grid_piernas.add_child(nuevo_cosmetico)
		nuevo_cosmetico.setAspecto(x["id"],x["nombre"],x["precio"],Global.PATH_PIERNAS + x["icono"] + ".png")
		if Jugador.cosmeticos.find(x["id"]) == -1:
			nuevo_cosmetico.bloquear()
		else:
			nuevo_cosmetico.connect("ropa_seleccionada", Callable(self, "cambiarCosmetico"))
	
	var cos_pies = Datos.getCosmeticosPies()
	for x in cos_cabeza:
		var nuevo_cosmetico = panel_cosmetico.instantiate()
		grid_pies.add_child(nuevo_cosmetico)
		nuevo_cosmetico.setAspecto(x["id"],x["nombre"],x["precio"],Global.PATH_PIES + x["icono"] + ".png")
		if Jugador.cosmeticos.find(x["id"]) == -1:
			nuevo_cosmetico.bloquear()
		else:
			nuevo_cosmetico.connect("ropa_seleccionada", Callable(self, "cambiarCosmetico"))


func cambiarCosmetico(id):
	var parte = Datos.getCosmeticoParte(id)
	match parte:
		"c":
			$Panel/Panel/sprCabeza.texture = load(Global.PATH_CASCOS + Datos.getCosmeticoIcono(id) + ".png")
		"t":
			$Panel/Panel/sprTorso.texture = load(Global.PATH_TORSOS + Datos.getCosmeticoIcono(id) + ".png")
		"p":
			$Panel/Panel/sprPiernas.texture = load(Global.PATH_PIERNAS + Datos.getCosmeticoIcono(id) + ".png")
		"pi":
			$Panel/Panel/sprPies.texture = load(Global.PATH_PIES + Datos.getCosmeticoIcono(id) + ".png")
	
