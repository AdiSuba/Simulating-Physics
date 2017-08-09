class Mover {
  PVector pos;
  PVector vel;
  PVector acc;
  float ang = 0;
  float angVel = 0;
  float angAcc = 0;
  float mass;
  
  Mover() {
    pos = new PVector(random(width), height/2);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    mass = random(1, 2);
  }
  
  Mover(PVector pos) {
    this.pos = new PVector(pos.x, pos.y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    mass = 1;
  }
  
  Mover(PVector pos, PVector vel) {
    this.pos = new PVector(pos.x, pos.y);
    this.vel = new PVector(vel.x, vel.y);
    acc = new PVector(0, 0);
    mass = 2;
  }
  
    Mover(PVector pos, PVector vel, float mass) {
    this.pos = new PVector(pos.x, pos.y);
    this.vel = new PVector(vel.x, vel.y);
    acc = new PVector(0, 0);
    this.mass = mass;
  }
  
  void applyFriction(float c) {
    PVector friction = vel.copy();
    friction.normalize();
    PVector gravity = new PVector(0, 0.2);
    friction.limit(-c * gravity.mag());
    applyForce(friction);
    applyTorque(friction.mag());
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
    PVector f = PVector.div(force, mass);
    acc.add(f);
  }
  
  void update() {
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
    angVel += angAcc;
    ang += angVel;
    angAcc = 0;
  }
  
  float getRadius() {
    return mass*10;
  }
  
  boolean checkCollision(Mover m) {
    float d = pos.dist(m.pos);
    float dvel = vel.dist(m.vel);
    PVector pos21 = m.pos.copy().sub(pos);
    PVector vel21 = m.vel.copy().sub(vel);
    if(d < getRadius() + m.getRadius() + dvel && vel21.dot(pos21) < 0) return true;
    return false;
  }
  
  float calcAngVel(PVector r) {
    return (r.cross(vel).z) / r.magSq();
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
    fill(150);
    stroke(2);
    ellipse(pos.x, pos.y, 2*getRadius(), 2*getRadius());
    fill(0);
    ellipse(pos.x, pos.y, 3, 3);
    line(pos.x, pos.y, pos.x + getRadius()*cos(ang), pos.y + getRadius()*sin(ang));
  }
}