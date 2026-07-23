# Extending resource is the typical and standard thing for a much wider 
# scale and should be used a ton for handling scripts. "res://" is short for it
extends Resource
class_name ItemData

@export var name: String = ""
@export_multiline() var description: String = ""
@export var stackable: bool = false
@export var texture: AtlasTexture
