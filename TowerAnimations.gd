extends Node3D
class_name TowerAnimations
@export var player:AnimationPlayer
func idle():
	player.play("Idle",.1)
	pass
func shoot():
	player.play("Shoot",.1)
	await player.animation_finished
	idle()
func dance():
	player.play("Dance",1)
