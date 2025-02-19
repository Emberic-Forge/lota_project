class_name InventoryViewer extends GridContainer

@export_file() var slot_prefab: String
@export var initial_size : Vector2i
@export var initial_slot_size : Vector2i
var slot_scene

var inventory_slots : Array[Control]

func _ready() -> void:
	slot_scene = load(slot_prefab)
	columns = initial_size.x
	_update_grid(initial_size.x * initial_size.y)
	

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
		inventory_slots.append(slot)
		

func _populate_inventory(data) -> void:
	pass

func init_debug() -> Control:
	var debug_label = Label.new()
	return debug_label

func _get_drag_data(at_position: Vector2) -> Variant:
	var c = init_debug()
	c.text = "[%s,%s]" % [at_position.x, at_position.y] 
	set_drag_preview(c)
	return c

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data != null

func _drop_data(at_position: Vector2, data: Variant) -> void:
	pass
