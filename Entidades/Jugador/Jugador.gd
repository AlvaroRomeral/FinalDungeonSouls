extends KinematicBody2D

onready var anim_personaje = $Aspecto/AnimAspecto
onready var anim_equipo = $Position2D/ComponenteArma/AnimArma

const ACELERACION = 800
const VEL_NORMAL = 50
const VEL_CORRER = 70
const FRICCION = 500

var interactuable: Area2D
var velocidad = Vector2.ZERO
var angulo_controlador = Vector2.ZERO
var controlador = false

func _ready():
	anim_personaje.play("Idle")

# MOVIMIENTO

func _physics_process(delta):
	if !anim_equipo.is_playing():
		if controlador:
			angulo_controlador.y = Input.get_joy_axis(0,JOY_AXIS_3)
			angulo_controlador.x = Input.get_joy_axis(0,JOY_AXIS_2)
			if angulo_controlador != Vector2.ZERO:
				$Position2D.rotation = angulo_controlador.angle()
			if angulo_controlador.x < 0:
				$Aspecto.scale.x = -1
			elif angulo_controlador.x > 0:
				$Aspecto.scale.x = 1
		else:
			$Position2D.look_at(get_global_mouse_position())
			if get_global_mouse_position().x < global_position.x:
				$Aspecto.scale.x = -1
			elif get_global_mouse_position().x > global_position.x:
				$Aspecto.scale.x = 1
				
	var direccion = Vector2.ZERO
	if Input.is_action_pressed("MOVER_ARRIBA"):
		direccion.y -= 1
	if Input.is_action_pressed("MOVER_ABAJO"):
		direccion.y += 1
	if Input.is_action_pressed("MOVER_IZQ"):
		direccion.x -= 1
	if Input.is_action_pressed("MOVER_DER"):
		direccion.x += 1
	
	var rapidez = VEL_NORMAL
	if Input.is_action_pressed("ESPRINTAR"):
		if Jugador.estamina > 0:
			rapidez = VEL_CORRER
			if direccion != Vector2.ZERO:
				Jugador.setEstamina(-2 * delta)
	else:
		Jugador.setEstamina(1 * delta)
	
	if direccion != Vector2.ZERO:
		if rapidez == VEL_NORMAL:
			anim_personaje.play("Andar")
		else:
			anim_personaje.play("Correr")
		velocidad = velocidad.move_toward(direccion * rapidez, ACELERACION * delta)
	else:
		anim_personaje.play("Idle")
		velocidad = velocidad.move_toward(Vector2.ZERO, FRICCION * delta)
	direccion = direccion.normalized()
	
	
	velocidad = move_and_slide(velocidad)


func _input(event):
	detectarControlador(event)
	if event.is_action_pressed("ATACAR"):
		if Jugador.estamina >= 1:
			Jugador.setEstamina(-1)
			$Position2D/ComponenteArma.usar()
	if event.is_action_released("LINTERNA"):
		if $Light2D.visible:
			$Light2D.hide()
		else:
			$Light2D.show()


func detectarControlador(evento):
	if evento is InputEventKey:
		if controlador == true:
			controlador = false
			Global.Notificacion("Modo Teclado/raton")
	elif evento is InputEventJoypadMotion:
		if controlador == false:
			controlador = true
			Global.Notificacion("Modo Mando")

# COMBATE

func checkVida():
	if Jugador.vida <= 0:
		$InterfazJugador/HasMuerto.show()
		$Aspecto.hide()
		get_tree().paused = true


func _on_Hurtbox_damageRecivido(cantidad):
	var cantidadFinal = cantidad
	cantidadFinal = cantidadFinal - Jugador.defensa
	if cantidadFinal > 0:
		Jugador.setVida(-cantidadFinal)
		checkVida()


func _on_AreaInteractuar_area_entered(area):
	interactuable = area


func _on_AreaInteractuar_area_exited(area):
	if interactuable == area:
		interactuable = null
