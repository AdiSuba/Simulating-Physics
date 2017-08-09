class CollisionSystem {
  ArrayList<Mover> movers;
  PVector force;
  float Cd = 0;
  
  CollisionSystem() {
    movers = new ArrayList();
    force = new PVector(0, 0);
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
         
         float overlapp = mi.getRadius() + mj.getRadius() - x12.mag();
         mi.pos = mi.pos.add(x12.normalize().mult(overlapp/2));
         mj.pos = mj.pos.add(x21.normalize().mult(overlapp/2));
                  
         mi.angVel = mi.calcAngVel(x12.normalize().mult(mi.getRadius()));
         mj.angVel = mj.calcAngVel(x21.normalize().mult(mi.getRadius()));
         mi.vel.sub(x12.mult((2*m2/(m1 + m2))*(v12.dot(x12)/x12.magSq())));
         mj.vel.sub(x21.mult((2*m1/(m1 + m2))*(v21.dot(x21)/x21.magSq())));
       }
      }
    }
  }
  
  void applyDrag(float Cd) {
    //Cd = 1 / 2 * coefficient of drag * fluid density * frontal area
    this.Cd = Cd;
  }
  
  void applyForce(PVector f) {
    force.add(f);
  }
  
  void update() {
    applyCollisions();
    //for(Mover m : movers) {
    //  m.applyForce(force);
    //  m.edges();
    //  m.update();
    //}
    for(int i = 0; i < movers.size(); i++) {
      Mover mi = movers.get(i);
      for(int j = 0; j < movers.size(); j++) {
        Mover mj = movers.get(j);
        if (i != j) {
          PVector gravity = mj.attract(mi);
          mi.applyForce(gravity);
        }
      }
      //println(mi.pos.x);
      //println(mi.pos.y);
      mi.update();
    }
    force.mult(0);
  }
  
  void display() {
    for(Mover m : movers) {
      m.display();
    }
  }
}