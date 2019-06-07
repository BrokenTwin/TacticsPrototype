extends Node2D

const MOVEMENT_SPEED = 96
const MOVE_POINT_RADIUS = 5

export var max_speed: int = 5
var path


export var max_health: int = 100
var current_health: int


func _ready():
	$HealthBar.max_value = max_health
	update_health(max_health)


func _process(delta):
	# Controls movement along the grid if a path is given.
	if path:
		var target = path[0]
		var direction = (target - position).normalized()
		
		position += direction * MOVEMENT_SPEED * delta
		
		if position.distance_to(target) < MOVE_POINT_RADIUS:
			path.remove(0)
			
			if path.size() == 0:
				path = null


# Works for damage and healing, triggers death at 0 and prevents HP from going above max.
func update_health(number):
	current_health += number
	current_health = clamp(current_health, 0, max_health)
	$HealthBar.value = current_health
	
	if current_health == 0:
		death()


func death():
	pass