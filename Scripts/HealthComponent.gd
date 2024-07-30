class_name Health_component extends Node

@export var max_health: float = 10.0
var health: float
var dead:bool = false

signal _no_health
signal _hited

func _ready():
	health = max_health

func _process(delta):
	if !dead:
		_check_health()

func _take_damage(dmg:float):
	health -= dmg
	_hited.emit(dmg)

func _check_health():
	if health <=0:
		dead = true
		_no_health.emit()

