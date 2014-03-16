color backgroundColor;
Puppet puppet;
SoundSense soundsense;


void setup() {
  size(500, 500);
  backgroundColor = 0;
  puppet = new Puppet(this);
  soundsense = new SoundSense(2);
  //soundsense.printInfo();
}

void draw() {
  background(backgroundColor);
  soundsense.sense(puppet);
  puppet.draw();
}

void keyPressed() {
  switch(key) {
   case 's':
      puppet.toggleSmile();
      break;
    case 'S':
      soundsense.toggleSmiling();
      break;
    case 'a':
      puppet.moveArms(PI*4/6);
      break;
    case 'A':
    case 'C':
      soundsense.toggleCheering();
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
    case 'N':
      soundsense.toggleNodding();
      break;
    case 'j':
      puppet.jump();
      break;
    case 'J':
      soundsense.toggleJumping();
      break;
    case 'O':
      soundsense.setAllOn();
      break;
    case 'o':
      soundsense.setAllOff();
      break;
    case 'F':
      soundsense.togglePrintFreqInfo();
      break;
  }
}
