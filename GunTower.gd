@icon("res://Tower.svg")
extends DamageTower
class_name GunTower
func _shoot(enemy):
	if !enemy: return
	entity.shoot()
	var dif = enemy.take_damage(damage)
	if !dif:
		dif = 0.0
	money.add(dif*money_bonus)
func _init():
	pass
