ArrayList<Mover> movers;

void setup() {
  size(600, 400);
  movers = new ArrayList<Mover>();
}

void mouseReleased() {
    PVector pos = new PVector(mouseX, mouseY);
    PVector vel = new PVector(mouseX - pmouseX, mouseY - pmouseY);
    movers.add(new Mover(pos, vel.div(2)));
    frameRate(60);
}

void draw() {
  background(200);
  stroke(0);
  fill(200);
  rect(0, 0, width - 1, height - 1);
  PVector gravity = new PVector(0, 0.2);
  for(Mover m : movers) {
    m.applyForce(gravity);
    m.edges();
    m.update();
    m.display();
  }
}