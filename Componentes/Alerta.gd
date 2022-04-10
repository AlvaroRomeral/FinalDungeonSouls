extends Control
class_name Alerta

signal aceptar
signal cancelar

export var texto: String


func _ready():
	$Panel/RichTextLabel.bbcode_text = "[center]" + texto


func _on_BtnAceptar_button_up():
	emit_signal("aceptar")
	queue_free()


func _on_BtnCancelar_button_up():
	emit_signal("cancelar")
	queue_free()
