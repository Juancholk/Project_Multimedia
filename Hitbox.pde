import netP5.*;
import oscP5.*;
class Hitbox
{
  float sq_x;
  float sq_y;
  OscP5 oscClient = new OscP5(this, 11111);
  NetAddress pureDataAddress = new  NetAddress("localhost", 11112);
  float hitbox_size_x, hitbox_size_y;
  float speed;
  
  Hitbox(float sq_x, float sq_y, float hitbox_size_x, float hitbox_size_y)
  {
    this.sq_x = sq_x;
    this.sq_y = sq_y;
    this.hitbox_size_x = hitbox_size_x;
    this.hitbox_size_y = hitbox_size_y;
  }
  
  void update(float sq_x, float sq_y, float hitbox_size_x, float hitbox_size_y)
  {
    this.sq_x = sq_x;
    this.sq_y = sq_y;
    this.hitbox_size_x = hitbox_size_x;
    this.hitbox_size_y = hitbox_size_y;
  }
  
  PVector new_direction(PVector old_dir)
  {
     if(sq_x <= 0)
     {
       float theta = radians(271 + random(0, 180));
       old_dir = new PVector(cos(theta), sin(theta));
       sendBounceMessage();
       //sendSpeedMessage();
     }
     
     else if(sq_x + hitbox_size_x >= 500)
     {
       float theta = radians(random(91, 270));
       old_dir = new PVector(cos(theta), sin(theta));
       sendBounceMessage();
       //sendSpeedMessage();
     }
     
     else if(sq_y <= 0)
     {
       float theta = radians(random(1, 180));
       old_dir = new PVector(cos(theta), sin(theta));
       sendBounceMessage();
       //sendSpeedMessage();
     }
     
     else if(sq_y + hitbox_size_y >= 500)
     {
       float theta = radians(181 + random(0, 180));
       old_dir = new PVector(cos(theta), sin(theta));
       sendBounceMessage();
       //sendSpeedMessage();
     }
     
     return old_dir;
  }
  
  void draw_hitbox()
  {
    fill(255, 0, 0);
    rect(sq_x, sq_y, hitbox_size_x, hitbox_size_y);
  }
  void capture(float x, float y){
    this.speed = 60 + 120*abs(x+y);
  }
  void sendBounceMessage(){
    OscMessage oscMessage = new OscMessage("/bounce");
    oscClient.send(oscMessage, pureDataAddress);
  }
  void sendSpeedMessage(){
    OscMessage oscMessage = new OscMessage("/speed");
    oscMessage.add(this.speed);
    oscClient.send(oscMessage, pureDataAddress);
  }
};
