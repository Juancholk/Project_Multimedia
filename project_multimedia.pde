ArrayList<Square> square_array = new ArrayList<Square>(); //Arreglo de cuadrados
ArrayList<Circle> circle_array = new ArrayList<Circle>();  //Arreglo de circulos
ArrayList<Triangle> triangle_array = new ArrayList<Triangle>(); //Arreglo de triángulos

void setup()
{
  size(500, 500);
 
}

void draw()
{
  noStroke();
    
  background(0, 0, 0);
  for(Square square : square_array)
  {
    square.move();
    square.draw();
  }
  
  for(Circle circle : circle_array)
  {
    circle.move();
    circle.draw();
  }
  
  for(Triangle tri : triangle_array)
  {
    tri.move();
    tri.draw();
  }
}

void mousePressed()
{
   int random_figure = int(random(3));
   //int random_figure = 1;
   if(random_figure == 0)
     square_array.add(new Square());
   
   else if(random_figure == 1)
     circle_array.add(new Circle());
     
   else
     triangle_array.add(new Triangle());
}
