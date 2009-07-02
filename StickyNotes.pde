import ddf.minim.*;
import ddf.minim.signals.*;
import processing.video.*;

Capture capture;
Minim minim;
AudioOutput lineOut;
SquareWave squareWave;
  
int triggerX = -1, triggerY = -1;
color triggerColor;
int triggerThreshold = 15;

void setup()
{
  size(640, 480);
  capture = new Capture(this, width, height, 30);
  minim = new Minim(this);
  lineOut = minim.getLineOut(Minim.STEREO, 512);
  squareWave = new SquareWave(440, 1, 44100);
}

void stop()
{
  lineOut.close();
  minim.stop();
  super.stop();
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
      trigger();
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

void trigger()
{
  println("TRIGGER!");
  lineOut.addSignal(squareWave);
}
