extends Resource
class_name ResGuardado

# DATOS JUGADOR
# DATOS
export(int) var vida = 2
export(int) var mana = 0
export(int) var esta = 1
export(int) var nivel = 1

# INVENTARIO Y EQUIPAMIENTO
export(int) var monedas = 0
export(Array) var inventario = []
export(Dictionary) var equipamiento = {
	"arma" : null,
	"cabeza" : null,
	"torso" : null,
	"piernas" : null,
	"pies" : null,
	"amuleto1" : null,
	"amuleto2" : null,
	"amuleto3" : null,
	"amuleto4" : null
}
