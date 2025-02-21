class_name InventoryViewer extends GridContainer

@export_file() var slot_prefab: String
@export var initial_size : Vector2i
@export var initial_slot_size : Vector2i


var slot_scene
var inventory_slots : Array[int]
var margin_offset : int

func _ready() -> void:
	slot_scene = load(slot_prefab)
	columns = initial_size.x
	_update_grid(initial_size.x * initial_size.y)
	margin_offset += _get_margin_offset()


func open_view(inventory) -> void:
	_update_grid(inventory.size)
	_populate_inventory(inventory.data)
	pass

func _update_grid(length : int) -> void:
	for child in get_children():
		child.queue_free()
	inventory_slots.clear()

	for i in range(length):
		var slot = slot_scene.instantiate()
		slot.get_child(0).custom_minimum_size = initial_slot_size;
		add_child(slot)
		inventory_slots.append(0)


func _populate_inventory(data) -> void:
	pass

func _get_margin_offset() -> int:
	var parent = get_parent()
	var result = 0

	result += parent.get_theme_constant("margin_bottom")
	result += parent.get_theme_constant("margin_left")
	result += parent.get_theme_constant("margin_right")
	result += parent.get_theme_constant("margin_top")

	if result <= 0:
		return 4
	return result / 4

func _get_index(at_position: Vector2) -> int:
	#TODO: Figure out a way to get the margin values for a slot and the padding of this grid
	var slot_size = initial_slot_size + Vector2i.ONE * 4
	var indxPos = Vector2i(at_position.x / slot_size.x, at_position.y / slot_size.y)
	return indxPos.x + initial_size.x * indxPos.y

func init_debug() -> Control:
	var debug_label = Label.new()
	return debug_label

func _get_drag_data(at_position: Vector2) -> Variant:
	var index : = _get_index(at_position)
	var c = init_debug()
	c.text = "[%s,%s] at index (%s)" % [at_position.x, at_position.y, index]
	set_drag_preview(c)
	return c

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data != null

func _drop_data(at_position: Vector2, data: Variant) -> void:
	pass
