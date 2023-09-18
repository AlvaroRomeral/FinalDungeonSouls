extends CharacterBody2D
class_name Jugador

@export var animacion:AnimationPlayer
@export var cooldown_ataque:Timer
@export var control_arma:ControlArma
@export var control_estado:ControlEstado

@export var velocidad = 150.0
@export var friccion = 0.5
@export var aceleracion = 0.3


func _physics_process(_delta):
	var direction = Input.get_vector("MOVER_IZQ", "MOVER_DER","MOVER_ARRIBA", "MOVER_ABAJO")
	
	if direction:
		animacion.play("walk")
		
		direction = direction.normalized()
		
		velocity = velocity.lerp(direction * velocidad, aceleracion)
	else:
		animacion.play("idle")
		velocity = velocity.lerp(Vector2.ZERO, friccion)

	move_and_slide()
	
	if Input.is_action_pressed("ATACAR") and cooldown_ataque.is_stopped():
		cooldown_ataque.start()
		control_arma.atacar()
