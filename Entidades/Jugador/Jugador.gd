extends KinematicBody2D

onready var anim_personaje = $Aspecto/AnimAspecto
onready var anim_equipo = $Position2D/ComponenteArma/AnimArma
onready var aspecto = $Aspecto
onready var com_arma = $Position2D/ComponenteArma

const ACELERACION = 800
const VEL_NORMAL = 50
const VEL_CORRER = 70
const FRICCION = 500

var interactuable: Area2D
var rapidez
var velocidad = Vector2.ZERO
var angulo_controlador = Vector2.ZERO
var controlador = false

func _ready():
	Jugador.actualizarStats()
	anim_personaje.play("Idle")

# MOVIMIENTO =======================================================================================

func _physics_process(delta):
	if !anim_equipo.is_playing():
		if controlador:
			angulo_controlador.y = Input.get_joy_axis(0,JOY_AXIS_3)
			angulo_controlador.x = Input.get_joy_axis(0,JOY_AXIS_2)
			if angulo_controlador != Vector2.ZERO:
				$Position2D.rotation = angulo_controlador.angle()
			if angulo_controlador.x < 0:
				aspecto.scale.x = 1
			elif angulo_controlador.x > 0:
				aspecto.scale.x = -1
		else:
			$Position2D.look_at(get_global_mouse_position())
			if get_global_mouse_position().x < global_position.x:
				aspecto.scale.x = 1
			elif get_global_mouse_position().x > global_position.x:
				aspecto.scale.x = -1
				
	var direccion = Vector2.ZERO
	if Input.is_action_pressed("MOVER_ARRIBA"):
		direccion.y -= 1
	if Input.is_action_pressed("MOVER_ABAJO"):
		direccion.y += 1
	if Input.is_action_pressed("MOVER_IZQ"):
		direccion.x -= 1
	if Input.is_action_pressed("MOVER_DER"):
		direccion.x += 1
	direccion = direccion.normalized()
	
	if direccion != Vector2.ZERO:
		if Input.is_action_pressed("ESPRINTAR") and direccion != Vector2.ZERO and Jugador.esta > 0:
			rapidez = VEL_CORRER
			anim_personaje.play("Correr")
		else:
			rapidez = VEL_NORMAL
			anim_personaje.play("Andar")
		velocidad = velocidad.move_toward(direccion * rapidez, ACELERACION * delta)
	else:
		velocidad = velocidad.move_toward(Vector2.ZERO, FRICCION * delta)
		anim_personaje.play("Idle")
	
	velocidad = move_and_slide(velocidad)


func _input(event):
	detectarControlador(event)
	if event.is_action_pressed("ATACAR"):
		if Jugador.esta >= 1:
			Jugador.setEsta(-1)
			com_arma.damage_arma = Jugador.ataque
			com_arma.usar()
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

# COMBATE ==========================================================================================

func checkVida():
	if Jugador.vida <= 0:
		$InterfazJugador/HasMuerto.show()
		Global.emit_signal("modoPelicula",true)
		aspecto.hide()
		get_tree().paused = true

# ASPECTO ==========================================================================================

func actualizarRopa():
	if Jugador.getEquipamiento("cabeza") != null:
		$Aspecto/Cabeza.texture = load(Global.PATH_CASCOS + Datos.getItemTextura(Jugador.getEquipamiento("cabeza")) + ".png")
	else:
		$Aspecto/Cabeza.texture = null
	if Jugador.getEquipamiento("torso") != null:
		$Aspecto/Torso.texture = load(Global.PATH_TORSOS + Datos.getItemTextura(Jugador.getEquipamiento("torso")) + ".png")
	else:
		$Aspecto/Torso.texture = null
	if Jugador.getEquipamiento("piernas") != null:
		$Aspecto/Piernas.texture = load(Global.PATH_PIERNAS + Datos.getItemTextura(Jugador.getEquipamiento("piernas")) + ".png")
	else:
		$Aspecto/Piernas.texture = null
	if Jugador.getEquipamiento("pies") != null:
		$Aspecto/Pies.texture = load(Global.PATH_PIES + Datos.getItemTextura(Jugador.getEquipamiento("pies")) + ".png")
	else:
		$Aspecto/Pies.texture = null
	if Jugador.getEquipamiento("arma") != null:
		$Aspecto/Arma.texture = load(Global.PATH_EQUIPO + Datos.getItemTextura(Jugador.getEquipamiento("arma")) + ".png")
	else:
		$Aspecto/Arma.texture = null

# INTERACCION ======================================================================================

func _on_AreaInteractuar_area_entered(area):
	interactuable = area


func _on_AreaInteractuar_area_exited(area):
	if interactuable == area:
		interactuable = null


func _on_ContadorSegundos_timeout():
	if rapidez != VEL_CORRER:
		Jugador.setEsta(1)
	else:
		Jugador.setEsta(-1)


func _on_Hurtbox_recibeDamage(damage,posicion):
	var cantidadFinal = damage
	cantidadFinal = cantidadFinal - int(Jugador.defensa)
	var empuje = global_position.direction_to(posicion)
	velocidad = -empuje * 300
	anim_personaje.play("Damaged")
	if cantidadFinal > 0:
		Jugador.setVida(-cantidadFinal)
		checkVida()
