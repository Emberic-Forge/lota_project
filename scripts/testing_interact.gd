extends Node3D

func on_player_interact(caller : Player, interactable : InteractionArea3D) -> void:
	print('This is an interaction event!')
	interactable.disable()
