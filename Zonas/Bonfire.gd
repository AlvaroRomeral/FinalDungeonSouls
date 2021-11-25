extends Area2D

var encendido = false


func _ready():
	if encendido:
		encender()


func interactuar():
	encender()


func encender():
	print(name)
	$Encendio.show()
	$Light2D.show()
	$AnimationPlayer.play("Encendido")


func _on_AreaInteraccion_Interactuado():
	encender()
