extends CharacterBody2D
class_name Jugador

@export var velocidad = 150.0
@export var friccion = 0.5
@export var aceleracion = 0.3
@export var pantalla_interfaz:PantallaInterfaz
@export var efecto_muerte:PackedScene

@export_category("Componentes (no tocar)")
@export var control_estado:ControlEstado
@export var control_equipo:ControlEquipo
@export var control_ataque:ControlAtaque
@export var animacion:AnimationPlayer

func _ready():
	control_equipo.equipo_modificado.connect(func(): pantalla_interfaz.actualizar_equipo())
	control_estado.estado_modificado.connect(func(): pantalla_interfaz.actualizar_estado())
	pantalla_interfaz.actualizar_equipo()
	pantalla_interfaz.actualizar_estado()
	control_estado.muerto.connect(muerte)


func _physics_process(_delta):
	var direction = Vector2.ZERO
	if control_estado.estado_actual.salud > 0:
		direction = Input.get_vector("MOVER_IZQ", "MOVER_DER","MOVER_ARRIBA", "MOVER_ABAJO")
	
	if direction:
		animacion.play("walk")
		
		direction = direction.normalized()
		
		velocity = velocity.lerp(direction * velocidad, aceleracion)
	else:
		animacion.play("idle")
		velocity = velocity.lerp(direction, friccion)

	move_and_slide()
	
	if Input.is_action_pressed("ATACAR") and !pantalla_interfaz.panel_inventario.visible:
		control_ataque.atacar(get_global_mouse_position())


func muerte():
	var particulas = efecto_muerte.instantiate()
	particulas.position = global_position
	get_parent().add_child(particulas)
	hide()
