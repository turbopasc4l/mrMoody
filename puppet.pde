import de.looksgood.ani.*;

public class Puppet {
  PApplet parentApplet;
  Ani puppetAnimations;
  AniSequence jumpSequence, nodSequence;
  PVector position;
  float trunkLength, armLength, legLength, neckLength, headDiameter;
  float trunkAngle, leftArmAngle, rightArmAngle, leftLegAngle, rightLegAngle, neckAngle;
  int lineWidth, smileWidth;
  color fillColor, lineColor;
  boolean smile;
  Puppet(PApplet applet) {
    parentApplet = applet;
    Ani.init(parentApplet);
    position = new PVector(width/2, height/2);
    trunkLength = height/6;
    armLength = trunkLength;
    legLength = trunkLength*1.3;
    neckLength = trunkLength*2/5;
    headDiameter = trunkLength/2;
    lineWidth = 6;
    smileWidth = 3;
    fillColor = 0;
    lineColor = 255;
    initJumpSequence();
    initNodSequence();
    reset();
  }
  public void draw() {
    strokeWeight(lineWidth);
    stroke(lineColor);
    fill(fillColor);
    drawBody();
  }
  private void drawBody() {
    pushMatrix();
    translate(position.x, position.y);
    rotate(trunkAngle);
    drawTrunk();
    drawNeckAndHead();
    drawArms();
    drawLegs();
    popMatrix();
  }
  private void drawTrunk() {
    line(0, -trunkLength/2, 0, trunkLength/2);
  }
  private void drawNeckAndHead() {
    pushMatrix();
    translate(0, -trunkLength/2);
    float visualNeckLength = neckLength*cos(neckAngle);
    line(0, 0, 0, -visualNeckLength);
    translate(0, -visualNeckLength);
    ellipse(0, 0, headDiameter, headDiameter);
    if(smile) {
      strokeWeight(smileWidth);
      arc(0, 0, headDiameter*2/3, headDiameter*2/3, PI/6, PI*5/6);
      strokeWeight(lineWidth);
    }
    popMatrix();
  }
  private void drawArms() {
    pushMatrix();
    translate(0, -trunkLength/2);
    pushMatrix();
    rotate(leftArmAngle);
    line(0, 0, 0, armLength);
    popMatrix();
    pushMatrix();
    rotate(-rightArmAngle);
    line(0, 0, 0, armLength);
    popMatrix();
    popMatrix();
  }
  private void drawLegs() {
    pushMatrix();
    translate(0, trunkLength/2);
    pushMatrix();
    rotate(leftLegAngle);
    line(0, 0, 0, legLength);
    popMatrix();
    pushMatrix();
    rotate(-rightLegAngle);
    line(0, 0, 0, legLength);
    popMatrix();
    popMatrix();
  }
  private void initJumpSequence() {
    jumpSequence = new AniSequence(parentApplet);
    jumpSequence.beginSequence();
    jumpSequence.add(Ani.to(position, 0.15, "y", height/2 - trunkLength, Ani.QUAD_OUT));
    jumpSequence.add(Ani.to(position, 0.15, "y", height/2, Ani.QUAD_IN));
    jumpSequence.endSequence();
  }
  private void initNodSequence() {
    nodSequence = new AniSequence(parentApplet);
    nodSequence.beginSequence();
    float initialNeckAngle = 0;
    nodSequence.add(Ani.to(this, 0.15, "neckAngle", PI/4, Ani.QUAD_OUT));
    nodSequence.add(Ani.to(this, 0.3, "neckAngle", initialNeckAngle, Ani.QUAD_IN));
    nodSequence.endSequence();
  }
  public void reset() {
    trunkAngle = 0;
    leftArmAngle = PI/12;
    rightArmAngle = PI/12;
    leftLegAngle = PI/18;
    rightLegAngle = PI/18;
    neckAngle = 0;
    smile = false;
  }
  public void jump() {
    jumpSequence.start();
  }
  public void setArmsAngle(float angle) {
    leftArmAngle = angle;
    rightArmAngle = angle;
  }
  public void moveArms(float angle) {
    moveArm("leftArmAngle", leftArmAngle, angle);
    moveArm("rightArmAngle", rightArmAngle, angle);
  }
  void moveArm(String variableName, float initialAngle, float angle) {
    AniSequence armSequence = new AniSequence(parentApplet);
    armSequence.beginSequence();
    armSequence.add(Ani.to(this, 0.25, variableName, angle));
    armSequence.add(Ani.to(this, 0.25, variableName, initialAngle));
    armSequence.endSequence();
    armSequence.start();
  }
  public void setLegsAngle(float angle) {
    leftLegAngle = angle;
    rightLegAngle = angle;
  }
  public void setSmile(boolean value) {
    smile = value;
  }
  public void toggleSmile() {
    smile = !smile;
  }
  public void nod() {
    nodSequence.start();
  }
}

