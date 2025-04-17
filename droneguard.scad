use <shortcuts.scad>;
// https://www.thingiverse.com/thing:644830
// https://gitlab.com/mhop/openscad-designs/tree/master/lib

// Blade Guard for AR Drone 2.0
//
// The guard locks on groove
// The propeller is r=100 mm
// The propeller is ~ 25mm above the groove
// So the guard should be centered there.
//
// Todo: 
//        Rebuild the fence so it snaps into the latch
//        mechanism.
// Done:  Put hook ends on the ends of the latch
//          that are closest to the drone body.
//       They will catch on the frame for the motor

$fn=120;
middlecircle=26;
middledistance=22.3;
fardistance=59.3;
height=6;

module outside() {
    hull() {
     Ci(d=14.5);
     Tx(middledistance) Ci(d=middlecircle);
     Tx(fardistance) Ci(d=10.5);
  }
}

module inside_small() {
  hull() {
     Ci(d=9.5);
     Tx(middledistance) Ci(d=20.4);
     Tx(fardistance) Ci(d=4.5);
  }
}

// the slot sorta disappears when it gets near
// the hook at the end.
module inside_slot() {
  hull() {
     Ci(d=12.5);
     Tx(middledistance) Ci(d=23.4);
     Tx(fardistance) Ci(d=7.5);
  }
}

module shape_small() {
  linear_extrude(height=8)
     inside_small();
}

module shape_slot() {
    linear_extrude(height=2.2)
       inside_slot();
}
module shape_big() {
  linear_extrude(height=height)
    outside();
}

module latch() {
  D() {
union() {    shape_big();
    T([fardistance-2,.1,height/2]) Cu([4,18,height]);
}
    Tz(-.1) shape_small();
    Tz(2)   shape_slot();
    Tx(25+fardistance) Cu(50);
  }
}


//RiS(R=30,r=1,h=4,w1=270,w2=90);
module wedge(angle, extent=112, height=fenceheight, center=true)
  {
    module wedge_wall()
    {
      translate([0,-1.5,(center==true ? -height/2 : 0)])
        cube([extent,1.5,height]);
    }
    
    for(r=[0:72:angle-1])
      rotate([0,0,r])
        wedge_wall();
    rotate([0,0,angle])
      wedge_wall();
  }


/* LATCH */
latch();
  

/* EVERYTHING */
//latch();
// fence
 fenceheight=4;
Tz(fenceheight/2) RiS(R=112,r=110,h=fenceheight,w1=110,w2=254);
D()  {
  Tz(fenceheight/2) Rz(110) wedge(angle=144);
    Tz(-.1) shape_small();
    Tz(2)   shape_slot();
}  



//help();
//rotN(r=.5*(100), N=3, offs=0, M=undef) Sq(3);