extends Control



var EDITMENU: PackedScene = preload("uid://dm3032vht7se")

func _ready() -> void:
	print(SaveLoad.quizzes.keys())
	var QUIZBUTTON: PackedScene = load("uid://yxe3xq01ans8")
	for quizID: String in SaveLoad.quizzes.keys():
		var quiz_button: QuizButton = QUIZBUTTON.instantiate()
		quiz_button.quizID = quizID
		quiz_button.text = SaveLoad.quizzes[quizID]["name"]
		#quiz_button.button_pressed =  true if SaveLoad.quizzes[quizID]["selected"] == "true" else false
		quiz_button.clicked_on.connect(_on_quiz_clicked_on)
		%QuizList.add_child(quiz_button)

func _on_quiz_clicked_on(quizID: String, on: bool) -> void:
	Constants.editQuiz = quizID
	add_sibling(EDITMENU.instantiate())
	queue_free()

func _on_add_button_pressed() -> void:
	var newQuizID: String
	while true:
		newQuizID = str(randi())
		if !SaveLoad.quizzes.has(newQuizID):
			break
	SaveLoad.quizzes[newQuizID] = {"name" : "New Quiz", "version": 2, "questions" : []}
	Constants.editQuiz = newQuizID
	add_sibling(EDITMENU.instantiate())
	queue_free()

func _on_header_logo_clicked() -> void:
	var MAINMENU: PackedScene = load("uid://cj28jotdlpd0g")
	add_sibling(MAINMENU.instantiate())
	queue_free()



var reader: JavaScriptObject = JavaScriptBridge.create_object("FileReader")
var _reader_callback_ref: JavaScriptObject = JavaScriptBridge.create_callback(JSBcallback_reader)
var document: JavaScriptObject = JavaScriptBridge.get_interface("document")
var _file_callback_ref: JavaScriptObject = JavaScriptBridge.create_callback(JSBcallback_file)
var input: JavaScriptObject = document.createElement("input")

func JSBcallback_file(args: Array) -> void:
	#$Label.text = "Got file"#input.files[0]
	reader.onload = _reader_callback_ref
	reader.readAsText(input.files[0], "UTF-8")#.then(_reader_callback_ref)

func JSBcallback_reader(args: Array) -> void:
	#$Label.text = "read"
	#$Label.text = reader.result
	var newQuizID: String
	while true:
		newQuizID = str(randi())
		if !SaveLoad.quizzes.has(newQuizID):
			break
	SaveLoad.quizzes[newQuizID] = JSON.to_native(JSON.parse_string(reader.result)) #{"name" : "New Quiz", "version": 2, "questions" : []}
	SaveLoad.resetSavegameQuiz(newQuizID)
	Constants.editQuiz = newQuizID
	add_sibling(EDITMENU.instantiate())
	queue_free()

func _on_import_button_pressed() -> void:
	input.type = "file"
	input.accept = ".json,application/json"
	input.onchange = _file_callback_ref
	input.click()
