class_name PlayerState extends State

@export var player : Player

func get_directional_input() -> Vector3:
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	return (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

func is_jumping() -> bool:
	return Input.is_action_just_pressed("move_jump")

func is_fallling() -> bool:
	return not player.is_on_floor() and player.velocity.y < 0
