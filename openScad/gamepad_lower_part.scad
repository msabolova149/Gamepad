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
height = 30;
//######

cylinder_r = 5;
cylinder_h = 30;

pos_x = 95;
pos_y = 63;

cover_height = 10;
cover_cap = 22;
raise = 25;
c_barrel_height = 4;
c_barrel_move = 6;

joys_base = 14;
joys_x = 22;
joys_x2 = -4;
joys_y = 43.5;
joys_y2 = 62.5;
   

color("grey")
base(); 

module joys_screws(x, y){
    translate([x,y,-2])
    cylinder(h = joys_base*3, r = 1);
}

module barrel(pos1, pos2,c_h, c_r){
    translate([pos1, pos2, 2])
        cylinder(h = c_h, r = c_r);
}

module leg(position_x, p_x1, p_x2){
    hull(){
        translate([position_x, pos_y+30, -10])
            sphere(6);
        barrel(p_x1, pos_y, cylinder_h, cylinder_r);
        barrel(p_x2, pos_y, cylinder_h, cylinder_r);  
    }
}

module body(c_h, c_r){
    minkowski(){
        hull(){
            barrel(2,0, c_h, c_r);
            barrel(pos_x, 0, c_h, c_r);
            barrel(-5, pos_y, c_h, c_r);
            barrel(pos_x+5, pos_y, c_h, c_r);
        }
        sphere(2);
    }
}

module base(){
    
    difference(){
        body(cylinder_h, cylinder_r);
        
        union(){
            // micro
            translate([85, 5.5, 3])
            cube([20, 14, 10]);
            
            // up 
            translate([-15,-10,cylinder_h])
            cube([pos_x+30, pos_y+30, 10]);
            
            // inside body
            hull(){
                barrel(2,0, cylinder_h, cylinder_r);
                barrel(pos_x, 0, cylinder_h, cylinder_r);
                barrel(-5, pos_y, cylinder_h, cylinder_r);
                barrel(pos_x+5, pos_y, cylinder_h, cylinder_r);
            }
        }
    }
    
    // joystick
    difference(){      
        body(joys_base, cylinder_r); 
        
        union(){    
            translate([-10,-11,-2])
            cube([pos_x+30, 50, joys_base*4]);

            translate([26,35,-2])
            cube([pos_x+10, 50, joys_base*4]);
        
            // screws
            joys_screws(joys_x,joys_y);
            joys_screws(joys_x,joys_y2);
            joys_screws(joys_x2,joys_y);
            joys_screws(joys_x2,joys_y2);
        }       
    }
    
    difference(){
        
        union(){
            leg(pos_x+15,pos_x+7,pos_x-20);
            leg(-15,-7,20);
        }
        union(){
            translate([-15,-10,cylinder_h])
                cube([pos_x+30, pos_y+30, 10]);
            
            hull(){
                barrel(-5, pos_y, cylinder_h, cylinder_r+2);
                barrel(20, pos_y, cylinder_h, cylinder_r+2);
            }
            hull(){
                barrel(pos_x+5, pos_y, cylinder_h, cylinder_r+2);
                barrel(pos_x-20, pos_y, cylinder_h, cylinder_r+2);
            }
        }
    }
    
    

    
translate([-5,-2.5,1])
union(){
    difference(){
        translate([21,-3,-1])
            cube([15, 45, 20]);
        translate([34,11,-1])
            cube([5, 50, 22]);
    }
    // screw 1
    translate([-pos_x/2+18,0,0]){
    translate([-10,3,0])
    difference(){
        translate([base_w-10, base_h-9, 0])
                cube([10,13,height-1]);

        union(){    
            translate([x+1, y, -1]) 
                cylinder(h = 40, d = 3.3);
            translate([x-1.95, y-5, 9.5+3]) 
                cube([5.9,10,3]);    
            }
        }
    }
    // screw 2
    translate([14,-3,0])
    rotate([0,0,90])
    difference(){
        translate([-1, -1, 0])
            cube([15,10,height-1]);
        translate([4,0,0])    
        union(){    
            translate([x1, y1, -1]) 
                cylinder(h = 40, d = 3.3);
            translate([x1-6, y1-2.95, 9.5+3]) 
                cube([12,5.9,3]);
            }
    }
}// union    
        
} // base

color("lightgrey")
translate([106,-7,39])
rotate([0,180,0])
import("vrch.stl");