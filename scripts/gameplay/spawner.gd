extends Node2D
class_name Spawner

func spawnear_enemigo(entidad:Enemigo):
    entidad.position = global_position
    get_parent().add_child(entidad)