extends KinematicBody2D

onready var animSprite:AnimationPlayer = $Aspecto/AnimAspecto
onready var animAtaque:AnimationPlayer = $AnimEquipo
onready var distVision = $Position2D/DistVision
onready var distAtaque = $Position2D/DistAtaque

const VELOCIDAD = 1000

export var vida = 2
export var drop = preload("res://Entidades/Interact/Items/Item.tscn")
export var cantidadDrop = 1
export var enShock = false

var path = []
var movimiento = Vector2.ZERO
var jugador : KinematicBody2D
var distancia = 1
var nav: Navigation2D = null

enum{
	IDLE,
	PERSIGUIENDO,
	ATACANDO,
	MUERTO
}
var estado

var invencible = false
var atacando = false


func _ready():
	if get_tree().has_group("jugador"):
		jugador = get_tree().get_nodes_in_group("jugador")[0]
	if get_tree().has_group("navegacion"):
		nav = get_tree().get_nodes_in_group("navegacion")[0]


func _physics_process(delta):
	if estado!=MUERTO:
		$Position2D.look_at(jugador.global_position)
		if enShock:
			animSprite.play("Damaged")
		else:
			estado = calcularEstado()
			match estado:
				IDLE:
					animSprite.play("Idle")
				PERSIGUIENDO:
					var dir = global_position.direction_to(jugador.global_position)
					if jugador.global_position.x > global_position.x:
						$Aspecto.scale.x = -1
					else:
						$Aspecto.scale.x = 1
					animSprite.play("Andar")
					movimiento = dir * VELOCIDAD * delta
					movimiento = move_and_slide(movimiento)
				ATACANDO:
					atacando=true
					animAtaque.play("Ataque")
					$Position2D/TimerAtaque.start()


func calcularEstado():
	if isJugadorVisto():
		if isJugadorAlcanzable():
			return ATACANDO
		return PERSIGUIENDO
	return IDLE


func isJugadorVisto() -> bool:
	var collider = distVision.get_collider()
	if collider and collider.is_in_group("jugador"):
		generarPath(jugador)
		return true
	return false


func isJugadorAlcanzable() -> bool:
	var collider = distAtaque.get_collider()
	if collider and collider.is_in_group("jugador"):
		generarPath(jugador)
		return true
	return false

# Pathfinding ==================================================================

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
		estado=MUERTO
		var moneda = drop.instance()
		get_parent().call_deferred("add_child",moneda)
		moneda.global_position = global_position
		animSprite.play("Muerte")
		$CollisionShape2D.set_deferred("disabled",true)
		$Hurtbox/CollisionShape2D.set_deferred("disabled",true)


func _on_Hurtbox_damageRecivido(cantidad):
	if estado!=MUERTO:
		enShock = true
		vida -= 1
		revisarVida()


func _on_TimerAtaque_timeout():
	atacando=false
