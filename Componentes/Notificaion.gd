extends Panel

export var texto = ""

func _ready():
	$Texto.text = texto
	$Timer.start()


func _on_Timer_timeout():
	queue_free()
