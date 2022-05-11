extends KinematicBody2D

onready var anim_cuerpo:AnimationPlayer = $Aspecto/AnimAspecto
onready var dist_vision = $Position2D/DistVision
onready var dist_ataque = $Position2D/DistAtaque
onready var com_ataque = $Position2D/ComponenteArma

const ACELERACION = 200
const FRICCION = 500
const RES_ITEM = preload("res://Entidades/Interact/Items/Item.tscn")

export var vida = 2
export var ataque = 1
export var movimiento_normal = 35
export var mov_correr = 60
export var id_drop = 2
export var cantidad_drop = 5
export var exp_drop = 100
export var puntuacion = 100

var enShock = false
var velocidad = Vector2.ZERO

var jugador : KinematicBody2D
var objetivo : Vector2
var path:Array = []
var nav: Navigation2D = null
var posicion_incial: Vector2
var punto_actual = 0

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
	revisarVida()
	posicion_incial = global_position


func _physics_process(delta):
	if estado != MUERTO:
		$Position2D.look_at(jugador.global_position)
		if enShock:
			anim_cuerpo.play("Damaged")
		else:
			if isJugadorVisto():
				navigate()

# Pathfinding ======================================================================================

func navigate():	# Define the next position to go to
	if isJugadorAlcanzable():
		anim_cuerpo.play("Idle")
		if atacando == false:
			atacando = true
			com_ataque.damage_arma = ataque
			com_ataque.usar()
			$Position2D/TimerAtaque.start()
	else:
		if jugador.global_position.x > global_position.x:
			$Aspecto.scale.x = -1
		else:
			$Aspecto.scale.x = 1
		anim_cuerpo.play("Andar")
#		generarPath(jugador.global_position)
#		if path.size() > 0:
		if path.size() > punto_actual:
#			velocidad = global_position.direction_to(path[1]) * movimiento_normal
			velocidad = global_position.direction_to(path[punto_actual]) * movimiento_normal
			# If reached the destination, remove this point from path array
#			if global_position == path[0]:
#				path.pop_front()
			if global_position.distance_to(path[punto_actual]) < 1:
				punto_actual += 1
		else:
			velocidad = Vector2.ZERO
		velocidad = move_and_slide(velocidad)


func generarPath(objetivo):
	punto_actual = 0
	if objetivo != Vector2.ZERO:
		path = nav.get_simple_path(global_position, objetivo)
	else:
		path = nav.get_simple_path(global_position, posicion_incial)


func isJugadorVisto() -> bool:
	var collider = dist_vision.get_collider()
	if collider and collider.is_in_group("jugador"):
		generarPath(jugador.global_position)
#		if !$TimerOlvidar.is_stopped():
#			$TimerOlvidar.stop()
#		if objetivo == Vector2.ZERO:
#			objetivo = Jugador.getJugadorPosicion()
		return true
	else:
#		if $TimerOlvidar.is_stopped():
#			$TimerOlvidar.start()
		return false


func isJugadorAlcanzable() -> bool:
	var collider = dist_ataque.get_collider()
	if collider and collider.is_in_group("jugador"):
		generarPath(objetivo)
		return true
	return false

# CALCULOS =========================================================================================

func calcularEstado():
	if isJugadorVisto():
		if isJugadorAlcanzable():
			return ATACANDO
		return PERSIGUIENDO
	return IDLE


func revisarVida():
	if vida <= 0:
		morir()


func morir():
		estado = MUERTO
		var drop: FDS_Item = RES_ITEM.instance()
		get_parent().call_deferred("add_child",drop)
		drop.item_id = id_drop
		drop.cantidad = cantidad_drop
		drop.global_position = global_position
		anim_cuerpo.play("Muerte")
		Jugador.setExp(exp_drop)


func borrarEntidad():
	queue_free()

# SEÑALES ==========================================================================================

func _on_Hurtbox_damageRecivido(cantidad, atacante):
	if estado != MUERTO:
		if cantidad > 0 or atacante != "Enemigo":
			enShock = true
			vida -= cantidad
			revisarVida()


func _on_TimerAtaque_timeout():
	atacando = false


func _on_TimerOlvidar_timeout():
	objetivo = Vector2.ZERO
