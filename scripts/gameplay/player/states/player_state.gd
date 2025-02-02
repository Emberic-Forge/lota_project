class_name PlayerState extends State

@export var player: Player

func get_directional_input() -> Vector3:
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	return (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

func is_jumping() -> bool:
	return Input.is_action_just_pressed("move_jump")

func is_fallling() -> bool:
	return not player.is_on_floor() and player.velocity.y < 0


func set_player_collider(new_collider: Shape3D) -> void:
	var collider: CollisionShape3D = player.get_node("collider")
	var old_shape = collider.shape
	collider.shape = new_collider
	player.position.y -= (old_shape.height - new_collider.height) / 2.0

func set_player_mesh(new_mesh: Mesh) -> void:
	var mesh_instance: MeshInstance3D = player.get_node("model")
	mesh_instance.mesh = new_mesh

func move_player(speed, acceleration, deceleration) -> void:
	# Get the directional input
	var direction = get_directional_input()

	# Move the player if the current input is not zero
	if direction:
		# Calculate the target velocity
		var target_velocity = direction * speed

		# Move the player towards the target velocity
		player.velocity.x = move_toward(player.velocity.x, target_velocity.x, acceleration)
		player.velocity.z = move_toward(player.velocity.z, target_velocity.z, acceleration)
	else:
		# If the input is zero, decelerate the player
		player.velocity.x = move_toward(player.velocity.x, 0, deceleration)
		player.velocity.z = move_toward(player.velocity.z, 0, deceleration)

	# Apply the velocity to the player
	player.move_and_slide()
