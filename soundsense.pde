import ddf.minim.*;
import ddf.minim.analysis.*;
import javax.sound.sampled.*;

public class SoundSense implements AudioListener {
  Minim minim;
  BeatDetect nodBeat, jumpBeat, cheerBeat; 
  AudioInput in;
  int bufferSize, sampleRate;
  int nodSensitivity, jumpSensitivity, cheerSensitivity;
  float smileThreshold;
  boolean _jump, _nod, _cheer;
  boolean jump, nod, cheer;
  boolean smile;
  boolean printFreqInfo;
  
  SoundSense(int mixerId)
  {
    jump = nod = smile = cheer = true;
    _jump = _nod = _cheer = false;
    printFreqInfo = false;
    bufferSize = 1024;
    sampleRate = 44100;
    smileThreshold = 0.001;
    nodSensitivity = 50;
    jumpSensitivity = 500;
    cheerSensitivity = 1500;
    
    minim = new Minim(this);
    
    if (mixerId != -1) {
      Mixer.Info[] mixerInfo = AudioSystem.getMixerInfo();
      Mixer mixer = AudioSystem.getMixer(mixerInfo[mixerId]);
      minim.setInputMixer(mixer);
    }
    
    in = minim.getLineIn(Minim.STEREO, bufferSize, sampleRate);
    in.disableMonitoring();
    
    in.addListener(this);
    
    nodBeat = new BeatDetect();
    jumpBeat = new BeatDetect(in.bufferSize(), in.sampleRate());
    cheerBeat = new BeatDetect(in.bufferSize(), in.sampleRate());
    
    nodBeat.setSensitivity(nodSensitivity);
    jumpBeat.setSensitivity(jumpSensitivity);
    cheerBeat.setSensitivity(cheerSensitivity);
  }
  
  private void printFreqDetect() {
    String str = "";
    for (int i = 0; i < jumpBeat.dectectSize(); ++i) {
      if (jumpBeat.isRange(i,i,1)) {
        str = str + "#";
      } else {
        str = str + "_";
      }
    }
    str = str + 
     " " + in.mix.level();
    println(str);
  }
  
  private void sensing() {
    nodBeat.detect(in.mix);
    jumpBeat.detect(in.mix);
    cheerBeat.detect(in.mix);
    
    if ( nodBeat.isOnset() ) {
      _nod = true;
    }
    
    if ( jumpBeat.isRange(1,10,6) ) {
     _jump = true;
    }
   
   if ( cheerBeat.isRange(13,24,6) ) {
     _cheer = true;
   }
   
   if ( printFreqInfo ) {
     printFreqDetect();
   }
  }
  
  synchronized void samples(float[] samples) {
    sensing();
  }
  
  synchronized void samples(float[] samplesLeft, float[] samplesRight) {
    sensing();
  }
  
  public void sense(Puppet puppet) {
    if ( jump && _jump ) {
      puppet.jump();
    }
    
    if ( nod && _nod ) {
      puppet.nod();
    } 
    if ( cheer && _cheer ) {
      puppet.moveArms(PI*4/6);
    } 
    
    if ( smile && in.mix.level() > smileThreshold ){
      puppet.setSmile ( true );
    } else {
      puppet.setSmile ( false );
    }
    
    _jump = _nod = _cheer = false;
  }
  
  synchronized void draw() {
  }
  
  public void setAllOn() {
    jump = nod = smile = cheer = true;
  }
  
  public void setAllOff() {
    jump = nod = smile = cheer = false;
  }
  
  public void toggleJumping() {
    jump = !jump;
  }
  
  public void toggleCheering() {
    cheer = !cheer;
  }
  
  public void toggleNodding() {
    nod = !nod;
  }
  
  public void toggleSmiling() {
    smile = !smile;
  }
  
  public void togglePrintFreqInfo() {
    printFreqInfo = !printFreqInfo;
  }
  
  public void printInfo() {
    for (int i = 0; i <= jumpBeat.dectectSize(); ++i) {
      println("Band " + i + ": " + jumpBeat.getDetectCenterFrequency (i));
    }
    for (int i=0; i < AudioSystem.getMixerInfo().length; ++i) {
      println ("Mixer " + i + ": " + AudioSystem.getMixerInfo()[i].getName());
    }
  }
}
