extends KinematicBody2D

onready var animPersonaje = $Sprite/AnimacionPersonaje
onready var animEquipo = $AnimacionEquipo

const ACELERACION = 200
const VEL_NORMAL = 35
const VEL_CORRER = 60
const FRICCION = 500

var interactuable: Area2D
var velocidad = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	animPersonaje.play("Idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if !animEquipo.is_playing():
		$Position2D.look_at(get_global_mouse_position())
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
		if DatosJugador.estamina > 0:
			rapidez = VEL_CORRER
			if direccion != Vector2.ZERO:
				DatosJugador.setEstamina(-2 * delta)
	else:
		DatosJugador.setEstamina(1 * delta)
	
	if direccion != Vector2.ZERO:
		animPersonaje.play("Andar")
		velocidad = velocidad.move_toward(direccion * rapidez, ACELERACION * delta)
	else:
		animPersonaje.play("Idle")
		velocidad = velocidad.move_toward(Vector2.ZERO, FRICCION * delta)
	direccion = direccion.normalized()
	
	if get_global_mouse_position().x < global_position.x:
		$Sprite.scale.x = -1
	elif get_global_mouse_position().x > global_position.x:
		$Sprite.scale.x = 1
	
	
	velocidad = move_and_slide(velocidad)


func _input(event):
	if event.is_action_pressed("ATACAR"):
		if interactuable:
			interactuable.interactuado()
		else:
			if DatosJugador.estamina >= 1:
				DatosJugador.setEstamina(-1)
				animEquipo.play("Ataque")


func checkVida():
	if DatosJugador.vida <= 0:
		$InterfazJugador/HasMuerto.show()
		$Sprite.hide()
		get_tree().paused = true


func _on_Hurtbox_damageRecivido(cantidad):
	DatosJugador.setVida(-cantidad)
	checkVida()


func _on_AreaInteractuar_area_entered(area):
	interactuable = area


func _on_AreaInteractuar_area_exited(area):
	if interactuable == area:
		interactuable = null
