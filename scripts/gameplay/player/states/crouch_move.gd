extends PlayerState

@export_category("Movement")
@export var speed: float = 10.0
@export var acceleration: float = 10.0
@export var deceleration: float = 10.0
@export_category("Collision")
@export var normal_hitbox: Shape3D
@export var crouch_hitbox: Shape3D
@export_category("Model")
@export var normal_model: Mesh
@export var crouch_model: Mesh


func on_enter(_msg):
	set_player_collider(crouch_hitbox)
	set_player_mesh(crouch_model)
	pass

func on_exit(_msg):
	if _msg.has("is_crouched"):
		set_player_collider(crouch_hitbox if not _msg["is_crouched"] else normal_hitbox)
		set_player_mesh(crouch_model if not _msg["is_crouched"] else normal_model)
	else:
		set_player_collider(normal_hitbox)
		set_player_mesh(normal_model)

func on_update(_delta: float):
	if is_fallling():
		transition_to_state.emit(self, "fall", {})
	elif is_zero_approx(player.velocity.length()) and is_zero_approx(get_directional_input().length()):
		transition_to_state.emit(self, "crouch", {"is_crouched": true})
	elif Input.is_action_just_released("move_crouch"):
		transition_to_state.emit(self, "move", {})

func on_physical_update(_delta: float):
	move_player(speed, acceleration, deceleration)
