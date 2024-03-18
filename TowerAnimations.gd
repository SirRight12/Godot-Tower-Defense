extends Node3D
class_name TowerAnimations
@export var player:AnimationPlayer
func idle():
	print("help")
	player.play("Idle",.1)
	pass
func _ready():
	idle()
	shoot_loop()
func shoot_loop():
	await timeout(1)
	shoot()
	shoot_loop()
func shoot():
	print("shootism time ig")
	player.play("Shoot",.1)
	await player.animation_finished
	idle()
func timeout(time):
	var timer:SceneTreeTimer = get_tree().create_timer(time)
	await timer.timeout
	return true
