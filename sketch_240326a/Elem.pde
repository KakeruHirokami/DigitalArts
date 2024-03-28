// Elemクラスの定義
class Elem {
  int id;
  Mass massA;
  Mass massB;
  float len;
  float spring;
  boolean rubberFlag;
  
  Elem(Mass massA, Mass massB, float len, float spring, boolean rubberFlag) {
    this.massA = massA;
    this.massB = massB;
    this.len = len;
    this.spring = spring;
    this.rubberFlag = rubberFlag;  // ゴム（true）か，紐（false）か。ゴムの場合は伸びる力も計算する
  }
  
  // dt先の位置・速度を算出
  void update(float dt) {
    // 2点間の距離と角度を計算
    PVector posA = this.massA.getPos();
    PVector posB = this.massB.getPos();
    PVector subVector = PVector.sub(posB, posA);
    float dist = subVector.mag();
    PVector angle = subVector.normalize(); 
    // 張力を算出
    if(this.rubberFlag && (dist < this.len)) {
      // 伸びる力を与える
      float force = (this.len - dist) * this.spring;
      massA.addforce(PVector.mult(angle, force));
      massB.addforce(PVector.mult(angle, -force));
    } else if(dist > len) {
      // 縮む力を与える
      float force = (dist - this.len) * this.spring;
      massA.addforce(PVector.mult(angle, force));
      massB.addforce(PVector.mult(angle, -force));
    }
  }
  
  void display() {
    stroke(255);
    strokeWeight(2);
    line(massA.getPos().x, massA.getPos().y, massB.getPos().x, massB.getPos().y);
  }
}
