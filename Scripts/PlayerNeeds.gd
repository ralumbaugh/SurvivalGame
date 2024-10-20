extends Node3D

var health : Need
var hunger : Need
var thirst : Need
var sleep : Need

@export var no_hunger_health_decay: float
@export var no_thirst_health_decay: float

func _ready():
	health = get_node("Health")
	hunger = get_node("Hunger")
	thirst = get_node("Thirst")
	sleep = get_node("Sleep")
	
	health.value = health.start_value
	hunger.value = hunger.start_value
	thirst.value = thirst.start_value
	sleep.value = sleep.start_value


func _process(delta):
	hunger.subtract(hunger.decay_rate * delta)
	thirst.subtract(thirst.decay_rate * delta)
	sleep.add(sleep.regen_rate * delta)
	
	if hunger.value == 0:
		health.subtract(no_hunger_health_decay * delta)
	if thirst.value == 0:
		health.subtract(no_thirst_health_decay * delta)
	
	health.update_ui_bar()
	hunger.update_ui_bar()
	thirst.update_ui_bar()
	sleep.update_ui_bar()
