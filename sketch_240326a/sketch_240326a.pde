// ボールオブジェクトの作成
ArrayList<ArrayList<Mass>> massListList = new ArrayList<ArrayList<Mass>>();
ArrayList<ArrayList<Elem>> elemListList = new ArrayList<ArrayList<Elem>>();
ArrayList<Net> netList = new ArrayList<Net>();
void setup() {
  frameRate(FRAMERATE);
  size(360, 640);
  // ボールの初期設定（位置と速度）
  ArrayList<PVector> netPosList = new ArrayList<PVector>();
  ArrayList<PVector> netSpdList = new ArrayList<PVector>();
  netPosList.add(new PVector(width/2, 0));
  netSpdList.add(new PVector(3, 0));
  ArrayList<ArrayList<PVector>> posListList = new ArrayList<ArrayList<PVector>>();
  for(PVector netPos : netPosList) {
    ArrayList<PVector> posList = new ArrayList<PVector>();
    posList.add(netPos.copy());
    posList.add(PVector.add(netPos, new PVector(-50, 50*(sqrt(3)/2))));
    posList.add(PVector.add(netPos, new PVector(50, 50*(sqrt(3)/2))));
    posListList.add(posList);
  }
  ArrayList<ArrayList<PVector>> spdListList = new ArrayList<ArrayList<PVector>>();
  for(PVector netSpd : netSpdList) {
    ArrayList<PVector> spdList = new ArrayList<PVector>();
    spdList.add(netSpd.copy());
    spdList.add(PVector.add(netSpd, new PVector(0, 10)));
    spdList.add(netSpd.copy());
    spdListList.add(spdList);
  }
  float radius = 3;
  float m = 1;
  
  // Mass作成
  for(int i=0; i<netPosList.size(); i++) {
    ArrayList<Mass> massList = new ArrayList<Mass>();
    for(int j=0; j<spdListList.get(i).size(); j++) {
      Mass mass = new Mass(posListList.get(i).get(j), spdListList.get(i).get(j), radius, m);
      massList.add(mass); //<>//
    }
    massListList.add(massList);
  }
  
  // Elem作成
  for(ArrayList<Mass> massList : massListList) {
    ArrayList<Elem> elemList = new ArrayList<Elem>();
    Elem elem0 = new Elem(massList.get(0), massList.get(1), 100, 0.1, false);
    Elem elem1 = new Elem(massList.get(1), massList.get(2), 100, 0.1, false);
    Elem elem2 = new Elem(massList.get(2), massList.get(0), 100, 0.1, false);
    elemList.add(elem0);
    elemList.add(elem1);
    elemList.add(elem2);
    elemListList.add(elemList);
  }
  
  // Net作成
  for(int i=0; i<netPosList.size(); i++) {
    netList.add(new Net(massListList.get(i), elemListList.get(i)));
  }
}

void draw() {
  fill(0, 255);
  rect(0,0,width,height);
  for (int i=0; i<CALC_BY_FRAME; i++) {
    // 加速度の初期化
    for(ArrayList<Mass> massList : massListList) {
      massList.get(0).setA(new PVector(0, 0));
      massList.get(1).setA(new PVector(0, 0));
      massList.get(2).setA(new PVector(0, 0));
    }
    for(Net net : netList) {
      net.update(DT);
    }
  }
  for(Net net : netList) {
    net.display();
  }
  //mass0.setPos(new PVector(width/2 + 50, height/2 + 30));
}
