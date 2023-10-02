extends StaticBody2D
class_name Brasero

@export var llama:AnimatedSprite2D

func _ready():
	apagar_llama()


func encender_llama():
	llama.show()


func apagar_llama():
	llama.hide()


func cambiar_llama(tipo:String):
	match tipo:
		"normal":
			llama.animation = "llama_normal"
		"azul":
			llama.animation = "llama_azul"
