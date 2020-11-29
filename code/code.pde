import processing.sound.*;
Amplitude amp;
AudioIn in;

String project_folder = "D:\\projet_personnage\\";
String prcharacter = "schopenhauer";
int fps; //do not touch, use setframerate;
float mouthoffset;
PImage Imgcharacter;
PImage Imgcharactermouth;

void setup() {
  
  fullScreen();
  setbackground("france");
  setbody("schopenhauer");
  setmouth("schopenhauer");
  
  setframerate(10);
  
  // Audio mode
  in = new AudioIn(this, 0);
  
  in.start();
  
  amp = new Amplitude(this);
  amp.input(in);

}

void draw() {
  
  mouthoffset = audiomap(amp.analyze());
  
  refreshbody();
  refreshmouth(mouthoffset);
  
  wait_framerate();
  
}



void setbackground(String background){
  
  PImage bckgrd = loadImage(project_folder + "background\\" + background + ".jpg");
  
  bckgrd.resize(width,height);
 
  background(bckgrd);
  
}
 
void setbody(String character){
   
  Imgcharacter = loadImage(project_folder + "personnage\\" + character + "\\body.png");
   
  float ratio = width/Imgcharacter.width;
   
   
  float imgheight = height;
  float imgwidth = Imgcharacter.width*ratio;
   
  Imgcharacter.resize((int)imgwidth,(int)imgheight);
   
  image(Imgcharacter,(width/2)-(Imgcharacter.width/2),0);
   
}

void setmouth(String character){
  
  Imgcharactermouth = loadImage(project_folder + "personnage\\" + character + "\\mouth.png");
  
  float ratio = width/Imgcharactermouth.width;
   
  float imgheight = height;
  float imgwidth = Imgcharactermouth.width*ratio;
   
  Imgcharactermouth.resize((int)imgwidth,(int)imgheight);
   
  image(Imgcharactermouth,(width/2)-(Imgcharactermouth.width/2),0);
  
}

void refreshbody(){
  
  image(Imgcharacter,(width/2)-(Imgcharacter.width/2),0);
  
}

void refreshmouth(float offset){
  
  image(Imgcharactermouth,(width/2)-(Imgcharactermouth.width/2),offset);
  
}

void setframerate(float frame){
  
  fps = (int)((1/frame)*1000);
  
}

void wait_framerate(){
 
  delay(fps);
  
}

float audiomap(float volume){
  
  float newvolume = map(volume,0,0.8,0,50);
  
  return newvolume;
  
}
