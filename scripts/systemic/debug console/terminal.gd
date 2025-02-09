extends PanelContainer

@onready var output: RichTextLabel = $layout/output
@onready var input: TextEdit = $layout/input

signal on_input_changed(input: String)

func _ready():
	self.visible = false
	input.text_changed.connect(_input_changed_event)


func toggle_visibility() -> void:
	self.visible = not self.visible
	if self.visible:
		input.grab_focus()

func update_output(text: String) -> void:
	if text == '':
		return
	output.text += text


func _input_changed_event() -> void:
	if not input.text.contains('\n'):
		return
	on_input_changed.emit(input.text)
	input.text = ''
