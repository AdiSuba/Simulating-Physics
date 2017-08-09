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
         PVector v1 = mi.vel.copy();
         PVector v2 = mj.vel.copy();
         PVector x1 = mi.pos.copy();
         PVector x2 = mj.pos.copy();
         PVector x12 = x1.copy().sub(x2);
         PVector v12 = v1.copy().sub(v2);
         PVector x21 = x2.copy().sub(x1);
         PVector v21 = v2.copy().sub(v1);
         float m1 = mi.mass, m2 = mj.mass;
         mi.vel.sub(x12.mult((2*m2/(m1 + m2))*(v12.dot(x12)/x12.magSq())));
         mj.vel.sub(x21.mult((2*m1/(m1 + m2))*(v21.dot(x21)/x21.magSq())));
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