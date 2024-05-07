extends CharacterBody2D


var speed: float = 100
var acceleration: Vector3 = Vector3.ZERO


var current_acceleration: Vector3
var direction: Vector3


@onready var polygon_2d: Polygon2D = $Polygon2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _physics_process(delta: float) -> void:
	direction = Vector3(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"), 0).normalized()

	if direction != Vector3.ZERO:
		current_acceleration = Vector3.ZERO
		velocity = Vector2(direction.x, direction.y) * speed
	else:
		current_acceleration = acceleration
		velocity += Vector2(current_acceleration.x, current_acceleration.y) * delta

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("bullet"):
		body.change_color(Color.AQUA)
