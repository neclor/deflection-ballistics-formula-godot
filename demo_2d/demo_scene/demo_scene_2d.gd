extends Node2D


const BULLET_2D = preload("res://demo_2d/projectile/bullet_2d.tscn")


var bullet_speed: float = 200
var bullet_acceleration: Vector2 = Vector2.ZERO


@onready var player: CharacterBody2D = $Player2D
@onready var v_box_container = %VBoxContainer


func _on_timer_timeout() -> void:
	create_bullet()


func create_bullet() -> void:
	var target_position: Vector2 = player.position
	var target_velocity: Vector2 = player.velocity
	var target_acceleration: Vector2 = player.current_acceleration

	var bullet_velocity: Vector2 = Deflection.vector2(bullet_speed, target_position, target_velocity, target_acceleration, bullet_acceleration)

	var new_bullet: Node = BULLET_2D.instantiate()

	if bullet_velocity == Vector2.ZERO:
		bullet_velocity = target_position.normalized() * bullet_speed
		new_bullet.modulate = Color.RED


	new_bullet.init(bullet_velocity, bullet_acceleration)
	add_child(new_bullet)


func _on_player_speed_value_changed(value: float) -> void:
	player.speed = value


func _on_player_accelerate_vector_x_text_changed(new_text: String) -> void:
	player.acceleration.x = float(new_text)


func _on_player_accelerate_vector_y_text_changed(new_text: String) -> void:
	player.acceleration.y = float(new_text)


func _on_bullet_speed_value_changed(value: float) -> void:
	bullet_speed = value


func _on_bullet_accelerate_vector_x_text_changed(new_text: String) -> void:
	bullet_acceleration.x = float(new_text)


func _on_bullet_accelerate_vector_y_text_changed(new_text: String) -> void:
	bullet_acceleration.y = float(new_text)


func _on_show_hide_ui_pressed():
	v_box_container.visible = !v_box_container.visible
