import ddf.minim.*;
import ddf.minim.signals.*;
import processing.video.*;

Capture capture;
Minim minim;
AudioOutput lineOut;

ArrayList triggers;
ArrayList selectors;

float[] frequencies = { 261.63, 293.66, 329.63, 349.23, 392.00, 440.00, 493.88 };
String[] frequencyLabels = { "C", "D", "E", "F", "G", "A", "B" };
int nextFrequencyIndex = 0;

void setup()
{
  size(640, 530);
  capture = new Capture(this, width, height - 50, 30);
  
  minim = new Minim(this);
  lineOut = minim.getLineOut(Minim.STEREO, 512);
  
  triggers = new ArrayList();
  
  selectors = new ArrayList();
  int cellWidth = width / frequencies.length;
  
  for (int i = 0; i < frequencies.length; i++)
  {
    selectors.add(new Selector((cellWidth / 2) + (i * cellWidth), height - 25, 30, 30, frequencyLabels[i]));
  }
}

void stop()
{
  lineOut.close();
  minim.stop();
  super.stop();
}

void mouseClicked()
{
  boolean selectorHit = false;
  
  for (int i = 0; i < selectors.size(); i++)
  {
    Selector selector = (Selector) selectors.get(i);
    
    if (selector.hit(mouseX, mouseY))
    {
      nextFrequencyIndex = i;
      selectorHit = true;
    }
  }
  
  if (!selectorHit)
  {
    triggers.add(new Trigger(mouseX, mouseY, get(mouseX, mouseY), lineOut, frequencies[nextFrequencyIndex]));
  }
}

void draw() 
{
  drawCapture();
  drawSelectors();
  processTriggers();
}

void drawCapture()
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

void drawSelectors()
{
  for (int i = 0; i < selectors.size(); i++)
  {
    Selector selector = (Selector) selectors.get(i);
    selector.draw();
  }
}

void processTriggers()
{
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
