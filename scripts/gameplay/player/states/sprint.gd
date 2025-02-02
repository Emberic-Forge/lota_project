extends PlayerState

@export var speed : float = 10.0
@export var acceleration : float = 10.0
@export var deceleration : float = 10.0

func on_enter(_msg):
	pass

func on_exit():
	pass

func on_update(_delta: float):
	if is_fallling():
		transition_to_state.emit(self, "fall", {})
	elif is_zero_approx(player.velocity.length()) and is_zero_approx(get_directional_input().length()):
		transition_to_state.emit(self, "idle", {})
	elif is_jumping():
		transition_to_state.emit(self, "jump", {})
	elif Input.is_action_just_released("move_sprint"):
		transition_to_state.emit(self, "move", {})

func on_physical_update(_delta: float):
	move_player(speed, acceleration, deceleration)
