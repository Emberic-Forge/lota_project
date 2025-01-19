extends PlayerState

@export var speed : float = 10.0

func on_enter(msg):
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


func on_physical_update(_delta: float):
	var direction = get_directional_input()

	if direction:
		player.velocity.x = direction.x * speed
		player.velocity.z = direction.z * speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed)
		player.velocity.z = move_toward(player.velocity.z, 0, speed)

	player.move_and_slide()
