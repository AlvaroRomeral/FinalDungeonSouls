extends Resource
class_name ResGuardado

# DATOS JUGADOR
# DATOS
export(int) var vida
export(int) var mana
export(int) var esta

export(int) var defensa = 0
export(int) var ataque = 0
export(int) var nivel = 1

# INVENTARIO Y EQUIPAMIENTO
export(int) var monedas = 0
export(Array) var inventario
export(int) var inventario_cap = 15
export(int) var item_cap_max = 1
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
