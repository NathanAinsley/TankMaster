class Enemy
{
  int Enemyx;
  int ShellDamage=5;
  int Enemyy = -50;
  float speed = 1;
  float angle = 0;
  float targetAngle = 0;
  float easing = 0.1;
  int Startingx;
  int Startingy;
  int StoppingY = 700;
  PImage Body, Turret;

  Enemy()
  {
    this.Enemyx = (int)random(50.0, 450.0);

    this.Startingx = Enemyx;
    this.Startingy = Enemyy;
    Body = loadImage("EnemyTankBody.png");
    Turret = loadImage("EnemyTankTurret.png");
  }

  void renderEnemy()
  {
    renderEnemyBody();
    RenderEnemyTurret();
    simulateTurret();
    moveEnemy();
  }

  void moveEnemy()
  {
    if (TankTrapHit() == false)
    {
      if (Enemyy <= StoppingY )
      {
        Enemyy += speed;
      }
      else 
      {
        ShellDamage = ShellDamage *2;
      }
    }
  }



  void renderEnemyBody() {

    //stroke(150);
    //fill(255,0,0);
    //rect(Enemyx-10,Enemyy-25,20,50);
    image(Body, Enemyx-18, Enemyy-25);
  }

  void RenderEnemyTurret()
  {

    pushMatrix();
    translate(Enemyx, Enemyy);
    rotate( targetAngle );
    image(Turret, -7, -20);
    popMatrix();
  }

  void simulateTurret()
  {
    float tankx=tank1.tankx;
    float tanky=tank1.tanky;
    // get the angle from the tank to the mouse position
    angle = atan2( tanky - Enemyy, tankx - Enemyx );
    // calculate the shortest rotation direction
    float dir = (angle - targetAngle) / TWO_PI;
    dir = dir - Math.round(dir); 
    dir = dir * TWO_PI;

    // ease rotation
    targetAngle += dir * easing;
  }

  boolean TankTrapHit()
  {
    for (int i =-18; i<=18; i++)
    {
      color pixel = get(Enemyx+i, Enemyy+30);

      if (pixel == EnemyTank || pixel == TankTrap || pixel == KurskRiver || pixel == UserTank ||  pixel == UserTurret)
      {
        
        return true;
      }
    }
    return false;
  }
  
  boolean TankPenerated()
  {
    //
    //Hit Detection for Bottom of Enemy Tank
    //
    for (int i =-18; i<=18; i++)
    {
      color pixel = get(Enemyx+i, Enemyy+30);
      if (pixel == TankShell||pixel ==FriendlyTracer)
      {
        image(explosion,Enemyx-18,Enemyy-25);
        TanksKilled+=1;
        return true;
      }
    }
    //
    // hit Detection for Top of Enemy Tank
    //
    for (int i =-18; i<=18; i++)
    {
      color pixel = get(Enemyx+i, Enemyy-30);

      if (pixel == TankShell||pixel ==FriendlyTracer)
      {
        image(explosion,Enemyx-18,Enemyy-25);
        TanksKilled+=1;
        return true;
      }
    }
    //
    //Hit Detection for Left side of Enemy Tank
    //
    for (int i =-25; i<=25; i++)
    {
      color pixel = get(Enemyx-27, Enemyy+i);

      if (pixel == TankShell||pixel ==FriendlyTracer)
      {
        image(explosion,Enemyx-18,Enemyy-25);
        TanksKilled+=1;
        return true;
      }
    }
     //
    //Hit Detection for Right side of Enemy Tank
    //
    for (int i =-25; i<=25; i++)
    {
      color pixel = get(Enemyx+27, Enemyy+i);

      if (pixel == TankShell||pixel ==FriendlyTracer)
      {
        image(explosion,Enemyx-18,Enemyy-25);
        TanksKilled+=1;
        return true;
      }
    }
    return false;
  }
  
  
}
