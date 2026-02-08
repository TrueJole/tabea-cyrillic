extends LineEdit


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = SaveLoad.quizzes[Constants.editQuiz]["name"]

func _on_text_changed(new_text: String) -> void:
	SaveLoad.quizzes[Constants.editQuiz]["name"] = new_text
