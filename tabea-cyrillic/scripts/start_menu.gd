extends Control

var CHOOSE_QUIZ: PackedScene = preload("uid://ds1473sk2eko3")
var CHOOSE_QUIZ_EDIT: PackedScene = preload("uid://bsjups11m8bn3")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_start_quiz_button_pressed() -> void:
	var next: Node = CHOOSE_QUIZ.instantiate()
	next.next = "quiz"
	add_sibling(next)
	queue_free()

func _on_edit_quiz_button_pressed() -> void:
	add_sibling(CHOOSE_QUIZ_EDIT.instantiate())
	queue_free()
