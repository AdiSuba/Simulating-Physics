CollisionSystem ms;

void setup() {
  size(800, 600);
  ms = new CollisionSystem();
  //ms.addMover(new Mover(new PVector(width/2, height/2)));
  //ms.addMover(new Mover(new PVector(width/4, height/2), new PVector(0, 0)));
  //ms.addMover(new Mover(new PVector(width/2, height/4), new PVector(0, 5)));
  //ms.addMover(new Mover(new PVector(width/4, height/4), new PVector(5, 5), 2));
}

void mouseReleased() {
    PVector pos = new PVector(mouseX, mouseY);
    PVector vel = new PVector(mouseX - pmouseX, mouseY - pmouseY);
    ms.addMover(new Mover(pos, vel.div(2)));
}

void draw() {
  background(200);
  stroke(0);
  fill(200);
  rect(0, 0, width - 1, height - 1);
  ms.update();
  ms.display();
  ms.displayCollisions();
}