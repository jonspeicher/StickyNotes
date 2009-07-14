class Selector
{
  int centerX, centerY;
  int width, height;
  String label;
  PFont font;

  Selector(int x, int y, int w, int h, String l)
  {
    centerX = x;
    centerY = y;
    width = w;
    height = h;
    label = l;
    
    font = loadFont("Helvetica-12.vlw");
    textFont(font);
    textAlign(CENTER);
  }
  
  boolean hit(int x, int y)
  {
    int minX = centerX - (width / 2);
    int maxX = centerX + (width / 2);
    int minY = centerY - (height / 2);
    int maxY = centerY + (height / 2);
    
    if ((x >= minX) && (x <= maxX) && (y >= minY) && (y <= maxY))
    {
      println("Selected " + label);
      return true;
    }
    else
    {
      return false;
    }
  }
  
  void draw()
  {
    noStroke();
    fill(128, 128, 128);
    ellipse(centerX, centerY, width, height);
    fill(255);
    text(label, centerX, centerY + 5);
  }  
}
