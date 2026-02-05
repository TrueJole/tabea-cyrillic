extends Button
class_name QuestionButton
signal clicked_on(id: int)
var id: int

func _on_pressed() -> void:
	clicked_on.emit(id)
