
class Square
{
  PVector[] vertices;
  PVector speed;
  PVector center;
  float[] rgb = {0, 0, 0};
  float[] colour_weights = {1, 1, 1};
  int significant_colour;
  Hitbox hitbox;
  OscP5 oscClient = new OscP5(this, 11111);
  NetAddress pureDataAddress = new  NetAddress("localhost", 11112);
  color clr;
  
  float side_length;
  
  Square()
  {
    this(new PVector(random(500), random(500)), new PVector().random2D(), (int)random(30));
  }
    
  Square(PVector top_left_corner, PVector speed, int side_length)
  {
    this.vertices = new PVector[4];
   
    this.vertices[0] = top_left_corner;
    
    this.vertices[1] = new PVector();
    this.vertices[1].x = top_left_corner.x + side_length;
    this.vertices[1].y = top_left_corner.y;
    
    this.vertices[2] = new PVector();
    this.vertices[2].x = top_left_corner.x + side_length;
    this.vertices[2].y = top_left_corner.y + side_length;
    
    this.vertices[3] = new PVector();
    this.vertices[3].x = top_left_corner.x;
    this.vertices[3].y = top_left_corner.y + side_length;
        
    this.speed = speed;
    significant_colour = (int)random(3);
    for(int idx = 0; idx < 3; idx++)
    {
      if(idx == significant_colour)
        this.rgb[idx] = 255;
      else
        this.rgb[idx] = (int)random(64, 128);
    }
    
    this.side_length = side_length;
    this.hitbox = new Hitbox(top_left_corner.x, top_left_corner.y, side_length, side_length);
    this.center = new PVector(top_left_corner.x + side_length/2, top_left_corner.y + side_length/2);
  }
    
  void change_color(float x_coord, float y_coord)
  {
    float weight_x = abs(x_coord-250)/250;
    float weight_y = abs(y_coord-250)/250;
    float avg = (weight_x + weight_y)/2;
    this.colour_weights[this.significant_colour] = avg;
    this.clr = color(this.rgb[0]*this.colour_weights[0], this.rgb[1]*this.colour_weights[1], this.rgb[2]*this.colour_weights[2]);
  }
  
  float ang_speed = 3;
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
        vertex.x += this.speed.x*3;
        vertex.y += this.speed.y*3;
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
    
    change_color(this.center.x, this.center.y);

  }
  
  void draw()
  {
   beginShape();
   fill(this.clr);
   for(PVector vertex : this.vertices)
       vertex(vertex.x, vertex.y);
    endShape();
  }
};
