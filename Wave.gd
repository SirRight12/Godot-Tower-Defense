extends Resource
class_name Wave
enum ENEMY_TYPES{BASIC,SPEEDY,ZICKEY}
@export var delay:int = 2
@export var bonus = 100
@export var enemies:Array[ENEMY_TYPES]
@export var times:Array[int]
@export var message:String
