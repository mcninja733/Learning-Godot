extends Resource
class_name SlotData

const max_stack_size: int = 99

@export var item_data: ItemData
@export_range(1, max_stack_size) var quantity: int = 1
