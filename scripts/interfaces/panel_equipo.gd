extends Control
class_name PanelEquipo

@export var interfaz:PantallaInterfaz
@export_category("Componentes (no tocar)")
@export var slot_cabeza:SlotInventario
@export var slot_cuerpo:SlotInventario
@export var slot_brazos:SlotInventario
@export var slot_pierna:SlotInventario
@export var slot_arma:SlotInventario

func _ready():
	slot_cabeza.slot_ref = interfaz.jugador.control_equipo.slot_cabeza
	slot_cuerpo.slot_ref = interfaz.jugador.control_equipo.slot_cuerpo
	slot_brazos.slot_ref = interfaz.jugador.control_equipo.slot_brazos
	slot_pierna.slot_ref = interfaz.jugador.control_equipo.slot_pierna
	slot_arma.slot_ref = interfaz.jugador.control_equipo.slot_arma


func actualizar():
	slot_cabeza.actualizar()
	slot_cuerpo.actualizar()
	slot_brazos.actualizar()
	slot_pierna.actualizar()
	slot_arma.actualizar()
