extends Panel

@export var slot_equipo: int = 0

func _ready():
	pass


func equipar():
	Jugador.array_equipo[slot_equipo]
