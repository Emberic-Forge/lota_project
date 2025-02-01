extends Node

@export var max_health: float = 100
var current_health: float

@export var hud : HUD


signal on_death
# Called when the node enters the scene tree for the first time.
func _ready():
	current_health = max_health

func _process(_delta: float) -> void:
	update_health_bar()

func update_health_bar() -> void:
	hud.update_health(current_health / max_health)

func take_damage(damage: int) -> void:
	current_health -= damage
	if current_health <= 0:
		die()

func die() -> void:
	print('Player has died!')
	on_death.emit()
