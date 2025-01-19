extends Node3D

@export var trigger_once : bool = false

func on_player_interact(_caller : Player, interactable : InteractionArea3D) -> void:
	print('This is an interaction event!')
	if trigger_once:
		interactable.disable()
