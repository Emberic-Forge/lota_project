extends CanvasLayer

@onready var terminal = $background

var commands: Dictionary[String, Callable] = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	terminal.on_input_changed.connect(_on_input_changed)
	register_command('help', _help)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed('debug_console'):
		terminal.toggle_visibility()

func _on_input_changed(input: String) -> void:
	print(input)
	var input_array = input.replace('\n', '').split(" ")
	print(input_array)
	var command = input_array[0].to_lower()
	print(command)
	print(commands)
	print(commands.has(command))
	if not commands.has(command):
		terminal.update_output('Command not found: ' + command)
		return
	
	terminal.update_output(commands[command].call(input_array.slice(1, input_array.size())))


func register_command(command: String, callback: Callable) -> void:
	commands[command] = callback
 
func _help(_args: Array) -> String:
	var help_text = 'Available commands:\n'
	for command in commands.keys():
		help_text += command + '\n'
	return help_text
