extends LineEdit
class_name AnswerLineEdit

var lastField: bool

func _on_text_changed(new_text: String) -> void:
	if text.strip_edges() == "" and !lastField:
		get_parent().get_child(get_index()-1) .grab_focus()
		queue_free()
	
	if  text.strip_edges() != "" and lastField:
		const ANSWER_LINE_EDIT: PackedScene = preload("uid://dsdkcsu4lqsrx")
		var newLastLine: AnswerLineEdit = ANSWER_LINE_EDIT.instantiate()
		newLastLine.lastField = true
		lastField = false
		add_sibling(newLastLine)
		

func _on_text_submitted(new_text: String) -> void:
	get_parent().get_child(get_index()+1).grab_focus()


func _on_focus_exited() -> void:
	if text.strip_edges() == "" and !lastField:
		get_parent().get_child(get_index()-1) .grab_focus()
		queue_free()
	
	if  text.strip_edges() != "" and lastField:
		const ANSWER_LINE_EDIT: PackedScene = preload("uid://dsdkcsu4lqsrx")
		var newLastLine: AnswerLineEdit = ANSWER_LINE_EDIT.instantiate()
		newLastLine.lastField = true
		lastField = false
		add_sibling(newLastLine)
