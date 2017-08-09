class Rectangle extends Body {
  float w;
  float h;
  
  Rectangle(){
    super();
    w = 80;
    h = 40;
  }
  
  Rectangle(PVector pos) {
    super(pos);
    w = 80;
    h = 40;
  }
  
  Rectangle(PVector pos, PVector vel) {
    super(pos, vel);
    w = 80;
    h = 40;
  }
  
  Rectangle(PVector pos, PVector vel, float mass) {
    super(pos, vel, mass);
    w = 80;
    h = 40;
  }
  
  float getVolume() {
    return w * h * h;
  }
  
  boolean checkCollision(Body b) {
    return false;
  }
  
  float getDistanceToShapeEdge() {
    return 1;
  }
  
  float calcAngVel(PVector r) {
    return (r.cross(vel.copy().mult(dt)).z) / r.magSq();
  }
  
  boolean checkCollisionEdgeX() {
    PVector d = getDistanceEdge();
    if(d.x < abs(vel.x)) return true;
    return false;
  }
  
  boolean checkCollisionEdgeY() { 
    PVector d = getDistanceEdge();
    if(d.y < abs(vel.y)) return true;
    return false;
  }
  
  PVector getDistanceEdge() {
    PVector distance = new PVector(-w, -h);
    if(vel.x > 0) {
      distance.x += width - pos.x;
    }
    else distance.x += pos.x;
    if(vel.y > 0) {
      distance.y += height - pos.y;
    }
    else distance.y += pos.y;
    return distance;
  }
  
  void edges() {
    PVector d = getDistanceEdge();
    if(checkCollisionEdgeX()) {
      vel.x = -vel.x;
      pos.x += d.x;
    }
    if(checkCollisionEdgeY()) {
      vel.y = -vel.y;
      pos.y += d.y;
    }
  }
  
  void display() {
    float gray = map(density, 0, 10, 155 , 0);
    fill(gray);
    stroke(2);
    pushMatrix();
    rotate(-ang);
    translate(pos.x, pos.y);
    rect(0, 0, w, h);
    popMatrix();
  }
}