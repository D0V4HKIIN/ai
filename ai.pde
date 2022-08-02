box floor;
ball ball;

ball best;
ball[] now;

void setup(){
  size(1080,720);
  frameRate(100);
  
  floor = new box(0,height-20,width,20);
  ball = new ball(50,height-75,50,-PI/4,75);
  
  now = new ball[100];
    
  for(int i = 0;i < now.length;i++){
    float angle = -random(PI/2);
    now[i] = new ball(50,height-75,50,angle,275);
  }
  best = new ball(50,height-75,50,-random(PI/2),175);
}

void draw(){
  for(int loop = 0;loop<2;loop++){
    background(0);
    floor.update();
    ball.update(255);
    best.update(200);
    for(int i = 0;i<now.length;i++){
      now[i].update(128);
    }
  }
}

class box{
  float x, y, w, h;
  box(float x,float y,float w,float h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  void update(){
    fill(255);
    rect(this.x,this.y,this.w,this.h);
  }
}

class ball{
  
 float x,y,xv,yv,r;
 int pos;
 float bx,by,ba;
 boolean go = true;
 
 ball(float x,float y,float r,float a, int pos){
   this.x = x;
   this.y = y;
   this.r = r;
   this.xv = 2*cos(a);
   this.yv = 2*sin(a);
   
   this.ba = a;
   this.bx = x;
   this.by = y;
   this.pos = pos;
 }
 
 void update(int clr){
   boolean ggo = true;
   for(int i = 0;i<now.length;i++){
     if(now[i].go == true){
       break;
     }else if(i == now.length-1){
       ggo = false;
     }
   }
   if(best.go == true || ball.go == true || ggo == true){
     fill(clr);
     ellipse(this.x,this.y,this.r,this.r);
     if(clr == 255 || clr == 200){
       textSize(64);
       text("x = "+this.x, 10, this.pos);
       text("a = "+(-1)*(this.ba/(PI*2))*360,500,this.pos);
     }else{
      int index = 0;
      for(int i = 0;i<now.length;i++){
         if(now[i].x > now[index].x){
           index = i;
         }
       }
       textSize(64);
       text("x = "+now[index].x, 10, now[index].pos);
       text("a = "+(-1)*(now[index].ba/(PI*2))*360,500,now[index].pos);
     }
     
     if(this.y+(this.r/2) <= floor.y){
       this.y += yv;
       this.x += xv;
       this.yv += 0.005;
     }else{
       this.go = false;
     }
   }else{
     reset();
   }
 }
}

void reset(){
  int index = 0;
   delay(1000);
   for(int i = 0;i<now.length;i++){
     if(now[i].x > now[index].x){
       index = i;
     }
   }
   if(now[index].x > best.x){
     best.ba = now[index].ba;
   }
   ball.x = ball.bx;
   ball.y = ball.by;
   ball.xv = 2*cos(ball.ba);
   ball.yv = 2*sin(ball.ba);
   ball.go = true;
   
   for(int i = 0;i<now.length;i++){
     now[i].x = now[i].bx;
     now[i].y = now[i].by;
     now[i].ba = -random(0,PI/2);
     now[i].xv = 2*cos(now[i].ba);
     now[i].yv = 2*sin(now[i].ba);
     now[i].go = true;
   }
   
   best.x = best.bx;
   best.y = best.by;
   best.xv = 2*cos(best.ba);
   best.yv = 2*sin(best.ba);
   
   ball.go = true;
   best.go = true;
 }
