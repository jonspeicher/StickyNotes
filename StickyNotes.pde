import processing.video.*;

Capture capture;

int triggerX = -1, triggerY = -1;
color triggerColor;
int triggerThreshold = 15;

void setup()
{
  size(640, 480);
  capture = new Capture(this, width, height, 30);
}

void draw() 
{
  if (capture.available())
  {
    capture.read();
    pushMatrix();
    scale(-1.0, 1.0);
    image(capture, -capture.width, 0);
    popMatrix();
  }
  
  if (triggerSet())
  {
    color currentColor = get(triggerX, triggerY);
    
    if (triggerThresholdExceeded(currentColor, triggerColor))
    {
      println("TRIGGER!");
    }
  }
}

void mouseClicked()
{
  triggerX = mouseX;
  triggerY = mouseY;
  triggerColor = get(triggerX, triggerY);
}

boolean triggerSet()
{
  return ((triggerX >= 0) && (triggerY >= 0));
}

boolean triggerThresholdExceeded(color currentColor, color triggerColor)
{
  float deltaRed = abs(red(currentColor) - red(triggerColor));
  float deltaGreen = abs(green(currentColor) - green(triggerColor));
  float deltaBlue = abs(blue(currentColor) - blue(triggerColor));
  return (deltaRed > triggerThreshold) || (deltaGreen > triggerThreshold) || (deltaBlue > triggerThreshold);
}
