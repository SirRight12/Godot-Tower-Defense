@icon("res://Tower.svg")
extends DamageTower
class_name GunTower
func _shoot(enemy):
	if !enemy: return
	enemy.take_damage(damage)
func _init():
	pass
