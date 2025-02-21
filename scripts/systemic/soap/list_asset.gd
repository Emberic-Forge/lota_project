class_name ListResource extends Resource

@export var initial_value : Array
var value : Array

signal on_value_changed

func _init():
	value = initial_value
	on_value_changed.emit()


func add(new_value) -> void:
	if new_value == null:
		return
	value.append(new_value)
	on_value_changed.emit()

func remove(new_value) -> void:
	if value.find(new_value) == -1:
		return
	value.remove_at(new_value)
	on_value_changed.emit()
