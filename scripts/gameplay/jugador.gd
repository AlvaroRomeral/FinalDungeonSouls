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
	control_estado.just_muerto.connect(muerte)


func _physics_process(_delta):
	var direction = Vector2.ZERO
	if !control_estado.is_muerto():
		direction = Input.get_vector("MOVER_IZQ", "MOVER_DER","MOVER_ARRIBA", "MOVER_ABAJO")
		
		if Input.is_action_pressed("ATACAR") and !pantalla_interfaz.panel_inventario.visible:
			control_ataque.atacar(get_global_mouse_position())

	if direction:
		animacion.play("walk")
		
		direction = direction.normalized()
		
		velocity = velocity.lerp(direction * velocidad, aceleracion)
	else:
		animacion.play("idle")
		velocity = velocity.lerp(direction, friccion)

	move_and_slide()
	


func _input(event):
	if event.is_action_pressed("LINTERNA"):
		control_estado.add_experiencia(10)
		# print(control_estado.exp_necesaria(31))
		# print(control_estado.exp_necesaria(50))
		# print(control_estado.exp_necesaria(100))
		# print(control_estado.exp_necesaria(195))
		# print(control_estado.exp_necesaria(200))


func muerte():
	var particulas = efecto_muerte.instantiate()
	particulas.position = global_position
	get_parent().call_deferred("add_child", particulas)
	hide()
