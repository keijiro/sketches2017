void setup()
{
  size(500, 500, P3D);
  colorMode(1, RGB);
  smooth(4);
  frameRate = 24;
}

PVector getCurvePoint(PVector params1, PVector params2, float t, float phase)
{
  return new PVector(
    sin(params1.x * t + (1 + sin(params2.x * t + phase) * 0.5)),
    sin(params1.y * t + (1 + sin(params2.y * t + phase) * 0.5)),
    sin(params1.z * t + (1 + sin(params2.z * t + phase) * 0.5))
  );
}

void draw()
{
  randomSeed(1);
  
  final int totalFrames = 30 * 4;
  final float progress = (float)frameCount / totalFrames % 1;
  
  perspective(PI / 180 * 45, 1, 0.1, 100);
  camera(0, 0, -4,  0, 0, 0,  0, 1, 0);

  background(1);
  stroke(0.18);

  final int steps = 35;
  final float dt = min(0.018, progress * 0.1);
  final float t0 = 0.01 * frameCount + 20;
  final float phase = 0.0279 * frameCount + 20;
  final float extent = min(0.05, 0.5 - progress / 2);
  
  for (int ri = 0; ri < 10; ri++)
  {
    PVector params1 = new PVector(random(-1, 1), random(-1, 1), random(-1, 1));
    PVector params2 = new PVector(random(-1, 1), random(-1, 1), random(-1, 1));
    params1.mult(6);
    params2.mult(20);
  
    PVector Pp = getCurvePoint(params1, params2, t0 - dt, phase);
    PVector P1 = getCurvePoint(params1, params2, t0, phase);
    PVector T1 = PVector.sub(P1, Pp);
    float t = t0 - dt;
    
    beginShape(TRIANGLE_STRIP);
    
    for (int i = 0; i < steps; i++)
    {
      PVector P = getCurvePoint(params1, params2, t, phase);
      PVector T = PVector.sub(P, P1);
      PVector N = PVector.sub(T, T1);
      PVector B = T.cross(N).normalize(null);
      
      PVector W = PVector.mult(B, extent);
      PVector Pa = PVector.sub(P, W);
      PVector Pb = PVector.add(P, W);
      
      vertex(Pa.x, Pa.y, Pa.z);
      vertex(Pb.x, Pb.y, Pb.z);
     
      P1 = P;
      T1 = T;
      t += dt;
    }
    
    endShape();
  }
  
//  if (frameCount <= totalFrames) saveFrame();
}