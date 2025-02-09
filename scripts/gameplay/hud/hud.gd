class_name HUD extends CanvasLayer

@onready var health_bar: TextureProgressBar = $health_bar

func update_health(new_value: float) -> void:
	health_bar.value = new_value
