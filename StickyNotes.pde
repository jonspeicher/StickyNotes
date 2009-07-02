import ddf.minim.*;
import ddf.minim.signals.*;
import processing.video.*;

Capture capture;
Minim minim;
AudioOutput lineOut;
ArrayList triggers;

float[] frequencies = { 261.63, 293.66, 329.63, 349.23, 392.00 };
int nextFrequency = 0;

void setup()
{
  size(640, 480);
  capture = new Capture(this, width, height, 30);
  minim = new Minim(this);
  lineOut = minim.getLineOut(Minim.STEREO, 512);
  triggers = new ArrayList();
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
  
  for (int i = 0; i < triggers.size(); i++)
  {
    Trigger trigger = (Trigger) triggers.get(i);
    
    if (trigger.thresholdExceeded())
    {
      trigger.trigger();
    }
    else
    {
      trigger.untrigger();
    }
  }
}

void mouseClicked()
{
  triggers.add(new Trigger(mouseX, mouseY, get(mouseX, mouseY), lineOut, frequencies[nextFrequency]));
  nextFrequency = (nextFrequency + 1) % frequencies.length;
}
