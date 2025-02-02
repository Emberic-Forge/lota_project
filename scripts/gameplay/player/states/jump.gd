extends PlayerState

@export var jump_height: float = 1.0

@export_category("Movement")
@export var air_speed: float = 10.0
@export var air_acceleration: float = 10.0
@export var air_deceleration: float = 10.0

func calculate_jump_velocity() -> float:
	return sqrt(2 * abs(player.get_gravity().y) * jump_height)


func on_enter(_msg) -> void:
	player.velocity.y = calculate_jump_velocity()
	pass

func on_exit(_msg) -> void:
	pass


func on_update(_delta: float) -> void:
	if is_fallling() and not player.is_on_floor():
		transition_to_state.emit(self, "fall", {})

func on_physical_update(delta: float) -> void:
	player.velocity += player.get_gravity() * delta
	move_player(air_speed, air_acceleration, air_deceleration)
