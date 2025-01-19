extends PlayerState

@export var jump_height: float = 1.0

func calculate_jump_velocity() -> float:
	return sqrt(2 * abs(player.get_gravity().y) * jump_height)


func on_enter(msg) -> void:
	player.velocity.y = calculate_jump_velocity()
	pass

func on_exit() -> void:
	pass


func on_update(_delta: float) -> void:
	if is_fallling() and not player.is_on_floor():
		transition_to_state.emit(self, "fall", {})

func on_physical_update(delta: float) -> void:
	player.velocity += player.get_gravity() * delta
	player.move_and_slide()
