extends Node


func vector2(bullet_speed: float, target_position: Vector2, target_velocity: Vector2, target_acceleration: Vector2 = Vector2.ZERO, bullet_acceleration: Vector2 = Vector2.ZERO) -> Vector2:
	var target_position_3: Vector3 = Vector3(target_position.x, target_position.y, 0)
	var target_velocity_3: Vector3 = Vector3(target_velocity.x, target_velocity.y, 0)
	var target_acceleration_3: Vector3 = Vector3(target_acceleration.x, target_acceleration.y, 0)
	var bullet_acceleration_3: Vector3 = Vector3(bullet_acceleration.x, bullet_acceleration.y, 0)

	var Vb3: Vector3 = vector3(bullet_speed, target_position_3, target_velocity_3, target_acceleration_3, bullet_acceleration_3)
	var Vb2: Vector2 = Vector2(Vb3.x, Vb3.y)

	return Vb2


func vector3(bullet_speed: float, target_position: Vector3, target_velocity: Vector3, target_acceleration: Vector3 = Vector3.ZERO, bullet_acceleration: Vector3 = Vector3.ZERO) -> Vector3:
	var s: float = bullet_speed
	var T: Vector3 = target_position
	var V: Vector3 = target_velocity
	var At: Vector3 = target_acceleration
	var Ab: Vector3 = bullet_acceleration
	var A: Vector3 = At - Ab

	var a: float = A.length_squared() / 4
	var b: float = A.dot(V)
	var c: float = V.length_squared() + A.dot(T) - s ** 2
	var d: float = 2 * V.dot(T)
	var e: float = T.length_squared()

	var roots_t: Array[float] = Equation.quartic_solve_real(a, b, c, d, e)

	var time: float = -1

	for t in roots_t:
		if t > 0:
			if time == -1:
				time = t
			else:
				time = t if t < time else time

	var Vb: Vector3

	if time == -1:
		Vb = Vector3.ZERO
	else:
		Vb = T / time + V + A * time / 2

	return Vb
