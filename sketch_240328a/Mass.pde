// Massクラスの定義
class Mass {
  PVector GRAVITY = new PVector(0, 0.1); // 重力加速度
  float E = 1;  // 反発係数
  
  int id;
  PVector pos;
  PVector speed;
  float radius;
  float m;
  PVector a;  // 加速度
  
  Mass(PVector pos, PVector speed, float radius, float m) {
    this.pos = pos;
    this.speed = speed;
    this.radius = radius;
    this.m = m;
    this.a = new PVector(0, 0);
  }
  
  void setPos(PVector pos) {
    this.pos = pos;
  }
  
  PVector getPos() {
    return this.pos;
  }

  PVector getSpeed() {
    return this.speed;
  }
  
  void initializeA(){
    // 加速度の初期化;
    this.a.set(0, 0);
  }
  
  void addforce(PVector force) {
    this.a.add(force.div(m));  // 加速度(ma = F)
  }
  
  // dt先の位置・速度を算出
  void update(float dt) {
    // 重力を与える
    this.addforce(GRAVITY);

    // 加速度を速度に変換
    this.speed.add(a.mult(dt));
    
    // 跳ね返りを与える
    if (pos.x > width - radius) {
      // 右端の場合
      PVector rebound_speed = new PVector(-abs(this.speed.x), this.speed.y).mult(E);
      this.speed.set(rebound_speed);
    } else if (pos.x < radius) {
      // 左端の場合
      PVector rebound_speed = new PVector(abs(this.speed.x), this.speed.y).mult(E);
      this.speed.set(rebound_speed);
    }
    if (pos.y > height - radius) {
      // 下端の場合
      PVector rebound_speed = new PVector(this.speed.x, -abs(this.speed.y)).mult(E); 
      this.speed.set(rebound_speed);
    } else if (pos.y < radius) {
      // 上端の場合
      PVector rebound_speed = new PVector(this.speed.x, abs(this.speed.y)).mult(E);
      this.speed.set(rebound_speed);
    }
    // 位置差分
    this.pos.add(PVector.mult(this.speed, dt));
  }
  
  void display() {
    fill(255);
    ellipse(pos.x, pos.y, radius * 2, radius * 2);
  }
}
