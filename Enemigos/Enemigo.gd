extends KinematicBody2D

onready var animSprite = $Sprite/AnimationSprite
onready var animAtaque = $AnimationEquipo
onready var distVision = $Position2D/DistVision
onready var distAtaque = $Position2D/DistAtaque

const VELOCIDAD = 35

export var vida = 5
export var drop = preload("res://Items/Moneda.tscn")
export var cantidadDrop = 1

var path = []
var movimiento = Vector2.ZERO
var jugador : KinematicBody2D
var distancia = 1
var nav: Navigation2D = null

var invencible = false
var atacando = false


func _ready():
	if get_tree().has_group("jugador"):
		jugador = get_tree().get_nodes_in_group("jugador")[0]
	if get_tree().has_group("navegacion"):
		nav = get_tree().get_nodes_in_group("navegacion")[0]


func _physics_process(delta):
	$Position2D.look_at(jugador.global_position)
#	navigate()
#	verJugador()
	if alcanzaJugador():
		atacando=true
		animAtaque.play("Ataque")
		$Position2D/TimerAtaque.start()
	
	if verJugador() and not animAtaque.is_playing():
		var dir = global_position.direction_to(jugador.global_position)
		animSprite.play("Andar")
		movimiento = dir * VELOCIDAD
		movimiento = move_and_slide(movimiento)
	
	if movimiento == Vector2.ZERO:
		animSprite.play("Idle")
		pass


func verJugador() -> bool:
	var collider = distVision.get_collider()
	if collider and collider.is_in_group("jugador"):
		generarPath(jugador)
		return true
	return false


func alcanzaJugador() -> bool:
	var collider = distAtaque.get_collider()
	if collider and collider.is_in_group("jugador"):
		generarPath(jugador)
		return true
	return false


func navigate():	# Define the next position to go to
	if path.size() > 0:
		if global_position.distance_to(path[0]) < distancia:
			path.remove(0)
		else:
			var dir = global_position.direction_to(path[0])
			movimiento = dir * VELOCIDAD
			movimiento = move_and_slide(movimiento)


func generarPath(objetivo):
	path = nav.get_simple_path(global_position, jugador.global_position, false)


func revisarVida():
	if vida <= 0:
		var moneda = drop.instance()
		get_parent().call_deferred("add_child",moneda)
		moneda.global_position = global_position
		$Sound_Muerte.play()
		queue_free()


func _on_Hurtbox_damageRecivido(cantidad):
	animSprite.play("Damaged")
	vida -= 1
	revisarVida()


func _on_TimerAtaque_timeout():
	atacando=false
