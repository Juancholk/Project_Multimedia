class Circle
{
  float circle_x, circle_y;
  float radius;
  color col;
  float dir_x = random(-3,5);
  float dir_y = random(-2,3);
  Circle(){
    this.circle_x = random(width);
    this.circle_y = random(height);
    this.radius= random(18);
    col = color(random(255),random(255),random(255));
  }
  void draw(){
    fill(col);
    ellipse(circle_x,circle_y,radius*2,radius*2);
  }
  void move(){
    this.hitbox();
    circle_x += dir_x;
    circle_y += dir_y;
  }
  void hitbox(){
    if( circle_x > (width -radius)){
      circle_x= width - radius;
      dir_x = -dir_x;
      if(random(-1,1)>0)
        dir_y=-dir_y;
    }
    else if(circle_x < radius){
      circle_x= radius;
      dir_x= -dir_x;
      if(random(-1,1)>0)
        dir_y=-dir_y;
  }
    if( circle_y >(height - radius)){
      circle_y = height - radius;
      dir_y = -dir_y;
      if(random(-1,1)>0)
        dir_x=-dir_x;
    }
    else if(circle_y < radius){
      circle_y = radius;
      dir_y = -dir_y;
      if(random(-1,1)>0)
        dir_x=-dir_x;
    }
    
  }


}
