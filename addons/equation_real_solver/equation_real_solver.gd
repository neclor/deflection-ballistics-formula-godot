extends Node


func linear_solve_real(a: float, b: float) -> Array[float]: # a * x + b = 0
	if is_zero_approx(a): # Exception, because if a = 0 then this is not a equation. 
		return []

	var p: float = b / a
	return [-p] # Linear equation. # https://en.wikipedia.org/wiki/Linear_equation


func quadratic_solve_real(a: float, b: float, c: float) -> Array[float]: # a * x^2 + b * x + c = 0
	if is_zero_approx(a): # Exception, because if a = 0 then this is not a quadratic equation.
		return linear_solve_real(b, c)

	var real_roots: Array[float] = []

	var p: float = b / a
	var q: float = c / a
	var D: float = p * p - 4 * q # Solution using discriminant. # https://en.wikipedia.org/wiki/Quadratic_equation

	if is_zero_approx(D):
		real_roots.append(-p / 2)

	elif D > 0:
		var sqrt_D: float = sqrt(D)
		real_roots.append((sqrt_D - p) / 2)
		real_roots.append((-sqrt_D - p) / 2)

	real_roots.sort()
	return real_roots


func cubic_solve_real(a: float, b: float, c: float, d: float) -> Array[float]: # a * x^3 + b * x^2 + c * x + d = 0
	if is_zero_approx(a): # Exception, because if a = 0 then this is not a cubic equation.
		return quadratic_solve_real(b, c, d)

	var real_roots: Array[float] = []

	var p: float = b / a # Solution using Vieta's trigonometric formula. 
	var q: float = c / a # https://en.wikipedia.org/wiki/Cubic_equation
	var r: float = d / a # https://ru.wikipedia.org/wiki/%D0%A2%D1%80%D0%B8%D0%B3%D0%BE%D0%BD%D0%BE%D0%BC%D0%B5%D1%82%D1%80%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%B0%D1%8F_%D1%84%D0%BE%D1%80%D0%BC%D1%83%D0%BB%D0%B0_%D0%92%D0%B8%D0%B5%D1%82%D0%B0

	var p_div_3: float = p / 3

	var Q: float = p * p / 9 - q / 3
	var R: float = p ** 3 / 27 + (3 * r - p * q) / 6

	var k: float
	if absf(Q) > 100000:
		k = Q / 100000
	elif absf(Q) < 0.00001:
		k = Q / 0.00001
	else:
		k = 1

	var Q_pow_3_div_k_pow_3: float = (Q / k) ** 3
	var R_pow_2_div_k_pow_3: float = (R / k) ** 2 / k
	var S_div_k_pow_3: float = Q_pow_3_div_k_pow_3 - R_pow_2_div_k_pow_3
	var S: float = S_div_k_pow_3 * (k ** 3)

	if is_equal_approx(Q_pow_3_div_k_pow_3, R_pow_2_div_k_pow_3):
		if is_zero_approx(R):
			real_roots.append(-p_div_3)
		else:
			if Q < 0:
				var cbrt_R: float = R ** (1.0 / 3)
				real_roots.append(-2 * cbrt_R - p_div_3)
				real_roots.append(cbrt_R - p_div_3)
			else:
				var sign_r_mul_sqrt_Q: float = sign(R) * sqrt(Q)
				real_roots.append(-2 * sign_r_mul_sqrt_Q - p_div_3)
				real_roots.append(sign_r_mul_sqrt_Q - p_div_3)

	elif S > 0:
		var f: float = acos(R / sqrt(Q ** 3)) / 3
		var neg_2_mul_sqrt_Q: float = -2 * sqrt(Q)
		var TAU_div_3: float = TAU / 3

		real_roots.append(neg_2_mul_sqrt_Q * cos(f) - p_div_3)
		real_roots.append(neg_2_mul_sqrt_Q * cos(f + TAU_div_3) - p_div_3)
		real_roots.append(neg_2_mul_sqrt_Q * cos(f - TAU_div_3) - p_div_3)

	else:
		if is_zero_approx(Q):
			real_roots.append(-1 * ((c - p_div_3 ** 3) ** (1.0 / 3) + p_div_3))

		elif Q > 0:
			var f: float = acosh(absf(R) / sqrt(Q ** 3)) / 3
			real_roots.append(-2 * signf(R) * sqrt(Q) * cosh(f) - p_div_3)

		else:
			var f: float = asinh(absf(R) / sqrt(absf(Q ** 3))) / 3
			real_roots.append(-2 * signf(R) * sqrt(absf(Q)) * sinh(f) - p_div_3)

	real_roots.sort()
	return real_roots


func quartic_solve_real(a: float, b: float, c: float, d: float, e: float) -> Array[float]: # a * x^4 + b * x^3 + c * x^2 + d * x + e = 0
	if is_zero_approx(a): # Exception, because if a = 0 then this is not a quartic equation.
		return cubic_solve_real(b, c, d, e)

	var real_roots: Array[float] = []

	var a1: float = b / a
	var b1: float = c / a
	var c1: float = d / a
	var d1: float = e / a

	var a1_pow_2: float = a1 * a1

	var p: float = -3.0 / 8 * a1_pow_2 + b1 # Converting to a depressed quartic. x = u - b / (4 * a) => u^4 + p * u^2 + q * u + r = 0
	var q: float = a1 ** 3 / 8 - a1 * b1 / 2 + c1 # Using Ferrari's solution.
	var r: float = -3.0 / 256 * a1_pow_2 ** 2 + a1_pow_2 * b1 / 16 - a1 * c1 / 4 + d1 # https://en.wikipedia.org/wiki/Quartic_equation

	if is_zero_approx(q):
		for u_pow_2 in quadratic_solve_real(1, p, r):
			if is_zero_approx(u_pow_2):
				real_roots.append(0)

			elif u_pow_2 > 0:
				var u: float = sqrt(u_pow_2)
				real_roots.append(u)
				real_roots.append(-u)

	else:
		var cubic_b: float = 2.5 * p
		var cubic_c: float = 2 * (p ** 2) - r
		var cubic_d: float = (p ** 3 - p * r - (q / 2) ** 2) / 2

		var y: float = cubic_solve_real(1, cubic_b, cubic_c, cubic_d)[0]
		var sqrt_p_add_2y: float = sqrt(p + 2 * y)
		var p_add_y: float = p + y
		var q_div_2_mul_sqrt_p_add_2y: float = q / (2 * sqrt_p_add_2y)

		real_roots.append_array(quadratic_solve_real(1, -sqrt_p_add_2y, p_add_y + q_div_2_mul_sqrt_p_add_2y))
		var new_real_roots: Array[float] = quadratic_solve_real(1, sqrt_p_add_2y, p_add_y - q_div_2_mul_sqrt_p_add_2y)

		if real_roots.size() == 0:
			real_roots.append_array(new_real_roots)
		else:
			for new_real_root in new_real_roots:
				var has_root: bool = false
				for real_root in real_roots:
					if is_equal_approx(new_real_root, real_root):
						has_root = true
				if not has_root:
					real_roots.append(new_real_root)

	var x_sub_u: float = -a1 / 4 # x - u = - b / (4 * a)

	for i in real_roots.size():
		real_roots[i] += x_sub_u
	real_roots.sort()
	return real_roots
