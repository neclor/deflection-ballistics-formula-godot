extends CharacterBody2D


var speed: float
var acceleration: Vector3
var direction: Vector3 


var time: float


func change_color(color: Color) -> void:
	if modulate != Color.AQUA:
		modulate = color


func init(new_direction: Vector3, new_speed: float, new_acceleration: Vector3, new_time: float) -> void:
	direction = new_direction
	speed = new_speed
	acceleration = new_acceleration
	time = new_time


func _ready() -> void:
	velocity = Vector2(direction.x, direction.y) * speed

	if time > 0:
		await get_tree().create_timer(time).timeout
		change_color(Color.RED)


func _physics_process(delta: float) -> void:
	velocity += Vector2(acceleration.x, acceleration.y) * delta
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	if collision:
		queue_free()
