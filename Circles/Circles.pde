final int DIVISOR = 10;

class Circle
{
  int x, y, step, dir;
  
  Circle()
  {
    x = floor(random(1, DIVISOR - 1));
    y = floor(random(1, DIVISOR - 1));
    step = floor(random(0, 4));
    dir = random(0, 1) < 0.5 ? 1 : -1;
  }
  
  void draw(final float time)
  {
    final int step1 = step + dir * floor(time * 4);
    final int step2 = step1 + dir;
    
    final int dx1 = ((step1 + 1) >> 1) & 1;
    final int dx2 = ((step2 + 1) >> 1) & 1;
    
    final int dy1 = (step1 >> 1) & 1;
    final int dy2 = (step2 >> 1) & 1;
    
    final float ip02 = time * 8 % 2;
    final float ipmv = 0.5 - 0.5 * cos(min(ip02, 1) * PI);
    
    final float sx = width * (x + lerp(dx1, dx2, ipmv)) / DIVISOR;
    final float sy = width * (y + lerp(dy1, dy2, ipmv)) / DIVISOR;
    
    final float ossc = ((x + dx2) * 0.8 + (y + dy2) * 0.2) / DIVISOR;
    final float ipsc = constrain((time * 8 % 4 - 3) * 2 - ossc, 0, 1);
    final float sw = width / DIVISOR * (abs(1 - ipsc * 2) * 0.75 + 0.25);
    
    ellipse(sx, sy, sw, sw);
  }
}

ArrayList<Circle> circles = new ArrayList<Circle>();

void setup()
{
  size(500, 500);
  colorMode(HSB, 1);
  smooth(4);
  frameRate(30);
  
  for (int i = 0; i < 8 * 6; i++)
    circles.add(new Circle());
}

void draw()
{
  background(0.08, 0.8, 0.5);
  noStroke();
  
  final int totalFrames = 30 * 5;
  final float time = (frameCount - 1.0) / totalFrames;
  
  for (Circle c : circles) c.draw(time);
  
//  if (frameCount <= totalFrames) saveFrame();
}