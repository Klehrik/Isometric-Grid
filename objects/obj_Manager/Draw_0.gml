/// Draw

//if (keyboard_check(ord("A"))) Origin_x += 2;
//if (keyboard_check(ord("D"))) Origin_x -= 2;
//if (keyboard_check(ord("W"))) Origin_y += 2;
//if (keyboard_check(ord("S"))) Origin_y -= 2;

if (keyboard_check_pressed(ord("A"))) AngleTo += 90;
if (keyboard_check_pressed(ord("D"))) AngleTo -= 90;
Angle += (AngleTo - Angle) / 10;
if (abs(AngleTo - Angle) < 0.25) Angle = AngleTo;

if (keyboard_check(ord("W"))) Perspective += 1;
if (keyboard_check(ord("S"))) Perspective -= 1;
Perspective = clamp(Perspective, 1, 90);



// default starting and ending position of the loop
var start = [0, 0]; // x, y
var finish = [GridSize, GridSize];
var x_inc = 1;
var y_inc = 1;

// clamp Angle range to 0 - 359
var angle = Angle;
while (angle < 0) angle += 360;
while (angle > 359) angle -= 360;

// get grid corner to start from (in order to draw tiles in correct z order)
if (angle <= 90) { start[0] = GridSize - 1; finish[0] = -1; x_inc = -1; }
else if (angle <= 180) { start[0] = GridSize - 1; finish[0] = -1; x_inc = -1; start[1] = GridSize - 1; finish[1] = -1; y_inc = -1; }
else if (angle <= 270) { start[1] = GridSize - 1; finish[1] = -1; y_inc = -1; }



// bg colour
var clr = $532b1d;
draw_rectangle_colour(0, 0, CamW, CamH, clr, clr, clr, clr, 0);

var triangles = 0;

// loop through the grid
for (var _y = start[1]; _y != finish[1]; _y += y_inc)
{
	for (var _x = start[0]; _x != finish[0]; _x += x_inc)
	{
		var height = Grid[# _x, _y];

		// get non-rotated tile position relative to the origin of the board (angle and distance)
		var point_x = Origin_x + (_x - GridSize / 2) * TileSize + 16;
		var point_y = Origin_y + (_y - GridSize / 2) * TileSize + 16;
		var angle = point_direction(Origin_x, Origin_y, point_x, point_y);
		var dist = point_distance(Origin_x, Origin_y, point_x, point_y);
			
		// rotate the angle by Angle and recalculate the rotated points
		angle += Angle;
		point_x = Origin_x + dcos(angle) * dist;
		point_y = Origin_y - dsin(angle) * dist * dsin(Perspective);
			
		// get angles of each corner of the tile
		var size = TileSize / 1.6;
		var p1 = point_direction(point_x, point_y, point_x - size, point_y - size);
		var p2 = point_direction(point_x, point_y, point_x + size, point_y - size);
		var p3 = point_direction(point_x, point_y, point_x - size, point_y + size);
		var p4 = point_direction(point_x, point_y, point_x + size, point_y + size);
		
		// draw the tile with rotated corners
		for (var ht = 0; ht <= height; ht++)
		{
			var clr = TileColours[ht][0]; // main body colour of tile
			var clr2 = TileColours[ht][1]; // top colour of tile (if at the top)
			
			// tile body
			if (ht > 0)
			{
				draw_stacked_quad(point_x + dcos(p1 + Angle) * size, point_y - dsin(p1 + Angle) * size * dsin(Perspective) - ((ht - 1) * TileHeight * dsin(90 - Perspective)),
				point_x + dcos(p2 + Angle) * size, point_y - dsin(p2 + Angle) * size * dsin(Perspective) - ((ht - 1) * TileHeight * dsin(90 - Perspective)),
				point_x + dcos(p3 + Angle) * size, point_y - dsin(p3 + Angle) * size * dsin(Perspective) - ((ht - 1) * TileHeight * dsin(90 - Perspective)),
				point_x + dcos(p4 + Angle) * size, point_y - dsin(p4 + Angle) * size * dsin(Perspective) - ((ht - 1) * TileHeight * dsin(90 - Perspective)),
				TileHeight * dsin(90 - Perspective), clr);
				
				triangles += 4;
			}
			
			// tile top
			draw_quad(point_x + dcos(p1 + Angle) * size, point_y - dsin(p1 + Angle) * size * dsin(Perspective) - (ht * TileHeight) * dsin(90 - Perspective),
			point_x + dcos(p2 + Angle) * size, point_y - dsin(p2 + Angle) * size * dsin(Perspective) - (ht * TileHeight) * dsin(90 - Perspective),
			point_x + dcos(p3 + Angle) * size, point_y - dsin(p3 + Angle) * size * dsin(Perspective) - (ht * TileHeight) * dsin(90 - Perspective),
			point_x + dcos(p4 + Angle) * size, point_y - dsin(p4 + Angle) * size * dsin(Perspective) - (ht * TileHeight) * dsin(90 - Perspective),
			clr2);
			
			triangles += 2;
		}
	}
}

show_debug_message(triangles);