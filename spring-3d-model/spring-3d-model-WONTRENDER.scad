wire_thickn = 0.5;
height = 13;
diam = 10.9;
windings = 5;
pin_len = 3.5;
slot_w = 2;

fn = 50;

/**
* An edge (or line) between 2 nodes
*/
module line(start, end, d, fn=4) {
  hull() {
    node(start,d, fn);
    node(end,d, fn);
  }      
}

/**
* A single node which is connected by edges
*/

module node(pos, d, fn=4) {
  if (pos[0]!=undef && pos[1] != undef && pos[2] != undef){ 
    translate(pos) sphere(d=d, $fn = fn);    
  }
}

module spring(d, dBottom=6, dTop=6, windings=2, height=10, steps=10, wireDiameter=1,fn=10) {
    // we use either d or dBottom&dTop
    r0 = d != undef ? d/2 : dBottom/2;
    r1 = d != undef ?d/2 : dTop/2;
    
    rx = (r0-r1) / (360.0*windings);    
    heightPerDegree = height/windings/360;
    
    for ( angle = [steps : steps : 360*windings] ){
        r = r0 - (angle * rx); 
        x0=r*cos(angle-steps);
        y0=r*sin(angle-steps);
        z0=(angle-steps)*heightPerDegree;
        x=r*cos(angle);
        y=r*sin(angle);
        z=angle*heightPerDegree;

        line([x0,y0,z0],[x,y,z],d=wireDiameter,fn=fn);        
    }
}

/**
* 3D Spring with identical diameter at top and bottom. The top and boton might
* start with a flat circle
*/
module spring3D(d=5,windings=3,height=10,flatStart=true,flatEnd=true, wireDiameter=1,  fn=4) {  
    spring(d=d, windings=windings,height=height, wireDiameter=wireDiameter, fn=fn);
    
    if (flatStart)
        spring(dBottom=d,dTop=d,windings=1,height=0, wireDiameter=wireDiameter, fn=fn);
    if (flatEnd)
        translate([0,0,height]) spring(dBottom=d,dTop=d, windings=1,height=0, wireDiameter=wireDiameter, fn=fn);
}

union() {
  spring3D(diam, windings=windings, height=height, wireDiameter=wire_thickn, fn=fn);
  
  translate([-diam/2, 0, -pin_len - wire_thickn/2])
  cylinder(d=wire_thickn, h=pin_len+(wire_thickn/2), $fn=fn);
  
  translate([diam/2 , 0, -pin_len+slot_w-wire_thickn]) {
    rotate([90, 0, 90])
    rotate_extrude(angle=180, convexity=10, $fn=fn)
    translate([-slot_w/2 + wire_thickn, 0])
    circle(d=wire_thickn, $fn=fn);
    
    translate([0, -slot_w/2 + wire_thickn])
    cylinder(d=wire_thickn, h=pin_len-slot_w/2 - wire_thickn, $fn=fn);
    
    translate([0, slot_w/2 - wire_thickn])
    cylinder(d=wire_thickn, h=pin_len-slot_w/2 - wire_thickn, $fn=fn);
  }
}
