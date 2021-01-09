PImage Charfrwd,Charleft,Charright,GameOver,Opening;
PShape coin1,coin2,coin3;
PFont font,font2;

float x = 0,y = 0;
int i,o;
int z = 0,Cy1 = 0,Cy2 =- 200,Cy3 =- 400,Cx1 = 175,Cx2 = 375,Cx3 = 575;

boolean left , right;
player surfer;

Timer startTimer;
int Time;

///////////////////////////////////////////////////

//Random Coin spawn lane
int Random() {
	int T = int(random(0,3));
	if (T == 1) {
		return 175;
	}
	else if (T == 2) {
		return 375;
	}
	else return 575;
}

void setup() {
	size(800,800);
	surfer = new player(375, 640);   //Surfer start location
	smooth()
	coin1 = loadShape("coin.svg");
	coin2 = loadShape("coin.svg");
	coin3 = loadShape("coin.svg");
	
	Charfrwd = loadImage("character_Frwd.png");
	Charleft = loadImage("character_left.png");
	Charright = loadImage("character_right.png");
	
	Opening = loadImage("Opening.png");  //Start screen                       
	GameOver = loadImage("over.jpg");    // End screen
	
	coin1.scale(1.3);                  
	coin2.scale(1.3);
	coin3.scale(1.3);
	
	
	font = loadFont("Calibri-48.vlw");            //Score-timer font
	font2 = loadFont("AbdoMaster-Black-48.vlw");  //Start-End background font
	
	textFont(font);
	
	startTimer = new Timer(16);
}

void draw() {

	/**********************************************/
  	// Open Screen Section
	if (int(startTimer.getTime())>15)	{

		image(Opening,0,0);

		textFont(font2);

		textSize(50);

		fill(0);
		text("Press ENTER To start",20,280,800,800);

		fill(255,217,73);
		text("Press ENTER To start",25,285,800,800);

		if (keyCode == ENTER) {
			startTimer.countDown();
		}
	}
	/**********************************************/
  	// Play Section
	if (int(startTimer.getTime())<= 15 && startTimer.getTime()>= 0) {

    	background(90);
		
		surfer.move(left, right);
		
		i = surfer.x;   // i is x coordiantes of the character
		o = surfer.y;   // y is y coordiantes of the character
		
		
		//Road  
		fill(0);
		//sidewalk
		rect(0,0,100,800);
		rect(700,0,100,800);
		fill(255);
		//right/mid lane
		rect(500,y,10,250);
		//left/ left lane
		rect(300,y,10,250);
		//lane lines
		rect(500,y + 300,10,250);
		rect(300,y + 300,10,250);
		
		rect(500,y + 600,10,250);
		rect(300,y + 600,10,250);
		
		rect(500,y + 900,10,250);
		rect(300,y + 900,10,250);
		

		rect(500,y - 50,10, - 250);
		rect(300,y - 50,10, - 250);
		
		rect(500,y - 350,10, - 250);
		rect(300,y - 350,10, - 250);
		
		rect(500,y - 650,10, - 250);
		rect(300,y - 650,10, - 250);
		
		if (y >= height + 50) {
			y =- 350;
		}
		
		y +=4;
		
		//Coin movment
		shape(coin1,Cx1,Cy1);
		shape(coin2,Cx2,Cy2);
		shape(coin3,Cx3,Cy3);
		Cy1 +=4;
		Cy2 +=4;
		Cy3 +=4;
		if (Cy1 >= height) {
			Cx1 = Random();
			Cy1 = int(random(- 80 , - 70));
		}
		if (Cy2 >= height) {
			Cx2 = Random();
			Cy2 = int(random(- 150 , - 130));
		}
		if (Cy3 >= height) {
			Cx3 = Random();
			Cy3 = int(random(- 230 , - 200));
		}
		
		
		//Score 
		textFont(font);
		textSize(18);
		text("score:" + z,710,10,110,100);
		
		
		//Game logic
		if (abs(Cx1 - i)<= 75 && abs(Cy1 - o)<= 75) {
			Cx1 = Random();
			Cy1 = int(random(- 80 , - 70));
			z++;
		}
		if (abs(Cx2 - i)<= 75 && abs(o - Cy2)<= 75) {
			Cx2 = Random();
			Cy2 = int(random(- 150 , - 130));
			z++;
	  	}
		if (abs(Cx3 - i)<= 75 && abs(Cy3 - o)<= 75) {
			Cx3 = Random();
			Cy3 = int(random(- 230 , - 200));
			z++;
		}

    	// key pressed
		if (keyPressed) {
			if (keyCode == LEFT) {
				left = true;
				image(Charleft,i,o);
			} 
			else if (keyCode == RIGHT) {
				right = true;
				image(Charright,i,o);  
			}
			else{
				image(Charfrwd, i,o);
			}
		}
		else {
			image(Charfrwd, i,o);
		}
		
		//Play Timer
		startTimer.countDown();
		if (startTimer.getTime()>= 5) {
			fill(0,255,0);
		}
		else{
			fill(255,0,0);
		}
		textFont(font);
		textSize(18);
		text("Time Left:" + int(startTimer.getTime()),10,10,110,100);

	}
    /**********************************************/
  	// End screen
	if (startTimer.getTime()<= 0){
		image(GameOver,0,0);
		textFont(font2);
		textSize(80);
		fill(248,25,153);
		text("Press DELETE To Restart",20,15,800,800);
		fill(233,248,255);
		text("Press DELETE To Restart",10,5,800,800);
		fill(128,248,254);
		text("Press DELETE To Restart",15,10,800,800);
		fill(248,25,153);
		text("Your Score:" + z,200,700,800,800);
		fill(233,248,255);
		text("Your Score:" + z,190,690,800,800);
		fill(128,248,254);
		text("Your Score:" + z,195,695,800,800);
		if (keyCode == DELETE)
		{
			startTimer.setTime(16);
			z = 0;
			Cy1 = 0;
			Cy2 =- 200;
			Cy3 =- 400;
			Cx1 = 175;
			Cx2 = 375;
			Cx3 = 575;
		}
	}
	/**********************************************/

}


void keyReleased() {
	if (keyCode == LEFT) {
		left = false;
	}  
	if (keyCode == RIGHT) {
		right = false;
	}
}


class player {
	boolean left;
	boolean right;
	int y;
	int x;
	int xspeed;
	
	public player(int x, int y) {
		this.x = x;
		this.y = y;
		xspeed = 2;
	}
	
	void move(boolean left, boolean right) {
		this.left = left;
		this.right = right;
		if (left == true && right == false) {      // if left key is pressed , move to the left 
			if (x >= 170) {
				x = x - 4;
			}
		}
		if (left == false && right == true) {    // if the right key is pressed, move to the right
			if (x < 565) {
				x = x + 4;
			}
		} 	
	} 
	
}
