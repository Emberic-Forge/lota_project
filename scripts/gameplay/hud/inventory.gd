extends PanelContainer

@onready var grid :GridContainer = $margins/slot_grid
const INVENTORY_SLOT = preload("res://elements/gameplay/hud/inventory_slot.tscn")

class Slot:
	var item : ItemEntry
	var quantity : int
	var visual_slot_ref : NodePath

	func is_empty() -> bool:
		return item == null

	func add(item_to_add : ItemEntry) -> void:
		if !item:
			item = item_to_add
			quantity = 1
			return
		if not item.name == item_to_add.name:
			return
		if quantity >= item.max_stack:
			return
		quantity += 1

	func remove() -> void:
		if !item:
			return
		quantity -= 1
		if quantity <= 0:
			quantity = 0
			item = null

var slots : Array[Slot]

func populate_inventory(inventory : InventoryEntry) -> void:
	for child in grid.get_children():
		child.queue_free()

	slots.clear()

	for i in range(inventory.size):
		var slot = Slot.new()
		var visual_slot = INVENTORY_SLOT.instantiate()
		grid.add_child(visual_slot)
		slot.visual_slot_ref = visual_slot.get_path()
		slots.append(slot)

func add_item(item: ItemEntry) -> void:
	for slot in slots:
		if slot.is_empty():
			slot.add(item)
			return

func remove_item(slot_index : int) -> void:
	if slot_index < 0 or slot_index >= slots.size():
		return
	if not slots[slot_index].is_empty():
		slots[slot_index].remove()
