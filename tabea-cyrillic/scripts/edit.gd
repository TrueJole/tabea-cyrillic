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
	for questionID: int in range(SaveLoad.questions.size()):
		var button: QuestionButton = QUESTION_BUTTON.instantiate()
		button.text = SaveLoad.questions[questionID]["question"]
		button.id = questionID
		button.clicked_on.connect(_on_question_clicked_on)
		%QuestionList.add_child(button)

func _on_question_clicked_on(id: int) -> void:
	currentEditID = id
	%EditPage.show()
	%QuestionField.text = SaveLoad.questions[id]["question"]
	for child: Node in %AnswerList.get_children():
		child.free()
		
	for answer: String in SaveLoad.questions[id]["answers"]:
		var answerField: AnswerLineEdit = ANSWER_LINE_EDIT.instantiate()
		answerField.text = answer
		%AnswerList.add_child(answerField)

	var answerField: AnswerLineEdit = ANSWER_LINE_EDIT.instantiate()
	answerField.lastField = true
	%AnswerList.add_child(answerField)

func _on_done_button_pressed() -> void:
	SaveLoad.questions[currentEditID]["question"] = %QuestionField.text
	var fields: Array = %AnswerList.get_children()
	SaveLoad.questions[currentEditID]["answers"] = []
	SaveLoad.questions[currentEditID]["answers"].resize(fields.size()-1)
	for answerID: int in range(fields.size()-1):
		SaveLoad.questions[currentEditID]["answers"][answerID] = fields[answerID].text
	%EditPage.hide()
	SaveLoad.writeQuestions()
	updateList()

func _on_logo_button_pressed() -> void:
	SaveLoad.writeQuestions()
	add_sibling(MENU.instantiate())
	queue_free()


func _on_add_button_pressed() -> void:
	SaveLoad.questions.append({"question" : "", "answers" : []})
	SaveLoad.resetSavegame()
	_on_question_clicked_on(SaveLoad.questions.size()-1)


func _on_remove_button_pressed() -> void:
	SaveLoad.questions.pop_at(currentEditID)
	SaveLoad.resetSavegame()
	%EditPage.hide()
	SaveLoad.writeQuestions()
	updateList()
