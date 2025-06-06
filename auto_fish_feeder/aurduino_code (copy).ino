//he final code for this Stepper motor :

    /*
       BYJ48 Stepper motor code
       Connect :
       IN1 >> D8
       IN2 >> D9
       IN3 >> D10
       IN4 >> D11
       VCC ... 5V Prefer to use external 5V Source
       Gnd
       written By :Mohannad Rawashdeh
      https://www.instructables.com/member/Mohannad+Rawashdeh/
         28/9/2013
      */

    #define IN1  8
    #define IN2  9
    #define IN3  10
    #define IN4  11
    int Steps = 0;
    boolean Direction = true;// gre
    unsigned long last_time;
    unsigned long currentMillis ;
    int steps_left=4095;
    long time;
    int rotation =0;
    const unsigned long SleepInterval = 43200000UL;
    //const unsigned long SleepInterval = 10000UL;
    unsigned long SleepStart = 0;



    void setup()
    {
    Serial.begin(115200);
    pinMode(IN1, OUTPUT); 
    pinMode(IN2, OUTPUT); 
    pinMode(IN3, OUTPUT); 
    pinMode(IN4, OUTPUT); 
    // delay(1000);

    }
    void loop()
    {
      if (millis() - SleepStart > SleepInterval){
        rotation =0;
      }

      if(rotation < 2 ){
         rotateMotorClockAndAntiClock();

      }
      
    }

    void rotateMotorClockAndAntiClock(){
     while(steps_left>0){
      currentMillis = micros();
      if(currentMillis-last_time>=1000){
      stepper(1); 
      time=time+micros()-last_time;
      last_time=micros();
      steps_left--;
      }
      }
       Serial.println(time);
      Serial.println("Wait...!");
      delay(2000);
      Direction=!Direction;
      steps_left=4095;
      SleepStart = millis();
      rotation ++;

    }

    void stepper(int xw){
      for (int x=0;x<xw;x++){
    switch(Steps){
       case 0:
         digitalWrite(IN1, LOW); 
         digitalWrite(IN2, LOW);
         digitalWrite(IN3, LOW);
         digitalWrite(IN4, HIGH);
       break; 
       case 1:
         digitalWrite(IN1, LOW); 
         digitalWrite(IN2, LOW);
         digitalWrite(IN3, HIGH);
         digitalWrite(IN4, HIGH);
       break; 
       case 2:
         digitalWrite(IN1, LOW); 
         digitalWrite(IN2, LOW);
         digitalWrite(IN3, HIGH);
         digitalWrite(IN4, LOW);
       break; 
       case 3:
         digitalWrite(IN1, LOW); 
         digitalWrite(IN2, HIGH);
         digitalWrite(IN3, HIGH);
         digitalWrite(IN4, LOW);
       break; 
       case 4:
         digitalWrite(IN1, LOW); 
         digitalWrite(IN2, HIGH);
         digitalWrite(IN3, LOW);
         digitalWrite(IN4, LOW);
       break; 
       case 5:
         digitalWrite(IN1, HIGH); 
         digitalWrite(IN2, HIGH);
         digitalWrite(IN3, LOW);
         digitalWrite(IN4, LOW);
       break; 
         case 6:
         digitalWrite(IN1, HIGH); 
         digitalWrite(IN2, LOW);
         digitalWrite(IN3, LOW);
         digitalWrite(IN4, LOW);
       break; 
       case 7:
         digitalWrite(IN1, HIGH); 
         digitalWrite(IN2, LOW);
         digitalWrite(IN3, LOW);
         digitalWrite(IN4, HIGH);
       break; 
       default:
         digitalWrite(IN1, LOW); 
         digitalWrite(IN2, LOW);
         digitalWrite(IN3, LOW);
         digitalWrite(IN4, LOW);
       break; 
    }
    SetDirection();
    }
    } 
    void SetDirection(){
    if(Direction==1){ Steps++;}
    if(Direction==0){ Steps--; }
    if(Steps>7){Steps=0;}
    if(Steps<0){Steps=7; }
    }
