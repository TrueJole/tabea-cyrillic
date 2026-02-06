extends Control

var MENU: PackedScene = load("uid://cj28jotdlpd0g")
const QUESTION_BUTTON: PackedScene = preload("uid://gjocejk3rjyb")
const ANSWER_LINE_EDIT: PackedScene = preload("uid://dsdkcsu4lqsrx")
var currentEditID: int = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	updateList()

func updateList() -> void:
	for child: Node in %QuestionList.get_children():
		child.free()
	for questionID: int in range(SaveLoad.quizzes[Constants.editQuiz]["questions"].size()):
		var button: QuestionButton = QUESTION_BUTTON.instantiate()
		button.text = SaveLoad.quizzes[Constants.editQuiz]["questions"][questionID]["question"]
		button.id = questionID
		button.clicked_on.connect(_on_question_clicked_on)
		%QuestionList.add_child(button)

func _on_question_clicked_on(id: int) -> void:
	currentEditID = id
	%EditPage.show()
	%QuestionField.text = SaveLoad.quizzes[Constants.editQuiz]["questions"][id]["question"]#SaveLoad.questions[id]["question"]
	for child: Node in %AnswerList.get_children():
		child.free()
		
	for answer: String in SaveLoad.quizzes[Constants.editQuiz]["questions"][id]["answers"]:
		var answerField: AnswerLineEdit = ANSWER_LINE_EDIT.instantiate()
		answerField.text = answer
		%AnswerList.add_child(answerField)

	var answerField: AnswerLineEdit = ANSWER_LINE_EDIT.instantiate()
	answerField.lastField = true
	%AnswerList.add_child(answerField)

func _on_done_button_pressed() -> void:
	SaveLoad.quizzes[Constants.editQuiz]["questions"][currentEditID]["question"] = %QuestionField.text
	var fields: Array = %AnswerList.get_children()
	SaveLoad.quizzes[Constants.editQuiz]["questions"][currentEditID]["answers"] = []
	SaveLoad.quizzes[Constants.editQuiz]["questions"][currentEditID]["answers"].resize(fields.size()-1)
	for answerID: int in range(fields.size()-1):
		SaveLoad.quizzes[Constants.editQuiz]["questions"][currentEditID]["answers"][answerID] = fields[answerID].text
	%EditPage.hide()
	SaveLoad.writeQuizzes()
	updateList()

func _on_add_button_pressed() -> void:
	SaveLoad.quizzes[Constants.editQuiz]["questions"].append({"question" : "", "answers" : []})
	SaveLoad.resetSavegameQuiz(Constants.editQuiz)
	_on_question_clicked_on(SaveLoad.quizzes[Constants.editQuiz]["questions"].size()-1)


func _on_remove_button_pressed() -> void:
	SaveLoad.quizzes[Constants.editQuiz]["questions"].pop_at(currentEditID)
	SaveLoad.resetSavegameQuiz(Constants.editQuiz)
	%EditPage.hide()
	SaveLoad.writeQuizzes()
	updateList()

func _on_header_logo_clicked() -> void:
	SaveLoad.writeQuizzes()
	add_sibling(MENU.instantiate())
	queue_free()
