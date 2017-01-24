SimplexNoise snoise = new SimplexNoise();

void setup()
{
  size(500, 500, P3D);
  colorMode(HSB, 1);
  frameRate(24);
  smooth(4);
}

void draw()
{
  final int reso = 8;
  final int totalFrames = 24 * 4;
  final float time01 = (frameCount - 1.0) / totalFrames % 1;
  final float phi = time01 * 2 * PI;
  
  perspective(radians(45), 1, 0.1, 100);
  camera(0, 0, -15 + sin(phi) * 2,  0, 0, 0,  0, 1, 0);
  rotateY(radians(60 + sin(phi) * 10));
  rotateZ(radians(40 + sin(phi * 2) * 6));
  
  background(1);
  stroke(0);
  
  for (int i = 0 ; i < reso; i++)
  {
    float x = i - 0.5 * reso;
    for (int j = 0 ; j < reso; j++)
    {
      float y = j - 0.5 * reso;
      for (int k = 0 ; k < reso; k++)
      {
        float z = k - 0.5 * reso;
        
        float nx = x * 0.3 + 2;
        float ny = y * 0.3 + 3;
        float nz1 = z * 0.3 + time01 * 8;
        float nz2 = z * 0.3 + time01 * 8 - 8;
        
        float n1 = snoise.calculate(nx, ny, nz1);
        float n2 = snoise.calculate(nx, ny, nz2);
        float n = lerp(n1, n2, time01);
        
        float s = 0.5 + n * 0.5;
        
        pushMatrix();
        translate(x, y, z);
        box(s, s, s);
        popMatrix();
      }
    }
  }
  
  //if (frameCount <= totalFrames) saveFrame();
}