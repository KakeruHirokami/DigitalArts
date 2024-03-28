// 三角形のnet作成
Net createTriangleNet(float size, PVector netPos, PVector netSpd, float radius, float m) {
  // ボールの位置と速度の設定
  ArrayList<PVector> posList = new ArrayList<PVector>();
  posList.add(netPos.copy());
  posList.add(PVector.add(netPos, new PVector(-size/2, (size/2)*(sqrt(3)/2))));
  posList.add(PVector.add(netPos, new PVector(size/2, (size/2)*(sqrt(3)/2))));
  ArrayList<PVector> spdList = new ArrayList<PVector>();
  spdList.add(netSpd.copy());
  spdList.add(PVector.add(netSpd, new PVector(0, 10)));
  spdList.add(netSpd.copy());
  // Mass作成
  ArrayList<Mass> massList = new ArrayList<Mass>();
  for(int i=0; i<spdList.size(); i++) {
    Mass mass = new Mass(posList.get(i), spdList.get(i), radius, m);
    massList.add(mass);
  }
  // Elem作成
  ArrayList<Elem> elemList = new ArrayList<Elem>();
  Elem elem0 = new Elem(massList.get(0), massList.get(1), size, 0.1, false);
  Elem elem1 = new Elem(massList.get(1), massList.get(2), size, 0.1, false);
  Elem elem2 = new Elem(massList.get(2), massList.get(0), size, 0.1, false);
  elemList.add(elem0);
  elemList.add(elem1);
  elemList.add(elem2);
  Net net = new Net(massList, elemList);
  return net;
}

// ボールオブジェクトの作成
ArrayList<Net> netList = new ArrayList<Net>();
void setup() {
  frameRate(FRAMERATE);
  size(360, 640);
  // ボールの初期設定（位置と速度）
  float radius = 1;
  float m = 1;
  float size = random(10, 40);
  ArrayList<Net> netList = new ArrayList<Net>();
  for(int i=0; i<10; i++) {
    PVector netPos = new PVector(width/2+random(-10, 10), random(0, 5));
    PVector netSpd = new PVector(random(-10, 10), random(0, 5));
    Net net = createTriangleNet(size, netPos, netSpd, radius, m);
    netList.add(net);
  } //<>//
}

void draw() {
  fill(0, 255);
  rect(0,0,width,height);

  if (frameCount % int(FRAMERATE/5) == 0) { //<>//
    float radius = 1;
    float m = 1;
    PVector netPos = new PVector(width/2+random(-10, 10), random(0, 5));
    PVector netSpd = new PVector(random(-10, 10), random(0, 5));
    float size = random(10, 40);
    Net net = createTriangleNet(size, netPos, netSpd, radius, m);
    netList.add(net);
  }
  
  for (int i=0; i<CALC_BY_FRAME; i++) {
    for(Net net : netList) {
      net.update(DT);
    }
  }
  for(Net net : netList) {
    net.display();
  }
  saveFrame("frames/####.tif");
  if (frameCount >= 900) { // 1800コマアニメーションした時
    exit();
  }
}
