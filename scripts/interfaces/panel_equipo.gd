extends Control
class_name PanelEquipo

@export var interfaz:PantallaInterfaz
@export_category("Componentes (no tocar)")
@export var slot_cabeza:SlotInventario
@export var slot_cuerpo:SlotInventario
@export var slot_brazos:SlotInventario
@export var slot_pierna:SlotInventario
@export var slot_arma:SlotInventario
@export var slot_trinket_1:SlotInventario
@export var slot_trinket_2:SlotInventario
@export var slot_trinket_3:SlotInventario
@export var slot_trinket_4:SlotInventario

@export var label_nivel:Label
@export var label_vida:Label
@export var label_ataque:Label
@export var label_armadura:Label

func _ready():
	slot_cabeza.slot_ref = interfaz.jugador.control_equipo.slot_cabeza
	slot_cuerpo.slot_ref = interfaz.jugador.control_equipo.slot_cuerpo
	slot_brazos.slot_ref = interfaz.jugador.control_equipo.slot_brazos
	slot_pierna.slot_ref = interfaz.jugador.control_equipo.slot_pierna
	slot_arma.slot_ref = interfaz.jugador.control_equipo.slot_arma
	slot_trinket_1.slot_ref = interfaz.jugador.control_equipo.slot_trinket_1
	slot_trinket_2.slot_ref = interfaz.jugador.control_equipo.slot_trinket_2
	slot_trinket_3.slot_ref = interfaz.jugador.control_equipo.slot_trinket_3
	slot_trinket_4.slot_ref = interfaz.jugador.control_equipo.slot_trinket_4


func actualizar():
	slot_cabeza.actualizar()
	slot_cuerpo.actualizar()
	slot_brazos.actualizar()
	slot_pierna.actualizar()
	slot_arma.actualizar()
