 import ddf.minim.*;
    
    int rectX, rectY;      // Position of square button
    int circleX, circleY;  // Position of circle button
    int rectSize = 500;     // Diameter of rect
    int circleSize = 500;   // Diameter of circle
    color rectColor, circleColor, baseColor;
    color rectHighlight, circleHighlight;
    color currentColor;
    boolean rectOver = false;
    boolean circleOver = false;
    boolean showimage;
    boolean showimage2;
    int algo;
    PImage img;
    PImage img3;
    PImage img1;
    PImage img2;   
    PImage img4; 
    PImage img6;
    int imgX, imgY, img1X, img1Y, img2X, img2Y;
    
    Minim soundengine;
    String [] cancion = {"Introducción.mp3","Devolverse a donde el viejo.mp3","Elige pica.mp3","Ayudar al perro.mp3",
                         "No ayudar al perro.mp3", "Elige pala.mp3","Ayudar niña.mp3","No ayudar niña.mp3",
                         "Escena Correr.mp3", "Escena Escudo.mp3", 
                          "Ayudar a la mujer.mp3","No ayuda mujer.mp3", "Escenaarma.mp3","ayudar gato.mp3",
                         "noayudargato.mp3","escena puerta y final.mp3"};
   
    void setup() {
      background(255,255,255);
      showimage = true;
      showimage2 = true;
      algo = 8;
      soundengine = new Minim(this);
      size(displayWidth, displayHeight);
      rectColor = color(0);
      rectHighlight = color(204);
      circleColor = color(0);
      circleHighlight = color(204);
      baseColor = color(102);
      currentColor = baseColor;
      circleX = width/2+circleSize/2+100;
      circleY = height/2-100;
      rectX = width/2-circleSize/2-100;
      rectY = height/2-100;
      img1X = width;
      img1Y = height;
      imgX = width/2+circleSize/2 - 150;
      imgY = height/2-circleSize/2 - 100;
      img2X = width/2-circleSize/2-340;
      img2Y = height/2-circleSize/2 - 90;
      ellipseMode(CENTER);
      img = loadImage("circulo.png");
      img3 = loadImage("circulo2.png");
      img1 = loadImage("inicio.jpg");
      img2 = loadImage("final.jpg");
      img4 = loadImage("boton.png");
      img6 = loadImage("tryagain.png");
    }
    
    void draw() {
 
      update(mouseX, mouseY);
      if (rectOver) {
        fill(rectHighlight);
      } else {
        fill(rectColor);
      }
   
      stroke(0);
      ellipse(rectX+10, rectY+5, circleSize, circleSize);
      image(img3, img2X, img2Y, circleSize, circleSize);
      
      if (circleOver) {
        fill(circleHighlight);
      } else {
        fill(circleColor);
      }
      stroke(0);
      ellipse(circleX, circleY, circleSize, circleSize);
      image(img, imgX, imgY, circleSize, circleSize);
      
      
    if(!showimage && showimage2)
    {
        image(img2, 0, 0, img1X, img1Y);
        image(img6, width/2-150, height/2+50, 300,300);
    }
      if(showimage)
    {
        image(img1, 0, 0, img1X, img1Y);
        image(img4, width/2-150, height/2-100, 300,300);
    }
    }
    
    void update(int x, int y) {
      if ( overCircle(circleX, circleY, circleSize) ) {
        circleOver = true;
        rectOver = false;
      } else if ( overRect(rectX, rectY, rectSize) ) {
        rectOver = true;
        circleOver = false;
      } else {
        circleOver = rectOver = false;
      }
    }
    
    void mousePressed() {
      
       if (circleOver && algo == 0) {
          algo++;
          currentColor = circleColor;
          soundengine.stop();
          soundengine.loadSample(cancion[algo], 1024).trigger();
          
        }
        else if (rectOver && algo == 0) {
          algo--;
          currentColor = circleColor;
          soundengine.stop();
          soundengine.loadSample(cancion[abs(algo)+7], 1024).trigger();
        }
        else if (rectOver && algo == -1){
          algo--;
          currentColor = circleColor;
          soundengine.stop();
          soundengine.loadSample(cancion[abs(algo)+7], 1024).trigger();
        }
        else if (circleOver && algo == -1){
          algo=algo-4;
          currentColor = circleColor;
          soundengine.stop();
          soundengine.loadSample(cancion[abs(algo)+7], 1024).trigger();
        }
        else if (algo == -2 || algo == -5){
          if (rectOver)
          {
            algo--;
            currentColor = circleColor;
            soundengine.stop();
            soundengine.loadSample(cancion[abs(algo)+7], 1024).trigger();
          }
          else if (circleOver)
          {
            algo = algo - 2;
            currentColor = circleColor;
            soundengine.stop();
            soundengine.loadSample(cancion[abs(algo)+7], 1024).trigger();
          }
        }
        
       //final
        else if (abs(algo) == 3 || abs(algo) == 4 || abs(algo) == 6 ||abs(algo) == 7){
            algo = 10;
            currentColor = circleColor;
            soundengine.stop();
            soundengine.loadSample(cancion[15], 1024).trigger();
            
             fill(0, 102, 153);
            textSize(200);
            text("word", width/2-150, height/2-100); 
           
            background(0);
            
            showimage2 = true;
            image(img2, 0, 0, img1X, img1Y);
            background(0);
          
           
        }
        
        //Inicio
        else if (algo == 8){
            currentColor = circleColor;
                background(0);    
            soundengine.stop();
            algo = 0;
            soundengine.loadSample(cancion[algo], 1024).trigger();
          
            showimage = false;
            image(img1, 0, 0, 0, 0);
            
            showimage2 = false;
            image(img2, 0, 0, 0, 0);
        }
      
       //Reinicio
      else if(algo == 10)
      {
        algo = 8;
        soundengine.stop();
        background(255,255,0);
        showimage2 = false;
        image(img2, 0, 0, 0, 0);
        showimage = true;
        image(img1, 0, 0, img1X, img1Y);
        image(img4, width/2-150, height/2-100, 300,300);
      }
        
        else if (rectOver && algo == 1){
          algo++;
          currentColor = circleColor;
          soundengine.stop();
          soundengine.loadSample(cancion[abs(algo)], 1024).trigger();
        }
        else if (circleOver && algo == 1){
          algo=algo+4;
          currentColor = circleColor;
          soundengine.stop();
          soundengine.loadSample(cancion[abs(algo)], 1024).trigger();
        }
        else if (algo == 2 || algo == 5){
          if (rectOver)
          {
            algo++;
            currentColor = circleColor;
            soundengine.stop();
            soundengine.loadSample(cancion[abs(algo)], 1024).trigger();
          }
          else if (circleOver)
          {
            algo = algo + 2;
            currentColor = circleColor;
            soundengine.stop();
            soundengine.loadSample(cancion[abs(algo)], 1024).trigger();
          }
        }
    }
    
    boolean overRect(int x, int y, int diameter)  {
      float disX = x - mouseX;
      float disY = y - mouseY;
      if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
        return true;
      } else {
        return false;
      }
    }
    
    boolean overCircle(int x, int y, int diameter) {
      float disX = x - mouseX;
      float disY = y - mouseY;
      if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
        return true;
      } else {
        return false;
      }
    }
