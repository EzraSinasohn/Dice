int numDice = 20;
float diceSize = 80;
float rx, ry, changeX, changeY, oX, oY;
boolean stop;
Dice dice[];
Dice[] diceList = new Dice[numDice];
public class Dice {
  int id;
  float originX, originY, x, y, z, g, vx, vy, prevX, prevY;
  boolean spin = true, filler = false, rotate = true;
  public Dice(float originX, float originY, float x, float y, float z, float g, float vx, float vy, int id){
    this.originX = originX;
    this.originY = originY;
    this.x = x;
    this.y = y;
    this.z = 0.0;
    this.g = g;
    this.vx = vx;
    this.vy = vy;
    this.id = id;
    //this.spin = spin;
    //this.filler = filler;
  }
  void drawDice() {
    fill(255);
    box(diceSize, diceSize, diceSize);
    fill(0);
    pushMatrix();
    translate(0, 0, (diceSize/2)+1);
    ellipse(0, 0, (3*diceSize/16), (3*diceSize/16));
    popMatrix();
    pushMatrix();
    rotateY(PI/2);
    translate(0, 0, (diceSize/2)+1);
    ellipse(0, 0, (3*diceSize/16), (3*diceSize/16));
    ellipse((diceSize/4), (diceSize/4), (3*diceSize/16), (3*diceSize/16));
    ellipse(-(diceSize/4), -(diceSize/4), (3*diceSize/16), (3*diceSize/16));
    popMatrix();
    pushMatrix();
    rotateY(PI);
    translate(0, 0, (diceSize/2)+1);
    ellipse(-(diceSize/4), (diceSize/4), (3*diceSize/16), (3*diceSize/16));
    ellipse((diceSize/4), (diceSize/4), (3*diceSize/16), (3*diceSize/16));
    ellipse(-(diceSize/4), 0, (3*diceSize/16), (3*diceSize/16));
    ellipse((diceSize/4), 0, (3*diceSize/16), (3*diceSize/16));
    ellipse(-(diceSize/4), -(diceSize/4), (3*diceSize/16), (3*diceSize/16));
    ellipse((diceSize/4), -(diceSize/4), (3*diceSize/16), (3*diceSize/16));
    popMatrix();
    pushMatrix();
    rotateY(-PI/2);
    translate(0, 0, (diceSize/2)+1);
    ellipse(-(diceSize/4), (diceSize/4), (3*diceSize/16), (3*diceSize/16));
    ellipse((diceSize/4), (diceSize/4), (3*diceSize/16), (3*diceSize/16));
    ellipse(-(diceSize/4), -(diceSize/4), (3*diceSize/16), (3*diceSize/16));
    ellipse((diceSize/4), -(diceSize/4), (3*diceSize/16), (3*diceSize/16));
    popMatrix();
    pushMatrix();
    rotateX(PI/2);
    translate(0, 0, (diceSize/2)+1);
    ellipse(-(diceSize/4), (diceSize/4), (3*diceSize/16), (3*diceSize/16));
    ellipse((diceSize/4), (diceSize/4), (3*diceSize/16), (3*diceSize/16));
    ellipse(0, 0, (3*diceSize/16), (3*diceSize/16));
    ellipse(-(diceSize/4), -(diceSize/4), (3*diceSize/16), (3*diceSize/16));
    ellipse((diceSize/4), -(diceSize/4), (3*diceSize/16), (3*diceSize/16));
    popMatrix();
    pushMatrix();
    rotateX(-PI/2);
    translate(0, 0, (diceSize/2)+1);
    ellipse((diceSize/4), (diceSize/4), (3*diceSize/16), (3*diceSize/16));
    ellipse(-(diceSize/4), -(diceSize/4), (3*diceSize/16), (3*diceSize/16));
    popMatrix();
  }
  
  void moveDice(float moveX, float moveY) {
    this.originX = moveX;
    this.originY = moveY;
    translate(this.originX, this.originY);
    rotateX(this.x);
    rotateY(this.y);
    rotateZ(this.z);
  }
  
  void controlRotation() {
     if (!(mousePressed && (mouseButton == LEFT)) && !filler && !(Math.abs(this.vy) <= 1 && ((this.originY >= height-(diceSize+30)) || !rotate))) {
      this.x += 0.3/3;
      this.y += 0.1/3;
      this.z += 0.4/3;
    } else {
      if(this.x != 0) {
        this.x += ((Math.round(this.x/HALF_PI)*HALF_PI)-this.x)/5;
      }
      if(this.y != 0) {
        this.y += ((Math.round(this.y/HALF_PI)*HALF_PI)-this.y)/5;
      }
      if(this.z != 0) {
        this.z += ((Math.round(this.z/HALF_PI)*HALF_PI)-this.z)/5;
      }
    }
    if(this.x > 2*PI) {
      this.x -= 2*PI;
    }
    if(this.y > 2*PI) {
      this.y -= 2*PI;
    }
    if(this.z > 2*PI) {
      this.z -= 2*PI;
    }
  }
  
  void controlMove() {
    if (!(mousePressed && (mouseButton == LEFT)) && this.originY <= height-(diceSize+20)) {
      this.prevX = this.originX;
      this.prevY = this.originY;
      this.originY += this.vy;
      this.originX += this.vx;
      if (this.vy != 0 || originY <= height-(diceSize+30)) {
        this.vy += g;
      }
    }
    if(!(mousePressed && (mouseButton == LEFT))){
      if(originY > height-(diceSize+20)) {
       originY = height-(diceSize+20);
       this.vy *= -0.5;
      }
      if(originY >= height-(diceSize+30)) {
       this.vx *= 0.9;
      }
      if(originX > width-(diceSize/2)) {
        originX = width-(diceSize/2);
        this.vx *= -0.5;
      } else if(originX < (diceSize/2)) {
        originX = (diceSize/2);
        this.vx *= -0.5;
      }
      if(Math.abs(this.vy) <= 1 && originY >= height-(diceSize+30)) {
       this.vy = 0;
       this.vx *= 0.8;
      }
    }
    if(vy > 30) {vy = 30;}
    moveDice(this.originX, this.originY);
    collision();
  }
  /*void drawTrail() {
    stroke(255, 255, 255, 100);
    strokeWeight(10);
    pushMatrix();
    line(this.prevX*100, this.prevY*100, this.originX, this.originY);
    popMatrix();
    stroke(0);
    strokeWeight(1);
  }*/
  void drawShadow() {
    strokeWeight(1);
    noStroke();
    fill(100);
    pushMatrix();
    translate(this.originX, height-(5*diceSize/8), height-(15*diceSize/4));
    rotateX(-HALF_PI);
    if(originY > 50) {
      ellipse(0, height-(15*diceSize/4), this.originY/(height/(15*diceSize/8)), this.originY/(height/(15*diceSize/8)));
    } else {
      ellipse(0, height-(15*diceSize/4), 50/3, 50/3);
    }
    popMatrix();
    stroke(0);
  }
  
  void diceBuild() {
    drawShadow();
    pushMatrix();
    controlMove();
    controlRotation();
    drawDice();
    popMatrix();
  }
  
  void randomBoost() {
    this.vx = (float) (Math.random()*60-30);
    this.vy = (float) (Math.random()*-10-15); 
  }
  
  void collision() {
   int underCount = 0;
   for(int i = 0; i < numDice; i++) {
     if(i != this.id) {
       if(Math.abs(this.originX-diceList[i].originX) <= diceSize && this.originY <= diceList[i].originY) {underCount++;}
       if(Math.abs(this.originX-diceList[i].originX) <= diceSize && Math.abs(this.originY-diceList[i].originY) <= diceSize) {
         if(Math.abs(this.originX-diceList[i].originX) > Math.abs(this.originY-diceList[i].originY)) {
           if(this.originX > diceList[i].originX) {
             this.originX = diceList[i].originX + diceSize;
           } else {
             this.originX = diceList[i].originX - diceSize;
           }
         } else {
           if(this.originY > diceList[i].originY) {
             this.originY = diceList[i].originY + diceSize;
           } else {
             this.originY = diceList[i].originY - diceSize;
           }
         }
         if(Math.abs(this.originY-diceList[i].originY) <= diceSize && Math.abs(this.originY-diceList[i].originY) < Math.abs(this.originX-diceList[i].originX)) {this.vx = -(this.vx+diceList[i].vx)/2;}
         if(Math.abs(this.originX-diceList[i].originX) <= diceSize && !(this.originY > diceList[i].originY && this.originY > (height-110+(underCount*diceSize))) && Math.abs(this.originX-diceList[i].originX) < Math.abs(this.originY-diceList[i].originY)) {
           this.vy = -(this.vy+diceList[i].vy)/2;
           this.vx *= 0.9;
     }
     if(Math.abs(this.originX-diceList[i].originX) <= diceSize && Math.abs(this.originY-diceList[i].originY) <= diceSize && (this.originY < diceList[i].originY)) {
       if(Math.abs(this.vy) <= 2) {
         this.vy = 0;
         rotate = false;
     } else {
         rotate = true;
     }
   }
   }
  }
}
}
}
/*void mouseDragged() 
{
  stop = true;
  oX = mouseX;
  if(mouseY <= height-100) {
    oY = mouseY;
  }
  redraw();
  dice.moveDice(oX, oY);
}

void mouseReleased() {
  dice.vx = (mouseX - pmouseX)/2;
  dice.vy = (mouseY - pmouseY)/2;
}*/
void setup() {
  size(1500, 1200, P3D);
  loop();
  for(int i = 0; i < numDice; i++) {diceList[i] = new Dice((int) (Math.random()*width), (int) (
    Math.random()*(height-110)), (float) (Math.random()*2*PI), (float) (Math.random()*2*PI), (float) (Math.random()*2*PI), 0.5, 0, 0, i);
    diceList[i].randomBoost();
  }
}


void draw() {
  background(100);
  drawFloor();
  for(int i = 0; i < numDice; i++) {diceList[i].diceBuild();}
}

void drawFloor() {
    fill(200);
    strokeWeight(3);
    pushMatrix();
    translate(width/2, height);
    box(width*2, 60, diceSize*5);
    popMatrix();
  }
  
  
void keyPressed() {
  if(key == ' ') {
    for(int i = 0; i < numDice; i++) {diceList[i].randomBoost();}
  }
}


