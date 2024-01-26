/// Init

randomize();

init_pico8_colours();

TileColours = [];
TileColours[0][0] = dk_pink;
TileColours[0][1] = dk_green;
TileColours[1][0] = dk_green;
TileColours[1][1] = green;
TileColours[2][0] = dk_gray;
TileColours[2][1] = lt_gray;
TileColours[3][0] = dk_gray;
TileColours[3][1] = lt_gray;
TileColours[4][0] = gray;
TileColours[4][1] = lt_gray;
TileColours[5][0] = lt_gray;
TileColours[5][1] = silver;
TileColours[6][0] = lt_gray;
TileColours[6][1] = silver;

CamW = camera_get_view_width(view_camera[0]);
CamH = camera_get_view_height(view_camera[0]);

Origin_x = CamW / 2;
Origin_y = CamH / 2;
GridSize = 10;
TileSize = 32;
TileHeight = TileSize;

Angle = 45;
AngleTo = 45;
Perspective = 45;



Grid = ds_grid_create(GridSize, GridSize);

//for (var i = 0; i < (GridSize * GridSize) / 2; i++)
//{
//	Grid[# irandom_range(0, GridSize - 1), irandom_range(0, GridSize - 1)] = irandom_range(1, 6);
//}

var map = [
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 1, 1, 1, 1, 0, 0, 0],
[0, 0, 1, 1, 2, 2, 1, 1, 0, 0],
[0, 0, 1, 1, 4, 3, 2, 1, 1, 0],
[0, 1, 2, 3, 5, 4, 2, 1, 1, 0],
[0, 1, 2, 4, 5, 5, 2, 1, 0, 0],
[0, 1, 1, 2, 3, 4, 1, 1, 0, 0],
[0, 1, 1, 1, 2, 2, 1, 1, 0, 0],
[0, 0, 1, 1, 1, 1, 1, 0, 0, 0],
[0, 0, 0, 1, 1, 0, 0, 0, 0, 0]
];

for (var _y = 0; _y < GridSize; _y++)
{
	for (var _x = 0; _x < GridSize; _x++)
	{
		Grid[# _x, _y] = map[_y][_x];
	}
}

// get number of "cubes"
show_debug_message(ds_grid_get_sum(Grid, 0, 0, GridSize - 1, GridSize - 1));