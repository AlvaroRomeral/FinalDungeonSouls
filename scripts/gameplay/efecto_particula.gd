extends Node2D
class_name EfectoParticula

@export var particulas:GPUParticles2D
@export var timer:Timer

func _ready():
	if timer:
		timer.timeout.connect(func(): queue_free())
	particulas.emitting = true
