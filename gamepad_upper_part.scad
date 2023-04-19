$fn = 100;
//###
base_w = 101;
base_h = 65;
wall = 2;
base_z = 23;
srob = 1;
posun = 5;
button = 12;
button2 = 7;
button_h = 17;
button_p = 16;
c_height = 55;
hull_h = 5;
c_r = 6;
const = 2;
a = 33;
b = 24;
posun2 = 5;
h = -10;
down = -2.5;
x = base_w-6;
y = base_h-5.5;
x1 = 5.5;
y1 = 4;
height = 25;

cylinder_r = 5;
cylinder_h = 25;

pos_x = 95;
pos_y = 63;


cover_height = 15;
cover_cap = 22;

raise = 25;

c_barrel_height = 9;// 4
c_barrel_move = 6;



translate([0,0,00])
difference(){
color("grey")
    rotate([0,180,0])
    translate([-106,7,-7])
    whole_cover();

    translate([101,10,-20])
    cylinder(h = 40, d = 3.3);

    translate([55,67,-20]) 
    cylinder(h = 40, d = 3.3);
    
    translate([97,58,-10])
    cylinder(h = 20, r = 10);
    
    translate([101,10,-15])
    cylinder(h = 10, d = 6);

    translate([55,67,-15]) 
    cylinder(h = 10, d = 6);
}



module button_h(x, y){
    translate([x+button2-1,y+button2-1,button_p])
    cylinder(h = button_h, r = button2);
}

module whole_cover(){
    difference(){
        cover();
        union(){
            //potentiometer
            translate([87,51,h])
            cylinder(h = c_height, r = 3.9); 
            
            //buttons
            rotate([0,0,180])
            translate([-85,-56,-17])
                union(){
                    translate([5,1,0]){
                    button_h(5.5, 25);
                    button_h(36, 25);
                    button_h(21, 11);
                    button_h(47, 39);
                    button_h(21, 39);    
                    }
                }      
        translate([0,0,-3])
        body(2);
        }
    }
    
    rotate([0,0,90])
    translate([-34,-122,4]){       
        difference(){
            translate([80+posun2,35,0])
                cylinder(h = 7.5, r = 11);
            
            union(){
                translate([80+posun2,35,-5])
                    cylinder(h = 18, r = 9);
                translate([66+posun2,37,-3])
                    cube([25, 15, 15]);     
            }
        }
    }
}


module barrel(pos1, pos2,c_h, c_r){
    translate([pos1, pos2, 2])
        cylinder(h = c_h, r = c_r);
}

module body(posun){
    hull(){
        translate([0,0,0])
        hull(){
            barrel(2+posun,0+posun, 2, cylinder_r+2);
            barrel(pos_x-posun, 0+posun, 2, cylinder_r+2);
            barrel(-5+posun, pos_y-posun-1, 2, cylinder_r+2);
            barrel(pos_x+5-posun, pos_y-posun-1, 2, cylinder_r+2);
        }
    
        translate([0,0,2])
        hull(){
            barrel(2+c_barrel_move,0+c_barrel_move, c_barrel_height, cylinder_r);
            barrel(pos_x-c_barrel_move, 0+c_barrel_move, c_barrel_height, cylinder_r);
            barrel(-5+c_barrel_move, pos_y-c_barrel_move, c_barrel_height, cylinder_r);
            barrel(pos_x+5-c_barrel_move, pos_y-c_barrel_move, c_barrel_height, cylinder_r);
        }
    } 
}


module cover(){
    body(0);
}