#define aa 0x01
#define ab 0x02
#define ac 0x04
#define ad 0x08

#define ba 0x11
#define bb 0x12
#define bc 0x14
#define bd 0x18

#define ca 0x21
#define cb 0x22
#define cc 0x24
#define cd 0x28

#define da 0x31
#define db 0x32
#define dc 0x34
#define dd 0x38

#define ea 0x41
#define eb 0x42
#define ec 0x44
#define ed 0x48

#define fa 0x51
#define fb 0x52
#define fc 0x54
#define fd 0x58


byte keys[6] = { 0x00, 0x10, 0x20, 0x30, 0x40, 0x50};

void setup() 
{ 
  Serial.begin(57600); 
} 

void loop() 
{  
  //Reset keys
  //Poll inputs
  
  //Set key table
  keys[int(aa>>4)] = keys[int(aa>>4)] | aa;
  keys[int(ac>>4)] = keys[int(ac>>4)] | ac;
  keys[int(bb>>4)] = keys[int(bb>>4)] | bb;
  keys[int(bd>>4)] = keys[int(bd>>4)] | bd;
  keys[int(ca>>4)] = keys[int(ca>>4)] | ca;
  keys[int(cc>>4)] = keys[int(cc>>4)] | cc;
  keys[int(cb>>4)] = keys[int(cb>>4)] | cb;
  keys[int(cd>>4)] = keys[int(cd>>4)] | cd;
  
  //Send table
  for (int i=0; i < 6; i++) {
    Serial.print(keys[i]); 
  } 
  
 delay(10); 
} 
