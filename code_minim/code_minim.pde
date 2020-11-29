import ddf.minim.*;
import ddf.minim.analysis.*;

String project_folder = "D:\\projet_personnage\\";

int fps; //do not touch, use setframerate;
float mouthoffset;
PImage Imgcharacter;
PImage Imgcharactermouth;
PImage bckgrd;

String characterBuffer[] = {"schopenhauer","schopenhauer","schopenhauer","schopenhauer"};
String skinBuffer[] = {"default","default","default","default"};

Minim minim;
AudioPlayer voice;
AudioPlayer song;
FFT fft;

void setup() {
  
  //sound processing setup
  minim = new Minim(this);
  
  voice = minim.loadFile(project_folder + "sound\\" + "vocal.wav");
  song = minim.loadFile(project_folder + "sound\\" + "music.wav");


  fft = new FFT(voice.bufferSize(), voice.sampleRate());
  
  fullScreen();
  setbackground("italy");
  setbody("schopenhauer","swag");
  setmouth("schopenhauer");
  
  setframerate(12);

}

void draw() {
  
  fft.forward(voice.mix);
  
  mouthoffset = audiomap(fft.calcAvg(100, 300));
  
  background(bckgrd);
  refreshbody();
  refreshmouth(mouthoffset);
  
  wait_framerate();
  
  noCursor();
  
}

void setbackground(String background){
  
  bckgrd = loadImage(project_folder + "background\\" + background + ".jpg");
  
  bckgrd.resize(width,height);
 
  background(bckgrd);
  
}
 
void setbody(String character, String skin){
   
  Imgcharacter = loadImage(project_folder + "personnage\\" + character + "\\" + skin + ".png");
   
  float ratio = width/Imgcharacter.width;
   
   
  float imgheight = height;
  float imgwidth = Imgcharacter.width*ratio;
   
  Imgcharacter.resize((int)imgwidth,(int)imgheight);
   
}

void setmouth(String character){
  
  Imgcharactermouth = loadImage(project_folder + "personnage\\" + character + "\\mouth.png");
  
  float ratio = width/Imgcharactermouth.width;
   
  float imgheight = height;
  float imgwidth = Imgcharactermouth.width*ratio;
   
  Imgcharactermouth.resize((int)imgwidth,(int)imgheight);
  
}

void refreshbody(){
  
  image(Imgcharacter,(width/2)-(Imgcharacter.width/2)+(mouseX-(width/2)),mouseY-(height/2));
  
}

void refreshmouth(float offset){
  
  image(Imgcharactermouth,(width/2)-(Imgcharactermouth.width/2)+(mouseX-(width/2)),offset+(mouseY-(height/2)));
  
}

void setframerate(float frame){
  
  fps = (int)((1/frame)*1000);
  
}

void wait_framerate(){
 
  delay(fps);
  
}

float audiomap(float volume){
  
  float newvolume = map(volume,0,60,0,50);
  
  return newvolume;
  
}

void mousePressed() {
  if(mouseButton == LEFT){

    voice.play(0);
    song.play(0);
    voice.mute();
    
  }else if(mouseButton == RIGHT){
    
  setbody("schopenhauer","default");
    
  }
}
