#include "colors.inc"
#include "camera.inc"

camera {
	camera_back
}

/* camera { */
/* 	location<3,30,3> */
/* 	look_at<3,0,3> */
/* } */

#declare panel_core = difference {
	box {
		<0,0,0,>, <30,5,8>
		texture {
			pigment { color rgb<1.0,0.15,0.0> }
			finish { phong 0.1 reflection 0.0 }
		}
	}
	box {
		<0,0,0>, <32,5,9>
		texture {
			pigment { color Black }
		}
		rotate<10,0,0>
		translate<-1,5,0>
	}
	box {
		<0,0,0>, <32,5,9>
		texture {
			pigment { color Black }
		}
		rotate<30,0,0>
		translate<-1,0,6>
	}
}

#declare vertical_border = cylinder {
	<0,0,0>, <0,5,0>, 0.2
	pigment {
		color Black
	}
}

#declare big_horizontal_border = cylinder {
	<0,0,0>, <30,0,0>, 0.2
	pigment {
		color Black
	}
}

#declare small_horizontal_border = cylinder {
	<0,0,0>, <6.2,0,0>, 0.2
	rotate<0,-90,0>
	pigment {
		color Black
	}
}

#declare diagonal_horizontal_border = cylinder {
	<0,0,0>, <8,-1.5,0>, 0.2
	rotate <0,-90,0>
	pigment {
		color Black
	}
}

#declare diagonal_vertical_border = cylinder {
	<0,0,0>, <0,3.5,1.8>, 0.2
	pigment {
		color Black
	}
}

#declare panel_core_with_border = union {
	object { panel_core }

	/* left */
	object { vertical_border translate<0,0,0> }
	object { small_horizontal_border translate<0,0,0> }
	object { diagonal_horizontal_border translate<0,5,0> }
	object { diagonal_vertical_border translate<0,0,6.2> }
	/* right */
	object { vertical_border translate<30,0,0> }
	object { small_horizontal_border translate<30,0,0> }
	object { diagonal_horizontal_border translate<30,5,0> }
	object { diagonal_vertical_border translate<30,0,6.2> }

	/* front down */
	object { big_horizontal_border translate<0,0,0> }
	/* front up */
	object { big_horizontal_border translate<0,5,0> }
	/* back down */
	object { big_horizontal_border translate<0,0,6.2> }
	/* back up */
	object { big_horizontal_border translate<0,3.5,8> }
}

#declare panel_central_light = prism {
	linear_spline
	0, 2, 3,
	<0,0>, <0.5,1.5>, <-0.5,1.5>
	rotate<90,90,0>
	/* translate<5,5,-10> */
	pigment { color Orange }
}

#declare panel = union {
	difference {
		object { panel_core_with_border }
		box {
			<0,0,0> <10,6,10>
			translate<10, -0.5, 2>
		}
	}
	object { panel_central_light rotate<10,0,0> translate<14,6.5,1> }
}

#declare panel_with_support = union {
	object { panel }
	prism {
		linear_spline
		0, 3, 4,
		<0,0>, <0,4>, <15,6.5>, <15,-2.5>
		rotate<0,0,90>
		rotate<0,90,0>
		translate<13,-11.5,-0.5>
		texture {
			pigment { color White }
			finish { phong 0.1 reflection 0.0 }
		}
	}
}

/* camera { */
/* 	location<2,20, 2> */
/* 	look_at<2,0,2> */
/* } */

/* camera { */
/* 	location<-20,6, 2> */
/* 	look_at<2,6,2> */
/* } */

#declare small_radar_box = union {
	difference {
		box {
			<0,0,0> <5.5,6,3.5>
		}
		box {
			<0,0,0> <6,7,10>
			rotate<0,5,0>
			translate<-5.5,-0.5,0>
		}
		box {
			<0,0,0> <6,7,10>
			rotate<0,-5,0>
			translate<5.5,-0.5,0>
		}
		box {
			<0,0,0> <7,7,15>
			rotate<10,0,0>
			translate<-0.5,6,0>
		}
		pigment { color White }
	}
	box{
		<0,0,0>, <1,1,0>
		pigment {
			image_map {
				png "small_radar.png"
				once
			}
		}
		scale<4,2,1>
		rotate<100,0,0>
		translate<1,6,0.001>
	}
}

/* #declare radar_box = difference { */
#declare radar_box = union {
	difference {
		box {
			<0,0,0> <10,15,10>
			pigment { color White }
		}
		box {
			<0,0,0> <11,25,20>
			rotate<-45,0,0>
			translate<-0.5,6,0>
			pigment { color White }
		}
		rotate<0,180,0>
	}
	box{
		<0,0,0>, <1,1,0>
		pigment {
			image_map {
				png "radar.png"
				once
			}
		}
		scale<9,11.5,1>
		rotate<-45,0,0>
		translate<-9.5,6,0.0001>
	}
	object {
		small_radar_box
		translate<-8,0,0>
	}
}

#declare full_panel = union {
	object { panel_with_support }
	object { radar_box translate<20,-11.5,12> }
}

object { full_panel }