// Netクラスの定義
class Net {
  ArrayList<Mass> massList;
  ArrayList<Elem> elemList;
  
  Net(ArrayList<Mass> massList, ArrayList<Elem> elemList) {
    this.massList = massList;
    this.elemList = elemList;
  }
  
  void update(float dt) {
    for(Elem elem : elemList) {
      elem.update(dt);
    }
    for(Mass mass : massList) {
      mass.update(dt);
    }
  }
  
  void display() {
    stroke(255);
    strokeWeight(3);
    for(Elem elem : elemList) {
      elem.display();
    }
    for(Mass mass : massList) {
      mass.display();
    }
  }
}
