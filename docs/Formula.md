# Formula
**Vp = Pt / t + Vt - A * t / 2**  
**Pt** - Vector to realtive target position  
**Vt** - Target velocity vector  
**Vp** - Projectile veloctity vector (desired value)  
**A = Ap - At** - Relative acceleration vector  
**t** - Time to hit and is equal to the positive root of:  
**(A<sup>2</sup> / 4) * t<sup>4</sup> + (-A * Vt) * t<sup>3</sup> + (V<sup>2</sup> - A * Pt - v<sup>2</sup>) * t<sup>2</sup> + (2 * Vt * Pt) * t + Pt<sup>2</sup> = 0**  
**v = |Vp|** - Projectile velocity module

## Explanation
![Scheme](Scheme.png)

**t** - Time to hit  
**Pt** - Vector to realtive target position  
**Vt** - Target velocity vector  
**At** - Target acceleration vector  
**Vp** - Projectile veloctity vector (desired value)  
**Ap** - Projectile acceleration vector  
**v = |Vp|** - Projectile velocity module  
**A = Ap - At** - Relative acceleration vector

Definition of projectile vector:  
**Vp * t + Ap * t<sup>2</sup> / 2 = Pt + Vt * t + At * t<sup>2</sup> / 2**  
**Vp = Pt / t + Vt + At * t / 2 - Ap * t / 2**  
**Vp = Pt / t + Vt - (Ap - At) * t / 2**

**Vp = Pt / t + Vt - A * t / 2**

Finding time:  
**Vp<sup>2</sup> - v<sup>2</sup> = 0**  
**(Pt / t + Vt - A * t / 2)<sup>2</sup> - v<sup>2</sup> = 0**  
**(A * t<sup>2</sup> / 2 - Vt * t - Pt)<sup>2</sup> - v<sup>2</sup> * t<sup>2</sup> = 0**  
**(A<sup>2</sup> / 4) * t<sup>4</sup> + (-A * Vt) * t<sup>3</sup> + (Vt<sup>2</sup> - A * Pt - v<sup>2</sup>) * t<sup>2</sup> + (2 * Vt * Pt) * t + Ptv<sup>2</sup> = 0**
