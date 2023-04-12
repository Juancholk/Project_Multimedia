
class Triangle
{
  Hitbox hitbox;
  PVector[] vertices = new PVector[3];
  
  color clr;
  
  PVector center = new PVector();
  PVector speed;
  Triangle()
  {
    this(new PVector(random(500), random(500)), new PVector().random2D());
  }
  
  Triangle(PVector v1, PVector speed)
  {
    this.vertices[0] = v1;
    PVector add = new PVector().random2D();
    add.mult(random(40));
    this.vertices[1] = new PVector(v1.x, v1.y);
    this.vertices[1] = this.vertices[1].add(add);
    add = new PVector().random2D();
    add.mult(random(40));
    this.vertices[2] = new PVector(this.vertices[1].x, this.vertices[1].y);
    this.vertices[2] = this.vertices[2].add(add);
     
    this.speed = speed;
    
    float less_x = 100000;
    float less_y = 100000;
    
    float greatest_x = -100000;
    float greatest_y = -100000;
    
    for(PVector vertex : this.vertices)
    {
      if(vertex.x < less_x)
        less_x = vertex.x;
      if(vertex.y < less_y)
        less_y = vertex.y;
        
      if(vertex.x > greatest_x)
        greatest_x = vertex.x;
      if(vertex.y > greatest_y)
        greatest_y = vertex.y;
    }
    
    this.hitbox = new Hitbox(less_x, less_y, greatest_x - less_x, greatest_y - less_y);
            
    this.center.x = this.hitbox.sq_x + this.hitbox.hitbox_size_x/2;
    this.center.y = this.hitbox.sq_y + this.hitbox.hitbox_size_y/2;
    this.clr = color(random(255), random(255), random(255));
  }
  
  float ang_speed = 5;
  void rotate()
  {
    pushMatrix();
    translate(this.center.x, this.center.y);
    for(PVector vertex : vertices)
    {
        vertex.sub(this.center.x, this.center.y);
        vertex.rotate(radians(ang_speed));
        vertex.add(this.center.x, this.center.y);
    }
    popMatrix();
  }
  
  void move()
  {
    this.rotate();
    this.speed = this.hitbox.new_direction(this.speed);
    for(PVector vertex : this.vertices)
    {
        vertex.x += this.speed.x;
        vertex.y += this.speed.y;
    }
    
    float less_x = 100000;
    float less_y = 100000;
    
    float greatest_x = -100000;
    float greatest_y = -100000;
         
    for(PVector vertex : this.vertices)
    {
      if(vertex.x < less_x)
        less_x = vertex.x;
      if(vertex.y < less_y)
        less_y = vertex.y;
        
      if(vertex.x > greatest_x)
        greatest_x = vertex.x;
      if(vertex.y > greatest_y)
        greatest_y = vertex.y;
    }
   
    this.hitbox.update(less_x, less_y, greatest_x - less_x, greatest_y - less_y);
        
    this.center.x = this.hitbox.sq_x + this.hitbox.hitbox_size_x/2;
    this.center.y = this.hitbox.sq_y + this.hitbox.hitbox_size_y/2;
  }
  
   void draw()
  {
   beginShape();
   fill(this.clr);
   for(PVector vertex : this.vertices)
       vertex(vertex.x, vertex.y);
    endShape();
  }
}
