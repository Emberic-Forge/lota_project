extends Node3D

@export var trigger_once : bool = false
@onready var test_prompt : Label3D = $test_prompt

func _ready() -> void:
	clear_prompt()

func on_player_interact(_caller : Player, interactable : InteractionArea3D) -> void:
	test_prompt.text = "Interacted with " + interactable.name
	get_tree().create_timer(2.0).timeout.connect(clear_prompt)
	if trigger_once:
		interactable.disable()
	
func clear_prompt() -> void:
	test_prompt.text = ""
