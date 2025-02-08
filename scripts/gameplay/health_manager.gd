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

func alter_health(value: int) -> void:
	current_health -= value
	clamp(current_health, 0, max_health)
	if current_health <= 0:
		die()

func die() -> void:
	print('Player has died!')
	on_death.emit()
