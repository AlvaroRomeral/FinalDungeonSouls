extends Panel

export(int) var slot_equipo = 0

func _ready():
	pass


func equipar():
	Jugador.array_equipo[slot_equipo]
