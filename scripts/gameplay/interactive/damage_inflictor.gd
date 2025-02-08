class_name DamageInflictor extends Area3D

@export var damage_over_time: int = 1
@export var damage_interval: float = 1.0

var found_player: Player
var counter : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	self.body_entered.connect(on_body_entered)
	self.body_exited.connect(on_body_exited)
	counter = damage_interval


func on_body_entered(body: Player) -> void:
	if !body:
		return
	found_player = body


func on_body_exited(body: Player) -> void:
	if !body:
		return
	found_player = null


func _process(delta: float) -> void:
	if !found_player:
		return
	counter -= delta
	if counter <= 0:
		counter = damage_interval
		found_player.health_manager.alter_health(damage_over_time)