
class EBullet{
float tankx,tanky,speed, targetAngle;
 
  EBullet(float x, float y , float dir) {
    this.tankx = x;
    this.tanky = y;
    speed = 3;
    this.targetAngle = dir;
  }
  
  void simulate()
  {
    tankx += cos(targetAngle) *speed;
    tanky += sin(targetAngle) *speed;
    
  }
 
  void render() {
    pushMatrix();
    translate(tankx, tanky);
    rotate( targetAngle );
    stroke(0,0,0);
    line( 0, 0, 5, 0 );    
    stroke(EnemyTracer);
    ellipse(0,0,5,1);
    popMatrix();
  }
  boolean Hit()
  {
    color pixel = get(round(tankx),round(tanky));
     
     if(pixel == UserTank ||  pixel == UserTurret)
     {
       if (tanky <= 600)
       {
         Damage += ShellDamage*2;
         return true;
       }
       else
       {
         Damage +=ShellDamage;
         return true;
       }
     }
     if(pixel == Rock)
     {
       return true;
     }
     return false;
  }
  
  
}
