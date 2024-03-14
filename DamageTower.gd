@icon("res://Tower.svg")
extends Tower
class_name DamageTower
@export var damage:int = 1:
	get = get_damage
@export var reload_time:float = 1:
	get = get_reload_time
var awaiting_attack = false
func process(dt):
	if awaiting_attack: return
	if range_util.areas.size() < 1: return
	awaiting_attack = true
	var target = range_util.get_first_target()
	hit_enemy(target)
	await timeout(reload_time)
	awaiting_attack = false
	pass
func timeout(time):
	var timer = get_tree().create_timer(time)
	await timer.timeout
	return true
func hit_enemy(enemy):
	if !enemy: return
	enemy.take_damage(damage)
func get_damage():
# for messing around with buffs
	var damage_changed = damage
	return damage_changed
func get_reload_time():
# for messing around with buffs	
	var time_changed = reload_time
	scaler.div(time_changed)
	return time_changed
