extends CharacterBody2D


var acceleration: Vector2


func change_color(color: Color) -> void:
	if modulate != Color.AQUA:
		modulate = color


func init(new_velocity: Vector2, new_acceleration: Vector2) -> void:
	velocity = new_velocity
	acceleration = new_acceleration


func _physics_process(delta: float) -> void:
	velocity += acceleration * delta
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	if collision:
		queue_free()
