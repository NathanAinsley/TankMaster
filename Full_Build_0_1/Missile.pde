
class Missile{
  float Enemyx,Enemyy, speed,targetAngle;
 
  Missile(float x, float y , float dir) {
    this.Enemyx = x;
    this.Enemyy = y;
    this.speed = 3;
    this.targetAngle = dir;
  }
  
  void simulate()
  {
    Enemyx += cos(targetAngle) *speed;
    Enemyy += sin(targetAngle) *speed;
    speed+=0.3;
  }
 
  void render() {
    pushMatrix();
    translate(Enemyx, Enemyy);
    rotate( targetAngle );
    stroke(0,0,0);
    line( 0, 0, 5, 0 );
    stroke(MissileTracer);
    ellipse(0,0,5,1);
    popMatrix();
  }
  boolean Hit()
  {
    color pixel = get(round(Enemyx),round(Enemyy));
     
     if(pixel == UserTank ||  pixel == UserTurret)
     {
       
       Damage += ShellDamage;
       return true;
       
     }
     if(pixel == Rock)
     {
       return true;
     }
     return false;
  }
  
  
}
