extends PlayerState

@export_category("Movement")
@export var air_speed: float = 10.0
@export var air_acceleration: float = 10.0
@export var air_deceleration: float = 10.0

func on_enter(_msg) -> void:
	pass

func on_exit() -> void:
	pass

func on_update(_delta: float) -> void:
	if player.is_on_floor():
		var next_state = "move" if get_directional_input().length() > 0 else "idle"
		transition_to_state.emit(self, next_state, {})

func on_physical_update(delta: float) -> void:
	player.velocity += player.get_gravity() * delta
	move_player(air_speed, air_acceleration, air_deceleration)
