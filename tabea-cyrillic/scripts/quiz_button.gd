extends Button
class_name QuizButton
signal clicked_on(quizID: String, on: bool)
var quizID: String

func _on_toggled(toggled_on: bool) -> void:
	clicked_on.emit(quizID, toggled_on)
