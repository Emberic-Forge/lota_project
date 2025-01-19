class_name UltraRichTextLabel extends RichTextLabel


func _ready():
	print(OS.get_keycode_string(DisplayServer.keyboard_get_label_from_physical(KEY_SPACE)).replace("Kp", "Numpad"))
