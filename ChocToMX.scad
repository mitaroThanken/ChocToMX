$fs = 0.10;

// Choc 部分

stem_size = [1.15, 2.98, 3.50];
stem_diff = [stem_size[0], stem_size[1] / 2.10, stem_size[2] + 1.00];
stem_offset = [5.70 / 2, 0, stem_size[2] / 2];
choc_stem_height = 3.00;

module stem_one_side() {
    difference() {
        cube(stem_size, true);
        translate([stem_size[0] * 2.50 / 3, 0, 0])
            cube(stem_diff, true);
        translate([stem_size[0] * -2.50 / 3, 0, 0])
            cube(stem_diff, true);
    }
}

module choc_stems() {
    translate(stem_offset)
        stem_one_side();
    translate([-1 * stem_offset[0], stem_offset[1], stem_offset[2]])
        stem_one_side();
}

// 接続部分（板）
board_size = [10.00, 10.00, 1.50];

module plate() {
    translate([0, 0, (board_size[2] / 2) + 3.00])
        cube(board_size, true);
}

// 十字部分

stem_cross_length = 3.80;
stem_cross_h      = 1.10;
stem_cross_v      = 1.10;
stem_height       = 3.0 + (board_size[2] / 2);

module mx_stem() {
    translate([0, 0, (stem_height / 2) + choc_stem_height + (board_size[2] / 2)])
        cube([stem_cross_h, stem_cross_length, stem_height], true);
    translate([0, 0,  (stem_height / 2) + choc_stem_height + (board_size[2] / 2)])
        cube([stem_cross_length, stem_cross_v, stem_height], true);
}

// 全部くっつけて、アダプタ
module choc_to_mx() {
    choc_stems();
    plate();
    mx_stem();
}

// 複製
//mirror([0, 0, 1])
    for (x = [0, 1])
        for (y = [0, 1])
            translate([(board_size[0] + 0.5) * x, (board_size[1] + 0.5) * y, 0])
                choc_to_mx();