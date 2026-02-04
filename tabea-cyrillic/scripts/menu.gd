extends Control

const EDIT: PackedScene = preload("uid://dm3032vht7se")
const MAIN: PackedScene = preload("uid://b04vt18h530x3")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_start_quiz_button_pressed() -> void:
	if SaveLoad.questions.size() > 0:
		add_sibling(MAIN.instantiate())
		queue_free()

func _on_edit_quiz_button_pressed() -> void:
	add_sibling(EDIT.instantiate())
	queue_free()
