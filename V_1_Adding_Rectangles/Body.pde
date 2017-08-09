abstract class Body {
  PVector pos;
  PVector vel;
  PVector acc;
  float ang = 0;
  float angVel = 0;
  float angAcc = 0;
  float density;
  float dt = 1;

  Body() {
    pos = new PVector(random(width), height/2);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    density = random(0.1, 0.2);
  }

  Body(PVector pos) {
    this.pos = new PVector(pos.x, pos.y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    density = 0.1;
  }

  Body(PVector pos, PVector vel) {
    this.pos = new PVector(pos.x, pos.y);
    this.vel = new PVector(vel.x, vel.y);
    acc = new PVector(0, 0);
    density = 0.1;
  }

  Body(PVector pos, PVector vel, float mass) {
    this.pos = new PVector(pos.x, pos.y);
    this.vel = new PVector(vel.x, vel.y);
    acc = new PVector(0, 0);
    setMass(mass);
  }

  void applyFriction(float c) {
    PVector friction = vel.copy();
    friction.normalize();
    PVector gravity = new PVector(0, 0.2);
    friction.limit(-c * gravity.mag());
    applyForce(friction);
    applyTorque(friction.mag());
  }

  PVector attract(Body m) {
    float G = 100;
    PVector force = PVector.sub(pos, m.pos);
    float dsq = force.magSq(); 
    force.normalize();

    float strength = (G * getMass() * m.getMass()) / dsq;
    force.mult(strength);

    return force;
  }

  void setMass(float mass) {
    density = mass / getVolume();
  }
  
  float getMass() {
    return density*getVolume();
  }

  abstract float getVolume();

  void applyDrag(float c) {
  }

  abstract boolean checkCollision(Body b);

  abstract float getDistanceToShapeEdge();

  abstract float calcAngVel(PVector r);

  void applyTorque(float torque) {
    angAcc = -0.5 * torque * angVel;
    //angAcc = torque * ((2/5) * mass * sq(getRadius()*0.01));
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, getMass());
    acc.add(f);
  }

  void update() {
    dt = 1 / frameRate;
    vel.add(acc.copy().mult(dt));
    pos.add(vel.copy().mult(dt));
    println(vel.x + " " + vel.y + "\n");
    acc.mult(0);
    angVel += angAcc;
    ang += angVel;
    angAcc = 0;
  }

  abstract boolean checkCollisionEdgeX();

  abstract boolean checkCollisionEdgeY();
  
  abstract void edges();

  abstract void display();
}