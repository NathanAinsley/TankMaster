Tank tank1;

final int GAMEOVER = 0;
final int MENU = 1;
final int DDay = 2;
final int KURSK = 3;
final int RULES = 4;
int GameMode = MENU;

ArrayList<EBullet> bullets = new ArrayList<EBullet>();
ArrayList<Bullet> Bullets = new ArrayList<Bullet>();
ArrayList<Missile> missiles = new ArrayList<Missile>();
ArrayList<Enemy> EnemyTanks = new ArrayList<Enemy>();
ArrayList<Truck> EnemyTrucks = new ArrayList<Truck>();
int value = 0;
int savedTime;
int MsavedTime;
int UsersavedTime;
int SpawnsavedTime;
int MSpawnsavedTime;
int EnemyReloadTime = 3000;
int UserReloadTime = 5000;
int EnemyMissileCooldownTime = 7000;
int EnemyTankDefaultRespawnTime = 7000;
int EnemyTruckDefaultRespawnTime =10000;
PImage beach, menu, gameover, kursk, explosion;
color EnemyTank = color(255, 0, 0);
color EnemyTurret = color(199, 24, 24);
color Rock = color(185, 122, 87);
color UserTank = color(63, 81, 181);
color UserTurret = color(33, 150, 243);  
color TankTrap = color(127, 127, 127);
color TankShell = color(1, 1, 1);
color EnemyTracer = color(255, 1, 0);
color FriendlyTracer = color(1, 255, 0);
color MissileTracer = color(255, 255, 0);
color KurskRiver = color(153, 217, 234);
int Reload = 0;
int MissileInBarage =0;
int Damage = 0;
int ShellDamage=0;
int MissileDamage=40;
int RemainingHP = 150;
int TimesHit = 0;
int TanksKilled = 0;




void setup() {
  frameRate(60);
  size(500, 1000);
  tank1 = new Tank();
  savedTime = millis();
  menu = loadImage("MainMenu.png");
  beach = loadImage("Beach.png");
  gameover = loadImage("GameOverMenu.png");
  kursk = loadImage("Kursk.png");
  explosion = loadImage("Explosion.png");
}
void DeathTest()
{
  if (RemainingHP<=0)
  {
    GameMode=GAMEOVER;
  }
}
void reset()
{
  tank1.tankx=width/2;
  tank1.tanky=height*7/8;
  RemainingHP=150;
  Damage=0;
  bullets = new ArrayList<EBullet>();
  Bullets = new ArrayList<Bullet>();
  missiles = new ArrayList<Missile>();
  EnemyTanks = new ArrayList<Enemy>();
  EnemyTrucks = new ArrayList<Truck>();
  TanksKilled = 0;
}

void draw() {

  switch (GameMode) {
  case GAMEOVER:

    background(gameover);
    fill(0);
    text(" Well-done brother, you fought valiantly.\n However, your tank has been destroyed and you are now dead. \n Although you did manage to take " + round(TanksKilled/2) + " or so tanks with you to the tank shed in the sky\n however we can not confirm this due to our Reconnaissance planes being shot down. \n If you want another chance to impress the führer press [ENTER] to return to the menu.", 0, height/2 );
    if (keyCode == 10)
    {
      GameMode = MENU;
    }
    break;
  case RULES:

    background(menu);
    fill(0);
    text("Rules;\n\nSurvive as long as you can and kill as many tanks as possible,\n the longer you survive the faster they spawn.\n\nYou are equiped with the latest in german armour,\n Thick armour and AP shells which are able to penetrate multiple tanks\n\n Rocks will block all shells but can be driven over\n\n Enemy tanks will advance to the barbed wire and then stop, \nthey will do double damage once they reach the barbedwire. \n\n You can cross the barbed wire but be carefull you will take alot more\n damage due to the closer range from the enemy tanks\n\n Also do not wander from the battlefield otherwise off to the camp with you soldier\n\n Press [ENTER] to return to the menu", 0, 350);
    if (keyCode == 10)
    {
      GameMode = MENU;
    }
    break;

  case MENU:

    background(menu);
    fill(0);
    text("Welcome to Tank Commander! \n\n\nPress:\n1==DDay (Normal)\n2==Kursk (Hard)\n3==Rules", 10, (height/2)-200);
    if (keyCode == 49 || keyCode == 97)
    {
      reset();
      GameMode = DDay;
    }
    if (keyCode == 50 || keyCode == 98)
    {
      reset();
      GameMode = KURSK;
    }
    if (keyCode == 51 || keyCode == 99)
    {
      GameMode = RULES;
    }
    break;

  case DDay:


    background(beach);
    DeathTest();
    tank1.go(); 
    EnemyFire();
    hp();
    EnemySpawnTime();
    Reload();
    ShellDamage = 5;
    
    for (Bullet bullet : (ArrayList<Bullet>)Bullets.clone()) {

      if ( bullet.Hit() == false)
      {
        bullet.simulate();
        bullet.render();
      }
    }
    for (EBullet bullet : (ArrayList<EBullet>)bullets.clone()) {

      if ( bullet.Hit() == false)
      {
        bullet.simulate();
        bullet.render();
      }
      if (bullet.Hit() == true)
      {
        bullets.remove(bullet);
      }
    }
    for (Enemy tank : (ArrayList<Enemy>)EnemyTanks.clone())
    {
      if ( tank.TankPenerated() == false)
      {
        tank.renderEnemy();
      }
      if (tank.TankPenerated() == true)
      {
        EnemyTanks.remove(tank);
      }
    }
    break;


  case KURSK:
    background(kursk);
    DeathTest();
    tank1.go(); 
    EnemyFire();
    EnemyMissileBarage();
    hp();
    EnemySpawnTime();
    EnemyTruckSpawnTime();
    Reload();
    ShellDamage = 10;
    for (Bullet bullet : (ArrayList<Bullet>)Bullets.clone()) {

      if ( bullet.Hit() == false)
      {
        bullet.simulate();
        bullet.render();
      }
    }
    for (EBullet bullet : (ArrayList<EBullet>)bullets.clone()) {

      if ( bullet.Hit() == false)
      {
        bullet.simulate();
        bullet.render();
      }
      if (bullet.Hit() == true)
      {
        bullets.remove(bullet);
      }
    }
    for (Missile missile :(ArrayList<Missile>)missiles.clone())
    {
      if (missile.Hit() == false )
      {
        missile.simulate();
        missile.render();
      }
      if (missile.Hit() == true )
      {
        missiles.remove(missile);
      }
      
    }
    for (Enemy tank : (ArrayList<Enemy>)EnemyTanks.clone())
    {
      if ( tank.TankPenerated() == false)
      {
        tank.renderEnemy();
      }
      if (tank.TankPenerated() == true)
      {
        EnemyTanks.remove(tank);
      }
    }
    for (Truck truck : (ArrayList<Truck>)EnemyTrucks.clone())
    {
      if ( truck.TankPenerated() == false)
      {
        truck.renderEnemy();
      }
      if (truck.TankPenerated() == true)
      {
        EnemyTrucks.remove(truck);
      }
      
    }
    break;
  }
}


void hp()
{
  int TotalHP = 150;
  stroke(0);
  fill(255, 1, 0);
  rect(340, 10, TotalHP+2, 20);
  RemainingHP = TotalHP-Damage;
  fill(0, 255, 0);
  rect(341, 11, RemainingHP, 18);
  fill(0,0,0);
  text("Score: " +TanksKilled + "." , 340,50);
  
}

void Reload()
{
  int MaxReload = 300;

  stroke(0);
  fill(0);
  rect(10, 10, 102, 20);
  fill(255);
  text("RELOADING", 25, 25);
  if (Reload<MaxReload)
  {
    rect(11, 11, Reload/3, 18);
    Reload+=1;
  }
  if (Reload == 300)
  {
    rect(11, 11, Reload/3, 18);
    fill(0);
    text("Shell Loaded", 25, 25);
  }
}

void mouseClicked() {

  int passedTime = millis() - UsersavedTime;
  if (passedTime > UserReloadTime)
  {
    shoot();
    UsersavedTime = millis();
  }
}
void shoot() {    
  float x = tank1.tankx;
  float y = tank1.tanky;
  float dir = tank1.targetAngle;
  Reload=0;
  Bullets.add(new Bullet(x, y, dir));
}

void EnemyFire()
{


  int passedTime = millis() - savedTime;
  if (passedTime > EnemyReloadTime)
  {
    EnemyShoot();
    savedTime = millis();
  }
}
void EnemyShoot() {
  for (Enemy tank : EnemyTanks)
  {
    float x = tank.Enemyx;
    float y = tank.Enemyy;
    float dir = tank.targetAngle;
    bullets.add(new EBullet(x, y, dir));
  }
}
void EnemySpawnTime() {

  int passedTime = millis() - SpawnsavedTime;
  if (passedTime > EnemyTankDefaultRespawnTime)
  {
    SpawnsavedTime = millis();
    EnemyTanks.add(new Enemy());
    EnemyTankDefaultRespawnTime-=10;
  }
}
void EnemyTruckSpawnTime() {

  int passedTime = millis() - MSpawnsavedTime;
  if (passedTime > EnemyTruckDefaultRespawnTime)
  {
    MSpawnsavedTime = millis();
    EnemyTrucks.add(new Truck());
    EnemyTruckDefaultRespawnTime-=5;
  }
}
void EnemyMissileBarage()
{
  int passedTime = millis() - MsavedTime;
  if (passedTime > EnemyMissileCooldownTime)
  {

    EnemyShootMissile();

    MsavedTime = millis();
  }
}

void EnemyShootMissile() {

  for (Truck truck : EnemyTrucks)
  {

    float x = truck.Enemyx;
    float y = truck.Enemyy;
    float dir = truck.targetAngle;
    for (int i = 0; i<11; i++)
    {
      missiles.add(new Missile(x, y, dir));
    }
    MissileInBarage = 0;
  }
}
