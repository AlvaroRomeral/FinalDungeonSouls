extends KinematicBody2D

onready var animPersonaje = $Sprite/AnimacionPersonaje
onready var animEquipo = $AnimacionEquipo

const VELOCIDAD = 50

var movimiento = Vector2.ZERO

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
	if direccion != Vector2.ZERO:
		animPersonaje.play("Andar")
	else:
		animPersonaje.play("Idle")
	direccion = direccion.normalized()
	
	if get_global_mouse_position().x < global_position.x:
		$Sprite.scale.x = -1
	elif get_global_mouse_position().x > global_position.x:
		$Sprite.scale.x = 1
	
#	movimiento = movimiento.move_toward(direccion * VELOCIDAD, 50 * delta)
	movimiento = move_and_slide(direccion * VELOCIDAD)


func _input(event):
	if event.is_action_pressed("ATACAR"):
		animEquipo.play("Ataque")


func checkVida():
	if DatosJugador.vida <= 0:
		$HasMuerto.show()
		$Sprite.hide()


func _on_Hurtbox_damageRecivido(cantidad):
	DatosJugador.setVida(-cantidad)
	checkVida()
