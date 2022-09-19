//https://github.com/akhil-code/flappy-bird-neuro-evolution/issues/1
PImage hintergrund;
//https://www.pngwing.com/en/search?q=Flappy+Bird
PImage vogel;
PImage rohr; 
//FlappyBrid logo: https://www.pngfind.com/mpng/iRJiJTw_3676-x-976-16-0-flappy-bird-logo/ (+ hintergrund)
PImage startSeite;

// Play true oder false
int startSpiel = 1;
//score
int score = 0;
//hintergrund
int x;
//vogelkoordinaten
int vogelY ;
//vogelgeschwindigkeit
int speed = 0;
//Rohre
// Warum 2? Auf dem Bildschirm sieht man immer nur zwei Rohre gleichzeitig
int rohrX[] = new int[2];
int rohrY[] =new int[2];
void setup() {
  hintergrund =loadImage("background.png");
  vogel =loadImage("vogel.png");
  rohr =loadImage("rohr.png");
  startSeite=loadImage("startSeite.png");

  //Fenstergröße
  size(600, 800);

  //Textfarbe + größe
  fill(0);
  textSize(20);
}

void draw() { 
  //Hintergrund
  if (startSpiel == 0) {
    imageMode(CORNER);
    image(hintergrund, x, 0);
    image(hintergrund, x+hintergrund.width, 0);
    //Bewegt sich immer nach links
    x -= 5;
    if (x == -1800) {
      x = 0;
    }

    //vogel Bewegung
    imageMode(CENTER);
    image(vogel, width/2, vogelY);
    speed += 1;
    vogelY += speed;
    // i<2, weil es 2 Rohre gibt
    for (int i = 0; i < 2; i++) {
      imageMode(CENTER);
      //oben
      // -(rohr.height/2+100) und + (rohr.height/2+100) damit es ein Abstand von 200 Pixeln gibt.
      image(rohr, rohrX[i], rohrY[i] - (rohr.height/2+100));
      //unten
      image(rohr, rohrX[i], rohrY[i] + (rohr.height/2+100));


      // Rohre bewegen sich immer nach links
      rohrX[i] -= 6;
      //Und wenn dann ein Rohr zu weit links ist, geht es einfach nach rechts zurück.2 neue Rohre werden gezeichnet
      if (rohrX[i] < 0) {
        rohrY[i] = (int)random(200, height-200);
        rohrX[i] = width;
      }
      //score
      //Es sieht so aus, als wäre der Vogel durch die Rohre gegangen.
      if (rohrX[i] == width/2) {
        score++;
      }
      //Kollision
      //(vogelY>height||vogelY<0 = Vogel ist nicht mehr auf dem Bildschirm
      // abs = abstand
      //abs(width/2-rohrX[i])<25 = wenn width/2(wo der Vogel ist) - rohrX[i] kleiner als 25 ist und
      // wenn vogelY - rohrY[i] > 100 ist dann ist startspiel wieder 1.
      // Quelle: https://www.ktbyte.com/resources/dist/assets/processing/sketches/crappierbird.pde
      if (vogelY>height||vogelY<0||(abs(width/2-rohrX[i])<25 && abs(vogelY-rohrY[i])>100)) { 
        startSpiel=1;
      }
    }


    text(score, width/2, 20);
  } else {
    imageMode(CENTER);
    image(startSeite, width/2, height/2);
  }
}
void mousePressed() {
  speed = -15;
  if (startSpiel==1) {
    rohrX[0] = 600;
    rohrY[0] = vogelY = height/2;
    rohrX[1] = 900;
    rohrY[1] = 600;
    // alles ist gleich 0
    x = 0;
    startSpiel = 0;
    score = 0;
  }
}
