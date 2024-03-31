@icon("res://Tower.svg")
extends Node3D
class_name Tower
@export var tower_range:float:
	set = range_changed
@export var cost:int = 100
@export var upgrades:Array[Upgrade]
@onready var utils = find_child("TowerUtils")
@onready var entity = find_child("Entity")
@onready var range_util:TowerRange = get_tower_util("Range")
@onready var deny_place_util:Area3D = get_tower_util("DenyPlace")
@onready var game:GameManager = get_parent_node_3d().find_child("GameManager")
@onready var wave:WaveManager = game.request_manager(game.MANAGERS.WAVE)
@onready var scaler:TimeScale = game.request_manager(game.MANAGERS.TIMESCALE)
@onready var money:MoneyManager = game.request_manager(game.MANAGERS.MONEY)
var is_placeholder = false
func range_changed(val):
	tower_range = val
	if !is_node_ready():
		await ready
	update_range()
func update_range():
	range_util.size = tower_range
func _init():
	assert(false,"Tower is an abstract class")
func _ready():
	entity.idle()
	update_range()
	wave.beat_game.connect(dance)
func dance():
	entity.dance()
func get_tower_util(util_name:String) -> Node3D:
	return utils.find_child(util_name)
func show_range():
	range_util.visible = true
func hide_range():
	range_util.visible = false
func show_deny_place():
	deny_place_util.visible = true
func hide_deny_place():
	deny_place_util.visible = false
func show_all():
	show_range()
	show_deny_place()
func hide_all():
	hide_range()
	hide_deny_place()
func check_deny():
	var areas = deny_place_util.get_overlapping_areas()
	if areas.size() >= 1: return true
	return false
