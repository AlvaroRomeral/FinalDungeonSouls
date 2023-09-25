extends CanvasLayer
class_name PantallaInterfaz

@export var jugador:Jugador

@export_category("Componentes (no tocar)")
@export var label_nivel:Label
@export var panel_inventario:PanelInventario
@export var panel_equipo:PanelEquipo
@export_subgroup("barra vida")
@export var bar_vida:ProgressBar
@export var label_cantidad_vida:Label
@export var label_max_vida:Label
@export_subgroup("barra estamina")
@export var bar_estamina:ProgressBar
@export var label_cantidad_estamina:Label
@export var label_max_estamina:Label
@export_subgroup("barra mana")
@export var bar_mana:ProgressBar
@export var label_cantidad_mana:Label
@export var label_max_mana:Label
@export_subgroup("barra experiencia")
@export var bar_exp:ProgressBar
@export var label_cantidad_exp:Label
@export var label_max_exp:Label

func _input(event):
	if event.is_action_pressed("INVENTARIO"):
		if panel_inventario.visible:
			panel_inventario.hide()
		else:
			panel_inventario.show()


func actualizar_todo():
	actualizar_barras()
	actualizar_equipo()


func actualizar_equipo():
	panel_inventario.actualizar()
	panel_equipo.actualizar()


func actualizar_estado():
	actualizar_barras()


func actualizar_barras():
	var status = jugador.control_estado
	
	bar_vida.max_value = status.salud_max
	label_max_vida.text = str(status.salud_max)
	bar_vida.value = status.salud
	label_cantidad_vida.text = str(status.salud)
	
	bar_estamina.max_value = status.estamina_max
	label_max_estamina.text = str(status.estamina_max)
	bar_estamina.value = status.estamina
	label_cantidad_estamina.text = str(status.estamina)
	
	bar_mana.max_value = status.mana_max
	label_max_mana.text = str(status.mana_max)
	bar_mana.value = status.mana
	label_cantidad_mana.text = str(status.mana)
		
	bar_exp.max_value = status.exp_necesaria(status.nivel)
	label_max_exp.text = str(status.exp_necesaria(status.nivel))
	bar_exp.value = status.experiencia
	label_cantidad_exp.text = str(status.experiencia)

	label_nivel.text = str(status.nivel)
	
