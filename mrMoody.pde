color backgroundColor;
Puppet puppet;

void setup() {
  size(500, 500);
  backgroundColor = 0;
  puppet = new Puppet(this);
}

void draw() {
  background(backgroundColor);
  puppet.draw();
}

void keyPressed() {
  switch(key) {
    case 's':
      puppet.toggleSmile();
      break;
    case 'a':
      puppet.setArmsAngle(PI*4/6);
      break;
    case 'A':
      puppet.moveArms(PI*4/6);
      break;
    case 'l':
      puppet.setLegsAngle(PI*4/6);
      break;
    case 'r':
      puppet.reset();
      break;
    case 'n':
      puppet.nod();
      break;
    case 'j':
      puppet.jump();
      break;
  }
}
