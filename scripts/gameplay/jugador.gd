extends CharacterBody2D
class_name Jugador

@export var velocidad = 150.0
@export var friccion = 0.5
@export var aceleracion = 0.3
@export var pantalla_interfaz:PantallaInterfaz

@export_category("Componentes (no tocar)")
@export var control_estado:ControlEstado
@export var control_equipo:ControlEquipo
@export var control_ataque:ControlAtaque
@export var animacion:AnimationPlayer
@export var cooldown_ataque:Timer

func _ready():
	control_equipo.equipo_modificado.connect(func(): pantalla_interfaz.actualizar())
	control_estado.estado_modificado.connect(func(): pantalla_interfaz.actualizar())


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
	
	if Input.is_action_pressed("ATACAR") and cooldown_ataque.is_stopped() and !pantalla_interfaz.panel_inventario.visible:
		cooldown_ataque.start()
		control_ataque.atacar(get_global_mouse_position())
