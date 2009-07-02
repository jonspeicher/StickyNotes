import processing.video.*;

Capture capture;

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
}
