void setup()
{
  size(500, 500, P3D);
  colorMode(HSB, 1);
  smooth(4);
  frameRate = 30;
}

PVector getCurvePoint(float freq1, float freq2, float t)
{
  final float sn1 = sin(t * freq1);
  final float cs1 = cos(t * freq1);
  final float sn2 = sin(t * freq2);
  final float cs2 = cos(t * freq2);
  return new PVector(sn1 * sn2, cs2, cs1 * sn2);
}

void draw()
{
  randomSeed(4);
  
  final int totalFrames = 30 * 3;
  final float progress = (float)(frameCount - 1) / totalFrames % 1;
  
  perspective(PI / 180 * 45, 1, 0.1, 100);
  camera(0, 0, -3,  0, 0, 0,  0, 1, 0);

//  background(1);
//  stroke(0.18);
  background(0.3, 0.84, 0.2);
  noStroke();
  fill(0.1, 0.04, 1);

  final int tapes = 32;
  final int steps = 14;
  final float dt = 0.01211;
  final float t0 = 0.02171 * frameCount + 20;
  
  for (int ti = 0; ti < tapes; ti++)
  {
    final float freq1 = random(-8, 8);
    final float freq2 = random(-8, 8);
    
    final float pr = constrain(progress * 1.5 - 0.5 * ti / tapes, 0, 1);
    final float tw = 0.075 * sin(PI * pr);
    
    PVector Pp = getCurvePoint(freq1, freq2, t0 - dt);
    PVector P1 = getCurvePoint(freq1, freq2, t0);
    PVector T1 = PVector.sub(P1, Pp);
    float t = t0 + dt;
    
    beginShape(TRIANGLE_STRIP);
    
    for (int i = 0; i < steps; i++)
    {
      PVector P = getCurvePoint(freq1, freq2, t);
      PVector T = PVector.sub(P, P1);
      PVector N = PVector.sub(T, T1);
      PVector B = T.cross(N).normalize(null);
      
      float w = sin(PI * i / steps) * tw;
      PVector W = PVector.mult(B, w);
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