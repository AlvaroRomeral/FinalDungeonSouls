extends Area2D

var encendido = false


func _ready():
	if encendido:
		encender()
	else:
		$AnimatedSprite.frame = 0


func interactuar():
	encender()


func encender():
	$Light2D.show()
	$AnimationPlayer.play("Encendido")


func _on_AreaInteraccion_Interactuado():
	encender()
