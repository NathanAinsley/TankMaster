class Tank
{
  float tankx, tanky, tanka;
  float speed;
  float angle = 0;
  float targetAngle = 0;
  float easing = 0.2;
  PImage Body, Turret;


  Tank()
  {
    this.tankx=width/2;
    this.tanky=height*7/8;
    this.targetAngle=0;
    this.speed=1.7;
    Body = loadImage("TankBody.png");
    Turret = loadImage("TankTurret.png");

    this.tanka=-90;
  }

  void go()
  {
    renderTank();
    RenderTurret();
    simulateTank();
    simulateTurret();
    OutofBounds();
  }
  void simulateTank() {
    if (keyPressed && key == CODED) 
    {
      if (keyCode == LEFT) tanka-=2;
      if (keyCode == RIGHT) tanka+=2;

      if (keyCode == UP ) 
      {
        tankx += cos(radians(tanka))*speed;
        tanky += sin(radians(tanka))*speed;
      }


      if (keyCode == DOWN) 
      {
        tankx -= cos(radians(tanka));
        tanky -= sin(radians(tanka));
      }
    }
  }

  void renderTank() {
    pushMatrix();
    translate(tankx, tanky);
    rotate(radians(tanka+90));
    image(Body, -18, -22);
    popMatrix();
  }

  void simulateTurret()
  {
    // get the angle from the tank to the mouse position
    angle = atan2( mouseY - tanky, mouseX - tankx );
    // calculate the shortest rotation direction
    float dir = (angle - targetAngle) / TWO_PI;
    dir = dir - Math.round(dir); 
    dir = dir * TWO_PI;

    // ease rotation
    targetAngle += dir * easing;
  }
  
  void RenderTurret()
  {
    pushMatrix();
    translate(tankx, tanky);
    rotate( targetAngle);
    image(Turret, -9, -18);
    popMatrix();
  }
  void OutofBounds()
  {
    if (tankx >=600||tankx<=-100 || tanky >=1100 |tanky<=-100)
    {
      GameMode=GAMEOVER;
    }
  }
}
