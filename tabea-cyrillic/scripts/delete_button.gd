extends Button


func _on_pressed() -> void:
	SaveLoad.quizzes.erase(Constants.editQuiz)
	$"../../../.."._on_header_logo_clicked()
