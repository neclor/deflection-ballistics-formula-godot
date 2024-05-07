extends Node2D


const BULLET_2D = preload("res://2d/projectile/bullet_2d.tscn")


var bullet_speed: float = 200
var bullet_acceleration: Vector3 = Vector3.ZERO


@onready var player: CharacterBody2D = $Player2D
@onready var v_box_container = %VBoxContainer


func _on_timer_timeout() -> void:
	create_bullet()


func create_bullet() -> void:
	var new_bullet: Node = BULLET_2D.instantiate()

	var target_position: Vector3 = Vector3(player.position.x, player.position.y, 0)
	var target_velocity: Vector3 = Vector3(player.velocity.x, player.velocity.y, 0)

	var predicted_shot: Dictionary = Formulas.predict_shot(target_position, target_velocity, player.current_acceleration, bullet_acceleration, bullet_speed)

	if predicted_shot["time"] < 0:
		new_bullet.change_color(Color.RED)
	else:
		new_bullet.change_color(Color.GREEN)

	new_bullet.init(predicted_shot["vector"], bullet_speed, bullet_acceleration, predicted_shot["time"])
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
