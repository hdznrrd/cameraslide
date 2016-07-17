include <config.scad>;

module cradle(length,heigth) {
    translate([-length/2,0,-tube_od/2])
    difference() {
        translate([0,-tube_od/2,tube_od/2-height])
        cube([length,tube_od,height]);
        
        translate([-1,0,0])
        rotate([0,90,0])
        cylinder(length+2,tube_od/2,tube_od/2, $fn=100);
    }
}


module plate(length,width,thickness) {
    // top plate
    cube([length,width,thickness],false);
    
    offset=tube_od*1.3;
    
    difference() {
    
    union() {
            // cradles
            translate([length/2,tube_od/2,0])
            cradle(length=length,height=cradle_thickness);
            
            translate([length/2,width-tube_od/2,0])
            cradle(length=length, height=cradle_thickness);
        }
        //color([1,0,0])
        translate([-1,offset/2,-cradle_thickness*1.5])
        cube([length+2,width-offset,cradle_thickness*1.5],false);
    }
}

module mounting_holes(length,width,thickness) {
    screw_length=thickness+tube_od+2;
    translate([length/4,tube_od/2,-screw_length/2])
    cylinder(screw_length,screw_od/2,screw_od/2, $fn=100);
    
    translate([3*length/4,tube_od/2,-screw_length/2])
    cylinder(screw_length,screw_od/2,screw_od/2, $fn=100);
    
    translate([length/4,width-tube_od/2,-screw_length/2])
    cylinder(screw_length,screw_od/2,screw_od/2, $fn=100);
    
    translate([3*length/4,width-tube_od/2,-screw_length/2])
    cylinder(screw_length,screw_od/2,screw_od/2, $fn=100);
}

module cradle_contra(length,height) {
    intersection() {    
        translate([0,-tube_od/2,height])
        cube([length,tube_od,height]);

        rotate([0,90,0])
        cylinder(length,tube_id/2,tube_id/2, $fn=100);
    }
}

module plate_contra(length,width,height) {        
    translate([0,tube_od/2,-tube_od/2])
    cradle_contra(length,height);
    
    translate([0,width-tube_od/2,-tube_od/2])
    cradle_contra(length,height);
}

module base_plate(length,width,with_plate,with_contra) {
    difference() {
        union() {
            if(with_plate)
                plate(length,width,plate_thickness);
            if(with_contra)
                plate_contra(length,width,plate_thickness);
        }
        mounting_holes(length,width,plate_thickness);
    }
}

module outer_plate(with_plate,with_contra) {
    difference() {
        base_plate(plate_length,plate_width,with_plate,with_contra);
        
        translate([-plate_width/8,plate_width/2,-10])
        cylinder(60,plate_width/3,plate_width/3, $fn=100);
    }
}

module inner_plate(with_plate,with_contra) {
    length=plate_length*1.5;
    difference() {
        base_plate(length,plate_width,with_plate,with_contra);
        
        translate([-plate_width/8,plate_width/2,-10])
        cylinder(60,plate_width/3,plate_width/3, $fn=100);

        translate([length+plate_width/8,plate_width/2,-10])
        cylinder(60,plate_width/3,plate_width/3, $fn=100);
    }
}
