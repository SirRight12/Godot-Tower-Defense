@icon("res://Tower.svg")
extends DamageTower
class_name GunTower
func _shoot(enemy):
	if !enemy: return
	entity.shoot()
	var dif = enemy.take_damage(damage)
	print(dif)
	money.add(dif*money_bonus)
func _init():
	pass
