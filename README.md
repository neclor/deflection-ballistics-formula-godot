# Deflection (ballistics) Formula
Function on GDScript for calculating the vector of an “intercepting” shot, considering “external” accelerations.

## Using
Function take bullet speed, target position, target velocity and optional(target_acceleration, bullet_acceleration), and returns an vector of length bullet speed.
If a hit is not possible, the function will return a zero vector.

### Warning 
Also used an [addon for solving equations](https://godotengine.org/asset-library/asset/2998).

### Functions in current version
```gdscript
vector2(bullet_speed: float, target_position: Vector2, target_velocity: Vector2, target_acceleration: Vector2 = Vector2.ZERO, bullet_acceleration: Vector2 = Vector2.ZERO) -> Vector2
vector3(bullet_speed: float, target_position: Vector3, target_velocity: Vector3, target_acceleration: Vector3 = Vector3.ZERO, bullet_acceleration: Vector3 = Vector3.ZERO) -> Vector3
```

## Formula
*If* **Vb** *is the desired deflection shot vector, then*\
**Vb = T / t + V + A * t / 2** *where:*\
**t** *is the positive root of this equation:*\
**(A * A) / 4 * t<sup>4</sup> + (A * V) * t<sup>3</sup> + (V * V + A * T - s<sup>2</sup>) * t<sup>2</sup> + 2 * (V * T) * t + T*T = 0**\
*and*\
**s** *- speed of the bullet*\
**T** *- vector to target (target position)*\
**V** *- target motion vector*\
**A** *- is the difference between the acceleration vector of the target and the bullet (At - Ab)*

## Solution
![Scheme](docs/Scheme.png)
***
**Vb** *- desired deflection shot vector*

**s = |Vb|** *- bullet speed*\
**T** *- vector to target (target position)*\
**V** *- target motion vector*\
**At** *- target acceleration vector*\
**Ab** *- bullet acceleration vector*\
**A = At - Ab** *- difference between the acceleration vector of the target and the bullet*
***
**|Vb|<sup>2</sup> = s<sup>2</sup>**\
**Vb.x<sup>2</sup> + Vb.y<sup>2</sup> + Vb.z<sup>2</sup> - s<sup>2</sup> = 0**

**(Vb.x * t)<sup>2</sup> + (Vb.y * t)<sup>2</sup> + (Vb.z * t)<sup>2</sup> - s<sup>2</sup> * t<sup>2</sup> = 0**


**Vb * t + Ab * t<sup>2</sup> / 2 = T + V * t + At * t<sup>2</sup> / 2**\
**Vb = T / t + V + (At - Ab) * t / 2**\
**Vb = T / t + V + A * t/2**\
**Vb * t = A * t<sup>2</sup> / 2 + V * t + T**

**Vb.x * t = A.x * t<sup>2</sup> / 2 + V.x * t + T.x**\
**Vb.y * t = A.y * t<sup>2</sup> / 2 + V.y * t + T.y**\
**Vb.z * t = A.z * t<sup>2</sup> / 2 + V.z * t + T.z**
***
**(A.x / 2 * t<sup>2</sup> + V.x * t + T.x)<sup>2</sup> + (A.y / 2 * t<sup>2</sup> + V.y * t + T.y)<sup>2</sup> + (A.z / 2 * t<sup>2</sup> + V.z * t + T.z)<sup>2</sup> - s<sup>2</sup> * t<sup>2</sup> = 0**

 *(A.x / 2 * t<sup>2</sup> + V.x * t + T.x)<sup>2</sup> = A.x<sup>2</sup> / 4 * t<sup>4</sup> + V.x<sup>2</sup> * t<sup>2</sup> + T.x<sup>2</sup> + A.x * V.x * t<sup>3</sup> + 2 * V.x * T.x * t + A.x * T.x * t<sup>2</sup>*
 *= A.x<sup>2</sup> / 4 * t<sup>4</sup> + A.x * V.x * t<sup>3</sup> + (V.x<sup>2</sup> + A.x * T.x) * t<sup>2</sup> + 2 * V.x * T.x * t + T.x<sup>2</sup>*

**A.x<sup>2</sup> / 4 * t<sup>4</sup> + A.x * V.x * t<sup>3</sup> + (V.x<sup>2</sup> + A.x * T.x) * t<sup>2</sup> + 2 * V.x * T.x * t + T.x<sup>2</sup>  +  A.y<sup>2</sup> / 4 * t<sup>4</sup> + A.y * V.y * t<sup>3</sup> + (V.y<sup>2</sup> + A.y * T.y) * t<sup>2</sup> + 2 * V.y * T.y * t + T.y<sup>2</sup>  +  A.z<sup>2</sup>2 / 4 * t<sup>4</sup> + A.z * V.z * t<sup>3</sup> + (V.z<sup>2</sup> + A.z * T.z) * t<sup>2</sup> + 2 * V.z * T.z * t + T.z<sup>2</sup>  -  s<sup>2</sup> * t<sup>2</sup> = 0**

**(A.x<sup>2</sup> + A.y<sup>2</sup> + A.z<sup>2</sup>) / 4 * t<sup>4</sup> + (A.x * V.x + A.y * V.y + A.z * V.z) * t<sup>3</sup> + (V.x<sup>2</sup> + V.y<sup>2</sup> + V.z<sup>2</sup> + A.x * T.x + A.y * T.y + A.z * T.z - s<sup>2</sup>) * t<sup>2</sup> + 2 * (V.x * T.x + V.y * T.y+V.z * T.z) * t + (T.x<sup>2</sup> + T.y<sup>2</sup> + T.z<sup>2</sup>) = 0**
 
**(A * A) / 4 * t<sup>4</sup> + (A * V) * t<sup>3</sup> + (V * V + A * T - s<sup>2</sup>) * t<sup>2</sup> + 2 * (V * T) * t + T*T = 0**
