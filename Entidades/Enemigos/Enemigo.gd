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
var path = []
var velocidad = Vector2.ZERO
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
	revisarVida()


func _physics_process(delta):
	if estado != MUERTO:
		$Position2D.look_at(jugador.global_position)
		if enShock:
			anim_cuerpo.play("Damaged")
		else:
			estado = calcularEstado()
			match estado:
				IDLE:
					anim_cuerpo.play("Idle")
				PERSIGUIENDO:
					var dir = global_position.direction_to(jugador.global_position)
					if jugador.global_position.x > global_position.x:
						$Aspecto.scale.x = -1
					else:
						$Aspecto.scale.x = 1
					anim_cuerpo.play("Andar")
					velocidad = velocidad.move_toward(dir * movimiento_normal, ACELERACION)
					velocidad = move_and_slide(velocidad)
				ATACANDO:
					anim_cuerpo.play("Idle")
					if atacando == false:
						atacando = true
						com_ataque.damage_arma = ataque
						com_ataque.usar()
						$Position2D/TimerAtaque.start()


func calcularEstado():
	if isJugadorVisto():
		if isJugadorAlcanzable():
			return ATACANDO
		return PERSIGUIENDO
	return IDLE


func isJugadorVisto() -> bool:
	var collider = dist_vision.get_collider()
	if collider and collider.is_in_group("jugador"):
		generarPath(jugador)
		return true
	return false


func isJugadorAlcanzable() -> bool:
	var collider = dist_ataque.get_collider()
	if collider and collider.is_in_group("jugador"):
		generarPath(jugador)
		return true
	return false

# Pathfinding ======================================================================================

func navigate():	# Define the next position to go to
	if path.size() > 0:
		if global_position.distance_to(path[0]) < distancia:
			path.remove(0)
		else:
			var dir = global_position.direction_to(path[0])
			velocidad = dir * ACELERACION
			velocidad = move_and_slide(velocidad)


func generarPath(objetivo):
	path = nav.get_simple_path(global_position, jugador.global_position, false)


func revisarVida():
	if vida <= 0:
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


func _on_Hurtbox_damageRecivido(cantidad, atacante):
	if estado != MUERTO:
		if cantidad > 0 or atacante != "Enemigo":
			enShock = true
			vida -= cantidad
			revisarVida()


func _on_TimerAtaque_timeout():
	atacando = false
