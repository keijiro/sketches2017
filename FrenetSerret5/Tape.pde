final class Tape
{
  ArrayList<PVector> segments;
  SimplexNoise noise;
  PVector head;
  PVector velocity;
  
  PVector randomVector()
  {
    while (true)
    {
      PVector v = new PVector(random(-1, 1), random(-1, 1), random(-1, 1));
      if (v.mag() <= 1.0) return v;
    }
  }
  
  Tape()
  {
    segments = new ArrayList<PVector>();
    noise = new SimplexNoise();
    head = PVector.mult(randomVector(), 0.1);
    velocity = new PVector();
  }
  
  void update(float dt)
  {
    noise.calculate(head.x, head.y, head.z);
    PVector grad1 = new PVector(noise.ddx, noise.ddy, noise.ddz);

    noise.calculate(head.x, head.y, head.z + 11.1111f);
    PVector grad2 = new PVector(noise.ddx, noise.ddy, noise.ddz);
    
    PVector dfn = grad1.cross(grad2);
    
    velocity.mult(0.9);
    velocity.add(PVector.mult(dfn, dt));
    head.add(PVector.mult(velocity, dt));

    segments.add(head.copy());
    
    while (segments.size() > 24) segments.remove(0);
  }
}