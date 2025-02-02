class_name InteractionArea3D extends Area3D

@export_multiline var interaction_message : String

var last_player : Player

signal on_interact(caller : Player, interactable: InteractionArea3D)

func _ready() -> void:
	self.body_entered.connect(on_player_entered)
	self.body_exited.connect(on_player_exited)

func on_player_entered(incoming_player : Player):
	if !incoming_player:
		print('Player is null')
		return
	incoming_player.current_interactable = self
	incoming_player.interaction_popup.text = interaction_message
	last_player = incoming_player
	print('Player entered')


func on_player_exited(incoming_player : Player):
	if !incoming_player:
		print('Player is null')
		return
	incoming_player.current_interactable = null
	incoming_player.interaction_popup.text = ''
	print('Player exited')

func enable() -> void:
	monitorable = true
	monitoring = true

func disable() -> void:
	monitorable = false
	monitoring = false
	on_player_exited(last_player)
