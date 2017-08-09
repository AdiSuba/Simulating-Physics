class AABB {
  PVector min;
  PVector max;
  
  AABB(Rectangle r) {
    min =  new PVector(999, 999);
    max =  new PVector(-999, -999);
    for(int i =  0; i < 4; i++) 
   {
      float tempX = (1 - 2 * (i % 2)) * r.w / 2, tempY = (1 - 2 * ((i / 2) % 2)) * r.h / 2 ;   
      //println("tempx" + tempX + " " + tempY);
      float rotX = tempX*cos(r.ang) - tempY*sin(r.ang);
      float rotY = tempX*sin(r.ang) + tempY*cos(r.ang);
      if(rotX < min.x) min.x = rotX;
      if(rotY < min.y) min.y = rotY;
      if(rotX > max.x) max.x = rotX;
      if(rotY > max.y) max.y = rotY;
   }
   
   min.add(r.pos);
   max.add(r.pos);
   //println("min" + min.x + " " + min.y);
   //println("max" + max.x + " " + max.y);
    
  }
  
  boolean checkAABBCollision(AABB a)
  {
    if(max.x < a.min.x || min.x > a.max.x) return false;
    if(max.y < a.min.y || min.y > a.max.y) return false;
    return true;
  }
  
  void display() {
    fill(40,140,40);
    stroke(2);
    rect(min.x, min.y, max.x - min.x, max.y - min.y);
  }
}