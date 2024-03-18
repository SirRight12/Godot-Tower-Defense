extends Node3D
class_name TowerAnimations
@export var player:AnimationPlayer
func idle():
	print("help")
	player.play("Idle",.1)
	pass
func shoot():
	print("shootism time ig")
	player.play("Shoot",.1)
	await player.animation_finished
	idle()
