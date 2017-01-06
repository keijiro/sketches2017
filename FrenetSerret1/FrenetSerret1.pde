void setup()
{
  size(500, 500, P3D);
  colorMode(1, RGB);
  smooth(4);
}

PVector curveParams;

PVector getCurvePoint(float t)
{
  float r = 1 + 0.5 * sin(t * 1.82845);
  return new PVector(
    sin(t * 1.42482) * r,
    sin(t * 1.28472) * r,
    sin(t * 1.11723) * r
  );
}

void draw()
{
  final boolean ribbon = true;
  
  background(1);
  perspective(PI / 180 * 45, 1, 0.1, 100);
  camera(0, 0, -5,  0, 0, 0,  0, 1, 0);
  
  final int steps = 500;
  final float dt = 0.08;
  
  float t = 30;
  PVector P1 = getCurvePoint(t);
  PVector T1 = PVector.sub(P1, getCurvePoint(t - dt));

  t += dt;
  
  if (ribbon)
  {
    stroke(0.32);
    fill(0.99);
    beginShape(TRIANGLE_STRIP);
  }
  else
  {
    stroke(0.1);
    noFill();
    beginShape();
  }
  
  for (int i = 0; i < steps; i++)
  {
    PVector P = getCurvePoint(t);
    PVector T = PVector.sub(P, P1);
    PVector N = PVector.sub(T, T1);
    PVector B = T.cross(N).normalize(null);
    
    PVector W = PVector.mult(B, 0.08);
    PVector Pa = PVector.sub(P, W);
    PVector Pb = PVector.add(P, W);
    
    if (ribbon)
    {
      vertex(Pa.x, Pa.y, Pa.z);
      vertex(Pb.x, Pb.y, Pb.z);
    }
    else
      vertex(P.x, P.y, P.z);
   
    P1 = P;
    T1 = T;
    t += dt;
  }
  
  endShape();
  
  //if (frameCount == 1) saveFrame();
}