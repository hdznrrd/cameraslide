include <config.scad>;
use <modules.scad>;

module all() {
    // inner plate
    mirror([0,0,1])
    inner_plate(true,false);
    
    // inner plate contra
    translate([0,plate_width*1.5,0])
    inner_plate(false,true);

    // outer plate 1
    translate([-plate_length*1.5,0,0])
    mirror([0,0,1])
    outer_plate(true,false);
    
    // outer plate 1 contra
    translate([-plate_length*3,0,0])
    outer_plate(false,true);

    // outer plate 2
    translate([-plate_width*0.5,plate_width*1.5,0])
    mirror([1,0,0])
    mirror([0,0,1])
    outer_plate(true,false);

    // outer plate 2 contra
    translate([-plate_width*2,plate_width*1.5,0])
    mirror([1,0,0])
    outer_plate(false,true);
    
}

all();