extends ParallaxBackground

@export var velocidad:float = 50

func _process(delta):
    scroll_offset.x -= velocidad * delta