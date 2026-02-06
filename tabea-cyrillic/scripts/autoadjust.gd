extends RichTextLabel

#@export font_size

func autoadjust() -> void:
	add_theme_font_size_override("normal_font_size", 50)
	autowrap_mode = TextServer.AUTOWRAP_ARBITRARY
	print(custom_minimum_size.y / (get_line_count()+1) * (2.0/3))
	add_theme_font_size_override("normal_font_size",custom_minimum_size.y / (get_line_count()+1) * (1.0/3)) # * get_theme_font_size("normal_font_size")
	autowrap_mode = TextServer.AUTOWRAP_WORD#_SMART
