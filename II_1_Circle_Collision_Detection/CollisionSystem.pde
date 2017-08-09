class CollisionSystem {
  ArrayList<Mover> movers;
  
  CollisionSystem() {
    movers = new ArrayList();
  }
  
  void addMover(Mover m) {
    movers.add(m);
  }
  
  void applyCollisions() {
    for(int i = 0; i < movers.size(); i++) {
      for(int j = i + 1; j < movers.size(); j++) {
        Mover mi = movers.get(i);
        Mover mj = movers.get(j);
       if(mi.checkCollision(mj)) {
         mi.vel.mult(-1); mj.vel.mult(-1);
       }
      }
    }
  }
  
  void update() {
    applyCollisions();
    for(Mover m : movers) {
      m.edges();
      m.update();
    }
  }
  
  void display() {
    for(Mover m : movers) {
      m.display();
    }
  }
}