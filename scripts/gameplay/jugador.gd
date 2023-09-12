extends CharacterBody2D
class_name Jugador

@export var animacion:AnimationPlayer
@export var equipamiento_cabeza:Node2D
@export var equipamiento_cuerpo:Node2D
@export var equipamiento_brazos:Node2D
@export var equipamiento_pies:Node2D
@export var accion_cooldown:Timer

const SPEED = 300.0


func _physics_process(delta):
	var direction = Vector2(Input.get_axis("MOVER_IZQ", "MOVER_DER"),Input.get_axis("MOVER_ARRIBA", "MOVER_ABAJO"))
	if direction:
		velocity = direction * SPEED * delta
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
