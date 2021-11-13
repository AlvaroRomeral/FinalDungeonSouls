extends KinematicBody2D

onready var distVision = $Position2D/DistVision
onready var distAtaque

const VELOCIDAD = 45

export var vida = 10
export var drop = preload("res://Items/Moneda.tscn")
export var cantidadDrop = 1

var path = []
var movimiento = Vector2.ZERO
var empuje = Vector2.ZERO
var jugador : KinematicBody2D
var vistoJugador = false
var levelNavigation: Navigation2D = null
var invencible = false


func _ready():
	$AnimationPlayer.play("Idle")
	jugador = get_tree().get_nodes_in_group("jugador")[0]
	if get_tree().has_group("navegacion"):
		levelNavigation = get_tree().get_nodes_in_group("navegacion")[0]

func _physics_process(delta):
	if jugador:
		$Position2D.look_at(jugador.global_position)
		check_player_in_detection()
		if vistoJugador:
			generate_path()
	navigate()
		
	mover()

func check_player_in_detection() -> bool:
	var collider = distVision.get_collider()
	if collider and collider.is_in_group("jugador"):
		vistoJugador = true
		return true
	else:
		vistoJugador = false
	return false

func navigate():	# Define the next position to go to
	if path.size() > 0:
		movimiento = global_position.direction_to(path[1]) * VELOCIDAD
		# If reached the destination, remove this point from path array
		if global_position == path[0]:
			path.pop_front()
	else:
		movimiento = Vector2.ZERO

func generate_path():	# It's obvious
	if levelNavigation != null and jugador != null:
		path = levelNavigation.get_simple_path(global_position, jugador.global_position, false)

func mover():
	movimiento = move_and_slide(movimiento)

func revisarVida():
	if vida <= 0:
		var moneda = drop.instance()
		get_parent().call_deferred("add_child",moneda)
		moneda.global_position = global_position
		queue_free()


func _on_Hurtbox_damageRecivido(cantidad):
	$AnimationPlayer.play("Damaged")
	vida -= 1
	revisarVida()
