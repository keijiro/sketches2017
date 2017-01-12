final class Tape
{
  ArrayList<PVector> segments;

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

    head = randomVector();
    head.mult(1);
    
    velocity = randomVector();
    velocity.normalize();
    velocity.mult(5);
  }
  
  void update(float dt)
  {
    velocity.mult(0.96);
    velocity.add(PVector.mult(head, -8.0 * dt));
    head.add(PVector.mult(velocity, dt));

    segments.add(head.copy());
    
    while (segments.size() > 12) segments.remove(0);
  }
}