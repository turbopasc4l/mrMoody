color backgroundColor;
Puppet puppet;

void setup() {
  size(500, 500);
  backgroundColor = 0;
  puppet = new Puppet();
}

void draw() {
  background(backgroundColor);
  puppet.draw();
}

void keyPressed() {
  switch(key) {
    case '1':
      puppet.setSmile(true);
      break;
    case '2':
      puppet.setSmile(false);
      break;
    case '3':
      puppet.setArmsAngle(PI*4/6);
      break;
    case '4':
      puppet.setLegsAngle(PI*4/6);
      break;
    case '5':
      puppet.reset();
      break;
  }
}
