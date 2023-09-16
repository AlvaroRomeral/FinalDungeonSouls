extends CharacterBody2D
class_name Jugador

@export var animacion:AnimationPlayer
@export var accion_cooldown:Timer
@export var control_arma:ControlArma

@export var velocidad = 200.0
@export var friccion = 0.5
@export var aceleracion = 0.3


func _physics_process(_delta):
	var direction = Input.get_vector("MOVER_IZQ", "MOVER_DER","MOVER_ARRIBA", "MOVER_ABAJO")
	if direction:
		animacion.play("walk")
		velocity = velocity.lerp(direction * velocidad, aceleracion)
	else:
		animacion.play("idle")
		velocity = velocity.lerp(Vector2.ZERO, friccion)

	move_and_slide()


func _input(event):
	if event.is_action("ATACAR"):
		control_arma.atacar()
