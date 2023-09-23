extends CharacterBody2D
class_name Enemigo

@export var velocidad = 50.0
@export var friccion = 0.5
@export var aceleracion = 0.3
@export var jugador:Jugador
@export var efecto_muerte:PackedScene
@export_category("componentes (no tocar)")
@export var control_estado:ControlEstado
@export var control_ataque:ControlAtaque
@export var animacion:AnimationPlayer
@export var nav_agent:NavigationAgent2D
@export var sprite:Sprite2D

func _ready():
	control_estado.muerto.connect(morir)


func _physics_process(_delta):
	var direccion = Vector2.ZERO

	if jugador:
		nav_agent.target_position = jugador.global_position
		
		if nav_agent.is_target_reachable() and global_position.distance_to(jugador.global_position) > 20 and jugador.control_estado.estado_actual.salud > 0:
			if nav_agent.get_next_path_position().x > global_position.x:
				sprite.flip_h = true
			else:
				sprite.flip_h = false
			animacion.play("walk")

			direccion = nav_agent.get_next_path_position() - global_position
			direccion = direccion.normalized()

			velocity = velocity.lerp(direccion * velocidad, aceleracion)
		else:
			animacion.play("idle")
			velocity = velocity.lerp(Vector2.ZERO, friccion)
		
		if global_position.distance_to(jugador.global_position) < 30 and jugador.control_estado.estado_actual.salud > 0:
			control_ataque.atacar(jugador.global_position)

	move_and_slide()


func morir():
	var particulas = efecto_muerte.instantiate()
	particulas.position = global_position
	get_parent().add_child(particulas)
	queue_free()
