class Circle extends Body {
  float radius;
  
  Circle(){
    super();
    radius = 15;
  }
  
  Circle(PVector pos) {
    super(pos);
    radius = 15;
  }
  
  Circle(PVector pos, PVector vel) {
    super(pos, vel);
    radius = random(10, 50);
  }
  
  Circle(PVector pos, PVector vel, float mass) {
    super(pos, vel, mass);
    radius = 15;
  }
  
  float getDistanceToShapeEdge() {
    return radius;
  }
  
  float getVolume() {
    return 4 / 3 * pow(radius, 3) * PI;
  }
  
  void applyDrag(float c) {
    PVector drag = vel.copy();
    drag.normalize();
    float A = PI*sq(getRadius()*0.01); //radius assumed in cm
    // A - frontal area
    drag.mult(-c*A*vel.magSq());
    if(drag.mag() > vel.mag()) drag.normalize().mult(vel.mag());
    applyForce(drag);
  }
  
  void applyTorque(float torque) {
   angAcc = -0.5 * torque * angVel;
    //angAcc = torque * ((2/5) * mass * sq(getRadius()*0.01));  
  }
  
  void applyForce(PVector force) {
    PVector f = PVector.div(force, getMass());
    acc.add(f);
  }
  
  float getRadius() {
    return radius;
  }
  
  boolean checkCollision(Body m) {
    if(m instanceof Circle) {
      return checkCollision((Circle)m);
    }
    else return false;
  }
  
  boolean checkCollision(Circle m) {
    float d = pos.dist(m.pos);
    float dvel = vel.dist(m.vel);
    PVector pos21 = m.pos.copy().sub(pos);
    PVector vel21 = m.vel.copy().sub(vel);
    if(d < getRadius() + m.getRadius() + dvel*dt && vel21.dot(pos21) <= 0 ) return true;
    return false;
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
    PVector distance = new PVector(- getRadius(), - getRadius());
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
    ellipse(pos.x, pos.y, 2*getRadius(), 2*getRadius());
    fill(0);
    ellipse(pos.x, pos.y, 3, 3);
    line(pos.x, pos.y, pos.x + getRadius()*cos(ang), pos.y + getRadius()*sin(ang));
  }
}