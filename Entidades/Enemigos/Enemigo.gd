extends KinematicBody2D

onready var anim_cuerpo:AnimationPlayer = $Aspecto/AnimAspecto
onready var lbl_estado = $LabelEstado

const FRICCION = 500
const RES_ITEM = preload("res://Entidades/Interact/Items/Item.tscn")

export var tier = 1
export var vida = 5
export var ataque = 2
export var velocidad = 35
export var id_drop = 2
export var cantidad_drop = 5
export var exp_drop = 100
export var puntuacion = 100

var enShock = false
var movimiento = Vector2.ZERO

var jugador : KinematicBody2D
var objetivo : Vector2
var path:Array = []
var nav: Navigation2D = null
var posicion_incial: Vector2

enum{
	IDLE,
	PERSIGUIENDO,
	SHOCK,
	MUERTO
}
var estado = IDLE

var invencible = false
var atacando = false


func _ready():
	$Hitbox.damage = ataque
	jugador = Jugador.getJugador()
	if get_tree().has_group("navegacion"):
		nav = get_tree().get_nodes_in_group("navegacion")[0]
	revisarVida()
	posicion_incial = global_position
	generarPath(jugador.global_position)


func _physics_process(delta):
	calcularEstado()
	match estado:
		IDLE:
			lbl_estado.text = "IDLE"
			pass
		PERSIGUIENDO:
			lbl_estado.text = "PERSIGUIENDO"
			if path.size() > 0:
				if global_position.distance_to(path[0]) < 2:
					path.remove(0)
#					generarPath(jugador.global_position)
				else:
					var direccion = global_position.direction_to(path[0])
					movimiento = direccion * velocidad
				if jugador.global_position.x > global_position.x:
					$Aspecto.scale.x = -1
				else:
					$Aspecto.scale.x = 1
		SHOCK:
			lbl_estado.text = "SHOCK"
		MUERTO:
			lbl_estado.text = "MUERTO"
	
	
	movimiento = move_and_slide(movimiento)


func calcularEstado():
	if estado == MUERTO:
		return
	elif enShock:
		estado = SHOCK
		anim_cuerpo.play("Damaged")
		return
	elif jugador == null:
		estado = IDLE
		anim_cuerpo.play("Idle")
		return
	estado = PERSIGUIENDO
	anim_cuerpo.play("Andar")


func generarPath(objetivo):
	if objetivo != Vector2.ZERO:
		path = nav.get_simple_path(global_position, objetivo, false)

# CALCULOS =========================================================================================

func revisarVida():
	if vida <= 0:
		morir()


func morir():
	movimiento = Vector2.ZERO
	estado = MUERTO
	$Hitbox.setActico(false)
	dropItem()
	anim_cuerpo.play("Muerte")
	Jugador.setPuntuacion(puntuacion)
	Jugador.setExp(exp_drop)
	Global.enemigoElimidado(tier)


func dropItem():
	var drop: FDS_Item = RES_ITEM.instance()
	drop.item_id = id_drop
	drop.cantidad = cantidad_drop
	drop.global_position = global_position
	get_parent().call_deferred("add_child",drop)


func borrarEntidad():
	queue_free()

# SEÑALES ==========================================================================================

func _on_TimerActualizar_timeout():
	generarPath(jugador.global_position)


func _on_Hurtbox_enShock():
	enShock = true


func _on_Hurtbox_noShock():
	enShock = false


func _on_Hurtbox_recibeDamage(damage,posicion):
	if estado != MUERTO:
		vida -= damage
		revisarVida()
