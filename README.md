# Shot prediction demo godot
Implementation of bullet hit prediction formulas for a moving target considering accelerations. \
And also Implementation of a function to solve the quartic equation.

## Formula
**Vb = T / t + V + A * t / 2** *where:* \
**Vb** *- the desired bullet motion vector* \
**T** *- vector to target* \
**V** *- target motion vector \
**A** *- is the difference between the acceleration vectors of the bullet and the target* \
**t*** - is the minimum positive root of this equation:* **(A * A) / 4 * t<sup>4</sup> + (A * V) * t<sup>3</sup> + (V * V + A * T - s<sup>2</sup>) * t<sup>2</sup> + 2 * (V * T) * t + T*T = 0** *where:* \
**s** *- is the speed of the bullet*

## Proof formula
![Scheme](docs/Scheme.png)
# Given:
**T** *- vector to target* \
**V** *- target motion vector* \
**At** *- target acceleration vector* \
**Ab** *- bullet acceleration vector* \
**s** *- bullet speed*\
**s = |Vb|**\
**A = At - Ab**

**Vb** *- the desired bullet motion vector*

# Solution:
**Vb * t + Ab * t<sup>2</sup> / 2 = T + V * t + At * t<sup>2</sup> / 2** \
**(Vb + Ab * t/2) * t = T + (V + At * t/2) * t** \
**Vb = T / t + V + (At - Ab) * t / 2**

**Vb = T / t + V + A * t/2** \
**Vb * t = A * t<sup>2</sup> / 2 + V * t + T**

**{ Vb.x * t = A.x * t<sup>2</sup> / 2 + V.x * t + T.x** \
**{ Vb.y * t = A.y * t<sup>2</sup> / 2 + V.y * t + T.y** \
**{ Vb.z * t = A.z * t<sup>2</sup> / 2 + V.z * t + T.z**


**|Vb|<sup>2</sup> = s<sup>2</sup>** \
**|Vb|<sup>2</sup> - s<sup>2</sup> = 0** \
**Vb.x<sup>2</sup> + Vb.y<sup>2</sup> + Vb.z<sup>2</sup> - s<sup>2</sup> = 0**

**{ (Vb.x * t)<sup>2</sup> + (Vb.y * t)<sup>2</sup> + (Vb.z * t)<sup>2</sup> - s<sup>2</sup> * t<sup>2</sup> = 0**
***
**(A.x / 2 * t<sup>2</sup> + V.x * t + T.x)<sup>2</sup> + (A.y / 2 * t<sup>2</sup> + V.y * t + T.y)<sup>2</sup> + (A.z / 2 * t<sup>2</sup> + V.z * t + T.z)<sup>2</sup> - s<sup>2</sup> * t<sup>2</sup> = 0**

*( (A.x / 2 * t<sup>2</sup> + V.x * t + T.x)<sup>2</sup> = A.x<sup>2</sup> / 4 * t<sup>4</sup> + V.x<sup>2</sup> * t<sup>2</sup> + T.x<sup>2</sup> + A.x * V.x * t<sup>3</sup> + 2 * V.x * T.x * t + A.x * T.x * t<sup>2</sup> )* \
*( = A.x<sup>2</sup> / 4 * t<sup>4</sup> + A.x * V.x * t<sup>3</sup> + (V.x<sup>2</sup> + A.x * T.x) * t<sup>2</sup> + 2 * V.x * T.x * t + T.x<sup>2</sup> )*

**A.x<sup>2</sup> / 4 * t<sup>4</sup> + A.x * V.x * t<sup>3</sup> + (V.x<sup>2</sup> + A.x * T.x) * t<sup>2</sup> + 2 * V.x * T.x * t + T.x<sup>2</sup>  +  A.y<sup>2</sup> / 4 * t<sup>4</sup> + A.y * V.y * t<sup>3</sup> + (V.y<sup>2</sup> + A.y * T.y) * t<sup>2</sup> + 2 * V.y * T.y * t + T.y<sup>2</sup>  +  A.z<sup>2</sup>2 / 4 * t<sup>4</sup> + A.z * V.z * t<sup>3</sup> + (V.z<sup>2</sup> + A.z * T.z) * t<sup>2</sup> + 2 * V.z * T.z * t + T.z<sup>2</sup>  -  s<sup>2</sup> * t<sup>2</sup> = 0** \
**(A.x<sup>2</sup> + A.y<sup>2</sup> + A.z<sup>2</sup>) / 4 * t<sup>4</sup> + (A.x * V.x + A.y * V.y + A.z * V.z) * t<sup>3</sup> + (V.x<sup>2</sup> + V.y<sup>2</sup> + V.z<sup>2</sup> + A.x * T.x + A.y * T.y + A.z * T.z - s<sup>2</sup>) * t<sup>2</sup> + 2 * (V.x * T.x + V.y * T.y+V.z * T.z) * t + (T.x<sup>2</sup> + T.y<sup>2</sup> + T.z<sup>2</sup>) = 0**
 
**(A * A) / 4 * t<sup>4</sup> + (A * V) * t<sup>3</sup> + (V * V + A * T - s<sup>2</sup>) * t<sup>2</sup> + 2 * (V * T) * t + T*T = 0**
