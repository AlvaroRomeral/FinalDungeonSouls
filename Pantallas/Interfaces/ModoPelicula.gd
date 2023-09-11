extends Control


func _ready():
	Global.connect("modoPelicula", Callable(self, "modoPelicula"))


func modoPelicula(modo):
	if modo:
		$AnimationPlayer.play("Aparecer")
	else:
		$AnimationPlayer.play("Desaparecer")
