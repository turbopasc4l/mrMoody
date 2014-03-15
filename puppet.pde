public class Puppet {
  PVector position;
  float trunkLength, armLength, legLength, neckLength, headDiameter;
  float trunkAngle, leftArmAngle, rightArmAngle, leftLegAngle, rightLegAngle, neckAngle;
  int lineWidth, smileWidth;
  color fillColor, lineColor;
  boolean smile;
  Puppet() {
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
    rotate(neckAngle);
    line(0, 0, 0, -neckLength);
    translate(0, -neckLength);
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
  public void reset() {
    trunkAngle = 0;
    leftArmAngle = PI/12;
    rightArmAngle = PI/12;
    leftLegAngle = PI/18;
    rightLegAngle = PI/18;
    neckAngle = 0;
    smile = false;
  }
  public void setArmsAngle(float angle) {
    leftArmAngle = angle;
    rightArmAngle = angle;
  }
  public void setLegsAngle(float angle) {
    leftLegAngle = angle;
    rightLegAngle = angle;
  }
  public void setSmile(boolean value) {
    smile = value;
  }
}

