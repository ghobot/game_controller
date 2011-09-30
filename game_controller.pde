/*   
 *	ITP September 2011
 *	Understanding Networks 
 *	Pong game controller 
 *	
 *	using the Android SDK and my HTC shift, i want to control the pong game using the d pad
 *	
 *	
 *	*/

import processing.net.*;

Client c;
int data[]; 
PFont font; 

//String input;

//String ipAddress = "128.122.151.161"; //pong server IP
//int port = 8080;

boolean drawUp, drawDown, drawLeft, drawRight, hasConnected, hasDisconnected, isConnected, drawConnect, drawDisconnect; //booleans to draw text to the video screen

void setup () {
  smooth();	
  size(screenWidth, screenHeight);
  //size(400,400); //for testing locally
  //orientation(PORTRAIT); // makes it possible to lock orientation	
  drawUp = false; //booleans that trigger if image is drawn to the screen	
  drawDown = false;
  drawLeft = false;
  drawRight = false;
  drawConnect = false;
  drawDisconnect = false;	
  hasConnected = false; //boolean to say if something is connected, us this to give status signal of connect
  hasDisconnected = false;  //boolean to say if something is connected, us this to give status signal of disconnection of socket
  isConnected = false; //boolean that controls status of connection
  // The font must be located in the sketch's 
  // "data" directory to load successfully if it is not called from the computer

  String[] fonts = PFont.list(); //call all the fonts and use the first one
  //println(fonts);
  font = createFont(fonts[0], 60);
  
  textFont(font, 18); 
  textAlign(CENTER);
  String directions = "Press 'c' to connect to server \n Press 'd' to disconnect from server. "; 
  fill(255);
  text(directions, width/2-1, height/2+1);
  fill(0);
  text(directions, width/2, height/2);
}

void draw() {

  /*Client thisClient = myServer.available();
   if (thisClient != null) {
   
   	// Receive data from server
   	  if (thisClient.available() > 0) {
   	    input = thisClient.readString();
   	    input = input.substring(0, input.indexOf("\n")); // Only up to the newline
   	    data = int(split(input, ' ')); // Split values into an array
   }*/
  if (hasConnected) {        	
    isConnected = true;
    hasDisconnected = false;	
    drawConnect();
  }

  if (hasDisconnected) {
    drawDisconnect();
    hasConnected = false;
    isConnected = false;
  }
  //println ("Server Is Disconnected = "+ " "+hasDisconnected);
  //println ("Server Is connected = "+ " "+hasConnected);

  if (drawDisconnect) {
  }

  if (drawUp) {
    background(0);	
    fill(255);
    textAlign(CENTER);
    textFont(font, 60);
    text("UP", width/2, height/2);
  }	

  if (drawDown) {
    background(255);	
    fill(0);
    textAlign(CENTER);
    textFont(font, 60);
    text("DOWN", width/2, height/2);
  }	

  if (drawRight) {
    background(255, 0, 0);	
    fill(255);
    textAlign(CENTER);
    textFont(font, 60);
    text("RIGHT", width/2, height/2);
  }	

  if (drawLeft) {
    background(0, 0, 255);	
    fill(255);
    textAlign(CENTER);
    textFont(font, 60);
    text("LEFT", width/2, height/2);
  }	


  // these two write the word connected or disconnected to the bottom of the screen to let us know if the computer is connected to the server
  if (isConnected == true && hasConnected==true) {
    textFont(font, 16);
    textAlign(RIGHT);
    fill(0, 255, 0);
    text("CONNECTED", width-5, height-5);
  }

  if (hasDisconnected == true && isConnected == false) {
    textFont(font, 16);
    textAlign(RIGHT);
    fill(0);
    text("DISCONNECTED", width-5, height-5);
    fill(255, 0, 0);
    text("DISCONNECTED", width-6, height-6);
  }

  //println ("drawConnect = "+ drawConnect);
}

void drawConnect () { //function that draws the connect condition to the screen.

  background (255, 255, 0);
  fill(255, 0, 0);
  textAlign(CENTER);
  textFont(font, 60);
  text("CONNECTED", width/2, height/2);
}

void drawDisconnect () {
  background(0);
  fill(255);
  textFont(font, 60);
  textAlign(CENTER);
  text("DISCONNECTED", width/2, height/2);
}

void keyPressed() {

  if (key == CODED) {
    //if (keyCode == DPAD) {
    // user pressed the center button on the d-pad
    //} else 

    if (keyCode == UP) {
      // user triggered 'up' on the d-pad
      drawUp = true;		
      drawDown = false; 
      drawLeft = false;
      drawRight = false;
      drawConnect = false;
      drawDisconnect = false;		
      println("u"); 
      //println("drawConnect ="+" "+ drawConnect );
      c.write("uuu" + "\n"); //to send to server
    } 
    else if (keyCode == DOWN) {
      // user triggered 'down' on the d-pad
      drawDown = true;
      drawUp = false; 
      drawLeft = false;
      drawRight = false;
      drawConnect = false;
      drawDisconnect = false;
      println("d"); 
      c.write("ddd" + "\n"); //to send to server
    } 
    else if (keyCode == LEFT) {
      // user triggered 'left' on the d-pad
      drawLeft = true;
      drawDown = false; 
      drawUp = false;
      drawRight = false;
      drawConnect = false;
      drawDisconnect = false;
      println("l"); 
      c.write("l" + "\n"); //to send to server
    } 
    else if (keyCode == RIGHT) {
      // user triggered 'right' on the d-pad
      drawRight = true;
      drawDown = false; 
      drawLeft = false;
      drawUp = false;
      drawConnect = false;
      drawDisconnect = false;
      println ("r");
      c.write("r" + "\n"); //to send to server
    }
  }

  if (key == 'c') { //connect socket
    println("Connect");	
    // Connect to the server's IP address and port
    c = new Client(this, "128.122.151.161", 8080); // Replace with your server's IP and port
//    c.write("ping 192.168.7.180 -c 1");
//                     if (c.available() > 0) {
//    	   String input = c.readString();
//    	    input = input.substring(0, input.indexOf("\n")); // Only up to the newline
//    	    data = int(split(input, ' ')); // Split values into an array
//            print (data);
//               
//              }
   
    hasConnected = true;
    isConnected = true;
    drawConnect = true;
    drawDisconnect = false;
  } 

  if (key == 'd') { //disconnect socket
    println("Disconnect");	
    c.write("x" + "\n"); 
    c.stop();
    hasDisconnected = true;
    hasConnected = false;
    isConnected = false; 
    drawDisconnect = true;
  } 

  if (key == 'i') { //write IP over paddle
    println("IP");	
    c.write("i" + "\n");
  }
}

