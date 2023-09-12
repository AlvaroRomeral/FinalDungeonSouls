extends Resource
class_name ResGuardado

# DATOS JUGADOR
# DATOS
@export var vida: int = 10
@export var mana: int = 0
@export var esta: int = 1
@export var nivel: int = 1
@export var experiencia: int = 0
@export var tiempo_preparatoria: float = 10

# INVENTARIO Y EQUIPAMIENTO
@export var monedas: int = 100
@export var inventario: Array = []
@export var equipamiento: Dictionary = {
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
