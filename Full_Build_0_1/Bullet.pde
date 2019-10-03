
class Bullet{
float tankx,tanky,speed, targetAngle;
 
  Bullet(float x, float y , float dir) {
    this.tankx = x;
    this.tanky = y;
    speed = 2;
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
    stroke(TankShell);
    line( 0, 0, 5, 0 );    
    stroke(FriendlyTracer);
    ellipse(0,0,5,1);
    popMatrix();
  }
  boolean Hit()
  {
    color pixel = get(round(tankx),round(tanky));
     
     if(pixel == EnemyTank || pixel == EnemyTurret)
     {
       return true;
     }
     if(pixel == Rock)
     {
       return true;
     }
     return false;
  }
  
  
}
