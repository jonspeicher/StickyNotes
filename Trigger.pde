class Trigger
{
  int x;
  int y;
  int triggerColor;
  int threshold;
  boolean triggered;
  
  AudioOutput lineOut;
  SineWave sineWave;
  
  Trigger(int triggerX, int triggerY, int triggerC, AudioOutput out, float frequency)
  {
    x = triggerX;
    y = triggerY;
    triggerColor = triggerC;
    threshold = 25;
    triggered = false;
    
    lineOut = out;
    sineWave = new SineWave(frequency, 1.0, lineOut.sampleRate());
    
    println("Added new trigger x = " + x + " y = " + y + " color = " + triggerColor);
  }
  
  boolean set()
  {
    return (x >= -1) && (y >= -1);
  }
  
  boolean thresholdExceeded()
  {
    color currentColor = get(x, y);
    float deltaRed = abs(red(currentColor) - red(triggerColor));
    float deltaGreen = abs(green(currentColor) - green(triggerColor));
    float deltaBlue = abs(blue(currentColor) - blue(triggerColor));
    return (deltaRed > threshold) || (deltaGreen > threshold) || (deltaBlue > threshold);
  }
  
  void trigger()
  {
    println("TRIGGER: " + sineWave.frequency());
    
    if (!triggered)
    {
      lineOut.addSignal(sineWave);
      triggered = true;
    }
  }
  
  void untrigger()
  {
    if (triggered)
    {
      lineOut.removeSignal(sineWave);
      triggered = false;
    }
  } 
}
