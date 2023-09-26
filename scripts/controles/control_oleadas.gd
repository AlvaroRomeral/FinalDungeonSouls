extends Node2D
class_name ControlOleadas

@export var jugador:Jugador
@export var enemigo_t1:PackedScene
@export var enemigo_t2:PackedScene
@export var enemigo_t3:PackedScene
@export var spawners:Array[Spawner]
@export var tiempo_entre_spawns:float = 2
@export var tiempo_entre_oleadas:float = 5

var indice_spawners:int = 0
var cantidad_t1 = 0
var cantidad_t2 = 0
var cantidad_t3 = 0
var enemigos_restantes = 0

func _ready():
	comenzar_oleada()


func comenzar_oleada():
	cantidad_t1 = 10
	cantidad_t2 = 5
	cantidad_t3 = 2
	spawnear_enemigos()


func spawnear_enemigos():
	await get_tree().create_timer(tiempo_entre_spawns).timeout
	
	if cantidad_t1:
		var new = enemigo_t1.instantiate()
		new.control_estado.muerto.connect(enemigo_eliminado)
		new.jugador = jugador

		enemigos_restantes += 1

		spawners[indice_spawners].spawnear_enemigo(new)
		cantidad_t1 -= 1
		if indice_spawners >= spawners.size() -1:
			indice_spawners = 0
		else:
			indice_spawners += 1
		spawnear_enemigos()
	
	elif cantidad_t2:
		var new = enemigo_t2.instantiate()
		new.control_estado.muerto.connect(enemigo_eliminado)
		new.jugador = jugador

		enemigos_restantes += 1

		spawners[indice_spawners].spawnear_enemigo(new)
		cantidad_t2 -= 1
		if indice_spawners >= spawners.size() -1:
			indice_spawners = 0
		else:
			indice_spawners += 1
		spawnear_enemigos()
	
	elif cantidad_t3:
		var new = enemigo_t3.instantiate()
		new.control_estado.muerto.connect(enemigo_eliminado)
		new.jugador = jugador

		enemigos_restantes += 1

		spawners[indice_spawners].spawnear_enemigo(new)
		cantidad_t3 -= 1
		if indice_spawners >= spawners.size() -1:
			indice_spawners = 0
		else:
			indice_spawners += 1
		spawnear_enemigos()


func enemigo_eliminado():
	enemigos_restantes -= 1
	if enemigos_restantes <= 0:
		oleada_finalizada()


func oleada_finalizada():
	await get_tree().create_timer(tiempo_entre_oleadas).timeout
	comenzar_oleada()
