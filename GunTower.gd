@icon("res://Tower.svg")
extends DamageTower
class_name GunTower
func _shoot(enemy):
	if !enemy: return
	entity.shoot()
	var dif = enemy.take_damage(damage)
	money.add(dif*money_bonus)
	enemy.take_damage(damage)
func _init():
	pass
