@tool
extends Control

signal logoClicked
@export var titel: String

func _on_logo_button_pressed() -> void:
	logoClicked.emit()

func _ready() -> void:
	%TitelLabel.text = titel
