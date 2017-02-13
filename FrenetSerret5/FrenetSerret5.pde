ArrayList<Tape> tapes = new ArrayList<Tape>();

void setup()
{
  size(500, 500, P3D);
  colorMode(HSB, 1);
  smooth(4);
  frameRate = 30;
}

void draw()
{
  final int totalFrames = 30 * 4;
  final float progress = (float)(frameCount - 1) / totalFrames % 1;
  
  perspective(PI / 180 * 45, 1, 0.1, 100);
  camera(0, 0, -3,  0, 0, 0,  0, 1, 0);

  background(1);
  stroke(0.18);
  //background(0.03, 1, 0.4);
  //noStroke();
  //fill(1);

  if (frameCount < 20)
  {
    tapes.add(new Tape());
    tapes.add(new Tape());
  }

  for (Tape tape : tapes)
  {
    tape.update(1.0 / 30);
    
    beginShape(TRIANGLE_STRIP);
    
    final float wk = 1.0 / (tape.segments.size() - 2);
    
    for (int i = 1; i < tape.segments.size() - 1; i++)
    {
      PVector P0 = tape.segments.get(i - 1);
      PVector P1 = tape.segments.get(i);
      PVector P2 = tape.segments.get(i + 1);
      PVector T0 = PVector.sub(P0, P1);
      PVector T1 = PVector.sub(P1, P2);
      PVector N1 = PVector.sub(T1, T0);
      PVector B1 = T1.cross(N1).normalize(null);
      
      final float wp = wk * (i - 1);// * min(1, 10 - progress * 10);
      PVector W = PVector.mult(B1, min(0.06 * wp, 0.1 * (1 - wp)));
      PVector Pa = PVector.sub(P1, W);
      PVector Pb = PVector.add(P1, W);
      
      vertex(Pa.x, Pa.y, Pa.z);
      vertex(Pb.x, Pb.y, Pb.z);
    }
    
    endShape();
  }
  
  //if (frameCount <= totalFrames) saveFrame();
}