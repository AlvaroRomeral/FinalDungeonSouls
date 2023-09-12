extends Area2D

var encendido = false


func _ready():
	if encendido:
		encender()
	else:
		$AnimatedSprite2D.frame = 0


func interactuar():
	encender()


func encender():
	$PointLight2D.show()
	$AnimationPlayer.play("Encendido")


func _on_AreaInteraccion_Interactuado():
	encender()
