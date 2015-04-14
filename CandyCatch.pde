//APWIDGETS

import apwidgets.*;
APMediaPlayer player;

import ketai.sensors.*;

KetaiSensor sensor;
float accelerometerX, accelerometerY, accelerometerZ;

float horizontalMap;
float verticalMap;
float colorMap;

float ReverseHorizontalMap;
//1280:800 = resolution of the tablet

PImage GingerbreadMan;
PImage Candy1;
PImage Candy2;
PImage Candy3;
PImage Spider;
PImage ScarySpider;
PImage Spiderweb;
PImage Win;
PImage Lose;

float xSS;
float ySS;

PImage Background;
float yBackground1;
float yBackground2;

PFont Font;
int point;
int speed;
int speedB;

float[] xCandy1 = new float[2];
float[] yCandy1 = new float[2];
float[] xCandy2 = new float[2];
float[] yCandy2 = new float[2];
float[] xCandy3 = new float[2];
float[] yCandy3 = new float[2];

float[] xSpider = new float[3];
float[] ySpider = new float[3];
float[] xSpiderweb = new float[3];
float[] ySpiderweb = new float[3];

boolean start=false;
boolean win=false;
boolean lose=false;

void setup()
{
  sensor = new KetaiSensor(this);
  sensor.start();
  orientation(PORTRAIT);
  imageMode(CENTER);
  textSize(36);

  Background=loadImage("Background.png");

  GingerbreadMan=loadImage("GingerbreadMan.png");
  Candy1=loadImage("Candy1.png");
  Candy2=loadImage("Candy2.png");
  Candy3=loadImage("Candy3.png");
  Spider=loadImage("Spider.png");
  ScarySpider=loadImage("ScarySpider.png");
  Spiderweb=loadImage("Spiderweb.png");
  Win=loadImage("Win.jpg");
  Lose=loadImage("Lose.jpg");

  Font=loadFont("Noteworthy-Bold-48.vlw");

  speed=10;
  speedB=8;
  yBackground1=height/2;
  yBackground2=height/2-height;
  ySS=-2000;

  for (int C1=0; C1<2; C1++) {
    xCandy1[C1]=random(-200, width-310);
    yCandy1[C1]=random(-500, 0);
  }
  for (int C2=0; C2<2; C2++) {
    xCandy2[C2]=random(-200, width-310);
    yCandy2[C2]=random(-500, 0);
  }
  for (int C3=0; C3<2; C3++) {
    xCandy3[C3]=random(-200, width-310);
    yCandy3[C3]=random(-500, 0);
  }
  for (int S=0; S<3; S++) {
    xSpider[S]=random(45, width-45);
    ySpider[S]=random(-500, 0);
  }
  for (int SW=0; SW<3; SW++) {
    xSpiderweb[SW]=random(45, width-45);
    ySpiderweb[SW]=random(-500, 0);
  }

  player = new APMediaPlayer(this);
  player.setMediaFile("JingleBellRock.mp3");
  player.setLooping(true);
}

void draw()
{
  if (start==false && win==false && lose==false) {
    image(Background, width/2, height/2, width, height);
    image(Candy1, 165, 170, 110, 90);
    image(Candy2, 165, 320, 100, 100);
    image(Candy3, 165, 480, 100, 100);
    image(ScarySpider, 510, 170, 90, 90);
    image(Spider, 510, 320, 90, 90);
    image(Spiderweb, 510, 480, 90, 90);

    pushStyle();
    textFont(Font, 70);
    fill(0);
    text("= 3", 235, 200);
    text("= 2", 235, 350);
    text("= 1", 235, 510);
    text("= -3", 580, 200);
    text("= -1", 580, 350);
    text("= -1", 580, 510);
    popStyle();

    pushStyle();
    textFont(Font, 90);
    textAlign(CENTER);
    fill(0);
    text("Let's collect", width/2, 700);
    text("100 candies!", width/2, 800);
    popStyle();

    pushStyle();
    textFont(Font, 33);    
    textAlign(CENTER);
    fill(random(150));
    text("TAP to BEGIN", width/2, 850);
    popStyle();

    if (mousePressed==true) {
      start=true;
      win=false;
      lose=false;
      player.start();
    }
  }

  if (start==true && win==false && lose==false) {
    eventGame();
  }

  if (point>=101) {
    start=false;
    win=true;
    lose=false;
  }
  if (start==false && win==true && lose==false) {
    image(Win, width/2, height/2, width, height);
    image(GingerbreadMan, width/2, 420, 300, 300);
    pushStyle();
    textFont(Font, 100);
    textAlign(CENTER);
    fill(0);
    text("Good job!!", width/2, 750);
    popStyle();
  }

  if (point<=-6) {
    start=false;
    win=false;
    lose=true;
  }
  if (start==false && win==false && lose==true) {
    image(Lose, width/2, height/2, width, height);
    image(ScarySpider, width/2, 420, 300, 300);
    pushStyle();
    textFont(Font, 80);
    textAlign(CENTER);
    fill(0);
    text("Spiders ate all", width/2, 700);
    text("your candies . . .", width/2, 790);
    popStyle();
  }
}

void eventGame()
{
  horizontalMap=map(accelerometerX, -10, 10, width, 0);
  verticalMap=map(accelerometerY, -10, 10, height/2+200, height/2+300);
  colorMap=map(accelerometerZ, -10, 10, 0, 255);

  ReverseHorizontalMap=map(accelerometerX, -10, 10, 0, width);

  image(Background, width/2, yBackground1, width, height);
  image(Background, width/2, yBackground2, width, height);

  yBackground1+=speedB;
  yBackground2+=speedB;

  if (yBackground1>height/2+height) {
    yBackground1=yBackground2-height;
  }
  if (yBackground2>height/2+height) {
    yBackground2=yBackground1-height;
  }

  pushStyle();
  textFont(Font, 75);
  fill(0);
  text("Candy: "+point, 30, 100);
  popStyle();
  pushStyle();
  textFont(Font, 35);
  fill(0);
  text("Speed: "+speed, 30, 160);
  popStyle();

  image(ScarySpider, ReverseHorizontalMap, ySS, 150, 150);
  ySS+=10+speed;

  if (ySS>height+2000) {
    ySS=random(-2000, 0);
  }

  if (horizontalMap-75<=ReverseHorizontalMap+75 && horizontalMap+75>=ReverseHorizontalMap-75 && verticalMap-75<=ySS+75 && verticalMap+75>=ySS-75) {
    ySS=-2000;
    point-=3;
    speed+=3;
    speedB+=3;
  }

  for (int C1=0; C1<2; C1++) {
    image(Candy1, ReverseHorizontalMap+xCandy1[C1], yCandy1[C1], 110, 90);
    yCandy1[C1]+=speed;

    if (yCandy1[C1]>height+45) {
      yCandy1[C1]=random(-500, 0);
    }

    if (horizontalMap-75<=ReverseHorizontalMap+xCandy1[C1]+55 && horizontalMap+75>=ReverseHorizontalMap+xCandy1[C1]-55 && verticalMap-75<=yCandy1[C1]+45 && verticalMap+75>=yCandy1[C1]-45) {
      yCandy1[C1]=random(-500, 0);
      point+=3;
      speed--;
      speedB--;
    }
  }

  for (int C2=0; C2<2; C2++) {
    image(Candy2, ReverseHorizontalMap+xCandy2[C2], yCandy2[C2], 100, 100);
    yCandy2[C2]+=speed;

    if (yCandy2[C2]>height+50) {
      yCandy2[C2]=random(-500, 0);
    }

    if (horizontalMap-75<=ReverseHorizontalMap+xCandy2[C2]+50 && horizontalMap+75>=ReverseHorizontalMap+xCandy2[C2]-50 && verticalMap-75<=yCandy2[C2]+50 && verticalMap+75>=yCandy2[C2]-50) {
      yCandy2[C2]=random(-500, 0);
      point+=2;
      speed--;
      speedB--;
    }
  }

  for (int C3=0; C3<2; C3++) {
    image(Candy3, ReverseHorizontalMap+xCandy3[C3], yCandy3[C3], 100, 100);
    yCandy3[C3]+=speed;

    if (yCandy3[C3]>height+50) {
      yCandy3[C3]=random(-500, 0);
    }

    if (horizontalMap-75<=ReverseHorizontalMap+xCandy3[C3]+50 && horizontalMap+75>=ReverseHorizontalMap+xCandy3[C3]-50 && verticalMap-75<=yCandy3[C3]+50 && verticalMap+75>=yCandy3[C3]-50) {
      yCandy3[C3]=random(-500, 0);
      point++;
      speed--;
      speedB--;
    }
  }

  for (int S=0; S<3; S++) {
    image(Spider, xSpider[S], ySpider[S], 90, 90);
    ySpider[S]+=speed;

    if (ySpider[S]>height+45) {
      ySpider[S]=random(-500, 0);
    }

    if (horizontalMap-75<=xSpider[S]+45 && horizontalMap+75>=xSpider[S]-45 && verticalMap-75<=ySpider[S]+45 && verticalMap+75>=ySpider[S]-45) {
      ySpider[S]=random(-500, 0);
      point--;
      speed+=2;
      speedB++;
    }
  }

  for (int SW=0; SW<3; SW++) {
    image(Spiderweb, xSpiderweb[SW], ySpiderweb[SW], 90, 90);
    ySpiderweb[SW]+=speed;

    if (ySpiderweb[SW]>height+45) {
      ySpiderweb[SW]=random(-500, 0);
    }

    if (horizontalMap-75<=xSpiderweb[SW]+45 && horizontalMap+75>=xSpiderweb[SW]-45 && verticalMap-75<=ySpiderweb[SW]+45 && verticalMap+75>=ySpiderweb[SW]-45) {
      ySpiderweb[SW]=random(-500, 0);
      point--;
      speed++;
      speedB++;
    }
  }

  if (speed<11) {
    speed=10;
  }
  if (speed>31) {
    speed=30;
  }
  if (speedB<11) {
    speedB=10;
  }
  if (speedB>31) {
    speedB=30;
  }

  image(GingerbreadMan, horizontalMap, verticalMap, 170, 170);
}

void onAccelerometerEvent(float x, float y, float z)
{
  accelerometerX = x;
  accelerometerY = y;
  accelerometerZ = z;
}

