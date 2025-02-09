class_name ItemEntry extends Resource

@export var name : String = 'ItemEntry'
@export_multiline var description : String = 'This is an item.'
@export var icon : Texture = null
@export var stackable : bool = false
@export_range(1, 100) var max_stack : int = 1
@export_flags('resource', 'usable', 'armor', 'weapon') var type : int
