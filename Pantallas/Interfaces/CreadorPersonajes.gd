extends Control

const path_cuerpo = "res://Recursos/Imagenes/Sprites/Cuerpo/"
const path_cabeza = "res://Recursos/Imagenes/Sprites/Equipo/Cabeza/"
const path_pecho = "res://Recursos/Imagenes/Sprites/Equipo/Pecho/"
const path_piernas = "res://Recursos/Imagenes/Sprites/Equipo/Piernas/"
const path_pies = "res://Recursos/Imagenes/Sprites/Equipo/Pies/"

var spr_cuerpo = []
var index_cuerpo = 0
var spr_cabeza = []
var index_cabeza = 0
var spr_pecho = []
var index_pecho = 0
var spr_piernas = []
var index_piernas = 0
var spr_pies = []
var index_pies = 0

func _ready():
	spr_cuerpo = Datos.getArchivosDePath(path_cuerpo)
	spr_cabeza = Datos.getArchivosDePath(path_cabeza)
	spr_pecho = Datos.getArchivosDePath(path_pecho)
	spr_piernas = Datos.getArchivosDePath(path_piernas)
	spr_pies = Datos.getArchivosDePath(path_pies)
	actualizarAspecto()


func actualizarAspecto():
	$Panel/Panel/Base.texture = load(path_cuerpo + spr_cuerpo[index_cuerpo])
	$Panel/Panel/Cabeza.texture = load(path_cabeza + spr_cabeza[index_cabeza])
	$Panel/Panel/Pecho.texture = load(path_pecho + spr_pecho[index_pecho])
	$Panel/Panel/Piernas.texture = load(path_piernas + spr_piernas[index_piernas])
	$Panel/Panel/Pies.texture = load(path_pies + spr_pies[index_pies])


func _on_BtnCerrar_button_up():
	get_tree().quit()


func _on_BtnCabezaD_button_up():
	index_cabeza = index_cabeza + 1
	if index_cabeza > spr_cabeza.size() - 1:
		index_cabeza = 0
	actualizarAspecto()


func _on_BtnCabezaI_button_up():
	index_cabeza = index_cabeza - 1
	if index_cabeza < 0:
		index_cabeza = spr_cabeza.size() - 1
	actualizarAspecto()


func _on_BtnPechoD_button_up():
	index_pecho = index_pecho + 1
	if index_pecho > spr_pecho.size() - 1:
		index_pecho = 0
	actualizarAspecto()


func _on_BtnPechoI_button_up():
	index_pecho = index_pecho - 1
	if index_pecho < 0:
		index_pecho = spr_pecho.size() - 1
	actualizarAspecto()


func _on_BtnPiernasD_button_up():
	index_piernas = index_piernas + 1
	if index_piernas > spr_piernas.size() - 1:
		index_piernas = 0
	actualizarAspecto()


func _on_BtnPiernasI_button_up():
	index_piernas = index_piernas - 1
	if index_piernas < 0:
		index_piernas = spr_piernas.size() - 1
	actualizarAspecto()


func _on_BtnCuerpoD_button_up():
	index_cuerpo = index_cuerpo + 1
	if index_cuerpo > spr_cuerpo.size() - 1:
		index_cuerpo = 0
	actualizarAspecto()


func _on_BtnCuerpoI_button_up():
	index_cuerpo = index_cuerpo - 1
	if index_cuerpo < 0:
		index_cuerpo = spr_cuerpo.size() - 1
	actualizarAspecto()


func _on_BtnPiesI_button_up():
	index_pies = index_pies - 1
	if index_pies < 0:
		index_pies = spr_pies.size() - 1
	actualizarAspecto()


func _on_BtnPiesD_button_up():
	index_pies = index_pies + 1
	if index_pies > spr_pies.size() - 1:
		index_pies = 0
	actualizarAspecto()
