extends Node

func predict_shot(target_position: Vector3, target_velocity: Vector3, target_acceleration: Vector3, bullet_acceleration: Vector3, bullet_speed: float) -> Array:
	var T: Vector3 = target_position
	var V: Vector3 = target_velocity
	var At: Vector3 = target_acceleration
	var Ab: Vector3 = bullet_acceleration
	var s: float = bullet_speed

	var roots_t: Array[float] = []

	var A: Vector3 = At - Ab
	var a: float = A.length_squared() / 4

	if is_zero_approx(a):
		var c: float = V.length_squared() - s ** 2
		var d: float = 2 * V.dot(T)
		var e: float = T.length_squared()

		if is_zero_approx(c):
			roots_t = [-e / d]
		else:
			roots_t = solve_quadratic_real(d / c, e / c)

	else:
		var b: float = A.dot(V)
		var c: float = V.length_squared() + A.dot(T) - s ** 2
		var d: float = 2 * V.dot(T)
		var e: float = T.length_squared()

		roots_t = solve_quartic_real(b / a, c / a, d / a, e / a)

	var possible_times: Array[float] = []
	for time in roots_t:
		if time > 0:
			possible_times.append(time)

	var result: Array[Dictionary]
	if possible_times.size() == 0:
		result.append({"Vector": T.normalized(), "Time": -1})

	else:
		possible_times.sort()
		for time in possible_times:
			var vector: Vector3 = (T / time + V + A * time / 2).normalized()
			result.append({"Vector": vector, "Time": time})

	return result


func solve_quadratic_real(a: float, b: float) -> Array[float]: # x^2 + a*x + b = 0
	# Solution using discriminant.

	var roots: Array[float] = []

	var D: float = a ** 2 - 4 * b
	if is_zero_approx(D):
		roots.append(-a / 2)

	elif D > 0:
		roots.append((-a + sqrt(D)) / 2)
		roots.append((-a - sqrt(D)) / 2)

	return roots


func solve_cubic_real(a: float, b: float, c: float) -> Array[float]: # x^3 + a*x^2 + b*x + c = 0
	# Solution using Vieta's trigonometric formula.
	# https://ru.wikipedia.org/w/index.php?title=%D0%A2%D1%80%D0%B8%D0%B3%D0%BE%D0%BD%D0%BE%D0%BC%D0%B5%D1%82%D1%80%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%B0%D1%8F_%D1%84%D0%BE%D1%80%D0%BC%D1%83%D0%BB%D0%B0_%D0%92%D0%B8%D0%B5%D1%82%D0%B0&oldid=130306948

	var roots: Array[float] = []

	var a_div_3: float = a / 3

	var Q: float = a_div_3 ** 2 - b / 3
	var R: float = a_div_3 ** 3 - a_div_3 * b / 2 + c / 2
	var S: float = Q ** 3 - R ** 2

	if is_zero_approx(S):
		if R == 0:
			roots.append(- a_div_3)
		else:
			var cbrt_R: float = R ** (1.0 / 3)
			roots.append(-2 * cbrt_R - a_div_3)
			roots.append(cbrt_R - a_div_3)

	elif S > 0:
		var f: float = acos(R / sqrt(Q ** 3)) / 3
		var neg_Q_mul_2:float = -2 * sqrt(Q)
		var TAU_div_3: float = TAU / 3

		roots.append(neg_Q_mul_2 * cos(f) - a_div_3)
		roots.append(neg_Q_mul_2 * cos(f + TAU_div_3) - a_div_3)
		roots.append(neg_Q_mul_2 * cos(f - TAU_div_3) - a_div_3)

	else:
		if is_zero_approx(Q):
			roots.append(-1 * ((c - a_div_3 ** 3) ** (1.0 / 3) + a_div_3))

		elif Q > 0:
			var f: float = acosh(absf(R) / sqrt(Q ** 3)) / 3
			roots.append(-2 * signf(R) * sqrt(Q) * cosh(f) - a_div_3)

		else:
			var f: float = asinh(absf(R) / sqrt(absf(Q ** 3))) / 3
			roots.append(-2 * signf(R) * sqrt(absf(Q)) * sinh(f) - a_div_3)

	return roots


func solve_quartic_real(a: float, b: float, c: float, d: float) -> Array[float]: # x^4 + a*x^3 + b*x^2 + c*x + d = 0
	# Using Ferrari's solution
	# https://en.wikipedia.org/wiki/Quartic_equation#Ferrari's_solution
	# u^4 + p*u^2 + q*u + r = 0

	var roots: Array[float] = []

	var p: float = -3 * (a ** 2) / 8 + b
	var q: float = (a ** 3) / 8 - a * b / 2 + c
	var r: float = -3 * (a ** 4) / 256 + b * (a ** 2) / 16 - a * c / 4 + d

	if is_zero_approx(q):
		var roots_pow_2: Array[float] = solve_quadratic_real(p, r)
		for root_pow_2 in roots_pow_2:
			if is_zero_approx(root_pow_2):
				roots.append(0)

			elif root_pow_2 > 0:
				roots.append(sqrt(root_pow_2))
				roots.append(-1 * sqrt(root_pow_2))

	else:
		var cubic_a: float = 5 * p / 2
		var cubic_b: float = 2 * (p ** 2) - r
		var cubic_c: float = (p ** 3) / 2 - p * r / 2 - (q ** 2) / 8

		var y: float = solve_cubic_real(cubic_a ,cubic_b, cubic_c)[0]
		var sqrt_p_add_2y: float = sqrt(p + 2 * y)

		roots.append_array(solve_quadratic_real(-sqrt_p_add_2y, p + y + (q / 2 / sqrt_p_add_2y)))
		roots.append_array(solve_quadratic_real(sqrt_p_add_2y, p + y - (q / 2 / sqrt_p_add_2y)))

		var neg_a_div_4: float = -a / 4
		for i in roots.size():
			roots[i] += neg_a_div_4

	return roots
