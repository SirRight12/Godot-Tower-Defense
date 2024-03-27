extends Node

@export var anim_node:TowerAnimations
func _ready():
	if !anim_node: return
	anim_node.idle()
